//
//  PBFSimplePieChartView.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/1/19.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//
//  简单饼状图

#import <UIKit/UIKit.h>

@interface PBFSimplePieChartViewItem:NSObject
//比例
@property (nonatomic,assign)float               percent;//0.1
//背景色
@property (nonatomic,strong)UIColor             *bgColor;//
@end

@interface PBFSimplePieChartView : UIView

//背景色
@property (nonatomic,strong)UIColor             *colBackground;

//中心背景色
@property (nonatomic,strong)UIColor             *colBackgroundCenter;

//元素之间间距
@property (nonatomic,assign)float               fItemGap;

//饼状图元素
@property (nonatomic,strong)NSArray             *arrPiesTarget;//PBFSimplePieChartViewItem

//边框占比
@property (nonatomic,assign)float               fBorderRatio;

@end