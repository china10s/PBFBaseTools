//
//  PBFColorTools.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/5/8.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import "PBFColorTools.h"
#import "PBFConvert.h"

@implementation PBFColorTools

+ (instancetype)sharedInstance{
    static PBFColorTools *tools ;
    @synchronized(self){
        if (!tools) {
            tools = [[PBFColorTools alloc] initPrivate];
        }
    }
    
    return tools;
}

- (instancetype)init{
    return nil;
}

- (instancetype)initPrivate{
    self = [super init];
    
    self.imageRedBtn = [UIImage imageNamed:@"icon_userinfo_btn_deposit.png"];
    self.imageRedBtn = [self.imageRedBtn stretchableImageWithLeftCapWidth:floor(self.imageRedBtn.size.width/2) topCapHeight:self.imageRedBtn.size.width/2];
    self.imageRedBtnSel = [UIImage imageNamed:@"icon_userinfo_btn_deposit_sel.png"];
    self.imageRedBtnSel = [self.imageRedBtnSel stretchableImageWithLeftCapWidth:floor(self.imageRedBtnSel.size.width/2) topCapHeight:self.imageRedBtnSel.size.width/2];
    
    self.imageGreenBtn = [UIImage imageNamed:@"icon_userinfo_btn_charge.png"];
    self.imageGreenBtn = [self.imageGreenBtn stretchableImageWithLeftCapWidth:floor(self.imageGreenBtn.size.width/2) topCapHeight:self.imageGreenBtn.size.width/2];
    self.imageGreenBtnSel = [UIImage imageNamed:@"icon_userinfo_btn_charge_sel.png"];
    self.imageGreenBtnSel = [self.imageGreenBtnSel stretchableImageWithLeftCapWidth:floor(self.imageGreenBtnSel.size.width/2) topCapHeight:self.imageGreenBtnSel.size.width/2];
    
    self.redColorSystem = [UIColor colorWithRed:239/255.0f green:49/255.0f blue:24/255.0f alpha:1];
    self.greenColorSystem = [UIColor colorWithRed:84/255.0f green:139/255.0f blue:84/255.0f alpha:1];
    self.blueColorSystem = [UIColor colorWithRed:45/255.0f green:183/255.0f blue:238/255.0 alpha:1];
    self.blackColorSystem = [UIColor blackColor];
    self.grayColorSystem = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    
    //表格分割线颜色
    self.colorTableSeparatorLine = [PBFConvert getColorFromHexString:@"#eeeeee"];
    //表格单元格Title颜色
    self.colorTableCellTitle = [PBFConvert getColorFromHexString:@"#333333"];
    
    return self;
}


@end