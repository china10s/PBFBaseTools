//
//  PBFColorTools.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/4/14.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PBFColorTools : NSObject
//CGColor与CGColorRef之间的转换
+(CGColorRef) getColorRefFromRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha;

//CGColor与CGColorRef之间的转换
+(UIColor*) getColorFromRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha;

//UIColor转换为UIImage
+ (UIImage*) createImageWithColor:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha;

//UIColor转换为UIImage
+ (UIImage*) createImageWithColor:(UIColor*)color;

//16进制字符串转换为颜色
+ (UIColor*)getColorFromHexString:(NSString*)strHex;
@end
