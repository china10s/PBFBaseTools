//
//  UITableView+EmptyImage.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/10/28.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (EmptyImage)
//加载，显示数据为空信息
- (void)reloadDataShowEmptyImage:(NSString *)strImgPath;
@end
