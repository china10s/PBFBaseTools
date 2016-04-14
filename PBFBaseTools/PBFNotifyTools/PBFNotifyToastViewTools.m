//
//  PBFNotifyToastViewTools.m
//  PBFBaseToolsDemo
//
//  Created by BY-MAC01 on 16/4/14.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import "PBFNotifyToastViewTools.h"
#import "MBProgressHUD.h"

@interface PBFNotifyToastViewTools()
@property (nonatomic,strong)MBProgressHUD                                   *HUDAlertInfo;  //提示框
@end

@implementation PBFNotifyToastViewTools
+ (instancetype)sharedInstance{
    static PBFNotifyToastViewTools *tools ;
    @synchronized(self){
        if (!tools) {
            tools = [[PBFNotifyToastViewTools alloc] initPrivate];
        }
    }
    return tools;
}

- (instancetype)init{
    return nil;
}

- (instancetype)initPrivate{
    self = [super init];
    return self;
}

- (void)showToastMsg:(UIView*)viewParent strMess:(NSString*)strMess{
    [self showToastMsg:viewParent strMess:strMess iTime:1.8f blockComplete:nil];
}

- (void)showToastMsg:(UIView*)viewParent strMess:(NSString*)strMess blockComplete:(ToastComplete)blockComplete{
    [self showToastMsg:viewParent strMess:strMess iTime:1.8f blockComplete:blockComplete];
}

- (void)showToastMsg:(UIView*)viewParent strMess:(NSString*)strMess iTime:(unsigned int)iTime {
    [self showToastMsg:viewParent strMess:strMess iTime:iTime blockComplete:nil];
}

- (void)showToastMsg:(UIView*)viewParent strMess:(NSString*)strMess iTime:(unsigned int)iTime blockComplete:(ToastComplete)blockComplete{
    self.HUDAlertInfo = [[MBProgressHUD alloc] initWithView:viewParent];
    [viewParent addSubview:self.HUDAlertInfo];
    self.HUDAlertInfo.labelText = @"";
    self.HUDAlertInfo.detailsLabelText = strMess;
    self.HUDAlertInfo.mode = MBProgressHUDModeText;
    self.HUDAlertInfo.yOffset -= 40;
    [self.HUDAlertInfo showAnimated:YES whileExecutingBlock:^{
        sleep(iTime);
    } completionBlock:^{
        if(blockComplete){
            blockComplete();
        }
    }];
}

@end