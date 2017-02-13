//
//  SNSClass.h
//  SNSShare
//
//  Created by 김민아 on 2017. 2. 9..
//  Copyright © 2017년 김민아. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SNSClass : NSObject 

- (BOOL)checkFacebookToken;
- (void)doFacebookLoginSelf:(UIViewController *)selfVC WithCompletion:(void (^)(void))completion;
- (void)shareFacebookWithImage:(UIImage *)image;

- (BOOL)checkTwitterToken;
- (void)doTwitterLoginSelf:(UIViewController *)selfVC WithCompletion:(void(^)(void))completion;
- (void)shareTwitterWithViewController:(UIViewController *)vc image:(UIImage *)image;

- (BOOL)checkGoogleToken;
- (void)doGoogleLoginWithViewController:(UIViewController *)vc;


@end
