//
//  PBFThreadTools.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/5/25.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import "PBFThreadTools.h"

@implementation PBFThreadTools

//主线程中执行
+ (void)doAtMainThread:(void(^)())block{
    if ([NSThread isMainThread]) {
        if (block) {
            block();
        }
    }
    else{
        dispatch_sync(dispatch_get_main_queue(), ^(){
            if (block) {
                block();
            }
        });
    }
}

@end
