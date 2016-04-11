//
//  PBFViewCtrlToolScanning.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/12/1.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//
//二维码扫描

#import <UIKit/UIKit.h>

@protocol PBFViewCtrlToolScanningDelegate
//扫描完成
- (void)finishScan:(NSString*)strPath;
@end

@interface PBFViewCtrlToolScanning : UIViewController
@property (nonatomic,weak)id<PBFViewCtrlToolScanningDelegate>       delegateSelf;
//单例
+ (instancetype)sharedInstance;
@end