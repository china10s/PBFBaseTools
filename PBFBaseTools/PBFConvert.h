//
//  PBFConvert.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/5/6.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface PBFConvert : NSObject

//CGColor与CGColorRef之间的转换
+(CGColorRef) getColorRefFromRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha;

//CGColor与CGColorRef之间的转换
+(UIColor*) getColorFromRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha;

//UIColor转换为UIImage
+ (UIImage*) createImageWithColor:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha;

//UIColor转换为UIImage
+ (UIImage*) createImageWithColor:(UIColor*)color;

//对象与数组之间的转换
+ (void)assembleObject:(Class)rtnType objRes:(NSDictionary*)objRes arrRtn:(NSMutableArray*)arrRtn;

//16进制字符串转换为颜色
+ (UIColor*)getColorFromHexString:(NSString*)strHex;

@end