//
//  PBFNotifyToastViewTools.h
//  PBFBaseToolsDemo
//
//  Created by BY-MAC01 on 16/4/14.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//
// toast提示框

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ToastComplete)();

@interface PBFNotifyToastViewTools : NSObject
+ (instancetype)sharedInstance;

- (void)showToastMsg:(UIView*)viewParent strMess:(NSString*)strMess;
- (void)showToastMsg:(UIView*)viewParent strMess:(NSString*)strMess blockComplete:(ToastComplete)blockComplete;
- (void)showToastMsg:(UIView*)viewParent strMess:(NSString*)strMess iTime:(unsigned int)iTime;
- (void)showToastMsg:(UIView*)viewParent strMess:(NSString*)strMess iTime:(unsigned int)iTime blockComplete:(ToastComplete)blockComplete;
@end