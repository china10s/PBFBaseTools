//
//  PBFColorTools.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/5/8.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface PBFColorTools : NSObject

//初始化
+ (instancetype)sharedInstance;

//按钮背景
@property (nonatomic,strong)UIImage                         *imageRedBtn;
@property (nonatomic,strong)UIImage                         *imageRedBtnSel;
@property (nonatomic,strong)UIImage                         *imageGreenBtn;
@property (nonatomic,strong)UIImage                         *imageGreenBtnSel;

@property (nonatomic,strong)UIColor                         *redColorSystem;
@property (nonatomic,strong)UIColor                         *greenColorSystem;
@property (nonatomic,strong)UIColor                         *blueColorSystem;
@property (nonatomic,strong)UIColor                         *blackColorSystem;
@property (nonatomic,strong)UIColor                         *grayColorSystem;

//表格分割线颜色
@property (nonatomic,strong)UIColor                         *colorTableSeparatorLine;
//表格单元格Title颜色
@property (nonatomic,strong)UIColor                         *colorTableCellTitle;

@end
