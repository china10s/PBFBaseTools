//
//  PBFUITextFieldAdditionFinishedBtn.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/12/22.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PBFUITextFieldVerify.h"

@protocol PBFUITextFieldAdditionFinishedBtnDelegate
//结束编辑
- (void)finishedEdit;
@end

@interface PBFUITextFieldAdditionFinishedBtn : NSObject<PBFUITextFieldVerifyAdditionDelegate>
- (void)additionComponent:(UITextField*)textField;
@property (nonatomic,weak)id<PBFUITextFieldAdditionFinishedBtnDelegate>     delegateSelf;
@end