//
//  PBFPopInputTools.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/6/18.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PBFPopInputTools : NSObject

typedef void(^InputBackRtn)(NSString* strRtn);

+ (instancetype)sharedInstance;
- (void)popOutTextField:(UIViewController*)ctrl strTitle:(NSString*)strTitle strMess:(NSString*)strMess cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitle:(NSString*)otherButtonTitle blockTextField:(void(^)(UITextField *))blockTextField blockFinish:(void(^)(NSString* ))blockFinish;
@end
