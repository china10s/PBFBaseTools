//
//  PBFSpringEffectAlertView.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/1/6.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//
//
//跳跃动态弹框

#import <UIKit/UIKit.h>

@interface PBFSpringEffectAlertView : UIView

- (instancetype)initWithSize:(CGSize)size;

//弹出
- (void)show;

//弹回
- (void)hide;

@end