//
//  PBFMacroView.h
//  Halo
//
//  Created by zhulin on 16/5/15.
//  Copyright © 2016年 inno-asiatech. All rights reserved.
//

#ifndef PBFViewMacro_h
#define PBFViewMacro_h

//整个主屏幕大小
#define kPBFMacroViewMainScreenSize                 [UIScreen mainScreen].bounds.size
//去除StatusBar和NavigationBar之后的Rect
#define kPBFMacroViewRectWithoutStatusNavi          CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)
//去除StatusBar和NavigationBar和TabBar之后的Rect
#define kPBFMacroViewRectWithoutStatusNaviTabBar    CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-113)
//去除StatusBar和NavigationBar之后的Rect
#define kPBFMacroViewRectWithoutTabBar              CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-49)

#endif /* PBFViewMacro_h */