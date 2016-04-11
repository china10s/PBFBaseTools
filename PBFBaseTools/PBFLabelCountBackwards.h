//
//  PBFLabelCountBackwards.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/1/18.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//
//
//  倒数Label

#import <UIKit/UIKit.h>

@interface PBFLabelCountBackwards : UILabel

//开始时间、结束时间
- (instancetype)initWithDate:(NSDate*)endDate frame:(CGRect)frame;

//开始时间、结束时间
- (instancetype)initWithDate:(NSDate*)startDate endDate:(NSDate*)endDate frame:(CGRect)frame;

- (void)setModel:(NSDate*)startDate endDate:(NSDate*)endDate ;
- (void)setModel:(NSDate*)endDate ;

@property (nonatomic,strong)NSString        *strFormatStringFore;
@property (nonatomic,strong)NSString        *strFormatStringAfter;
@property (nonatomic,strong)UIColor         *colTime;

- (void)fire;
- (void)stop;

@end