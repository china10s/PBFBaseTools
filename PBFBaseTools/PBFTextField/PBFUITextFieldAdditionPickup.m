//
//  PBFUITextFieldAdditionPickup.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/12/22.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//

#import "PBFUITextFieldAdditionPickup.h"
#import <UIKit/UIKit.h>

//调用完成后的回调函数
typedef void(^SelComplete)(long);

@interface PBFUITextFieldAdditionPickup()
@property(nonatomic,strong)UIPickerView                         *pkvTimePick;
@property(nonatomic,strong)SelComplete                          blockSel;
@property(nonatomic,strong)NSArray                              *ranges;
@property(nonatomic,strong)UITextField                          *textField;
@end

@implementation PBFUITextFieldAdditionPickup
- (instancetype)initWithSelRange:(NSArray*)range blockSel:(void(^)(long))blockSel{
    self = [super init];
    self.blockSel = blockSel;
    self.ranges = range;
    return self;
}

- (void)additionComponent:(UITextField*)textField{
    textField.inputView = self.pkvTimePick;
    self.textField = textField;
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.ranges count];
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.ranges objectAtIndex:row];
}

- (void)selTimeRange:(id)sender{
    [self.textField resignFirstResponder];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.textField.text = [self.ranges objectAtIndex:row];
    if (self.blockSel) {
        self.blockSel(row);
    }
}

#pragma mark - getter and setter
- (UIPickerView*)pkvTimePick{
    if (!_pkvTimePick) {
        //pkvPick
        _pkvTimePick = [[UIPickerView alloc] init];
        _pkvTimePick.delegate = self;
        _pkvTimePick.dataSource = self;
    }
    return _pkvTimePick;
}

@end