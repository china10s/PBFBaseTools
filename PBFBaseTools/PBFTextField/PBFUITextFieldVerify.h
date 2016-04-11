//
//  PBFUITextFieldVerify.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/12/22.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//
//
//  UITextField控制文字类型

#import <UIKit/UIKit.h>

//增加组件
@protocol PBFUITextFieldVerifyAdditionDelegate
- (void)additionComponent:(UITextField*)textField;
@end

//验证策略
@protocol PBFUITextFieldVerifyStrategyDelegate
- (BOOL)isValidate:(NSString *)strText;
@end

@interface PBFUITextFieldVerify : UITextField
- (instancetype)initWithStrategy;
- (instancetype)initWithStrategyFrame:(CGRect)rect;
- (void)addAddition:(id<PBFUITextFieldVerifyAdditionDelegate>)addition;
- (void)addStrategy:(id<PBFUITextFieldVerifyStrategyDelegate>)strategyItem;
@end