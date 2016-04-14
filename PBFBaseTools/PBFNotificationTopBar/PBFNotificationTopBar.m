//
//  PBFNotificationTopBar.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/1/6.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import "PBFNotificationTopBar.h"

@implementation PBFNotificationTopBar
- (instancetype)init{
    self.isHided = TRUE;
    //高度
    self.fBarHeight = 44;
    //背景色
    self.colBackground = [UIColor colorWithRed:1 green:226/255.0f blue:179/255.0f alpha:1];
    self = [super initWithFrame:CGRectMake(0, -self.fBarHeight, [UIScreen mainScreen].bounds.size.width, self.fBarHeight)];
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    //背景色
    [self setBackgroundColor:self.colBackground];
    //高度
    CGRect rectAll = self.superview.frame;
    rectAll.size.height = self.fBarHeight;
    [self setFrame:rectAll];
}

//弹出提示条
- (void)show{
    if (self.datasource) {
        [self.datasource assmebleViewTopBar:self];
    }
    
    self.isHided = FALSE;
    CGRect rectAll = self.superview.frame;
    rectAll.size.height = self.fBarHeight;
    rectAll.origin.y = -self.fBarHeight;
    [self setFrame:rectAll];
    
    [UIView animateWithDuration:1.0f delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect rectNew = self.frame;
        rectNew.origin.y = 0;
        [self setFrame:rectNew];
    } completion:^(BOOL finished) {
        
    }];
}

//取消提示条
- (void)hide{
    self.isHided = TRUE;
    [UIView animateWithDuration:0.2f animations:^{
        CGRect rectNew = self.frame;
        rectNew.origin.y = -self.fBarHeight;
        [self setFrame:rectNew];
    }];
}

@end