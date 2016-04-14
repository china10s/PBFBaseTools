//
//  PBFContextGraphicsTools.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/7/7.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PBFContextGraphicsTools : NSObject
//绘制一条线
+ (void)drawLine:(UIView*)view fWidth:(double)fWidth color:(UIColor*)color aryPoints:(NSArray*)arryPoints;
@end
