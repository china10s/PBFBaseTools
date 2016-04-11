//
//  PBFMetadataTools.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/1/13.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import "PBFMetadataTools.h"
#import "BOYDataManger.h"

@implementation PBFMetadataToolsRegionModel

@end

@implementation PBFMetadataTools
//单例
+ (instancetype)sharedInstance{
    static PBFMetadataTools *dataTools = nil;
    @synchronized(self) {
        if (!dataTools) {
            dataTools = [[PBFMetadataTools alloc] init];
        }
    }
    return dataTools;
}

//TB_METADATA_REGIONALISM (CODE,NAME,SHORTCODE,PARENTCODE)

//获取所有省份名称
- (NSArray*)getProvinces{
    return [[BOYDataManger sharedInstance] executeQuery:@"select * from TB_METADATA_REGIONALISM where PARENTCODE ='0';" classType:[PBFMetadataToolsRegionModel class] isPrivate:FALSE];
}

//获取省份下所有城市名称
- (NSArray*)getProviceCitys:(NSString*)strProvince{
    NSString *strSql = [NSString stringWithFormat:@"select * from TB_METADATA_REGIONALISM where parentcode = (select code from TB_METADATA_REGIONALISM where name = '%@');",strProvince];
    return [[BOYDataManger sharedInstance] executeQuery:strSql classType:[PBFMetadataToolsRegionModel class] isPrivate:FALSE];
}

@end