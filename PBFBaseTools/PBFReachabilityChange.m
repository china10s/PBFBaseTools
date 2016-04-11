//
//  PBFReachabilityChange.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/6/28.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import "PBFReachabilityChange.h"

//static Reachability    *reachability;

@interface PBFReachabilityChange()
@property(nonatomic,strong)Reachability     *reachability;
@end

@implementation PBFReachabilityChange
//开始监控
+ (Reachability*)start:(NSString*)strHostName{
    static PBFReachabilityChange   *reachabilityChange;
    @synchronized(self){
        if (!reachabilityChange) {
            reachabilityChange = [[PBFReachabilityChange alloc] init];
            reachabilityChange.reachability = [Reachability reachabilityWithHostName:strHostName];
            [reachabilityChange.reachability startNotifier];
            [PBFReachabilityChange addNotification:reachabilityChange selector:@selector(reachabilityChanged:)];
        }
    }
    return reachabilityChange.reachability;
}

//增加通知
+ (void)addNotification:(id)obsever  selector:(SEL)selector{
    if ([obsever respondsToSelector:selector]) {
        [[NSNotificationCenter defaultCenter] addObserver:obsever selector:selector name:kReachabilityChangedNotification object:nil];
    }
}


/*
//网络监控函数
- (void)reachabilityChanged:(NSNotification *)note{
    Reachability *curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    PBFReachabilityStatus = [curReach currentReachabilityStatus];
}
*/

@end
