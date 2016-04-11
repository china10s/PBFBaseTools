//
//  PBFUITextFieldStratageRegex.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/12/22.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PBFUITextFieldVerify.h"

@interface PBFUITextFieldStratageRegex : NSObject<PBFUITextFieldVerifyStrategyDelegate>
- (instancetype)initWithRgex:(NSString*)strRegex;
- (BOOL)isValidate:(NSString *)strText;
@end