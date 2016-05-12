//
//  PBFORMTools.m
//  PBFBaseToolsDemo
//
//  Created by BY-MAC01 on 16/5/12.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import "PBFORMTools.h"
#import <objc/runtime.h>

@implementation PBFORMTools

//ORM框架，利用Runtime构建Model
+ (void)assembleDictionaryData:(NSObject*)objDes objRes:(NSDictionary*)objRes{
    Class classType = [objDes class];
    //NSArray类型对照表
    NSDictionary *dicArrClassNames = nil;
    NSString *strDicArrNames = @"_dicArrayClassName";
    Ivar ivarDicArrayClassNames = class_getInstanceVariable(classType, [strDicArrNames UTF8String]);
    if(ivarDicArrayClassNames != NULL){
        id idDicArray = object_getIvar(objDes, ivarDicArrayClassNames);
        if ([idDicArray isKindOfClass:[NSDictionary class]]) {
            dicArrClassNames = idDicArray;
        }
    }
    if (objRes) {
        for (NSString * keyNameRes in [objRes allKeys]) {
            if (!keyNameRes || [keyNameRes length]<=0) {
                continue;
            }
            //1、获取Class对应属性，判断属性类型
            const char * attNameRes = [[NSString stringWithFormat:@"_%@",keyNameRes] UTF8String];
            Ivar varTmpDes = class_getInstanceVariable(classType,attNameRes);
            //2、判断Json数据中，对应数据是否存在
            //2.1、如不存在，continue
            if (varTmpDes == NULL) {
                continue;
            }
            //2.2、判断json数据和属性的类型是否一致
            NSObject *objValueRes = [objRes objectForKey:keyNameRes];
            const char *ivarType = ivar_getTypeEncoding(varTmpDes);
            NSString *strIvarTypeDes = [NSString stringWithUTF8String:ivarType];
            //2.2.1、NSString类型
            if([objValueRes isKindOfClass:[NSString class]] && [strIvarTypeDes containsString:@"NSString"]){
                //设置值
                object_setIvar(objDes, varTmpDes, objValueRes);
            }
            //2.2.2、NSNumber类型
            else if([objValueRes isKindOfClass:[NSNumber class]] && [strIvarTypeDes containsString:@"NSNumber"]){
                //设置值
                object_setIvar(objDes, varTmpDes, objValueRes);
            }
            //2.2.3、NSDictionary类型
            //如属于NSDictionary、且Class该属性类型不属于上述类型，递归调用 assembleDictionaryData
            else if ([objValueRes isKindOfClass:[NSDictionary class]]) {
                //设置值
                Class classDes = objc_getClass(ivarType);
                id objDes = [[classDes alloc] init];
                [PBFORMTools assembleDictionaryData:objDes objRes:(NSDictionary*)objValueRes];
                object_setIvar(objDes, varTmpDes, objDes);
            }
            //2.2.4、NSArray类型
            //如类型属于NSArray、循环递归 assembleArrayData
            else if ([objValueRes isKindOfClass:[NSArray class]]) {
                //设置值
                if (dicArrClassNames == NULL) {
                    continue;
                }
                id classType = [dicArrClassNames objectForKey:keyNameRes];
                if (classType == NULL) {
                    continue;
                }
                NSObject *objDes = [PBFORMTools assembleArrayData:classType objRes:(NSArray*)objValueRes];
                object_setIvar(objDes, varTmpDes, objDes);
            }
        }
    }
    return ;
}

//ORM框架，利用Runtime构建Model
+ (NSArray*)assembleArrayData:(Class)classType objRes:(NSArray*)objRes{
    NSMutableArray *arrRtn = [[NSMutableArray alloc] init];
    for(NSObject* objTmp in objRes){
        //1、NSString类型
        if([objTmp isKindOfClass:[NSString class]] && classType == [NSString class]){
            //设置值
            [arrRtn addObject:objTmp];
        }
        //2、NSNumber类型
        else if([objTmp isKindOfClass:[NSNumber class]] && classType == [NSNumber class]){
            //设置值
            [arrRtn addObject:objTmp];
        }
        //3、属于NSArray，递归调用本方法 assembleArrayData
        else if ([objTmp isKindOfClass:[NSArray class]]) {
            NSArray *arrDes = [PBFORMTools assembleArrayData:classType objRes:(NSArray*)objTmp];
            [arrRtn addObject:arrDes];
        }
        //4、不属于NSArray，属于NSDictionary，直接调用 assembleDictionaryData
        else if ([objTmp isKindOfClass:[NSDictionary class]]) {
            id objDes = [[classType alloc] init];
            [PBFORMTools assembleDictionaryData:objDes objRes:(NSDictionary*)objTmp];
            [arrRtn addObject:objDes];
        }
    }
    return [arrRtn copy];
}



@end
