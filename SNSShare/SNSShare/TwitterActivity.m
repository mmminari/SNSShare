//
//  TwitterActivity.m
//  SNSShare
//
//  Created by 김민아 on 2017. 2. 9..
//  Copyright © 2017년 김민아. All rights reserved.
//

#import "TwitterActivity.h"

@interface TwitterActivity ()

@end

@implementation TwitterActivity

+ (UIActivityCategory)activityCategor
{
    return UIActivityCategoryShare;
}

- (nullable NSString *)activityTitle
{
    NSString *result = @"Twitter";
    
    return result;
}

- (nullable UIActivityType)activityType
{
    return UIActivityTypePostToTwitter;
}

- (nullable UIImage *)activityImage
{
    UIImage *result = [UIImage imageNamed:@"twitter_icon"];
    
    return result;
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItem
{
    return YES;
}

// 눌렀을 때 실행될 액션들
- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    if([self.delegate respondsToSelector:@selector(didTouchTwitterButton)])
    {
        [self.delegate didTouchTwitterButton];
    }

}

@end
