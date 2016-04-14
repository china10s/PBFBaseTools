//
//  PBFNotifyLoadingViewTools.m
//  PBFBaseToolsDemo
//
//  Created by BY-MAC01 on 16/4/14.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import "PBFNotifyLoadingViewTools.h"
#import "MBProgressHUD.h"
#import "PBFNotifyToastViewTools.h"

@interface PBFNotifyLoadingViewTools()
@property (nonatomic,strong)MBProgressHUD                                   *HUDPross;      //进度等待框
@property (nonatomic,strong)MBProgressHUD                                   *HUDComplete;   //进度完成框
@end

@implementation PBFNotifyLoadingViewTools
+ (instancetype)sharedInstance{
    static PBFNotifyLoadingViewTools *tools ;
    @synchronized(self){
        if (!tools) {
            tools = [[PBFNotifyLoadingViewTools alloc] initPrivate];
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

//显示菊花等待框子
- (void)showLoadingView:(UIView *)parentView showShadow:(BOOL)showShadow{
    [self showLoadingView:parentView strMess:@"请等待" showShadow:showShadow];
}

//显示菊花等待框子
- (void)showLoadingView:(UIView *)parentView strMess:(NSString*)strMess showShadow:(BOOL)showShadow{
    if (self.HUDPross) {
        return;
    }
    self.HUDPross = [[MBProgressHUD alloc] initWithView:parentView];
    [parentView addSubview:self.HUDPross];
    self.HUDPross.labelText = strMess;
    self.HUDPross.yOffset -= 40;
    if (showShadow) {
        self.HUDPross.dimBackground = YES;
    }
    
    [self.HUDPross showAnimated:YES whileExecutingBlock:^{
        //默认30s后必须消失，否则可能出现假死
        sleep(10);
    } completionBlock:^{
        [self.HUDPross removeFromSuperview];
        self.HUDPross = nil;
    }];
}

//停止菊花等待框,完成任务
- (void)stopLoadingViewComplete{
    UIView  *parentView = [self.HUDPross superview];
    //菊花停止
    if(self.HUDPross){
        [self.HUDPross removeFromSuperview];
        self.HUDPross = nil;
    }
    if(parentView){
        //操作完成
        self.HUDComplete = [[MBProgressHUD alloc] initWithView:parentView];
        [parentView addSubview:self.HUDComplete];
        self.HUDComplete.labelText = @"成功";
        self.HUDComplete.yOffset -= 60;
        self.HUDComplete.mode = MBProgressHUDModeCustomView;
        self.HUDComplete.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        [self.HUDComplete showAnimated:YES whileExecutingBlock:^{
            sleep(1.5);
        } completionBlock:^{
            [self.HUDComplete removeFromSuperview];
            self.HUDComplete = nil;
        }];
    }
}
//停止菊花等待框
- (void)stopLoadingView{
    //菊花停止
    if(self.HUDPross){
        [self.HUDPross removeFromSuperview];
        self.HUDPross = nil;
    }
}

//停止菊花等待框
- (void)stopLoadingView:(NSString*)strMess{
    UIView  *parentView = [self.HUDPross superview];
    //菊花停止
    if(self.HUDPross){
        [self.HUDPross removeFromSuperview];
        self.HUDPross = nil;
    }
    if(parentView && ([strMess length] > 0)){
        //操作完成
        [[PBFNotifyToastViewTools sharedInstance] showToastMsg:parentView strMess:strMess];
    }
}

@end