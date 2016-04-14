//
//  UITableView+EmptyText.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/4/14.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import "UITableView+EmptyText.h"

//TextView标记
#define kUITableViewEmptyTextViewFlag         123

@implementation UITableView (EmptyText)

///////////////////////////////////////加载空数据TEXT
//加载，显示数据为空信息
- (void)reloadDataShowEmptyText{
    [self reloadData];
    UILabel *labTextEmpty = [self labTextEmpty];
    //无数据
    if ([self numberOfSections] <= 0 ||
        ([self numberOfSections] == 1 && (![self numberOfRowsInSection:0] || [self numberOfRowsInSection:0] < 0))) {
        if (labTextEmpty && ![labTextEmpty superview]) {
            [self addSubview:labTextEmpty];
        }
    }
    else{//有数据
        if (labTextEmpty && [labTextEmpty superview]) {
            [labTextEmpty removeFromSuperview];
        }
    }
}

- (UILabel*)labTextEmpty{
    UILabel* labTextEmpty = nil;
    for ( UIView *view in self.subviews ) {
        if ([view isKindOfClass:[UILabel class]] &&
            view.tag == kUITableViewEmptyTextViewFlag) {
            labTextEmpty = (UILabel*)view;
        }
    }
    //是否为空，为空需要新生成一个UILabelView
    if (!labTextEmpty) {
        labTextEmpty = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        labTextEmpty.center = CGPointMake(self.frame.size.width/2, 80);
        labTextEmpty.text = @"暂无记录";
        labTextEmpty.textAlignment = NSTextAlignmentCenter;
        labTextEmpty.tag = kUITableViewEmptyTextViewFlag;
        labTextEmpty.textColor = [UIColor grayColor];
    }
    return labTextEmpty;
}

@end