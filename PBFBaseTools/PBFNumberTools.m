//
//  PBFNumberTools.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/11/25.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//

#import "PBFNumberTools.h"
#import "PBFNSStringTools.h"

@implementation PBFNumberTools
//非四舍五入
+ (NSString*)noRound:(double)number decimal:(int)position{
    long lIndex = pow(10, position);
    NSString *strTotalNumber = [NSString stringWithFormat:@"%.2f",floor(number*lIndex)/lIndex];
    NSString *strFormat = [NSString stringWithFormat:@"%%.%df",position];
    return [NSString stringWithFormat:strFormat,[strTotalNumber doubleValue]];
}

//是否纯数字
+ (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

//是否纯数字
+ (BOOL)isPureLong:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    long val;
    return [scan scanInteger:&val] && [scan isAtEnd];
}

//是否纯字母
+ (BOOL)isPureChar:(NSString*)string{
    return [PBFNSStringTools isRegularString:@"^[A-Za-z]+$" strText:string];
    
//    NSScanner* scan = [NSScanner scannerWithString:string];
//    long val;
//    return ![scan scanInteger:&val];
}

//是否是身份真
+ (BOOL)isChineseIDCardNumber:(NSString*)string{
    //验证身份证号
    if([string length] != 15 && [string length] != 18){
        return FALSE;
    }
    //长度为15
    if ([string length] == 15 && [PBFNumberTools isPureLong:string]){
        return TRUE;
    }
    //长度为18
    if ([string length] == 18) {
        //是不是纯数字
        if (![PBFNumberTools isPureFloat:string]) {
            //前面17位是不是数字
            NSString *strPerNumber = [string substringToIndex:17];
            if (![PBFNumberTools isPureLong:strPerNumber]) {
                return FALSE;
            }
            //最后一位是不是x、X
            if(![PBFNSStringTools isEndWithString:@"X" strText:string] &&
               ![PBFNSStringTools isEndWithString:@"x" strText:string]){
                return FALSE;
            }
        }
        return TRUE;
    }
    return FALSE;
}

@end