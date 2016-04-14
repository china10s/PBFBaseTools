//
//  PBFConvert.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/5/6.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import "PBFConvert.h"

@implementation PBFConvert
//对象与数组之间的转换
+ (void)assembleObject:(Class)rtnType objRes:(NSDictionary*)objRes arrRtn:(NSMutableArray*)arrRtn{
    if (objRes) {
        NSObject *objTmp = [rtnType new];
        for (NSString * keyName in [objRes allKeys]) {
            NSString *destMethodName = [NSString stringWithFormat:@"set%@:",[self headUpperCase:keyName ]];
            SEL destMethodSelector = NSSelectorFromString(destMethodName);
            if ([objTmp respondsToSelector:destMethodSelector]) {
                [objTmp performSelector:destMethodSelector withObject:[objRes objectForKey:keyName]];
            }
        }
        [arrRtn addObject:objTmp];
    }
    return;
}

//首字母大写函数
+ (NSString*)headUpperCase:(NSString*)strDest{
    if (strDest) {
        if (strDest.length ==1) {
            return [strDest uppercaseString];
        }
        else{
            NSRange rangHead = NSMakeRange(0, 1);
            NSString *strHead = [strDest substringWithRange:rangHead];
            NSString *strLast = [strDest substringFromIndex:1];
            return [NSString stringWithFormat:@"%@%@",[strHead uppercaseString],strLast];
        }
    }
    else{
        return nil;
    }
    
}



@end