//
//  PBFSimplePieChartView.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/1/19.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import "PBFSimplePieChartView.h"

//元素
@implementation PBFSimplePieChartViewItem

@end

@interface PBFSimplePieChartView()
//饼状图元素展现比例
@property (nonatomic,assign)double             nPercent;//百分比
@end

@implementation PBFSimplePieChartView
@synthesize arrPiesTarget = _arrPiesTarget;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self setBackgroundColor:[UIColor clearColor]];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    [self setBackgroundColor:[UIColor clearColor]];
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self drawBackground];
    [self drawItemPies];
    [self drawCenterView];
}

//绘制背景色
- (void)drawBackground{
    CGSize sizeView = self.frame.size;
    CGPoint pCenter = CGPointMake(sizeView.width/2, sizeView.height/2);
    float radius = sizeView.width/2;

    CGContextRef  context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, pCenter.x, pCenter.y);
    CGContextAddArc(context, pCenter.x, pCenter.y, radius, 0, 2*M_PI, 0);
    CGContextSetFillColorWithColor(context, self.colBackground.CGColor);
    CGContextFillPath(context);
}
//+self.fItemGap*itemInfo.percent
//绘制每块
- (void)drawItemPies{
    if ([self.arrPiesTarget count] <= 0) {
        return;
    }
    CGSize sizeView = self.frame.size;
    CGPoint pCenter = CGPointMake(sizeView.width/2, sizeView.height/2);
    float radius = sizeView.width/2;
    CGContextRef  context = UIGraphicsGetCurrentContext();
    float fPercent = 0;
    for (int i =0 ; i < [self.arrPiesTarget count]; ++i) {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, pCenter.x, pCenter.y);
        PBFSimplePieChartViewItem *itemInfo = [self.arrPiesTarget objectAtIndex:i];
        CGContextAddArc(context, pCenter.x, pCenter.y, radius, fPercent*2*M_PI, (fPercent + itemInfo.percent*self.nPercent)*2*M_PI, 0);
        CGContextSetFillColorWithColor(context, itemInfo.bgColor.CGColor);
        CGContextSetRGBStrokeColor(context,1,1,1,1.0);//画笔线的颜色
        CGContextSetLineWidth(context, 5.0);//线的宽度
        CGContextFillPath(context);
        CGContextDrawPath(context, kCGPathStroke);
        fPercent += itemInfo.percent*self.nPercent;
    }
}

//绘制中间圆形
- (void)drawCenterView{
    if (self.fBorderRatio > 1) {
        return;
    }
    CGSize sizeView = self.frame.size;
    CGPoint pCenter = CGPointMake(sizeView.width/2, sizeView.height/2);
    float radius = sizeView.width/2*(1-self.fBorderRatio);
    
    CGContextRef  context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, pCenter.x, pCenter.y);
    CGContextAddArc(context, pCenter.x, pCenter.y, radius, 0, 2*M_PI, 0);
    CGContextSetFillColorWithColor(context, self.colBackgroundCenter.CGColor);
    CGContextFillPath(context);
}

#pragma mark - getter and setter
//背景色
- (UIColor*)colBackground{
    if (!_colBackground) {
        _colBackground = [UIColor groupTableViewBackgroundColor];
    }
    return _colBackground;
}


//中心背景色
- (UIColor*)colBackgroundCenter{
    if (!_colBackgroundCenter) {
        _colBackgroundCenter = [UIColor whiteColor];
    }
    return _colBackgroundCenter;
}


//饼状图元素
- (NSArray*)arrPiesTarget{//PBFSimplePieChartViewItem
    if (!_arrPiesTarget) {
        _arrPiesTarget = [[NSArray alloc] init];
    }
    return _arrPiesTarget;
}

//边框占比
- (float)fBorderRatio{
    if (_fBorderRatio == 0) {
        _fBorderRatio = 0.6;
    }
    return _fBorderRatio;
}

////重载设置函数
//- (void)setArrPies:(NSArray *)arrPies{
//    _arrPies = arrPies;
//    [self setNeedsDisplay];
//}

//重载设置函数
- (void)setArrPiesTarget:(NSArray *)arrPiesTarget{
    _arrPiesTarget = arrPiesTarget;
    self.nPercent = 0.01;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(countly:) userInfo:nil repeats:TRUE];
    [timer fire];
}

- (void)countly:(NSTimer*)timer{
    if (self.nPercent >= 1) {//达到或者超过
        self.nPercent = 1;
        [timer invalidate];
        timer = nil;
    }
    else{//不及
        self.nPercent += 0.03;
    }
    [self setNeedsDisplay];
}

@end