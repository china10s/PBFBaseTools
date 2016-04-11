//
//  PBFScrollFlowView.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/10/30.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//

#import "PBFScrollFlowView.h"
#import "PBFViewTools.h"

//页面tag
#define kPBFScrollFlowViewPageControlTag                   1234567

@interface PBFScrollFlowView()
//间隔
@property (nonatomic,assign)float                                               fGHoriGap;
//宽度
@property (nonatomic,assign)float                                               fViewWidth;

@property (nonatomic,strong)NSMutableArray                                      *arryItemViews;
@property (nonatomic,assign)NSInteger                                           curShowIndex;
@property (nonatomic,assign)float                                               foreOffsetX;//滑动前位置
@property (nonatomic,strong)UIPageControl                                       *pageCtrl;

//时间控制器
@property (nonatomic,strong)NSTimer                                             *timer;


@end

@implementation PBFScrollFlowView
//初始化
- (instancetype)initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame horiGap:30 fViewWidth:250];
}

//初始化
- (instancetype)initWithFrame:(CGRect)frame horiGap:(float)fHoriGap fViewWidth:(float)fViewWidth{
    self.iScrollTimeGap = 10.0f;
    CGRect rectTmp = frame;
    frame.size.width = (fViewWidth + fHoriGap);
    self = [super initWithFrame:frame];
    self.center = CGPointMake(rectTmp.size.width/2, rectTmp.size.height/2);
    self.delegate = self;
    self.clipsToBounds = NO;
    self.pagingEnabled = TRUE;
    self.contentSize = CGSizeMake( frame.size.width*3, frame.size.height);
    self.contentOffset = CGPointMake((fViewWidth+fHoriGap), 0);
    self.curShowIndex = 0;
    self.showsHorizontalScrollIndicator = FALSE;
    
    //间隔
    self.fGHoriGap = fHoriGap;
    //宽度
    self.fViewWidth = fViewWidth;
    
    return self;
}

- (void)scrollPageRepeat:(NSTimer*)timer{
    [UIView animateWithDuration:0.2f animations:^{
        [self reLoadViews:FALSE];
    }];
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
}

//按钮
- (void)tapItem:(UITapGestureRecognizer*)gester{
    if (self.delegateSelf) {
        [self.delegateSelf selectedCell:self index:self.curShowIndex];
    }
}

- (void)didMoveToSuperview{
    //初始化
    [self reloadData];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.foreOffsetX = scrollView.contentOffset.x;
}

// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.foreOffsetX < self.contentOffset.x) {//向右
        [self reLoadViews:FALSE];
    }
    else if((self.foreOffsetX > self.contentOffset.x)){//向左
        [self reLoadViews:TRUE];
    }
}


//重新放置所有view位置
- (void)reLoadViews:(BOOL)isLeftOrient{
    //自动旋转
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.iScrollTimeGap target:self selector:@selector(scrollPageRepeat:) userInfo:nil repeats:TRUE];
    
    CGRect rectEmptyp;
    //1、首先记下需要被移出去的VIEW将会被放置的地方
    if (isLeftOrient) {//左方向
        self.curShowIndex = [self calculateNumber:--self.curShowIndex];
        rectEmptyp = ((UIView*)[self.arryItemViews firstObject]).frame;
    }
    else{//右方向
        self.curShowIndex = [self calculateNumber:++self.curShowIndex];
        rectEmptyp = ((UIView*)[self.arryItemViews lastObject]).frame;
    }
    //2、整体加视角反方向移动
    for (int i = 0; i < self.arryItemViews.count; ++i) {
        UIView *viewChild = [self.arryItemViews objectAtIndex:i];
        CGRect rect = viewChild.frame;
        if (isLeftOrient) {//左方向
            rect.origin.x += self.frame.size.width;
        }
        else{//右方向
            rect.origin.x -= self.frame.size.width;
        }
        viewChild.frame = rect;
    }
    //3、移出视野最远端的VIEW放置回来、并对该VIEW重新绑定数据
    if (isLeftOrient) {//左方向
        UIView *viewLast = [self.arryItemViews lastObject];
        viewLast.frame = rectEmptyp;
        [self.arryItemViews removeObject:viewLast];
        [self.arryItemViews insertObject:viewLast atIndex:0];
        [[PBFViewTools sharedInstance] removeAllSubviews:viewLast];
        [self.delegateDatasource assembleView:self parentView:viewLast assembleViewAtIndex:[self calculateNumber:(self.curShowIndex - 2)]];
    }
    else{//右方向
        UIView *viewfirst = [self.arryItemViews firstObject];
        viewfirst.frame = rectEmptyp;
        [self.arryItemViews removeObject:viewfirst];
        [self.arryItemViews addObject:viewfirst];
        [[PBFViewTools sharedInstance] removeAllSubviews:viewfirst];
        [self.delegateDatasource assembleView:self parentView:viewfirst assembleViewAtIndex:[self calculateNumber:(self.curShowIndex + 2)]];
    }
    self.contentOffset = CGPointMake(self.fViewWidth+self.fGHoriGap, 0);
    self.pageCtrl.currentPage = self.curShowIndex;
}

//归零计算
- (NSInteger)calculateNumber:(NSInteger)iNumber{
    if(iNumber < 0){
        while (iNumber < 0) {
            iNumber+=([self.delegateDatasource countOfItems:self]);
        }
    }
    else if(iNumber >= [self.delegateDatasource countOfItems:self]){
        while (iNumber >= [self.delegateDatasource countOfItems:self]) {
            iNumber-=([self.delegateDatasource countOfItems:self]);
        }
    }
    return iNumber;
}

#pragma mark - public method
//重新加载数据
- (void)reloadData{
    [self.arryItemViews removeAllObjects];
    //初始化
    for (int i = 0 ; i < 5; ++i ) {
        UIView *viewParent = [[UIView alloc] initWithFrame:CGRectMake(self.fViewWidth *(i-1)+self.fGHoriGap*(i-0.5), 0, self.fViewWidth , self.frame.size.height)];
        viewParent.tag = i;
        [self.delegateDatasource assembleView:self parentView:viewParent assembleViewAtIndex:[self calculateNumber:(self.curShowIndex + i - 2)]];
        [self.arryItemViews addObject:viewParent];
        [self addSubview:viewParent];
        //加上手势
        UITapGestureRecognizer *gester = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapItem:)];
        [viewParent addGestureRecognizer:gester];
        [viewParent setUserInteractionEnabled:TRUE];
    }
    if ([self.pageCtrl superview]) {
        [self.pageCtrl removeFromSuperview];
    }
    self.pageCtrl.numberOfPages = [self.delegateDatasource countOfItems:self];
    [self.superview addSubview:self.pageCtrl];
    //当只有一个时候，不需要滚动
    if(self.pageCtrl.numberOfPages <= 1){
        [self setScrollEnabled:FALSE];
        [self.timer invalidate];
        self.timer = nil;
        [self.pageCtrl setHidden:TRUE];
    }
    else{
        [self setScrollEnabled:TRUE];
        //滚动
        [self.timer invalidate];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(scrollPageRepeat:) userInfo:nil repeats:TRUE];
        [self.pageCtrl setHidden:FALSE];
    }
}

#pragma mark - getter & setter
- (NSMutableArray*)arryItemViews{
    if (!_arryItemViews) {
        _arryItemViews = [[NSMutableArray alloc] init];
    }
    return _arryItemViews;
}

- (UIPageControl*)pageCtrl{
    if (!_pageCtrl) {
        _pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        _pageCtrl.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, self.frame.size.height-10);
        _pageCtrl.numberOfPages = [self.delegateDatasource countOfItems:self];
        _pageCtrl.currentPage = 0;
        [_pageCtrl setPageIndicatorTintColor:self.colorPageIndicatorTint];
        [_pageCtrl setCurrentPageIndicatorTintColor:self.colorCurrentPageIndicatorTint];
    }
    return _pageCtrl;
}

@end