//
//  PBFImageObtainTools.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/11/19.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//

#import "PBFImageObtainTools.h"
#import <AVFoundation/AVFoundation.h>
#import "PBFViewTools.h"

@implementation PBFImageObtainTools
//单例
+ (instancetype)sharedInstance{
    static PBFImageObtainTools *imgTools = nil;
    @synchronized(self) {
        if (!imgTools) {
            imgTools = [[PBFImageObtainTools alloc] init];
        }
    }
    return imgTools;
}

//显示
- (void)show{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        return [[PBFViewTools sharedInstance] showSimpleAlertView:@"提醒" message:@"您的相机设置功能好像有问题哦~\r\n去“设置>隐私>相机”开一下吧" backBlock:^(long btnIndex) {} cancelButtonTitle:@"确定" otherButtonTitles:nil];
    }
    UIApplication *application = [UIApplication sharedApplication];
    UIActionSheet *sheetCell = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"本地图片", nil];
    [sheetCell showInView:application.keyWindow];
}

#pragma mark - UIActionSheetDelegate
// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 8_3) __TVOS_PROHIBITED{
    if(!self.delegateSelf){
        return;
    }
    UIViewController *viewCtrl = [self.delegateSelf parentViewCtrl];
    if(buttonIndex == 0){//相机
        UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
        imgPicker.delegate = self;
        imgPicker.allowsEditing = YES;
        imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [viewCtrl presentViewController:imgPicker animated:TRUE completion:nil];
    }
    else if(buttonIndex == 1){//本地图片
        UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
        imgPicker.delegate = self;
        imgPicker.allowsEditing = YES;
        imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [viewCtrl presentViewController:imgPicker animated:TRUE completion:nil];
    }
}

#pragma UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if(!self.delegateSelf){
        return ;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *imgData = [info objectForKey:UIImagePickerControllerEditedImage];
    if(self.delegateSelf){
        [self.delegateSelf PBFImageObtainTools:self imgItem:imgData];
    }
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end