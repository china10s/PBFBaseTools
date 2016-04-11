//
//  PBFThreadTools.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/5/25.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PBFThreadTools : NSObject

+ (void)doAtMainThread:(void(^)())block;

@end
