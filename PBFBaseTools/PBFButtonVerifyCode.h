//
//  PBFButtonVerifyCode.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/12/16.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//
//验证码发送按钮

#import <UIKit/UIKit.h>

typedef void(^PBFButtonVerifyCodeBlock)();

@interface PBFButtonVerifyCode : UIButton
//验证码初始化
- (instancetype)initWithVerify:(PBFButtonVerifyCodeBlock)block;

//倒数时间间隔
@property (nonatomic,assign)long                    lTimeGapLen;
//发送
@property (nonatomic,strong)NSString                *strBtnNormalTitle;
//重发(%@)
@property (nonatomic,strong)NSString                *strBtnUnableTitle;

//开始计时
- (void)fire;
//重置状态
- (void)recover;

@end