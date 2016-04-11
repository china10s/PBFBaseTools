//
//  PBFUITextFieldStratageMinlength.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/12/22.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PBFUITextFieldVerify.h"

@interface PBFUITextFieldStratageMinlength : NSObject<PBFUITextFieldVerifyStrategyDelegate>
- (instancetype)initWithMinKLength:(long)lMinLength;
@end