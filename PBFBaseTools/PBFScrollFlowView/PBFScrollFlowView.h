//
//  PBFScrollFlowView.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/10/30.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PBFScrollFlowViewDataSource,PBFScrollFlowViewDelegate;

@interface PBFScrollFlowView : UIScrollView<UIScrollViewDelegate>
@property (nonatomic,weak)id<PBFScrollFlowViewDataSource>                       delegateDatasource;
@property (nonatomic,weak)id<PBFScrollFlowViewDelegate>                         delegateSelf;

//PageControl
@property (nonatomic,strong)UIColor                                             *colorPageIndicatorTint;
@property (nonatomic,strong)UIColor                                             *colorCurrentPageIndicatorTint;

//重播时间间隔
@property (nonatomic,assign)int                                                 iScrollTimeGap;

//初始化
- (instancetype)initWithFrame:(CGRect)frame horiGap:(float)fHoriGap fViewWidth:(float)fViewWidth;
//重新加载数据
- (void)reloadData;
@end

@protocol PBFScrollFlowViewDataSource<NSObject>
- (NSInteger)countOfItems:(PBFScrollFlowView*)scrollView;
- (void)assembleView:(PBFScrollFlowView*)scrollView parentView:(UIView*)parentView assembleViewAtIndex:(NSInteger)index;
@end

@protocol PBFScrollFlowViewDelegate<NSObject>
- (void)selectedCell:(PBFScrollFlowView*)scrollView index:(NSInteger)index;
@end