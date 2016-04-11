//
//  PBFUITextFieldStratageMinlength.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/12/22.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//

#import "PBFUITextFieldStratageMinlength.h"


@interface  PBFUITextFieldStratageMinlength()
@property (nonatomic,assign)long                    lMinLength;
@end


@implementation PBFUITextFieldStratageMinlength
- (instancetype)initWithMinKLength:(long)lMinLength{
    self = [super init];
    self.lMinLength = lMinLength;
    return self;
}

- (BOOL)isValidate:(NSString *)strText{
    if ([strText length] >= self.lMinLength) {
        return TRUE;
    }
    else{
        return FALSE;
    }
}
@end