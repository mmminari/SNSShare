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

@interface SNSClass () <FBSDKSharingDelegate>

@end

@implementation SNSClass

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

@end
