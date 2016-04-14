//
//  PBFPopInputView.h
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/4/14.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^InputBackRtn)(NSString* strRtn);

@interface PBFPopInputView : NSObject
+ (instancetype)sharedInstance;
- (void)popOutTextField:(UIViewController*)ctrl strTitle:(NSString*)strTitle strMess:(NSString*)strMess cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitle:(NSString*)otherButtonTitle blockTextField:(void(^)(UITextField *))blockTextField blockFinish:(void(^)(NSString* ))blockFinish;
@end
