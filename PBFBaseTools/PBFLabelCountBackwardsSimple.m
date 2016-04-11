//
//  PBFLabelCountBackwardsSimple.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/1/27.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import "PBFLabelCountBackwardsSimple.h"
#import "PBFDateTools.h"

@interface PBFLabelCountBackwardsSimple()
//计时器
@property (nonatomic,strong)NSTimer                 *timer;
//时间差距
@property (nonatomic,assign)long                    lGap;
//结束时间
@property (nonatomic,strong)NSDate                  *endDate;
@end

@implementation PBFLabelCountBackwardsSimple

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    self.strFormatStringFore = @"";
    self.strFormatStringAfter = @"";
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.strFormatStringFore = @"";
    self.strFormatStringAfter = @"";
    return self;
}

- (instancetype)init{
    self = [super init];
    self.strFormatStringFore = @"";
    self.strFormatStringAfter = @"";
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
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
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
        
        NSString* strDays = [NSString stringWithFormat:@"%d",iDays];
        NSString* strHours = [NSString stringWithFormat:@"%02d",iHours];
        NSString* strMinutes = [NSString stringWithFormat:@"%02d",iMinutes];
        NSString* strSeconds = [NSString stringWithFormat:@"%02d",iSeconds];
        
        NSString *strFormat = @"";
        if(iHours <= 0){
            strFormat = [NSString stringWithFormat:@"%@:%@",strMinutes,strSeconds];
        }
        else{
            strFormat = [NSString stringWithFormat:@"%@:%@:%@",strHours,strMinutes,strSeconds];
        }
        
        strFormat = [NSString stringWithFormat:@"%@%@%@",self.strFormatStringFore,strFormat,self.strFormatStringAfter];
        [self setText:strFormat];
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
    if(self.delegateSelf){
        [self.delegateSelf finishedCount];
    }
}

@end