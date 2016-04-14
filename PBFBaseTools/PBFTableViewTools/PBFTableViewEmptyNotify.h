//
//  PBFTableViewEmptyNotify.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/1/27.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//
//  表格无数据，提示为空

#import <UIKit/UIKit.h>

@protocol PBFTableViewEmptyNotifyDatasource <NSObject>
//资源
- (void)assembleEmptyView:(UIView*)parentView;
@end

@interface PBFTableViewEmptyNotify : UITableView
@property (nonatomic,strong)id<PBFTableViewEmptyNotifyDatasource>       datasourceSelf;
//加载，显示数据为空提示
- (void)reloadDataShowEmptyNotify;
@end