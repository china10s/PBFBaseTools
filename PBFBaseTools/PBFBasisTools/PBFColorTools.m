//
//  PBFColorTools.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/4/14.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import "PBFColorTools.h"

@implementation PBFColorTools

+(CGColorRef) getColorRefFromRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha
{
    CGFloat r = (CGFloat) red/255.0;
    CGFloat g = (CGFloat) green/255.0;
    CGFloat b = (CGFloat) blue/255.0;
    CGFloat a = (CGFloat) alpha;
    CGFloat components[4] = {r,g,b,a};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef color = (CGColorRef)CGColorCreate(colorSpace, components) ;
    CGColorSpaceRelease(colorSpace);
    
    return color;
}

+(UIColor*) getColorFromRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha
{
    CGFloat r = (CGFloat) red/255.0;
    CGFloat g = (CGFloat) green/255.0;
    CGFloat b = (CGFloat) blue/255.0;
    CGFloat a = (CGFloat) alpha;
    return [UIColor colorWithRed:r green:g blue:b alpha:a];;
}

+ (UIImage*) createImageWithColor:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha
{
    UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

//UIColor转换为UIImage
+ (UIImage*) createImageWithColor:(UIColor*)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

//16进制字符串转换为颜色
+ (UIColor*)getColorFromHexString:(NSString*)strHex{
    if (!strHex || [strHex length] != 7) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange rang;
    rang.length = 2;
    rang.location = 1;
    [[NSScanner scannerWithString:[strHex substringWithRange:rang]] scanHexInt:&red];
    rang.location = 3;
    [[NSScanner scannerWithString:[strHex substringWithRange:rang]] scanHexInt:&green];
    rang.location = 5;
    [[NSScanner scannerWithString:[strHex substringWithRange:rang]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
}

@end