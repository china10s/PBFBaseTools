//
//  PBFSpringEffectAlertView.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/1/6.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import "PBFSpringEffectAlertView.h"

@interface PBFSpringEffectAlertView()
//内容View
@property (nonatomic,strong)UIView                  *VIEWContent;
//背景View
@property (nonatomic,strong)UIView                  *VIEWBackground;
@end

@implementation PBFSpringEffectAlertView
//重载该函数实现弹出框内容
//装备View
- (void)assmebleViewContent:(UIView *)VIEWContent{
    
}

//重载该函数实现弹出框内容
//装备View
- (void)assmebleViewBackground:(UIView *)VIEWBackground{
    
}

/////////////////////////////////////////////////////////////////
- (instancetype)initWithSize:(CGSize)size{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    [self setBackgroundColor:[UIColor clearColor]];
    
    //半透明背景
    self.VIEWBackground = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.VIEWBackground setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7f]];
    [self addSubview:self.VIEWBackground];
    
    //白色内容框
    CGRect rect = [UIScreen mainScreen].bounds;
    self.VIEWContent = [[UIView alloc] initWithFrame:CGRectMake(0, 0,size.width, size.height)];
    [self.VIEWContent setBackgroundColor:[UIColor whiteColor]];
    [self.VIEWContent.layer setCornerRadius:3.0f];
    self.VIEWContent.center = CGPointMake(rect.size.width/2, rect.size.height/2);
    [self addSubview:self.VIEWContent];
    
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    //装配背景内容
    [self assmebleViewBackground:self];
    //装配内容框
    [self assmebleViewContent:self.VIEWContent];
}

//弹出
- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    CGRect rect = [UIScreen mainScreen].bounds;
    CGRect rectBackground = self.VIEWContent.frame;
    rectBackground.origin.y = -rectBackground.size.height;
    [self.VIEWContent setFrame:rectBackground];
    [self.VIEWContent setAlpha:0];
    [UIView animateWithDuration:0.7f delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.VIEWContent.center = CGPointMake(rect.size.width/2, rect.size.height/2);
        [self.VIEWContent setAlpha:1];
    } completion:^(BOOL finished) {
        
    }];
}

//弹回
- (void)hide{
    [UIView animateWithDuration:0.3f animations:^{
        CGRect rectBackground = self.VIEWContent.frame;
        rectBackground.origin.y = -rectBackground.size.height;
        [self.VIEWContent setFrame:rectBackground];
        [self.VIEWContent setAlpha:0];
    } completion:^(BOOL finished) {
        if([self superview]){
            [self removeFromSuperview];
        }
    }];
}

@end