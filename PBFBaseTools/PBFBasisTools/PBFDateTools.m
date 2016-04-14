//
//  PBFDateTools.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/6/10.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import "PBFDateTools.h"

@implementation PBFDateTools

//获取年份
+ (NSInteger)getYearFromDate:(NSDate*)date{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlag = NSYearCalendarUnit;
    NSDateComponents *dComponent = [cal components:unitFlag fromDate:date];
    return [dComponent year];
}

//获取月份
+ (NSInteger)getMonthFromDate:(NSDate*)date{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlag = NSMonthCalendarUnit;
    NSDateComponents *dComponent = [cal components:unitFlag fromDate:date];
    return [dComponent month];
}

//获取日份
+ (NSInteger)getDayFromDate:(NSDate*)date{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlag = NSDayCalendarUnit;
    NSDateComponents *dComponent = [cal components:unitFlag fromDate:date];
    return [dComponent day];
}

//获取星期
+ (NSInteger)getWeekdayFromDate:(NSDate*)date{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlag = NSWeekdayCalendarUnit;
    NSDateComponents *dComponent = [cal components:unitFlag fromDate:date];
    return [dComponent weekday];
}

//获取时
+ (NSInteger)getHourFromDate:(NSDate*)date{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlag = NSHourCalendarUnit;
    NSDateComponents *dComponent = [cal components:unitFlag fromDate:date];
    return [dComponent hour];
}

//获取分
+ (NSInteger)getMinuteFromDate:(NSDate*)date{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlag = NSMinuteCalendarUnit;
    NSDateComponents *dComponent = [cal components:unitFlag fromDate:date];
    return [dComponent minute];
}

//获取秒
+ (NSInteger)getSecondFromDate:(NSDate*)date{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlag = NSSecondCalendarUnit;
    NSDateComponents *dComponent = [cal components:unitFlag fromDate:date];
    return [dComponent second];
}


//按格式获取当前日期
+ (NSString*)getCurrentDate:(NSString*)strFormat{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = strFormat;
    return [fmt stringFromDate:now];
}

//string转NSDate
+ (NSDate*)getDateFromString:(NSString*)strDate strFormat:(NSString*)strFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:strFormat];
    NSDate *dateDes = [dateFormatter dateFromString:strDate];
    return dateDes;
}

//NSDate转string
+ (NSString*)getStringFromDate:(NSString*)strFormat strDate:(NSDate*)Date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:strFormat];
    return [dateFormatter stringFromDate:Date];
}

//utc时间转换为当地时间
+ (NSDate *)getUTCFormatDate:(NSDate *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    NSDate *dateDes = [PBFDateTools getDateFromString:dateString strFormat:@"yyyy-MM-dd HH:mm:ss"];
    return dateDes;
}

//当地时间转换为utc时间
+ (NSDate *)getLocalFromUTC:(NSDate *)utcDate
{
    NSString* strUtcDate = [PBFDateTools getStringFromDate:@"yyyy-MM-dd HH:mm:ss Z" strDate:utcDate];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSDate *ldate = [dateFormatter dateFromString:strUtcDate];
    return ldate;
}

@end
