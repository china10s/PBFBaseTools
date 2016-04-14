//
//  PBFNotifyAlertViewTools.m
//  PBFBaseToolsDemo
//
//  Created by BY-MAC01 on 16/4/14.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import "PBFNotifyAlertViewTools.h"

@interface PBFNotifyAlertViewTools()
@property(nonatomic,strong)AlertBtnClickBlock           alertBlock;
@end

@implementation PBFNotifyAlertViewTools
+ (instancetype)sharedInstance{
    static PBFNotifyAlertViewTools *tools ;
    @synchronized(self){
        if (!tools) {
            tools = [[PBFNotifyAlertViewTools alloc] initPrivate];
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

//////////////////////////提示框
- (void)showSimpleAlertView:(NSString *)title message:(NSString *)message  backBlock:(AlertBtnClickBlock)backBlock cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    UIAlertView *tmpAlertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles,nil];
    
    self.alertBlock = backBlock;
    //tmpAlertView.delegate = self;
    [tmpAlertView show];
}

//定制提示框
- (void)showAlterView:(NSString *)title message:(NSString *)message parentViewCtrl:(UIViewController*)parentViewCtrl textAlign:(NSTextAlignment)textAlign backBlock:(AlertBtnClickBlock)backBlock cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        //ios7以上
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        NSMutableParagraphStyle *paraGraphStyle = [[NSMutableParagraphStyle alloc] init];
        //靠左对齐
        paraGraphStyle.alignment = textAlign;
        //行间距
        paraGraphStyle.lineSpacing = 5.0;
        NSDictionary *attributes = @{NSFontAttributeName :[UIFont systemFontOfSize:13.0],NSParagraphStyleAttributeName:paraGraphStyle};
        NSMutableAttributedString *attributeTitle = [[NSMutableAttributedString alloc] initWithString:message];
        [attributeTitle addAttributes:attributes range:NSMakeRange(0, message.length)];
        [alertController setValue:attributeTitle forKey:@"attributedMessage"];
        
        if (cancelButtonTitle) {
            //默认按钮
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                if (backBlock) {
                    backBlock(0);
                }
            }];
            [alertController addAction:defaultAction];
        }
        //其他按钮
        va_list args;
        va_start(args, otherButtonTitles);
        if (otherButtonTitles) {
            //第一个其他按钮
            UIAlertAction *defaultAction1 = [UIAlertAction actionWithTitle:otherButtonTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                if (backBlock) {
                    backBlock(1);
                }
            }];
            [alertController addAction:defaultAction1];
            //剩下的其他按钮
            __block int iNum = 1;
            NSString*strTitle;
            while ((strTitle = va_arg(args, NSString*))) {
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:strTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    if (backBlock) {
                        backBlock(++iNum);
                    }
                }];
                [alertController addAction:defaultAction];
            }
            va_end(args);
        }
        [parentViewCtrl presentViewController:alertController animated:YES completion:nil];
    }
    else{
        //ios7以下
        UIAlertView *tmpAlertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles,nil];
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
            CGSize size = [message sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(240, 1000) lineBreakMode:NSLineBreakByTruncatingTail];
            
            UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 240, size.height)];
            textLabel.font = [UIFont systemFontOfSize:15.0f];
            textLabel.textColor = [UIColor blackColor];
            textLabel.backgroundColor = [UIColor clearColor];
            textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            textLabel.numberOfLines = 0;
            textLabel.textAlignment = textAlign;
            textLabel.text = message;
            [tmpAlertView setValue:textLabel forKey:@"accessoryView"];
            
            tmpAlertView.message = @"";
        }
        self.alertBlock = backBlock;
        tmpAlertView.delegate = self;
        [tmpAlertView show];
    }
    return ;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0){
    if (self.alertBlock) {
        self.alertBlock(buttonIndex);
    }
}

@end