//
//  PBFDeviceTools.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/5/14.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kPBFDeviceToolsAppstorePath @""

//机器类型系列
typedef enum{
    DEVICETYPES_DEFAULT = 0,
    DEVICETYPES_IPHONE3,
    DEVICETYPES_IPHONE4,
    DEVICETYPES_IPHONE5,
    DEVICETYPES_IPHONE6,
    DEVICETYPES_IPHONE6p
    
}EnumPbfDeviceType;

@interface PBFDeviceTools : NSObject
#pragma mark - 机器
//获取机器类型
+ (EnumPbfDeviceType)getDeviceTypeEnum;
//获取机器详情
+ (NSString*)getDeviceTypeDetial;
//获取SDK版本
+ (double)getSDKVersion;
//友好强退App
+ (void)exitApplicationFriendly;

#pragma mark - 用户评价
//处理用户评价策略
+ (void)handlerUerEvaluate:(UIViewController*)viewCtrl;
//邀请用户评价
+ (void)showUerEvaluate:(UIViewController*)viewCtrl;

#pragma mark - 版本号
//核对AppStore版本，自动升级
+ (void)showAutoUpdate:(UIViewController*)viewCtrl;
//获取机器版本号码
+ (NSString*)getDeviceCurVersion;
//获取AppStore上的App版本
+ (void)getAppStoreCurVersion:(void (^)(NSString*))blockRtn;

#pragma mark - 机器是否接受消息推送开关
+ (BOOL)getIsAllowPushMessage;
+ (void)setIsAllowPushMessage:(BOOL)isAllowPush;


@end