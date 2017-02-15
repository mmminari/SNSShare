//
//  ParentActivity.h
//  SNSShare
//
//  Created by 김민아 on 2017. 2. 14..
//  Copyright © 2017년 김민아. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActivityDelegate <NSObject>

- (void)didTouchFacebookButton;
- (void)didTouchTwitterButton;
- (void)didTouchGoogleButton;

@end

@interface ParentActivity : UIActivity

@property (weak, nonatomic) id<ActivityDelegate> delegate;

@end
