//
//  PBFProgressCircleView.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/1/19.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import "PBFProgressCircleView.h"

@interface PBFProgressCircleView()
//当前百分比
@property (nonatomic,assign)float                       percent;
@end

@implementation PBFProgressCircleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

*/

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    [self setBackgroundColor:[UIColor clearColor]];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self setBackgroundColor:[UIColor clearColor]];
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self drawCircleBackground];
    [self drawCircleProgress];
    [self drawCircleCenter];
}

//绘制圆形背景
- (void)drawCircleBackground{
    CGColorRef color = self.backgroundCol.CGColor;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width/2, viewSize.height/2);
    
    CGFloat radius = viewSize.width/2;
    CGContextBeginPath(contextRef);
    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef,center.x, center.y, radius, 0, 2*M_PI,0);
    CGContextSetFillColorWithColor(contextRef, color);
    CGContextFillPath(contextRef);
}

//绘制进度条
- (void)drawCircleProgress{
    if(self.percent == 0 || self.percent > 1){
        return ;
    }
    
    CGColorRef color = (self.percent == 1)?
        self.progressColfinished.CGColor:self.progressColUnfinished.CGColor;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width/2, viewSize.height/2);
    CGFloat radius = viewSize.width/2;
    CGContextBeginPath(contextRef);
    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef, center.x, center.y, radius, 0, self.percent*2*M_PI,0);
    CGContextSetFillColorWithColor(contextRef, color);
    CGContextFillPath(contextRef);
}

//绘制中心
- (void)drawCircleCenter{
    //背景
    CGColorRef color = [UIColor whiteColor].CGColor;
    CGSize size = self.bounds.size;
    float radius = size.width/2 - self.borderWidth;
    CGPoint center = CGPointMake(size.width/2, size.height/2);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, center.x, center.y);
    CGContextAddArc(context,center.x, center.y, radius, 0, 2*M_PI, 0);
    CGContextSetFillColorWithColor(context, color);
    CGContextFillPath(context);
    
    //文字
    NSString *percentString = self.percent == 1?
        @"100%":[NSString stringWithFormat:@"%0.0f%%",self.percent*100];
    UIColor *arcColor = self.percent == 1?self.progressColfinished:self.progressColUnfinished;
    CGSize viewSize = self.bounds.size;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *dicAtt = [NSDictionary dictionaryWithObjectsAndKeys:
                            arcColor,NSForegroundColorAttributeName,
                            self.fontLabel,NSFontAttributeName,
                            paragraph,NSParagraphStyleAttributeName, nil];
    [percentString drawInRect:CGRectMake(0, (viewSize.height-self.fontLabel.pointSize)/2, viewSize.width, self.fontLabel.pointSize) withAttributes:dicAtt];
}


#pragma mark - getter and setter
//背景色
- (UIColor *)backgroundCol{
    if(!_backgroundCol){
        _backgroundCol = [UIColor groupTableViewBackgroundColor];
    }
    return _backgroundCol;
}

//未完成时候，进度色.
- (UIColor *)progressColUnfinished{
    if(!_progressColUnfinished){
        _progressColUnfinished = [UIColor blueColor];
    }
    return _progressColUnfinished;
}

//已完成时候，进度色
- (UIColor *)progressColfinished{
    if(!_progressColfinished){
        _progressColfinished = [UIColor greenColor];
    }
    return _progressColfinished;
}

//字体
- (UIFont*)fontLabel{
    if(!_fontLabel){
        _fontLabel = [UIFont boldSystemFontOfSize:14.0f];
    }
    return _fontLabel;
}

//边框宽度
- (float)borderWidth{
    if(_borderWidth == 0){
        _borderWidth = self.frame.size.width/15;
    }
    return _borderWidth;
}

//百分比
- (void)setTargetPercent:(float)targetPercent{
    _targetPercent = targetPercent;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(countly:) userInfo:[NSNumber numberWithInt:1] repeats:TRUE];
    [timer fire];
    return ;
}

//百分比
- (void)setPercent:(float)percent{
    _percent = percent;
    //重绘
    [self setNeedsDisplay];
    return ;
}

- (void)countly:(NSTimer*)timer{
    float fCurPercent = _percent + self.targetPercent*0.01;
    if (_percent >= self.targetPercent) {//超过或达到
        [self setPercent:self.targetPercent];
        [timer invalidate];
        timer = nil;
    }
    else{
        [self setPercent:fCurPercent];
    }
}


@end