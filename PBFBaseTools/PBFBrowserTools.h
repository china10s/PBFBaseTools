//
//  PBFBrowserTools.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/6/24.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol PBFBrowserViewCtrlDelegate;

@interface PBFBrowserTools : NSObject

+ (void)showBrowserView:(UINavigationController*)naviCtrl strTitle:(NSString*)strTitle strPath:(NSString*)strPath;
+ (void)showBrowserView:(UINavigationController*)naviCtrl strTitle:(NSString*)strTitle strPath:(NSString*)strPath delegate:(id<PBFBrowserViewCtrlDelegate>)delegate;

@end