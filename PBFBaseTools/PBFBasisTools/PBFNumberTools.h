//
//  PBFNumberTools.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/11/25.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//
//数字处理

#import <Foundation/Foundation.h>

@interface PBFNumberTools : NSObject
//非四舍五入
+ (NSString*)noRound:(double)number decimal:(int)position;
//是否纯数字
+ (BOOL)isPureFloat:(NSString*)string;
//是否纯数字
+ (BOOL)isPureLong:(NSString*)string;
//是否纯字母
+ (BOOL)isPureChar:(NSString*)string;
//是否是身份真
+ (BOOL)isChineseIDCardNumber:(NSString*)string;
//给金额变成千、万结尾
+ (NSString*)addChinaUnitToMoney:(double)moneyIn;
//给金额加上逗号
+ (NSString*)addCommaToMoney:(NSString*)strMoney;
@end