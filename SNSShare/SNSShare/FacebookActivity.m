//
//  FacebookActivity.m
//  SNSShare
//
//  Created by 김민아 on 2017. 2. 9..
//  Copyright © 2017년 김민아. All rights reserved.
//

#import "FacebookActivity.h"
#import "SNSClass.h"

@interface FacebookActivity ()

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIViewController *vc;

@end

@implementation FacebookActivity

- (instancetype)initWithImage:(UIImage *)image viewController:(UIViewController *)vc
{
    if(self = [super init])
    {
        self.image = image;
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
    NSString *result = @"Facebook";
    
    return result;
}

- (nullable UIActivityType)activityType
{
    return UIActivityTypePostToFacebook;
}

- (nullable UIImage *)activityImage
{
    UIImage *result = [UIImage imageNamed:@"facebook_icon"];
    
    
    return result;
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItem
{
    return YES;
}

// 눌렀을 때 실행될 액션들
- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    NSLog(@"facebook share");
    
    SNSClass *sns = [[SNSClass alloc]init];
    
    if([sns checkFacebookToken])
    {
        [sns shareFacebookWithImage:self.image viewController:self.vc];
    }
    else
    {
        [sns doFacebookLoginSelf:self.activityViewController WithCompletion:^{
            
            [sns shareFacebookWithImage:self.image viewController:self.vc];
        }];
    }
}

@end
