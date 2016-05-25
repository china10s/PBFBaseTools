//
//  PBFNotifyLoadingViewTools.h
//  PBFBaseToolsDemo
//
//  Created by BY-MAC01 on 16/4/14.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//
// 菊花等待框

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MBProgressHUD;

@interface PBFNotifyLoadingViewTools : NSObject
+ (instancetype)sharedInstance;
//显示菊花等待框子
- (void)showLoadingView:(BOOL)showShadow;
//颤抖菊花等待框
- (void)showLoadingView:(UIView *)parentView showShadow:(BOOL)showShadow;
//显示菊花等待框子
- (void)showLoadingView:(UIView *)parentView strMess:(NSString*)strMess showShadow:(BOOL)showShadow;
//停止菊花等待框,完成任务
- (void)stopLoadingViewComplete;
//停止菊花等待框
- (void)stopLoadingView;
//停止菊花等待框
- (void)stopLoadingView:(NSString*)strMess;

@end
