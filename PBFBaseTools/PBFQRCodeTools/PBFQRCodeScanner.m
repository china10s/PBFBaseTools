//
//  PBFQRCodeScanner.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/4/14.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import "PBFQRCodeScanner.h"
#import <AVFoundation/AVFoundation.h>
#import "PBFNotifyAlertViewTools.h"

@interface PBFQRCodeScanner ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic,strong)NSString                        *strUrlPath;
@property (nonatomic,strong)UIView                          *boxView;
@property (nonatomic,strong)CALayer                         *scanLayer;
@property (nonatomic,strong)UILabel                         *labScan;//扫一扫

////返回按钮
//@property (nonatomic,strong)UIButton                        *btnBack;

//捕捉会话
@property (nonatomic,strong)AVCaptureSession                *captureSession;
//展示Layer
@property (nonatomic,strong)AVCaptureVideoPreviewLayer      *videoPreviewLayer;

@end

@implementation PBFQRCodeScanner
//加载view
- (void)loadView{
    self.title = @"扫一扫";
    [super loadView];
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    _captureSession = nil;
    [self setHidesBottomBarWhenPushed:TRUE];
}

- (void)viewWillAppear:(BOOL)animated{
    //[self setHidesBottomBarWhenPushed:TRUE];
    [self.navigationController setNavigationBarHidden:FALSE];
    [self initSystem];
    self.strUrlPath = @"";
    [self handlerCamerReject];
}

- (void)handlerCamerReject{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        [[PBFNotifyAlertViewTools sharedInstance] showSimpleAlertView:@"提示" message:@"请打开相机权限" backBlock:^(long btnIndex) {
            [self.navigationController popViewControllerAnimated:TRUE];
        } cancelButtonTitle:@"确定" otherButtonTitles:nil];
        return;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:TRUE];
    self.strUrlPath = @"";
}

- (void)viewDidAppear:(BOOL)animated{
    //返回按钮
    //    [self.view addSubview:self.btnBack];
}

- (void)initSystem{
    CGRect rect = [UIScreen mainScreen].bounds;
    NSError *error ;
    //1、初始化捕捉设备
    AVCaptureDevice     *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //2、用captureDevice创建输入流
    AVCaptureDeviceInput    *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@",[error localizedDescription]);
        return ;
    }
    //3、创建没提数据输出流
    AVCaptureMetadataOutput *captureMetaDataOutput = [[AVCaptureMetadataOutput alloc] init];
    //4、实例化捕捉对象
    _captureSession = [[AVCaptureSession alloc] init];
    //4.1、将输入流添加到会话
    [_captureSession addInput:input];
    //4.2、将媒体输出流添加到会话中
    [_captureSession addOutput:captureMetaDataOutput];
    //5、创建串行队列，并将媒体输出流添加到队列
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    //5.1设置代理
    [captureMetaDataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    //5.2设置输出没提数据类型为QRCode
    [captureMetaDataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    //6、实例化预览图层
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    //7、设置预览图层填充方式
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    //8、设置图层frame
    [_videoPreviewLayer setFrame:[UIScreen mainScreen].bounds];
    //9、将图层添加到预览的view的图层上
    [self.view.layer addSublayer:_videoPreviewLayer];
    //10、设置扫描范围
    captureMetaDataOutput.rectOfInterest = CGRectMake(0.2f, 0.2f, 0.8f, 0.8f);
    //10.1扫描框
    _boxView = [[UIView alloc] initWithFrame:CGRectMake(rect.size.width*0.2f, (rect.size.height-rect.size.width*0.6f)/2, rect.size.width*0.6f, rect.size.width*0.6f)];
    [self.view addSubview:_boxView];
    //设置背景
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:_boxView.frame];
    imgView.image = [UIImage imageNamed:@"ic_menu_scan_bg.png"];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imgView];
    //10.2扫描线
    _scanLayer = [[CALayer alloc] init];
    _scanLayer.frame = CGRectMake(0, 0, rect.size.width*0.6f, 1);
    _scanLayer.backgroundColor = [UIColor brownColor].CGColor;
    [_boxView.layer addSublayer:_scanLayer];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES];
    [timer fire];
    
    //10.3扫一扫
    self.labScan = [[UILabel alloc] initWithFrame:CGRectMake(0, (rect.size.height/2+rect.size.width*0.3f) + 20, rect.size.width, 20)];
    [self.labScan setText:@"扫一扫 有惊喜"];
    [self.labScan setTextColor:[UIColor whiteColor]];
    [self.labScan setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.labScan];
    
    //11、开始扫描
    [_captureSession startRunning];
}

//扫描函数
- (void)moveScanLayer:(NSTimer *)timer
{
    CGRect frame = _scanLayer.frame;
    if (_boxView.frame.size.height < _scanLayer.frame.origin.y) {
        frame.origin.y = 0;
        _scanLayer.frame = frame;
    }else{
        frame.origin.y += 5;
        [UIView animateWithDuration:0.1 animations:^{
            _scanLayer.frame = frame;
        }];
    }
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //判断是否有数据
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        //判断回传的数据类型
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            NSString *stringValue = [metadataObj stringValue];
            [self performSelectorOnMainThread:@selector(stopReading:) withObject:stringValue waitUntilDone:NO];
            //[self performSelector:@selector(stopReading:) withObject:stringValue];
            //[self stopReading:stringValue];
        }
    }
}

- (void)stopReading:(NSString *)stringValue{
    if (self.strUrlPath && [self.strUrlPath length] > 0) {
        self.strUrlPath = @"";
        return;
    }
    self.strUrlPath = stringValue;
    [_captureSession stopRunning];
    _captureSession = nil;
    [_scanLayer removeFromSuperlayer];
    [_videoPreviewLayer removeFromSuperlayer];
    [self.navigationController popViewControllerAnimated:TRUE];
    if(self.delegateSelf){
        [self playSound];
        [self.delegateSelf finishScan:stringValue];
    }
    
}

//播放一段声音
- (void)playSound{
    SystemSoundID sound ;
    NSString *path = @"/System/Library/Audio/UISounds/sms-received1.caf";
    OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&sound);
    if(error == kAudioServicesNoError ){
        AudioServicesPlaySystemSound(sound);
    }
}

@end