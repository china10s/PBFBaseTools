//
//  PBFReachabilityChange.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/6/28.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

//状态
//static NetworkStatus        PBFReachabilityStatus;
typedef void(^AddNotification)(void);

@interface PBFReachabilityChange : NSObject
//开始监控
+ (Reachability*)start:(NSString*)strHostName;
//增加通知
+ (void)addNotification:(id)obsever  selector:(SEL)selector;
@end