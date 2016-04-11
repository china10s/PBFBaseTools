//
//  PBFContextGraphicsTools.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/7/7.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import "PBFContextGraphicsTools.h"

@implementation PBFContextGraphicsTools

//绘制一条线
+ (void)drawLine:(UIView*)view fWidth:(double)fWidth color:(UIColor*)color aryPoints:(NSArray*)arryPoints{
    //绘制一条分割线
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:view.frame];
    [view addSubview:imgView];
    [view sendSubviewToBack:imgView];
    
    UIGraphicsBeginImageContext(view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [imgView.image drawInRect:view.frame];
    
    double fRed ;
    double fGreen ;
    double fBlue ;
    double fAlpha ;
    [color getRed:&fRed green:&fGreen blue:&fBlue alpha:&fAlpha];
    CGContextSetRGBStrokeColor(context, fRed, fGreen, fBlue, fAlpha);
    CGContextSetShouldAntialias(context, NO);//设置线条平滑，不需要两边像素宽
    CGContextSetLineWidth(context, fWidth);  //线宽
    CGContextBeginPath(context);
    
    NSValue *valueTmp = [arryPoints objectAtIndex:0];
    CGPoint pntTmp = [valueTmp CGPointValue];
    CGContextMoveToPoint(context, pntTmp.x, pntTmp.y);
    for ( int i = 1;i < [arryPoints count] ; ++i) {
        valueTmp = [arryPoints objectAtIndex:i];
        pntTmp = [valueTmp CGPointValue];
        CGContextAddLineToPoint(context, pntTmp.x,pntTmp.y);
    }
    
    CGContextStrokePath(context);
    imgView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

@end
