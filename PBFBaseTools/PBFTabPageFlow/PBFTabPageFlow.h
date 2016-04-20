//
//  PBFTabPageFlow.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/4/14.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//
//滑动tab页面

#import <UIKit/UIKit.h>

@interface PBFTabPageFlow : UIViewController<UIScrollViewDelegate>
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

//当前页
@property (nonatomic,assign)long                    iCurPageIndex;

//初始化
- (instancetype)initWithControl:(NSString*)strName;
- (void)setControls:(NSArray*)arryCtrls;

//初始化
- (instancetype)initWithControl:(NSString*)strName arryCtrls:(NSArray*)arryCtrls;

//指定滚动到某一页
- (void)baseScrollToPage:(long)pag;
@end