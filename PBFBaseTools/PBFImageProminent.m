//
//  PBFImageProminent.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/9/29.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//

#import "PBFImageProminent.h"

@interface PBFImageProminent()

@property (nonatomic,assign)CGRect oldFrame ;

@end

@implementation PBFImageProminent

//单例
+ (instancetype)sharedInstance{
    static PBFImageProminent *imgCtrl = nil;
    @synchronized(self) {
        if (!imgCtrl) {
            imgCtrl = [[PBFImageProminent alloc] init];
        }
    }
    return imgCtrl;
}

//凸显图片
- (void)showImageView:(UIImageView*)avatarImageView{
    self.oldFrame = avatarImageView.frame;
    CGRect rect = [UIScreen mainScreen].bounds;
    UIImage *image = avatarImageView.image;
    UIImageView *imgViewNew = [[UIImageView alloc] initWithImage:image];
    imgViewNew.frame = avatarImageView.frame;
    imgViewNew.tag = 1;
    UIView *viewBackground = [[UIView alloc] initWithFrame:rect];
    viewBackground.backgroundColor = [UIColor blackColor];
    viewBackground.alpha = 0;
    UIWindow *window =[UIApplication sharedApplication].keyWindow;
    [window addSubview:viewBackground];
    [viewBackground addSubview:imgViewNew];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(heightImage:)];
    [viewBackground addGestureRecognizer:tap];
    viewBackground.userInteractionEnabled = TRUE;
    
    [UIView animateWithDuration:0.5f animations:^(void){
        imgViewNew.frame = CGRectMake(0, 0, 200, 200);
        imgViewNew.center = CGPointMake(rect.size.width/2, rect.size.height/2);
        viewBackground.alpha = 1;
    }];
}

- (void)heightImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView = tap.view;
    UIImageView *imageView = (UIImageView*)[tap.view viewWithTag:1];
    
    [UIView animateWithDuration:0.5f animations:^(void){
        imageView.frame = self.oldFrame;
        backgroundView.alpha = 0;
    } completion:^(BOOL finished){
        [backgroundView removeFromSuperview];
    }];
}

@end