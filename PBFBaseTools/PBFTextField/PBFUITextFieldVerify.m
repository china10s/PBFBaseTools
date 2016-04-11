//
//  PBFUITextFieldVerify.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/12/22.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//

#import "PBFUITextFieldVerify.h"

@interface PBFUITextFieldVerify()
//策略
@property (nonatomic,strong)NSMutableArray                  *arrStrategys;
//组件
@property (nonatomic,strong)NSMutableArray                  *arrComponents;
@end

@implementation PBFUITextFieldVerify
- (instancetype)initWithStrategy{
    self = [super init];
    [self addTarget:self action:@selector(textViewDidChange:) forControlEvents:UIControlEventEditingChanged];
    return self;
}

- (instancetype)initWithStrategyFrame:(CGRect)rect{
    self = [super initWithFrame:rect];
    [self addTarget:self action:@selector(textViewDidChange:) forControlEvents:UIControlEventEditingChanged];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    [self addTarget:self action:@selector(textViewDidChange:) forControlEvents:UIControlEventEditingChanged];
    return self;
}

- (instancetype)init{
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame{
    return nil;
}

- (void)addStrategy:(id<PBFUITextFieldVerifyStrategyDelegate>)strategyItem{
    [self.arrStrategys addObject:strategyItem];
}

- (void)addAddition:(id<PBFUITextFieldVerifyAdditionDelegate>)addition{
    [self.arrComponents addObject:addition];
}

//- (void)willMoveToSuperview:(UIView *)newSuperview{
//    for (id<PBFUITextFieldVerifyAdditionDelegate> delegateAddition in self.arrComponents) {
//        [delegateAddition additionComponent:self];
//    }
//}

- (void)didMoveToSuperview{
    for (id<PBFUITextFieldVerifyAdditionDelegate> delegateAddition in self.arrComponents) {
        [delegateAddition additionComponent:self];
    }
}


- (BOOL)isAvaliable:(NSString *)strText{
    for (id<PBFUITextFieldVerifyStrategyDelegate> delegateStrategy in self.arrStrategys) {
        if (![delegateStrategy isValidate:strText]) {
            return FALSE;
        }
    }
    return TRUE;
}

- (void)textViewDidChange:(NSNotification *)notification{
    if (![self isAvaliable:self.text] && [self.text length] > 0) {
        self.text = [self.text substringToIndex:[self.text length]-1];
    }
}

#pragma mark - getter and setter
- (NSMutableArray*)arrStrategys{
    if(!_arrStrategys){
        _arrStrategys = [[NSMutableArray alloc] init];
    }
    return _arrStrategys;
}

- (NSMutableArray*)arrComponents{
    if(!_arrComponents){
        _arrComponents = [[NSMutableArray alloc] init];
    }
    return _arrComponents;
}

@end