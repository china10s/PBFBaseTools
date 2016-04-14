//
//  PBFBrowserViewCtrl.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/6/24.
//  Copyright (c) 2015年 BY-MAC01. All rights reserved.
//

#import "PBFBrowserViewCtrl.h"
#import "PBFViewTools.h"
#import "PBFNSStringTools.h"

@interface PBFBrowserViewCtrl ()
@property (nonatomic,strong)UIWebView                   *viewWeb;//网页控件
@property (nonatomic,strong)NSString                    *strPath;
@property (nonatomic,strong)NSMutableArray              *arrDelegate;//跳转控制
@end

@implementation PBFBrowserViewCtrl
#pragma mark - life cycle
- (instancetype)initWithTitle:(NSString*)strPath strTitle:(NSString*)strTitle{
    self = [super init];
    
    self.title = strTitle;
    self.strPath = strPath;
    
    [self setHidesBottomBarWhenPushed:TRUE];
    
    //返回按钮
    UIBarButtonItem *itemBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_forward_left.png"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
    [itemBack setImageInsets:UIEdgeInsetsMake(10, 0, 10,9)];
    self.navigationItem.leftBarButtonItem = itemBack;
    
    return self;
}

- (void)loadView{
    [super loadView];
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.viewWeb];
    [self.arrDelegate addObject:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //_viewWeb
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_viewWeb]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self,_viewWeb)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_viewWeb]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self,_viewWeb)]];

    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    NSURL *url = [NSURL URLWithString:self.strPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.viewWeb loadRequest:request];
}

- (void)viewDidDisappear:(BOOL)animated{
    [self.viewWeb loadHTMLString:@" " baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    float ver = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if(ver >= 6.0f)
    {
        if(self.isViewLoaded && !self.view.window)
        {
            self.view = nil; //确保下次重新加载
        }
    }
}

//增加Delegate
- (void)addDelegate:(id<PBFBrowserViewCtrlDelegate>)delegate{
    if(delegate){
        [self.arrDelegate addObject:delegate];
    }
}

#pragma mark - public event
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if (webView != self.viewWeb) {
        return YES;
    }
    
    NSURL *url = [request URL];
    NSString *strUrl = [url absoluteString];
    if ([strUrl isEqualToString:@"about:blank"])
    {
        return NO;
    }
    BOOL isDo = YES;
    for (id<PBFBrowserViewCtrlDelegate> delegate in self.arrDelegate) {
        if (![delegate jsFunctionDo:strUrl]) {
            isDo = NO;
        }
    }
    
    //    NSRange range = [strUrl rangeOfString:@"jsShowMyAwards"];
    //    if (range.location != NSNotFound) {
    //        [self.navigationController popViewControllerAnimated:TRUE];
    //    }
    
    return isDo;
}

#pragma mark - private event
//通用返回按钮
- (void)goBack:(id)sender{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [[self navigationController] popViewControllerAnimated:NO];
}


#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [[PBFViewTools sharedInstance] showLoadingView:self.view showShadow:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [[PBFViewTools sharedInstance] stopLoadingView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [[PBFViewTools sharedInstance] stopLoadingView];
}

#pragma mark - getters and setters
- (UIWebView*)viewWeb{
    if (!_viewWeb) {
        _viewWeb = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_viewWeb setTranslatesAutoresizingMaskIntoConstraints:NO];
        _viewWeb.scalesPageToFit = TRUE;
        //隐藏掉左右滚动条
        UIScrollView *tempView=(UIScrollView *)[_viewWeb.subviews objectAtIndex:0];
        tempView.showsHorizontalScrollIndicator = FALSE;
    }
    return _viewWeb;
}

//跳转控制
- (NSMutableArray*)arrDelegate{
    if (!_arrDelegate) {
        _arrDelegate = [[NSMutableArray alloc] init];
    }
    return _arrDelegate;
}


@end