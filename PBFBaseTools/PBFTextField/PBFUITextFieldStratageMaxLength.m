//
//  PBFUITextFieldStratageMaxLength.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/12/22.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//

#import "PBFUITextFieldStratageMaxLength.h"

@interface  PBFUITextFieldStratageMaxLength()
@property (nonatomic,assign)long                    lMaxLength;
@end


@implementation PBFUITextFieldStratageMaxLength
- (instancetype)initWithMaxKLength:(long)lMaxLength{
    self = [super init];
    self.lMaxLength = lMaxLength;
    return self;
}

- (BOOL)isValidate:(NSString *)strText{
    if ([strText length] <= self.lMaxLength) {
        return TRUE;
    }
    else{
        return FALSE;
    }
}
@end