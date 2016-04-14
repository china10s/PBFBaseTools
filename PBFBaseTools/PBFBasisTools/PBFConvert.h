//
//  PBFConvert.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/5/6.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface PBFConvert : NSObject
//对象与数组之间的转换
+ (void)assembleObject:(Class)rtnType objRes:(NSDictionary*)objRes arrRtn:(NSMutableArray*)arrRtn;
@end