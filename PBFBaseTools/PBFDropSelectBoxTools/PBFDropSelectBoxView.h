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
//收起
- (void)hideFinished;
@end

@interface PBFDropSelectBoxView : UIView

- (instancetype)initWithAppearLine:(CGPoint)startPnt width:(float)width;

//是否隐藏中
@property (nonatomic,assign)BOOL                                    isHide;
@property (nonatomic,strong)id<PBFDropSelectBoxViewDatasource>      datasourceSelf;
@property (nonatomic,strong)id<PBFDropSelectBoxViewDelegate>        delegateSelf;


//展示下拉列表
- (void)showUp:(UIView*)parentView showShadow:(BOOL)showShadow;
- (void)showDown:(UIView*)parentView showShadow:(BOOL)showShadow;

//手动关闭
- (void)hide;

@end