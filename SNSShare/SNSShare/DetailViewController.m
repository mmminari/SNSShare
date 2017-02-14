//
//  DetailViewController.m
//  SNSShare
//
//  Created by 김민아 on 2017. 2. 8..
//  Copyright © 2017년 김민아. All rights reserved.
//

#import "DetailViewController.h"
#import "FacebookActivity.h"
#import "TwitterActivity.h"
#import "GoogleActivity.h"

#import <Google/SignIn.h>
#import <FBSDKShareKit/FBSDKShareKit.h>


@interface DetailViewController () <UIAlertViewDelegate, GIDSignInUIDelegate, FBSDKSharingDelegate>

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotification:) name:@"ImageSetting" object:nil];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"image : %@", self.image);
    
    self.ivDetail.image = self.image;
}

#pragma mark - User Action
- (IBAction)touchedBackButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)touchedShareButton:(UIButton *)sender
{
    
    FacebookActivity *activtyFacebook = [[FacebookActivity alloc]initWithImage:self.image viewController:self];
    TwitterActivity *activityTwitter = [[TwitterActivity alloc]initWithViewController:self image:self.image];
    GoogleActivity *activityGoogle = [[GoogleActivity alloc]initWithViewController:self];
    
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:@[activtyFacebook, activityTwitter, activityGoogle] applicationActivities:@[activtyFacebook, activityTwitter, activityGoogle]];
    
    [self presentViewController:activityVC animated:YES completion:nil];

}

#pragma mark - GIDSignInUIDelegate
- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - SFBSDKSharingDelegate
- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results
{
    NSLog(@"did complete to share with facebook");
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error
{
    NSLog(@"did fail to share with facebook");
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer
{
    NSLog(@"did cancel to share with facebook");
    
}


#pragma mark - NSNotification
- (void)didReceiveNotification:(NSNotification *)noti
{
    NSLog(@"noti : %@", noti);
    
    NSDictionary *userInfo = noti.userInfo;
    
    self.image = [userInfo objectForKey:@"userInfo"];
    
    self.ivDetail.image = self.image;
    
    [self.view layoutIfNeeded];

}


@end
