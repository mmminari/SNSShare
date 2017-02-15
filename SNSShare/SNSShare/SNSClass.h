//
//  SNSClass.h
//  SNSShare
//
//  Created by 김민아 on 2017. 2. 9..
//  Copyright © 2017년 김민아. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//Facebook
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

//Twitter
#import <TwitterKit/TwitterKit.h>
#import <Fabric/Fabric.h>

//Google
#import <Google/SignIn.h>

//Activities
#import "FacebookActivity.h"
#import "TwitterActivity.h"
#import "GoogleActivity.h"

@interface SNSClass : UIViewController

- (instancetype)initWithViewController:(UIViewController *)vc image:(UIImage *)image;
- (UIActivityViewController *)getActivityViewControllerWithActivites;

- (BOOL)checkFacebookToken;
- (void)doFacebookLoginSelf:(UIViewController *)selfVC WithCompletion:(void (^)(void))completion;
- (void)shareFacebookWithImage:(UIImage *)image viewController:(UIViewController *)vc;

- (BOOL)checkTwitterToken;
- (void)doTwitterLoginSelf:(UIViewController *)selfVC WithCompletion:(void(^)(void))completion;
- (void)shareTwitterWithViewController:(UIViewController *)vc image:(UIImage *)image;

- (BOOL)checkGoogleToken;
- (void)doGoogleLoginWithViewController:(UIViewController *)vc;


@end
