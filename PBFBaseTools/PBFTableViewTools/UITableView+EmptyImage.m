//
//  UITableView+EmptyImage.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/10/28.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//

#import "UITableView+EmptyImage.h"

//UIImageView标记
#define kUITableViewEmptyNotifyImageViewFlag        456

@implementation UITableView (EmptyImage)
///////////////////////////////////////加载空数据IMAGE
//加载，显示数据为空信息
- (void)reloadDataShowEmptyImage:(NSString *)strImgPath{
    [self reloadData];
    UIImageView *imgEmpty = [self imgEmpty:strImgPath];
    //无数据
    if ([self numberOfSections] <= 0 ||
        ([self numberOfSections] == 1 && (![self numberOfRowsInSection:0] || [self numberOfRowsInSection:0] < 0))) {
        if (imgEmpty && ![imgEmpty superview]) {
            [self addSubview:imgEmpty];
        }
    }
    else{//有数据
        if (imgEmpty && [imgEmpty superview]) {
            [imgEmpty removeFromSuperview];
        }
    }
}

- (UIImageView*)imgEmpty:(NSString *)strImgPath{
    UIImageView* imgEmpty = nil;
    for ( UIView *view in self.subviews ) {
        if ([view isKindOfClass:[UIImageView class]] &&
            view.tag == kUITableViewEmptyNotifyImageViewFlag) {
            imgEmpty = (UIImageView*)view;
        }
    }
    //是否为空，为空需要新生成一个UILabelView
    if (!imgEmpty) {
        imgEmpty = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        imgEmpty.center = CGPointMake(self.frame.size.width/2, 120);
        imgEmpty.tag = kUITableViewEmptyNotifyImageViewFlag;
        imgEmpty.contentMode = UIViewContentModeScaleAspectFit;
    }
    imgEmpty.image = [UIImage imageNamed:strImgPath];
    return imgEmpty;
}

@end
