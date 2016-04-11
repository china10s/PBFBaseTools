//
//  PBFDeviceTools.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/5/14.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import <Foundation/Foundation.h>

//系列
typedef enum{
    DEVICETYPES_DEFAULT = 0,
    DEVICETYPES_IPHONE3,
    DEVICETYPES_IPHONE4,
    DEVICETYPES_IPHONE5,
    DEVICETYPES_IPHONE6,
    DEVICETYPES_IPHONE6p
    
}EnumPbfDeviceType;

@interface PBFDeviceTools : NSObject
+ (instancetype)sharedInstance;
- (EnumPbfDeviceType)getDeviceEnumType;

//判断sdk版本
- (double)getSDKVersion;
@end