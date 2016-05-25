//
//  PBFMacroData.h
//  Halo
//
//  Created by zhulin on 16/5/25.
//  Copyright © 2016年 inno-asiatech. All rights reserved.
//

#ifndef PBFMacroData_h
#define PBFMacroData_h

//Block
typedef void(^CompleteBlockVoid)(void);
typedef void(^CompleteBlockBool)(BOOL);
typedef void(^CompleteBlockNSArray)(NSArray*);
typedef void(^CompleteBlockNSDictionary)(NSDictionary*);
//#define CompleteBlockClass(x) void(^)(x)

#endif /* PBFMacroData_h */
