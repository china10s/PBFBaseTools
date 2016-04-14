//
//  PBFNotifyAlertViewTools.h
//  PBFBaseToolsDemo
//
//  Created by BY-MAC01 on 16/4/14.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//
//弹出式提示框

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^AlertBtnClickBlock)(long btnIndex);

@interface PBFNotifyAlertViewTools : NSObject<UIAlertViewDelegate>
+ (instancetype)sharedInstance;

- (void)showSimpleAlertView:(NSString *)title message:(NSString *)message  backBlock:(AlertBtnClickBlock)backBlock cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;
- (void)showAlterView:(NSString *)title message:(NSString *)message parentViewCtrl:(UIViewController*)parentViewCtrl textAlign:(NSTextAlignment)textAlign backBlock:(AlertBtnClickBlock)backBlock cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;
@end
