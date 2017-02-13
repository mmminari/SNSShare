//
//  GoogleActivity.m
//  SNSShare
//
//  Created by 김민아 on 2017. 2. 9..
//  Copyright © 2017년 김민아. All rights reserved.
//

#import "GoogleActivity.h"
#import "SNSClass.h"

@interface GoogleActivity ()

@property (strong, nonatomic) UIViewController *vc;

@end

@implementation GoogleActivity

- (instancetype)initWithViewController:(UIViewController *)vc
{
    if(self = [super init])
    {
        self.vc = vc;
    }
    
    return self;
}

+ (UIActivityCategory)activityCategor
{
    return UIActivityCategoryShare;
}

- (nullable NSString *)activityTitle
{
    NSString *result = @"Google";
    
    return result;
}

- (nullable UIActivityType)activityType
{
    return UIActivityTypePostToFacebook;
}

- (nullable UIImage *)activityImage
{
    UIImage *result = [UIImage imageNamed:@"google_icon"];
    
    
    return result;
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItem
{
    return YES;
}

// 눌렀을 때 실행될 액션들
- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    NSLog(@"google share");
    
    SNSClass *sns = [[SNSClass alloc]init];
    
    if([sns checkGoogleToken])
    {
        
    }
    else
    {
        [sns doGoogleLoginWithViewController:self.vc];
    }
}

@end
