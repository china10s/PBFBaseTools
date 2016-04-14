//
//  PBFQRCodeScanner.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/4/14.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//
//二维码扫描

#import <UIKit/UIKit.h>

@protocol PBFViewCtrlToolScanningDelegate
//扫描完成
- (void)finishScan:(NSString*)strPath;
@end

@interface PBFQRCodeScanner : UIViewController
@property (nonatomic,weak)id<PBFViewCtrlToolScanningDelegate>       delegateSelf;
@end