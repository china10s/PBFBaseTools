//
//  PBFDateTools.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/6/10.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PBFDateTools : NSObject
//获取年份
+ (NSInteger)getYearFromDate:(NSDate*)date;
//获取月份
+ (NSInteger)getMonthFromDate:(NSDate*)date;
//获取日份
+ (NSInteger)getDayFromDate:(NSDate*)date;

//获取星期
+ (NSInteger)getWeekdayFromDate:(NSDate*)date;

//获取时
+ (NSInteger)getHourFromDate:(NSDate*)date;
//获取分
+ (NSInteger)getMinuteFromDate:(NSDate*)date;
//获取秒
+ (NSInteger)getSecondFromDate:(NSDate*)date;

//按格式获取当前日期
+ (NSString*)getCurrentDate:(NSString*)strFormat;

//string转NSDate
+ (NSDate*)getDateFromString:(NSString*)strDate strFormat:(NSString*)strFormat;
//NSDate转string
+ (NSString*)getStringFromDate:(NSString*)strFormat strDate:(NSDate*)Date;

//utc时间转换为当地时间
+ (NSDate *)getUTCFormatDate:(NSDate *)localDate;
//当地时间转换为utc时间
+ (NSDate *)getLocalFromUTC:(NSDate *)utcDate;
@end
