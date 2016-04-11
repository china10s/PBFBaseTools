//
//  PBFViewTools.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/5/5.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import "PBFViewTools.h"
#import "MBProgressHUD.h"

#define PBFVIEWTOOLS_LOADINGWIDTH 50

@interface PBFViewTools()

@end

@implementation PBFViewTools
+ (instancetype)sharedInstance{
    static PBFViewTools *tools ;
    @synchronized(self){
        if (!tools) {
            tools = [[PBFViewTools alloc] initPrivate];
        }
    }
    
    return tools;
}

- (instancetype)init{
    return nil;
}

- (instancetype)initPrivate{
    self = [super init];
    ////////////////////////////////////菊花等待框
    /*
    self.activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, PBFVIEWTOOLS_LOADINGWIDTH, PBFVIEWTOOLS_LOADINGWIDTH )];//指定进度轮的大小
    [self.activityView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];//设置进度轮显示类型
    [self.activityView setColor:[UIColor whiteColor]];
    
    self.alphaView = [[UIView alloc] init];
    self.alphaView.backgroundColor = [UIColor blackColor];
    self.alphaView.alpha = 0.5f;
     */
    
    return self;
}




//////////////////////////菊花等待框
//显示菊花等待框子
- (void)showLoadingView:(UIView *)parentView showShadow:(BOOL)showShadow{
    [self showLoadingView:parentView strMess:@"请等待" showShadow:showShadow];
}

//显示菊花等待框子
- (void)showLoadingView:(UIView *)parentView strMess:(NSString*)strMess showShadow:(BOOL)showShadow{
    if (self.HUDPross) {
        return;
    }
    self.HUDPross = [[MBProgressHUD alloc] initWithView:parentView];
    [parentView addSubview:self.HUDPross];
    self.HUDPross.labelText = strMess;
    self.HUDPross.yOffset -= 40;
    if (showShadow) {
        self.HUDPross.dimBackground = YES;
    }
    
    [self.HUDPross showAnimated:YES whileExecutingBlock:^{
        //默认30s后必须消失，否则可能出现假死
        sleep(10);
    } completionBlock:^{
        [self.HUDPross removeFromSuperview];
        self.HUDPross = nil;
    }];
}

//停止菊花等待框,完成任务
- (void)stopLoadingViewComplete{
    UIView  *parentView = [self.HUDPross superview];
    //菊花停止
    if(self.HUDPross){
        [self.HUDPross removeFromSuperview];
        self.HUDPross = nil;
    }
    if(parentView){
        //操作完成
        self.HUDComplete = [[MBProgressHUD alloc] initWithView:parentView];
        [parentView addSubview:self.HUDComplete];
        self.HUDComplete.labelText = @"操作成功";
        self.HUDComplete.yOffset -= 60;
        self.HUDComplete.mode = MBProgressHUDModeCustomView;
        self.HUDComplete.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        [self.HUDComplete showAnimated:YES whileExecutingBlock:^{
            sleep(1.5);
        } completionBlock:^{
            [self.HUDComplete removeFromSuperview];
            self.HUDComplete = nil;
        }];
    }
}
//停止菊花等待框
- (void)stopLoadingView{
    //菊花停止
    if(self.HUDPross){
        [self.HUDPross removeFromSuperview];
        self.HUDPross = nil;
    }
}

//停止菊花等待框
- (void)stopLoadingView:(NSString*)strMess{
    UIView  *parentView = [self.HUDPross superview];
    //菊花停止
    if(self.HUDPross){
        [self.HUDPross removeFromSuperview];
        self.HUDPross = nil;
    }
    if(parentView && ([strMess length] > 0)){
        //操作完成
        [self showToastMsg:parentView strMess:strMess];
    }
}




///////////////////////////////////////////////toats提示框
- (void)showToastMsg:(UIView*)viewParent strMess:(NSString*)strMess{
    [self showToastMsg:viewParent strMess:strMess iTime:1.8f blockComplete:nil];
}

- (void)showToastMsg:(UIView*)viewParent strMess:(NSString*)strMess blockComplete:(ToastComplete)blockComplete{
    [self showToastMsg:viewParent strMess:strMess iTime:1.8f blockComplete:blockComplete];
}

- (void)showToastMsg:(UIView*)viewParent strMess:(NSString*)strMess iTime:(unsigned int)iTime {
    [self showToastMsg:viewParent strMess:strMess iTime:iTime blockComplete:nil];
}

- (void)showToastMsg:(UIView*)viewParent strMess:(NSString*)strMess iTime:(unsigned int)iTime blockComplete:(ToastComplete)blockComplete{
    self.HUDAlertInfo = [[MBProgressHUD alloc] initWithView:viewParent];
    [viewParent addSubview:self.HUDAlertInfo];
    self.HUDAlertInfo.labelText = @"";
    self.HUDAlertInfo.detailsLabelText = strMess;
    self.HUDAlertInfo.mode = MBProgressHUDModeText;
    self.HUDAlertInfo.yOffset -= 40;
    [self.HUDAlertInfo showAnimated:YES whileExecutingBlock:^{
        sleep(iTime);
    } completionBlock:^{
        if(blockComplete){
            blockComplete();
        }
    }];
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
//            __block int iNum = 0;
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
//        if (otherButtonTitles) {
//            //其他按钮
//            UIAlertAction *defaultAction1 = [UIAlertAction actionWithTitle:otherButtonTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//                if (backBlock) {
//                    backBlock(1);
//                }
//            }];
//            [alertController addAction:defaultAction1];
//        }
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

//清除所有子View
- (void)removeAllSubviews:(UIView*)parentView{
    if(![parentView subviews] || [[parentView subviews] count] <= 0){
        return [parentView removeFromSuperview];
    }
    for(UIView *viewSub in parentView.subviews){
        [self removeAllSubviews:viewSub];
    }
}




@end
