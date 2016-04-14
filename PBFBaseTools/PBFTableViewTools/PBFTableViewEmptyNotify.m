//
//  PBFTableViewEmptyNotify.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/1/27.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import "PBFTableViewEmptyNotify.h"

@interface PBFTableViewEmptyNotify()
@property (nonatomic,strong)UIView          *viewParent;
@end

@implementation PBFTableViewEmptyNotify
//加载，显示数据为空提示
- (void)reloadDataShowEmptyNotify{
    [self reloadData];
    
    //无数据
    if ([self numberOfSections] <= 0 ||
        ([self numberOfSections] == 1 && (![self numberOfRowsInSection:0] || [self numberOfRowsInSection:0] < 0))) {
        if (![self.viewParent superview]) {
            if (self.datasourceSelf) {
                [self.datasourceSelf assembleEmptyView:self.viewParent];
            }
            [self addSubview:self.viewParent];
        }
    }
    else{//有数据
        if ([self.viewParent superview]) {
            [self.viewParent removeFromSuperview];
        }
    }
}

#pragma mark - getter and setter
- (UIView*)viewParent{
    if (!_viewParent) {
        _viewParent = [[UIView alloc] initWithFrame:self.frame];
    }
    return _viewParent;
}


@end