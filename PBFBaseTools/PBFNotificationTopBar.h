//
//  PBFNotificationTopBar.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/1/6.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PBFNotificationTopBarDatasource
//装备View
- (void)assmebleViewTopBar:(UIView *)view;
@end

@interface PBFNotificationTopBar : UIView
//高度
@property (nonatomic,assign)float               fBarHeight;
//背景色
@property (nonatomic,strong)UIColor             *colBackground;

//是否隐藏
@property (nonatomic,assign)BOOL                isHided;

@property (nonatomic,weak)id<PBFNotificationTopBarDatasource>     datasource;

//弹出提示条
- (void)show;
//取消提示条
- (void)hide;
@end