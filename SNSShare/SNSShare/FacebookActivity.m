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

@end

@implementation FacebookActivity

- (instancetype)initWithImage:(UIImage *)image
{
    if(self = [super init])
    {
        self.image = image;
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
        [sns shareFacebookWithImage:self.image];
    }
    else
    {
        [sns doFacebookLoginSelf:self.activityViewController WithCompletion:^{
            
            [sns shareFacebookWithImage:self.image];
        }];
    }
}

@end
