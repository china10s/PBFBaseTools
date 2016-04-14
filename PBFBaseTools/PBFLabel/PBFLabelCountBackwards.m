//
//  PBFLabelCountBackwards.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/1/18.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import "PBFLabelCountBackwards.h"
#import "PBFDateTools.h"

@interface PBFLabelCountBackwards()
//计时器
@property (nonatomic,strong)NSTimer                 *timer ;
//时间差距
@property (nonatomic,assign)long                    lGap;
//结束时间
@property (nonatomic,strong)NSDate                  *endDate;
@end

@implementation PBFLabelCountBackwards

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    self.strFormatStringFore = [NSString stringWithFormat:@""];
    self.strFormatStringAfter = [NSString stringWithFormat:@""];
    self.colTime = [UIColor blackColor];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.strFormatStringFore = @"";
    self.strFormatStringAfter = @"";
    self.colTime = [UIColor blackColor];
    return self;
}

- (instancetype)init{
    self = [super init];
    self.strFormatStringFore = @"";
    self.strFormatStringAfter = @"";
    self.colTime = [UIColor blackColor];
    return self;
}

//开始时间、结束时间
- (instancetype)initWithDate:(NSDate*)endDate frame:(CGRect)frame{
    return [self initWithDate:[NSDate date] endDate:endDate frame:frame];
}

//开始时间、结束时间
- (instancetype)initWithDate:(NSDate*)startDate endDate:(NSDate*)endDate frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.lGap = [endDate timeIntervalSinceDate:startDate];
    self.strFormatStringFore = @"";
    self.strFormatStringAfter = @"";
    self.colTime = [UIColor blackColor];
    return self;
}

- (void)setModel:(NSDate*)startDate endDate:(NSDate*)endDate{
    self.lGap = [endDate timeIntervalSinceDate:startDate];
    self.endDate = endDate;
}

- (void)setModel:(NSDate*)endDate{
    [self setModel:[NSDate date] endDate:endDate];
}

//开始计时
- (void)fire{
    [self stop];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countly:) userInfo:nil repeats:TRUE];
    [self.timer fire];
}

//计时
- (void)countly:(NSTimer*)timer{
    --self.lGap;
    if (self.lGap >= 0) {
        int iDays = (int)self.lGap/(3600*24);
        int iHours = (int)(self.lGap - iDays*3600*24)/3600;
        int iMinutes = (int)(self.lGap - iDays*3600*24 - iHours*3600)/60;
        int iSeconds = (int)(self.lGap - iDays*3600*24 - iHours*3600 - iMinutes*60);
        
        NSString* strDays = iDays<=0?@"":[NSString stringWithFormat:@"%d",iDays];
        NSString* strHours = [NSString stringWithFormat:@"%d",iHours];
        NSString* strMinutes = [NSString stringWithFormat:@"%d",iMinutes];
        NSString* strSeconds = [NSString stringWithFormat:@"%d",iSeconds];
        
        NSString* strDaysPath = iDays<=0?self.strFormatStringFore:[NSString stringWithFormat:@"%@%@天",self.strFormatStringFore,strDays];
        NSString* strHoursPath = [NSString stringWithFormat:@"%@%@时",strDaysPath,strHours];
        NSString* strMinutesPath = [NSString stringWithFormat:@"%@%@分",strHoursPath,strMinutes];
        NSString* strSecondsPath = [NSString stringWithFormat:@"%@%@秒%@",strMinutesPath,strSeconds,self.strFormatStringAfter];
        
        UIColor *colorRed = [UIColor colorWithRed:239/255.0f green:49/255.0f blue:24/255.0f alpha:1];
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:strSecondsPath];
        [attString addAttribute:NSForegroundColorAttributeName value:colorRed range:NSMakeRange([self.strFormatStringFore length], [strDays length])];
        [attString addAttribute:NSForegroundColorAttributeName value:colorRed range:NSMakeRange([strDaysPath length], [strHours length])];
        [attString addAttribute:NSForegroundColorAttributeName value:colorRed range:NSMakeRange([strHoursPath length], [strMinutes length])];
        [attString addAttribute:NSForegroundColorAttributeName value:colorRed range:NSMakeRange([strMinutesPath length], [strSeconds length])];
        
        [self setAttributedText:attString];
    }
    else{
        [self stop];
    }
}

//计时结束
- (void)stop{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    NSString *strEndeDate = [PBFDateTools getStringFromDate:@"yyyy-MM-dd" strDate:self.endDate];
    NSString *strDate = [NSString stringWithFormat:@"%@%@%@",self.strFormatStringFore,strEndeDate,self.strFormatStringAfter];
    self.text = strDate&&[strDate length]<=0?strDate:@"";
}

@end