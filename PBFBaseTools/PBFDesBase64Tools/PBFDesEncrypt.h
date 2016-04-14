//
//  PBFDesEncrypt.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/10/12.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//
//Des加密

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface PBFDesEncrypt : NSObject

//加密
+ (NSString *)encrypt:(NSString *)sText key:(NSString *)key iv:(NSString*)iv;

@end