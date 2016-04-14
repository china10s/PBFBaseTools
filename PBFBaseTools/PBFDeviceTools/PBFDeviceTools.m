//
//  PBFDeviceTools.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/5/14.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import "PBFDeviceTools.h"
#import "sys/sysctl.h"
#import <UIKit/UIKit.h>
#import "PBFNotifyAlertViewTools.h"

#define kPBFDeviceToolsCurrentVersionOpenedTimes        @"kPBFDeviceToolsCurrentVersionOpenedTime"
#define kPBFDeviceToolsCurrentVersionRecord             @"kPBFDeviceToolsCurrentVersionRecord"
#define kPBFDeviceToolsIsAllowPushMessage               @"kPBFDeviceToolsIsAllowPushMessage"

@implementation PBFDeviceTools
#pragma mark - 机器
//获取机器类型
+ (EnumPbfDeviceType)getDeviceTypeEnum{
    size_t size;
    int nR = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    nR = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    if ([PBFDeviceTools containString:platform strKey:@"iPhone1"]||[PBFDeviceTools containString:platform strKey:@"iPhone2"])
        return DEVICETYPES_IPHONE3;
    if ([PBFDeviceTools containString:platform strKey:@"iPhone3"]||[PBFDeviceTools containString:platform strKey:@"iPhone4"])
        return DEVICETYPES_IPHONE4;
    if ([PBFDeviceTools containString:platform strKey:@"iPhone5"]||[PBFDeviceTools containString:platform strKey:@"iPhone6"])
        return DEVICETYPES_IPHONE5;
    if ([PBFDeviceTools containString:platform strKey:@"iPhone7"])
        return DEVICETYPES_IPHONE6;

    return DEVICETYPES_DEFAULT;
}

//获取机器详情
+ (NSString*) getDeviceTypeDetial{
    size_t size;
    int nR = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    nR = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return @"unknown";
}

//是否包含字段
+ (BOOL)containString:(NSString*)strEntire strKey:(NSString*)strKey{
    NSRange range = [strEntire rangeOfString:strKey];
    if (range.length > 0) {
        return YES;
    }
    else{
        return NO;
    }
}

//获取SDK版本
+ (double)getSDKVersion{
    return [[UIDevice currentDevice].systemVersion doubleValue];
}

//友好强退App
+ (void)exitApplicationFriendly{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(window.bounds.size.height/2, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

#pragma mark - 用户评价
//处理用户评价策略
+ (void)handlerUerEvaluate:(UIViewController*)viewCtrl{
    NSString *strDeviceVersion = [self getDeviceCurVersion];
    NSData * dataParam = [[NSUserDefaults standardUserDefaults] objectForKey:kPBFDeviceToolsCurrentVersionOpenedTimes];
    NSMutableDictionary * dicParam= [[NSKeyedUnarchiver unarchiveObjectWithData:dataParam] mutableCopy];
    if (!dicParam) {
        dicParam = [[NSMutableDictionary alloc] init];
    }
    if (![dicParam objectForKey:strDeviceVersion]) {
        [dicParam setObject:[NSNumber numberWithInt:1] forKey:strDeviceVersion];
    }
    else{
        NSNumber *numberTimes = [dicParam objectForKey:strDeviceVersion];
        long lTimes = [numberTimes integerValue];
        if (lTimes > 3) {//大于3次不计
            return;
        }
        else if (lTimes < 3){//小于3次每次加一
            [dicParam setObject:[NSNumber numberWithInteger:(lTimes+1)] forKey:strDeviceVersion];
        }
        else if (lTimes == 3){//正好3次，弹出评价框
            [dicParam setObject:[NSNumber numberWithInteger:(lTimes+1)] forKey:strDeviceVersion];
            [self showUerEvaluate:viewCtrl];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:dicParam] forKey:kPBFDeviceToolsCurrentVersionOpenedTimes];
    
    return;
}

//邀请用户评价
+ (void)showUerEvaluate:(UIViewController*)viewCtrl{
    [[PBFNotifyAlertViewTools sharedInstance] showAlterView:@"提醒" message:@"如果喜欢我们的APP，现在去给个好评吧！" parentViewCtrl:viewCtrl textAlign:NSTextAlignmentCenter backBlock:^(long btnIndex){
        if(btnIndex == 1){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kPBFDeviceToolsAppstorePath]];
        }
    } cancelButtonTitle:@"稍后评价" otherButtonTitles:@"现在就去",nil];//,@"不再提示"
}

#pragma mark - 版本号
//核对AppStore版本，自动升级
+ (void)showAutoUpdate:(UIViewController*)viewCtrl{
    static BOOL isShowed ;
    if (isShowed) {
        return;
    }
    [self getAppStoreCurVersion:^(NSString* strAppsStoreVersion){
        NSString *strDeviceVersion = [self getDeviceCurVersion];
        //当前安装版本和AppStore版本不一致，表示有更新
        if ([strAppsStoreVersion isEqualToString:strDeviceVersion]) {
            return ;
        }
        NSString *strUserDeviceVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kPBFDeviceToolsCurrentVersionRecord];
        if([strUserDeviceVersion isEqualToString:strAppsStoreVersion]){
            return;
        }
        [[PBFNotifyAlertViewTools sharedInstance] showAlterView:@"提醒" message:@"有新版本，是否更新?" parentViewCtrl:viewCtrl textAlign:NSTextAlignmentCenter backBlock:^(long btnIndex){
            if(btnIndex == 0){//下次再说
                isShowed = TRUE;
                [[NSUserDefaults standardUserDefaults] setObject:strDeviceVersion forKey:kPBFDeviceToolsCurrentVersionRecord];
            }
            else if(btnIndex == 1){//不再提示
                isShowed = TRUE;
                [[NSUserDefaults standardUserDefaults] setObject:strAppsStoreVersion forKey:kPBFDeviceToolsCurrentVersionRecord];
            }
            else if(btnIndex == 2){//去更新
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kPBFDeviceToolsAppstorePath]];
            }
        } cancelButtonTitle:@"下次打开再更新" otherButtonTitles:@"跳过此版本",@"去App Store更新",nil];
    }];
}
//获取机器版本号码
+ (NSString*)getDeviceCurVersion{
    return [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
}
//获取AppStore上的App版本
+ (void)getAppStoreCurVersion:(void (^)(NSString*))blockRtn{
    NSURL *url = [NSURL URLWithString:kPBFDeviceToolsAppstorePath];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSString *strData = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [strData dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            if(!data){
                return ;
            }
            NSDictionary *dicRtn = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *arrResult = [dicRtn objectForKey:@"results"];
            NSString *strVersion = [arrResult[0] objectForKey:@"version"];
            blockRtn(strVersion);
        });
    });
}

#pragma mark - 机器是否接受消息推送开关
+ (BOOL)getIsAllowPushMessage{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults valueForKey:kPBFDeviceToolsIsAllowPushMessage]) {//还未保存过设置结果
        [self setIsAllowPushMessage:TRUE];
    }
    return [defaults boolForKey:kPBFDeviceToolsIsAllowPushMessage];
}

+ (void)setIsAllowPushMessage:(BOOL)isAllowPush{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:isAllowPush forKey:kPBFDeviceToolsIsAllowPushMessage];
}


@end