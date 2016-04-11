//
//  PBFMetadataTools.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/1/13.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//
//  基础数据获取

#import <Foundation/Foundation.h>

//区域model
@interface PBFMetadataToolsRegionModel:NSObject
@property (nonatomic,strong)NSString            *CODE;//唯一编码
@property (nonatomic,strong)NSString            *NAME;//名称
@property (nonatomic,strong)NSString            *SHORTCODE;//简化代码
@property (nonatomic,strong)NSString            *PARENTCODE;//父节点名称
@end

@interface PBFMetadataTools : NSObject
//单例
+ (instancetype)sharedInstance;

//获取所有省份名称
- (NSArray*)getProvinces;//PBFMetadataToolsRegionModel

//获取省份下所有城市名称
- (NSArray*)getProviceCitys:(NSString*)strProvince;//PBFMetadataToolsRegionModel

@end