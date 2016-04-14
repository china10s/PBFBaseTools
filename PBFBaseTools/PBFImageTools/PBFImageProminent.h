//
//  PBFImageProminent.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/9/29.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//
//放大显示图片

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PBFImageProminent : NSObject

//单例
+ (instancetype)sharedInstance;

//凸显图片
- (void)showImageView:(UIImageView*)avatarImageView;

@end
