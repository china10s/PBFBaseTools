//
//  PBFButtonVerifyCode.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/12/16.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//

#import "PBFButtonVerifyCode.h"
#import "PBFConvert.h"

@interface PBFButtonVerifyCode()
//倒数计时器
@property (nonatomic,strong)NSTimer                         *timer;
//干活
@property (nonatomic,strong)PBFButtonVerifyCodeBlock        blockWork;
//倒数时间
@property (nonatomic,assign)long                            nCurCountDown;
@end

@implementation PBFButtonVerifyCode
//验证码初始化
- (instancetype)initWithVerify:(PBFButtonVerifyCodeBlock)block{
    self = [self init];
    self.lTimeGapLen = 60;
    self.strBtnNormalTitle = @"获取";
    self.strBtnUnableTitle = @"重发(%ld)";
    self.blockWork = block;
    
    [self setTitle:self.strBtnNormalTitle forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self setBackgroundImage:[PBFConvert createImageWithColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [self addTarget:self action:@selector(clickWork:) forControlEvents:UIControlEventTouchUpInside];
    return self;
}

//干活
- (void)clickWork:(UIButton*)sender{
    if (self.blockWork) {
        self.blockWork();
    }
}

//开始计时
- (void)fire{
    if (self.timer) {
        return;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(workTimer:) userInfo:nil repeats:TRUE];
    self.nCurCountDown = self.lTimeGapLen;
    [self setEnabled:FALSE];
    [self setTitle:[NSString stringWithFormat:@"重发(%ld)",self.nCurCountDown] forState:UIControlStateNormal];
    [self.timer fire];
}

- (void)workTimer:(NSTimer*)sender{
    NSTimer* timer = (NSTimer*)sender;
    self.nCurCountDown -= 1;
    if (self.nCurCountDown < 0) {
        [timer invalidate];
        [self setEnabled:TRUE];
        [self setTitle:self.strBtnNormalTitle forState:UIControlStateNormal];
        self.timer = nil;
        return ;
    }
    [self setTitle:[NSString stringWithFormat:@"重发(%ld)",self.nCurCountDown] forState:UIControlStateNormal];
    
}

//重置状态
- (void)recover{
    [self.timer invalidate];
    self.timer = nil;
    [self setEnabled:TRUE];
    [self setTitle:self.strBtnNormalTitle forState:UIControlStateNormal];
}

@end