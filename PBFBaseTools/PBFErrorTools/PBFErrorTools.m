//
//  PBFErrorTools.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/5/15.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import "PBFErrorTools.h"

@implementation PBFErrorTools

//写入错误记录
+ (void)PBFLog:(NSString*)strDomain strErrorDes:(NSString*)strErrorDes{
    NSLog(@"DateTime:【%@】/ ErrorDomain:【%@】/ ErrorCode:【%@】",[NSDate date],strDomain,strErrorDes);
}

@end
