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

@interface DetailViewController () <UIAlertViewDelegate>



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
    
    FacebookActivity *activtyFacebook = [[FacebookActivity alloc]initWithImage:self.image];
    TwitterActivity *activityTwitter = [[TwitterActivity alloc]init];
    GoogleActivity *activityGoogle = [[GoogleActivity alloc]init];
    
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:@[activtyFacebook, activityTwitter, activityGoogle] applicationActivities:@[activtyFacebook, activityTwitter, activityGoogle]];
    
    [self.navigationController presentViewController:activityVC animated:YES completion:nil];

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
