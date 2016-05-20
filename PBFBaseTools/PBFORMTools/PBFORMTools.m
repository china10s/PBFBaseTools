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
//两种方式：
//PBFORMToolsAssembleModelDefault：当json的dictionary中，该字段不存在时，不作处理，初始化为nil
//PBFORMToolsAssembleModelInitNull：当json的dictionary中，该字段不存在时，初始化为@""或者0
+ (void)assembleDictionaryData:(NSObject*)objDes objRes:(NSDictionary*)objRes mode:(PBFORMToolsAssembleModel)mode{
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
        //默认方式
        if (mode == PBFORMToolsAssembleModelDefault) {
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
                strIvarTypeDes = [strIvarTypeDes substringWithRange:NSMakeRange(2, [strIvarTypeDes length]-3)];
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
                //2.2.3、NSDate类型
                else if([objValueRes isKindOfClass:[NSDate class]] && [strIvarTypeDes containsString:@"NSNumber"]){
                    long lTimeStamp = [(NSNumber*)objValueRes longLongValue];
                    NSDate *dateRes = [NSDate dateWithTimeIntervalSince1970:lTimeStamp];
                    //设置值
                    object_setIvar(objDes, varTmpDes, dateRes);
                }
                //2.2.4、NSDictionary类型
                //如属于NSDictionary、且Class该属性类型不属于上述类型，递归调用 assembleDictionaryData
                else if ([objValueRes isKindOfClass:[NSDictionary class]]) {
                    //设置值
                    Class classDes = objc_getClass([strIvarTypeDes UTF8String]);
                    id objDesDic = [[classDes alloc] init];
                    [PBFORMTools assembleDictionaryData:objDesDic objRes:(NSDictionary*)objValueRes];
                    object_setIvar(objDes, varTmpDes, objDesDic);
                }
                //2.2.5、NSArray类型
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
                    NSObject *objNSArray = [PBFORMTools assembleArrayData:classType objRes:(NSArray*)objValueRes];
                    object_setIvar(objDes, varTmpDes, objNSArray);
                }
            }
        }
        else{//未传值初始化为0或者@“”
            unsigned int count;// 记录属性个数
            objc_property_t *properties = class_copyPropertyList(classType, &count);
            for(int iFlag = 0 ; iFlag < count ; ++iFlag ){
                objc_property_t property = properties[iFlag];
                const char *propertyName = property_getName(property);
                const char *propertyType = property_getAttributes(property);
                NSString *strAttName = [NSString stringWithUTF8String:propertyName];
                NSString *strAttType = [NSString stringWithUTF8String:propertyType];
                if(!strAttName || [strAttName length] <= 0 || !strAttType || [strAttType length] <= 0){
                    continue;
                }
                NSObject *objValueRes = [objRes objectForKey:strAttName];
                //2.2.1、NSString类型
                if([objValueRes isKindOfClass:[NSString class]] && [strAttType containsString:@"NSString"]){
                    //设置值
                    [objDes setValue:objValueRes forKey:strAttName];
                }
                //2.2.2、NSNumber类型
                else if([objValueRes isKindOfClass:[NSNumber class]] && [strAttType containsString:@"NSNumber"]){
                    //设置值
                    [objDes setValue:objValueRes forKey:strAttName];
                }
                //2.2.3、NSDate类型
                else if([objValueRes isKindOfClass:[NSDate class]] && [strAttType containsString:@"NSNumber"]){
                    long lTimeStamp = [(NSNumber*)objValueRes longLongValue];
                    NSDate *dateRes = [NSDate dateWithTimeIntervalSince1970:lTimeStamp];
                    //设置值
                    [objDes setValue:dateRes forKey:strAttName];
                }
                //2.2.4、NSDictionary类型
                //如属于NSDictionary、且Class该属性类型不属于上述类型，递归调用 assembleDictionaryData
                else if ([objValueRes isKindOfClass:[NSDictionary class]]) {
                    //设置值
                    //将类型字符串截取
                    NSArray *arrTyle = [strAttType componentsSeparatedByString:@"\""];
                    if (!arrTyle || [arrTyle count] < 2) {
                        continue;
                    }
                    NSString *strAttTypeFormat = [arrTyle objectAtIndex:1];
                    Class classDes = objc_getClass([strAttTypeFormat UTF8String]);
                    id objDesDic = [[classDes alloc] init];
                    [PBFORMTools assembleDictionaryData:objDesDic objRes:(NSDictionary*)objValueRes];
                    [objDes setValue:objDesDic forKey:strAttName];
                }
                //2.2.4、NSArray类型
                //如类型属于NSArray、循环递归 assembleArrayData
                else if ([objValueRes isKindOfClass:[NSArray class]]) {
                    //设置值
                    if (dicArrClassNames == NULL) {
                        continue;
                    }
                    id classType = [dicArrClassNames objectForKey:strAttName];
                    if (classType == NULL) {
                        continue;
                    }
                    NSObject *objNSArray = [PBFORMTools assembleArrayData:classType objRes:(NSArray*)objValueRes];
                    [objDes setValue:objNSArray forKey:strAttName];
                }
                //给默认值
                else if(![strAttName isEqualToString:@"dicArrayClassName"]){
                    //设置值
                    if([strAttType containsString:@"NSString"]){
                        //设置值
                        [objDes setValue:@"" forKey:strAttName];
                    }
                    else if([strAttType containsString:@"NSNumber"]){
                        //设置值
                        [objDes setValue:[NSNumber numberWithInt:0] forKey:strAttName];
                    }
                    
                }
            }
        }
    }
    return ;
}

//ORM框架，利用Runtime构建Model
+ (void)assembleDictionaryData:(NSObject*)objDes objRes:(NSDictionary*)objRes{
    [PBFORMTools assembleDictionaryData:objDes objRes:objRes mode:PBFORMToolsAssembleModelDefault];
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
