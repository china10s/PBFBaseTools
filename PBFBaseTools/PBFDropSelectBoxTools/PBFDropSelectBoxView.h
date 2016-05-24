//
//  PBFDropSelectBoxView.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/5/24.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PBFDropSelectBoxView;

@protocol PBFDropSelectBoxViewDatasource <NSObject>

@required
//获取要展示行的标题
- (NSString*)getTitleForRow:(long)lRowIndex;
//获取当前选中行
- (int)getSelectedRow;

@end

@protocol PBFDropSelectBoxViewDelegate <NSObject>
//选中行
- (void)selRow:(PBFDropSelectBoxView*)sender iSelRow:(int)iSelRow;
@end

@interface PBFDropSelectBoxView : UIView

@property (nonatomic,strong)id<PBFDropSelectBoxViewDatasource>      datasourceSelf;
@property (nonatomic,strong)id<PBFDropSelectBoxViewDelegate>        delegateSelf;

- (instancetype)initWithAppearLine:(CGPoint)startPnt width:(float)width;

//展示下拉列表
- (void)showUp:(UIView*)parentView showShadow:(BOOL)showShadow;
- (void)showDown:(UIView*)parentView showShadow:(BOOL)showShadow;

//手动关闭
- (void)hide;

@end