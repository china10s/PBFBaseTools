//
//  PBFAPPLoadingPages.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/9/24.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//
//APP启动页

#import <UIKit/UIKit.h>

typedef void(^PBFAPPLoadingPagesComplete)(void) ;

@interface PBFAPPLoadingPages : UIViewController<UIScrollViewDelegate>
- (instancetype)initWithPages:(NSArray*)arrPages blockComplete:(PBFAPPLoadingPagesComplete)blockComplete;
//进入按钮背景
@property (nonatomic,strong)UIImage                 *imgEnterButtonNormal;
@property (nonatomic,strong)UIImage                 *imgEnterButtonSelect;
@end