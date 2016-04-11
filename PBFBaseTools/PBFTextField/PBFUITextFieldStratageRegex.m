//
//  PBFUITextFieldStratageRegex.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/12/22.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//

#import "PBFUITextFieldStratageRegex.h"
#import "PBFNSStringTools.h"

@interface  PBFUITextFieldStratageRegex()
@property (nonatomic,strong)NSString                    *strFormatString;
@end


@implementation PBFUITextFieldStratageRegex
- (instancetype)initWithRgex:(NSString*)strRegex{
    self = [super init];
    self.strFormatString = strRegex;
    return self;
}

- (BOOL)isValidate:(NSString *)strText{
    if ([PBFNSStringTools isRegularString:self.strFormatString strText:strText]) {
        return TRUE;
    }
    else{
        return FALSE;
    }
}
@end