//
//  PBFViewTools.m
//  PBFBaseToolsDemo
//
//  Created by BY-MAC01 on 16/4/14.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import "PBFViewTools.h"
#import <UIKit/UIKit.h>

@implementation PBFViewTools

//清除所有子View
+ (void)removeAllSubviews:(UIView*)parentView{
    if(![parentView subviews] || [[parentView subviews] count] <= 0){
        return [parentView removeFromSuperview];
    }
    for(UIView *viewSub in parentView.subviews){
        [self removeAllSubviews:viewSub];
    }
}

//为主View获取合适的CGRect
+ (CGRect)getFitRectForMainView:(UIViewController*)viewCtrl{
    int iLengthSub = 0;
    //是否存在StatusBar
    if (![[UIApplication sharedApplication] isStatusBarHidden]) {
        iLengthSub += 20;
    }
    //是否存在NaviBar
    if (!viewCtrl.navigationController.isNavigationBarHidden) {
        iLengthSub += 44;
    }
    //是否存在ButtomTab
    if(!viewCtrl.tabBarController.tabBar.isHidden){
        iLengthSub += 49;
    }
    return CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-iLengthSub);
}

@end