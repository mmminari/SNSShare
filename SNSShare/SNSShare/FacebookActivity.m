//
//  FacebookActivity.m
//  SNSShare
//
//  Created by 김민아 on 2017. 2. 9..
//  Copyright © 2017년 김민아. All rights reserved.
//

#import "FacebookActivity.h"

@interface FacebookActivity ()

@end

@implementation FacebookActivity

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
    NSLog(@"self : %@", self.delegate);
    
    if([self.delegate respondsToSelector:@selector(didTouchFacebookButton)])
    {
        [self.delegate didTouchFacebookButton];
    }
    
    NSLog(@"facebook share");

}

@end
