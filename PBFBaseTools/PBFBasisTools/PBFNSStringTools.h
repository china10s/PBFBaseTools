//
//  PBFNSStringTools.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/6/3.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PBFNSStringTools : NSObject
#pragma mark - StringScan
//以开始
+ (BOOL)isStartWithString:(NSString*)strStartString strText:(NSString*)strWholeString;
//以结束
+ (BOOL)isEndWithString:(NSString*)strStartString strText:(NSString*)strWholeString;
//正则表达式判断,是否包含
+ (BOOL)isRegularString:(NSString*)strRegularString strText:(NSString*)strWholeString;

#pragma mark - StringEncode
//Encode
+ (NSString *)URLEncodedString:(NSString*)stringInput;
//Decode
+ (NSString*)URLDecodedString:(NSString*)stringInput;
@end