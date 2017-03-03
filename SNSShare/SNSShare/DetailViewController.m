//
//  DetailViewController.m
//  SNSShare
//
//  Created by 김민아 on 2017. 2. 8..
//  Copyright © 2017년 김민아. All rights reserved.
//

#import "DetailViewController.h"
#import "SNSClass.h"
#import "HTTPClient.h"

@interface DetailViewController () <UIAlertViewDelegate, GIDSignInUIDelegate, FBSDKSharingDelegate>

@property (strong, nonatomic) SNSClass *sns;
@property (strong, nonatomic) HTTPClient *httpClient;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotification:) name:@"ImageSetting" object:nil];
    
    self.httpClient = [[HTTPClient alloc]initWithBaseURL];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"image : %@", self.image);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.ivDetail.image = self.image;
        
    });
}

#pragma mark - User Action
- (IBAction)touchedBackButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)touchedShareButton:(UIButton *)sender
{
    self.sns = [[SNSClass alloc]initWithViewController:self image:self.image];
    
    [self presentViewController:[self.sns getActivityViewControllerWithActivites] animated:YES completion:nil];

}

- (IBAction)touchedUplaodButton:(UIButton *)sender
{
    [self reqLogin];
}

#pragma mark - Reqeuest

- (void)reqLogin
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:@"yonghwinam@smtown.com" forKey:@"userID"];
    [param setObject:@"apple0000" forKey:@"userPassword"];
    [param setObject:@"autoLogin" forKey:@"Y"];
    
    NSDictionary *resigsterDevice =
    @{
      @"deviceToken":@"token",
      @"deviceType":@"ios",
      @"version":@"1",
      @"lang":@"ko",
      @"isPushOn":[NSNumber numberWithBool:TRUE],
      @"isPushDebug":[NSNumber numberWithBool:TRUE]
      };
    
    [param setObject:resigsterDevice forKey:@"registerDevice"];
    
    [self.httpClient POSTWithUrlString:@"/auth" parameters:param success:^(id results) {
        
        NSLog(@"Login Result : %@", results);
        
        [self reqUploadImage];

    } failure:^(NSError *error) {
        NSLog(@"Login Error : %@", error.description);
    }];
}

- (void)reqUploadImage
{
    NSLog(@"height : %f, width : %f", self.image.size.height, self.image.size.width);
    
    NSData *imageData = UIImageJPEGRepresentation(self.image, 1.0f);
    
    [self.httpClient UPLOADWithUrlString:@"/aws/image" data:imageData success:^(id responseObject) {
        
        NSLog(@"success : %@", responseObject);
        
        [self successCompletionOfReqUploadImageWithResult:responseObject];
        
    } failure:^(NSError *error) {
        
        NSLog(@"error : %@", error.description) ;
        
    }];
}

- (void)successCompletionOfReqUploadImageWithResult:(id)result
{
    NSInteger code = [[result objectForKey:@"code"]integerValue];
    
    NSString *message = [result objectForKey:@"message"];
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%zd", code] message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
    
    [controller addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:controller animated:YES completion:nil];
    });
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
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.ivDetail.image = self.image;
        
    });
    [self.view layoutIfNeeded];

}


@end
