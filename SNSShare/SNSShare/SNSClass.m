
//
//  SNSClass.m
//  SNSShare
//
//  Created by 김민아 on 2017. 2. 9..
//  Copyright © 2017년 김민아. All rights reserved.
//

#import "SNSClass.h"

@interface SNSClass () <TWTRComposerViewControllerDelegate, GIDSignInUIDelegate, ActivityDelegate>

@property (strong, nonatomic) UIViewController *vc;
@property (strong, nonatomic) UIImage *image;


@end

@implementation SNSClass

- (instancetype)initWithViewController:(UIViewController *)vc image:(UIImage *)image
{
    if(self = [super init])
    {
        self.vc = vc;
        self.image = image;
    }
    
    return self;
    
}

- (UIActivityViewController *)getActivityViewControllerWithActivites
{
    FacebookActivity *activtyFacebook = [[FacebookActivity alloc]init];
    TwitterActivity *activityTwitter = [[TwitterActivity alloc]init];
    GoogleActivity *activityGoogle = [[GoogleActivity alloc]init];
    
    activtyFacebook.delegate = self;
    activityTwitter.delegate = self;
    activityGoogle.delegate = self;
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:@[@"a", @"b"]
                                                                            applicationActivities:@[activtyFacebook, activityTwitter, activityGoogle]];
    
    [activityVC setCompletionWithItemsHandler:^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
        NSLog(@"completed: %@, \n%d, \n%@, \n%@,", activityType, completed, returnedItems, activityError);
        
    }];
    
    return activityVC;
    
}

#pragma mark - ActivityDelegate
- (void)didTouchFacebookButton
{
    [self.vc dismissViewControllerAnimated:YES completion:^{
        
        if([self checkFacebookToken])
        {
            [self shareFacebookWithImage:self.image viewController:self.vc];
        }
        else
        {
            [self doFacebookLoginSelf:self.vc WithCompletion:^{
                
                [self shareFacebookWithImage:self.image viewController:self.vc];
            }];
        }
    }];
}

- (void)didTouchTwitterButton
{
    [self.vc dismissViewControllerAnimated:YES completion:^{
        if([self checkTwitterToken])
        {
            [self shareTwitterWithViewController:self.vc image:self.image];
        }
        else
        {
            [self doTwitterLoginSelf:self.vc WithCompletion:^{
                
                [self shareTwitterWithViewController:self.vc image:self.image];
                
            }];
        }
    }];

}

- (void)didTouchGoogleButton
{
    [self.vc dismissViewControllerAnimated:YES completion:^{
        
        if([self checkGoogleToken])
        {
            NSLog(@"Google Share X");
        }
        else
        {
            [self doGoogleLoginWithViewController:self.vc];
        }
        
    }];

}

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

- (void)shareFacebookWithImage:(UIImage *)image viewController:(UIViewController *)vc
{
    FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
    
    photo.image = image;
    
    photo.userGenerated = YES;
    
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    
    content.photos = @[photo];
    
    [FBSDKShareAPI shareWithContent:content delegate:(id<FBSDKSharingDelegate>)vc];
    
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
    
    return NO;
}

- (void)doTwitterLoginSelf:(UIViewController *)selfVC WithCompletion:(void(^)(void))completion
{
    [[Twitter sharedInstance]logInWithViewController:selfVC
                                             methods:TWTRLoginMethodWebBasedForceLogin
                                          completion:^(TWTRSession * _Nullable session, NSError * _Nullable error) {
                                              
                                              if(completion)
                                                  completion();
        
    }];
}

- (void)shareTwitterWithViewController:(UIViewController *)vc image:(UIImage *)image
{
    TWTRComposer *composer = [[TWTRComposer alloc]init];
    
    [composer setImage:image];
    
    [composer showFromViewController:vc completion:^(TWTRComposerResult result) {
        
        NSLog(@"Twitter share : %zd", result);
        
        [vc.navigationController popViewControllerAnimated:YES];
        
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
