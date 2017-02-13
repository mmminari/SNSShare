//
//  SNSClass.m
//  SNSShare
//
//  Created by 김민아 on 2017. 2. 9..
//  Copyright © 2017년 김민아. All rights reserved.
//

#import "SNSClass.h"

//Facebook
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

//Twitter
#import <TwitterKit/TwitterKit.h>


//Google
#import <Google/SignIn.h>

@interface SNSClass () <FBSDKSharingDelegate, TWTRComposerViewControllerDelegate, GIDSignInUIDelegate>

@end

@implementation SNSClass

#pragma mark - Facebook
- (BOOL)checkFacebookToken
{
    BOOL result = NO;
    
    if([FBSDKAccessToken currentAccessToken] != nil)
    {
        result = YES;
    }
    
    return result;
}

- (void)doFacebookLoginSelf:(UIViewController *)selfVC WithCompletion:(void (^)(void))completion
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc]init];
    
    login.loginBehavior = FBSDKLoginBehaviorWeb;
    
    NSArray *permissions = @[@"publish_actions"];
    
    [login logInWithPublishPermissions:permissions fromViewController:selfVC handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        
        NSLog(@"FacebookLogin Result : %@", result);
        
        NSLog(@"FacebookLogin Error : %@", error.description);
        
        if(completion)
            completion();
    }];
}

- (void)shareFacebookWithImage:(UIImage *)image
{
    FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
    
    photo.image = image;
    
    photo.userGenerated = YES;
    
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    
    content.photos = @[photo];
    
    [FBSDKShareAPI shareWithContent:content delegate:self];
    
}

#pragma mark - SFBSDKSharingDelegate
- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results
{
    
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error
{
    
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer
{
    
}

#pragma mark - Twitter
- (BOOL)checkTwitterToken
{
    BOOL result = NO;
    
    TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
    
    TWTRSession *session = store.session;
    
    if(session.authToken != nil)
    {
        result = YES;
    }
    
    return result;
}

- (void)doTwitterLoginSelf:(UIViewController *)selfVC WithCompletion:(void(^)(void))completion
{
    [[Twitter sharedInstance]logInWithViewController:selfVC
                                             methods:TWTRLoginMethodWebBasedForceLogin
                                          completion:^(TWTRSession * _Nullable session, NSError * _Nullable error) {
        
    }];
}

- (void)shareTwitterWithViewController:(UIViewController *)vc image:(UIImage *)image
{
    TWTRComposer *composer = [[TWTRComposer alloc]init];
    
    [composer setImage:image];
    
    [composer showFromViewController:vc completion:^(TWTRComposerResult result) {
        
        NSLog(@"Twitter share : %zd", result);
        
    }];
}

#pragma mark - Google
- (BOOL)checkGoogleToken
{
    BOOL result = NO;
    
    if([GIDSignIn sharedInstance].currentUser != nil)
    {
        result = YES;     
    }
    
    return result;
}

- (void)doGoogleLoginWithViewController:(UIViewController *)vc
{
    [vc dismissViewControllerAnimated:YES completion:^{
        
        GIDSignIn *signIn = [GIDSignIn sharedInstance];
        
        signIn.uiDelegate = (id<GIDSignInUIDelegate>)vc;
        
        [signIn signIn];

    }];
    
}

- (void)shareGoogle
{
    
}

@end
