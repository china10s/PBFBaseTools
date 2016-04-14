//
//  PBFBrowserViewCtrl.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/6/24.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PBFBrowserViewCtrlDelegate
//JS返回函数
- (BOOL)jsFunctionDo:(NSString*)strJsFunction;
@end

@interface PBFBrowserViewCtrl : UIViewController<UIWebViewDelegate,PBFBrowserViewCtrlDelegate>
//@property (nonatomic,weak)id<PBFBrowserViewCtrlDeelgate>        delegateSelf;
//增加Delegate
- (void)addDelegate:(id<PBFBrowserViewCtrlDelegate>)delegate;
- (instancetype)initWithTitle:(NSString*)strPath strTitle:(NSString*)strTitle;
@end