//
//  PBFImageObtainTools.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/11/19.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//
//获取图片：
//1、照相机
//2、相册

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PBFImageObtainTools;

@protocol PBFImageObtainToolsDelegate
//获取照片
- (void)PBFImageObtainTools:(PBFImageObtainTools*)tools imgItem:(UIImage*)imgItem;
//弹出窗口父级
- (UIViewController*)parentViewCtrl;
@end

@interface PBFImageObtainTools : NSObject
//单例
+ (instancetype)sharedInstance;
//显示
- (void)show;
@property (nonatomic,weak)id<PBFImageObtainToolsDelegate>           delegateSelf;
@end