//
//  PBFViewCtrlTabPage.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/7/24.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//
//顶部TAB页

#import <UIKit/UIKit.h>

@interface PBFViewCtrlTabPage : UIViewController<UIScrollViewDelegate>
//按钮背景色
@property (nonatomic,strong)UIColor                 *colBtnBackground;
//按钮选中前景色
@property (nonatomic,strong)UIColor                 *colBtnSelForeColor;
//按钮未选中前景色
@property (nonatomic,strong)UIColor                 *colBtnUnSelForeColor;
//标志背景色
@property (nonatomic,strong)UIColor                 *colFlagBackground;
//标志前景色
@property (nonatomic,strong)UIColor                 *colFlagForeColor;

@property (nonatomic,assign)int                     iCurPageIndex;      //当前页

//初始化
- (instancetype)initWithControl:(NSString*)strName;
- (void)setControls:(NSArray*)arryCtrls;

//初始化
- (instancetype)initWithControl:(NSString*)strName arryCtrls:(NSArray*)arryCtrls;

//指定滚动到某一页
- (void)baseScrollToPage:(long)pag;

@end
