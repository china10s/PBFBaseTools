//
//  PBFUITextFieldAdditionPickup.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/12/22.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UITextField;
@protocol UIPickerViewDataSource,UIPickerViewDelegate;

@interface PBFUITextFieldAdditionPickup : NSObject<UIPickerViewDataSource,UIPickerViewDelegate>
- (instancetype)initWithSelRange:(NSArray*)range blockSel:(void(^)(long))blockSel;
- (void)additionComponent:(UITextField*)textField;
@end