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

@end