//
//  PBFSpringEffectAlertView.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/1/6.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//
//
//  动态弹出框

#import <UIKit/UIKit.h>

typedef enum {
    PBFSpringEffectAlertViewDisappearTypeBackgroundTapEnable,
    PBFSpringEffectAlertViewDisappearTypeBackgroundTapDisable
}PBFSpringEffectAlertViewDisappearType;

@interface PBFSpringEffectAlertView : UIView

- (instancetype)initWithSize:(CGSize)size;

- (instancetype)initWithSize:(CGSize)size disappearType:(PBFSpringEffectAlertViewDisappearType)disappearType;

//弹出
- (void)show;

//弹回
- (void)hide;

@end