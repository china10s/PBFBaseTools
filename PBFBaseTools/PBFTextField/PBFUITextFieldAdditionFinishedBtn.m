//
//  PBFUITextFieldAdditionFinishedBtn.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/12/22.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//

#import "PBFUITextFieldAdditionFinishedBtn.h"

@interface PBFUITextFieldAdditionFinishedBtn()
@property(nonatomic,strong)UIToolbar                        *tbrTimeSel;
@property(nonatomic,strong)UITextField                      *textField;
@end

@implementation PBFUITextFieldAdditionFinishedBtn
- (void)additionComponent:(UITextField*)textField{
    textField.inputAccessoryView = self.tbrTimeSel;
    self.textField = textField;
}

#pragma mark - getter and setter
- (UIToolbar*)tbrTimeSel{
    if (!_tbrTimeSel) {
        _tbrTimeSel = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        
        //toolbarItem
        UIBarButtonItem *itemSel = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(finishedEdit:)];
        itemSel.width = 50;
        UIBarButtonItem *itemSelEmpty = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        itemSelEmpty.width = [UIScreen mainScreen].bounds.size.width - 90;
        [_tbrTimeSel setItems:[NSArray arrayWithObjects:itemSelEmpty,itemSel, nil]];
    }
    return _tbrTimeSel;
}

- (void)finishedEdit:(id)sender{
    [self.textField resignFirstResponder];
    if(self.delegateSelf){
        [self.delegateSelf finishedEdit];
    }
}

@end