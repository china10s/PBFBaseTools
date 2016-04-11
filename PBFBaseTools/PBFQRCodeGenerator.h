//
//  PBFQRCodeGenerator.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/12/8.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//
//二维码生成

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PBFQRCodeGenerator : NSObject
+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size;
+ (UIImage *)twoDimensionCodeImage:(UIImage *)twoDimensionCode withAvatarImage:(UIImage *)avatarImage;
@end
