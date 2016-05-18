//
//  PBFViewTools.h
//  PBFBaseToolsDemo
//
//  Created by BY-MAC01 on 16/4/14.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//
//UIView工具

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class UIView;

@interface PBFViewTools : NSObject

//清除所有子View
+ (void)removeAllSubviews:(UIView*)parentView;

//为主View获取合适的CGRect
+ (CGRect)getFitRectForMainView:(UIViewController*)viewCtrl;

@end