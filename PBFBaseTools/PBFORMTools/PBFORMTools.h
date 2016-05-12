//
//  PBFORMTools.h
//  PBFBaseToolsDemo
//
//  Created by BY-MAC01 on 16/5/12.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//
// ORM框架
// 如果需要处理NSArray的参数类型，需要自定义一个名为“KPBFORMToolsDicArrayName”的NSDictionary，存储类型为<arrayName,class>，Init函数内绑定

// Array类型名称
#define KPBFORMToolsDicArrayName        dicArrayClassName

#import <Foundation/Foundation.h>

@interface PBFORMTools : NSObject

//ORM框架，利用Runtime构建Model
+ (void)assembleDictionaryData:(NSObject*)objDes objRes:(NSDictionary*)objRes;

//ORM框架，利用Runtime构建Model
+ (NSArray*)assembleArrayData:(Class)classType objRes:(NSArray*)objRes;

@end