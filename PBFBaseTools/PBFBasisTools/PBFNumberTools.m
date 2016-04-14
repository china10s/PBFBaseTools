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

//给金额变成千、万结尾
+ (NSString*)addChinaUnitToMoney:(double)moneyIn{
    if (moneyIn > 1000 && moneyIn < 10000) {
        return [NSString stringWithFormat:@"%.0f千",moneyIn/1000];
    }
    else if (moneyIn > 10000) {
        return [NSString stringWithFormat:@"%.0f万",moneyIn/10000];
    }
    return [NSString stringWithFormat:@"%.0f",moneyIn];
}

//给金额加上逗号
+ (NSString*)addCommaToMoney:(NSString*)strMoney{
    if (!strMoney || [strMoney length] <= 0) {
        return @"";
    }
    
    NSString    *strDecimal         = @"";
    NSRange     rangDec            = [strMoney rangeOfString:@"."];
    if (rangDec.length > 0) {
        strDecimal = [strMoney substringFromIndex:rangDec.location];
        strMoney = [strMoney substringToIndex:rangDec.location];
    }
    
    long        lSrtLen             = [strMoney length];
    ushort      uAlone              = lSrtLen%3;
    NSString    *strTmpLeft         = strMoney;
    NSString    *strMoneyComma      = @"";
    if (lSrtLen/3 >= 1) {
        if (uAlone > 0) {
            strTmpLeft = [strMoney substringFromIndex:uAlone];
            strMoneyComma = [strMoney substringToIndex:uAlone];
        }
        else{
            strTmpLeft = [strMoney substringFromIndex:3];
            strMoneyComma = [strMoney substringToIndex:3];
        }
        
        while ([strTmpLeft length]/3>0) {
            NSString *strTmpCur = [strTmpLeft substringToIndex:3];
            strTmpLeft = [strTmpLeft substringFromIndex:3];
            if ([strMoneyComma isEqualToString:@"+"] || [strMoneyComma isEqualToString:@"-"]) {
                strMoneyComma = [NSString stringWithFormat:@"%@%@",strMoneyComma,strTmpCur];
            }
            else{
                strMoneyComma = [NSString stringWithFormat:@"%@,%@",strMoneyComma,strTmpCur];
            }
        }
    }
    else{
        strMoneyComma = strMoney;
    }
    if (strDecimal && [strDecimal length] > 0) {
        strMoneyComma = [NSString stringWithFormat:@"%@%@",strMoneyComma,strDecimal];
    }
    
    return strMoneyComma;
}

@end