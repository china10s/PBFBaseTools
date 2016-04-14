//
//  PBFViewTools.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/5/5.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class MBProgressHUD;

@interface PBFViewTools : NSObject<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
+ (instancetype)sharedInstance;
///////////////////////////////////////////////菊花等待框
@property (nonatomic,strong)MBProgressHUD                                   *HUDPross;      //进度等待框
@property (nonatomic,strong)MBProgressHUD                                   *HUDComplete;   //进度完成框
@property (nonatomic,strong)MBProgressHUD                                   *HUDAlertInfo;  //提示框
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
///////////////////////////////////////////////toats提示框
typedef void(^ToastComplete)();
- (void)showToastMsg:(UIView*)viewParent strMess:(NSString*)strMess;
- (void)showToastMsg:(UIView*)viewParent strMess:(NSString*)strMess blockComplete:(ToastComplete)blockComplete;
- (void)showToastMsg:(UIView*)viewParent strMess:(NSString*)strMess iTime:(unsigned int)iTime;
- (void)showToastMsg:(UIView*)viewParent strMess:(NSString*)strMess iTime:(unsigned int)iTime blockComplete:(ToastComplete)blockComplete;

///////////////////////////////////////////////提示框
typedef void(^AlertBtnClickBlock)(long btnIndex);
@property(nonatomic,strong)AlertBtnClickBlock           alertBlock;
- (void)showSimpleAlertView:(NSString *)title message:(NSString *)message  backBlock:(AlertBtnClickBlock)backBlock cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;
- (void)showAlterView:(NSString *)title message:(NSString *)message parentViewCtrl:(UIViewController*)parentViewCtrl textAlign:(NSTextAlignment)textAlign backBlock:(AlertBtnClickBlock)backBlock cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

//清除所有子View
- (void)removeAllSubviews:(UIView*)parentView;
@end