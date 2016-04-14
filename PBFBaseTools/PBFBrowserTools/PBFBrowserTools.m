//
//  PBFBrowserTools.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/6/24.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import "PBFBrowserTools.h"
#import "PBFBrowserViewCtrl.h"

@implementation PBFBrowserTools

+ (void)showBrowserView:(UINavigationController*)naviCtrl strTitle:(NSString*)strTitle strPath:(NSString*)strPath{
    [PBFBrowserTools showBrowserView:naviCtrl strTitle:strTitle strPath:strPath delegate:nil];
}

+ (void)showBrowserView:(UINavigationController*)naviCtrl strTitle:(NSString*)strTitle strPath:(NSString*)strPath delegate:(id<PBFBrowserViewCtrlDelegate>)delegate{
    PBFBrowserViewCtrl *ctrlBrowser = [[PBFBrowserViewCtrl alloc] initWithTitle:strPath strTitle:strTitle];
    if(delegate){
        [ctrlBrowser addDelegate:delegate];
    }
    if ( ctrlBrowser && !ctrlBrowser.parentViewController) {
        [naviCtrl pushViewController:ctrlBrowser animated:YES];
    }
}

@end