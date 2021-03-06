//
//  PBFPopInputView.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/4/14.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import "PBFPopInputView.h"
#import "PBFDeviceTools.h"

@interface PBFPopInputView()
//返回
@property (nonatomic,strong)InputBackRtn        blockFinish;
@end

@implementation PBFPopInputView
+ (instancetype)sharedInstance{
    static PBFPopInputView *tools ;
    @synchronized(self){
        if (!tools) {
            tools = [[PBFPopInputView alloc] initPrivate];
        }
    }
    return tools;
}

- (instancetype)init{
    return nil;
}

- (instancetype)initPrivate{
    self = [super init];
    return self;
}

- (void)popOutTextField:(UIViewController*)ctrl strTitle:(NSString*)strTitle strMess:(NSString*)strMess cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitle:(NSString*)otherButtonTitle blockTextField:(void(^)(UITextField *))blockTextField blockFinish:(void(^)(NSString* ))blockFinish{
    if ([PBFDeviceTools  getSDKVersion] > 8.0f) {
        __block UITextField* textFieldTmp = nil;
        UIAlertController *ctrlAlertConfirm = [UIAlertController alertControllerWithTitle:strTitle message:strMess preferredStyle:UIAlertControllerStyleAlert];
        [ctrlAlertConfirm addTextFieldWithConfigurationHandler:^(UITextField* textField){
            textFieldTmp = textField;
            textField.textAlignment = NSTextAlignmentCenter;
            textField.borderStyle = UITextBorderStyleNone;
            blockTextField(textField);
        }];
        //取消按钮
        UIAlertAction *defaultActionCancell = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            
        }];
        //确定按钮
        UIAlertAction *defaultActionOk = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
            if (textFieldTmp) {
                blockFinish(textFieldTmp.text);
            }
            //self.infoDeposit
        }];
        [ctrlAlertConfirm addAction:defaultActionCancell];
        [ctrlAlertConfirm addAction:defaultActionOk];
        [ctrl presentViewController:ctrlAlertConfirm animated:YES completion:nil];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:strTitle message:strMess delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle, nil];
        [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
        
        UITextField* textField = [alertView textFieldAtIndex:0];
        textField.textAlignment = NSTextAlignmentCenter;
        textField.borderStyle = UITextBorderStyleNone;
        blockTextField(textField);
        self.blockFinish = blockFinish;
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        UITextField *textFieldTmp = [alertView textFieldAtIndex:0];
        if (self.blockFinish) {
            self.blockFinish(textFieldTmp.text);
        }
    }
}

@end