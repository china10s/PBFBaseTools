//
//  PBFNSStringTools.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/6/3.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import "PBFNSStringTools.h"

@implementation PBFNSStringTools
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

//以开始
+ (BOOL)isStartWithString:(NSString*)strStartString strText:(NSString*)strWholeString{
    if (!strStartString || !strWholeString ||
        [strStartString length] <= 0 ||
        [strWholeString length] <= 0 ||
        [strStartString length] > [strWholeString length]) {
        return FALSE;
    }
    long lWholeLength = [strWholeString length];
    long lStartLength = [strStartString length];
    NSString *strSubString = [strWholeString substringToIndex:lStartLength];
    if ([strSubString isEqualToString:strStartString]) {
        return TRUE;
    }
    else{
        return FALSE;
    }
}
//以结束
+ (BOOL)isEndWithString:(NSString*)strStartString strText:(NSString*)strWholeString{
    if (!strStartString || !strWholeString ||
        [strStartString length] <= 0 ||
        [strWholeString length] <= 0 ||
        [strStartString length] > [strWholeString length]) {
        return FALSE;
    }
    long lWholeLength = [strWholeString length];
    long lStartLength = [strStartString length];
    NSString *strSubString = [strWholeString substringFromIndex:lWholeLength-lStartLength];
    if ([strSubString isEqualToString:strStartString]) {
        return TRUE;
    }
    else{
        return FALSE;
    }
}

//正则表达式判断,是否包含
+ (BOOL)isRegularString:(NSString*)strRegularString strText:(NSString*)strWholeString{
    if (!strRegularString || !strWholeString ||
        [strRegularString length] <= 0 ||
        [strWholeString length] <= 0 ) {
        return FALSE;
    }
    NSRange range = [strWholeString rangeOfString:strRegularString options:NSRegularExpressionSearch];
    if (range.location == NSNotFound) {
        return FALSE;
    }
    else{
        return TRUE;
    }
}

//Encode
+ (NSString *)URLEncodedString:(NSString*)stringInput{
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)stringInput,
                                            NULL,
                                            CFSTR("!*'();:@&=+$,/?%#[] "),
                                            kCFStringEncodingUTF8);
    return result;
}

//Decode
+ (NSString*)URLDecodedString:(NSString*)stringInput{
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                            (CFStringRef)stringInput,
                                                            CFSTR(""),
                                                            kCFStringEncodingUTF8);
    return result; 
}

@end