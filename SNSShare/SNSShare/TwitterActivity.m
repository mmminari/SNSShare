//
//  TwitterActivity.m
//  SNSShare
//
//  Created by 김민아 on 2017. 2. 9..
//  Copyright © 2017년 김민아. All rights reserved.
//

#import "TwitterActivity.h"
#import "SNSClass.h"

@interface TwitterActivity ()

@property (strong, nonatomic) UIViewController *vc;
@property (strong, nonatomic) UIImage *image;

@end

@implementation TwitterActivity

- (instancetype)initWithViewController:(UIViewController *)vc image:(UIImage *)image
{
    if(self = [super init])
    {
        self.vc = vc;
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
    // 뷰의 계층관계 때문에 shareView를 띄워주기 전에 기존의 activityVC를 내려주어야 함
    [self.vc dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"twitter share");
    
    SNSClass *sns = [[SNSClass alloc]init];
    
    if([sns checkTwitterToken])
    {
        [sns shareTwitterWithViewController:self.vc image:self.image];
    }
    else
    {
        [sns doTwitterLoginSelf:self.vc WithCompletion:^{
            
            [sns shareTwitterWithViewController:self.vc image:self.image];
            
        }];
    }
}

@end
