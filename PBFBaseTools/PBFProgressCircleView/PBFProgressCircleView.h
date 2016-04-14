//
//  PBFProgressCircleView.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/1/19.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//
//
//  圆形进度条

#import <UIKit/UIKit.h>

@interface PBFProgressCircleView : UIView

//背景色
@property (nonatomic,strong)UIColor                     *backgroundCol;
//未完成时候，进度色
@property (nonatomic,strong)UIColor                     *progressColUnfinished;
//已完成时候，进度色
@property (nonatomic,strong)UIColor                     *progressColfinished;
//字体
@property (nonatomic,strong)UIFont                      *fontLabel;

//边框宽度
@property (nonatomic,assign)float                       borderWidth;
//百分比
@property (nonatomic,assign)float                       targetPercent;

@end