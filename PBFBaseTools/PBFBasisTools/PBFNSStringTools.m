//
//  PBFNSStringTools.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/6/3.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import "PBFNSStringTools.h"

@implementation PBFNSStringTools
#pragma mark - StringScan
//以开始
+ (BOOL)isStartWithString:(NSString*)strStartString strText:(NSString*)strWholeString{
    if (!strStartString || !strWholeString ||
        [strStartString length] <= 0 ||
        [strWholeString length] <= 0 ||
        [strStartString length] > [strWholeString length]) {
        return FALSE;
    }
//    long lWholeLength = [strWholeString length];
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

#pragma mark - StringEncode
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