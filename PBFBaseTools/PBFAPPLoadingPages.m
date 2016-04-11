//
//  PBFAPPLoadingPages.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/9/24.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//

#import "PBFAPPLoadingPages.h"

@interface PBFAPPLoadingPages ()
////顶部按钮背景
//@property (nonatomic,strong)UIScrollView    *ViewBackGround;    //按钮背景滚动页面
@property (nonatomic,strong)NSArray                     *ARRPagePaths;

@property (nonatomic,strong)PBFAPPLoadingPagesComplete  blockComplete;
//页码标识
@property (nonatomic,strong)UIPageControl               *pageCtrl;
@end

@implementation PBFAPPLoadingPages
#pragma mark - life cycle
- (instancetype)initWithPages:(NSArray*)arrPages blockComplete:(PBFAPPLoadingPagesComplete)blockComplete{
    self = [super init];
    self.ARRPagePaths = arrPages;
    self.blockComplete = blockComplete;
    return self;
}

//加载view
- (void)loadView{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //背景
    CGRect rect = [UIScreen mainScreen].bounds;
    UIScrollView    *ViewBackGround = [[UIScrollView alloc] initWithFrame:rect];
    for ( NSString *strPagePath in self.ARRPagePaths) {
        UIImageView *imgTmp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:strPagePath]];
        imgTmp.frame = rect;
        imgTmp.contentMode = UIViewContentModeScaleToFill;
        [ViewBackGround addSubview:imgTmp];
        rect.origin.x += rect.size.width;
    }
    rect = [UIScreen mainScreen].bounds;
    rect.size.width *= [self.ARRPagePaths count];
    ViewBackGround.contentSize = rect.size;
    ViewBackGround.pagingEnabled = TRUE;
    ViewBackGround.showsHorizontalScrollIndicator = FALSE;
    ViewBackGround.bounces = NO;
    ViewBackGround.delegate = self;
    [self.view addSubview:ViewBackGround];
    
    //按钮
    CGRect rectScreen = [UIScreen mainScreen].bounds;
    UIButton *btnDisappear = [[UIButton alloc] initWithFrame:CGRectMake(0,0,171, 40)];
    [btnDisappear.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:20]];
    [btnDisappear.imageView setContentMode:UIViewContentModeScaleAspectFit];
    if (self.imgEnterButtonNormal) {
        [btnDisappear setBackgroundImage:self.imgEnterButtonNormal forState:UIControlStateNormal];
    }
    else{
        [btnDisappear setTitle:@"立即体验" forState:UIControlStateNormal];
        [btnDisappear setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnDisappear setBackgroundColor:[UIColor redColor]];
    }
    if (self.imgEnterButtonSelect) {
        [btnDisappear setBackgroundImage:self.imgEnterButtonSelect forState:UIControlStateSelected];
    }
    
    btnDisappear.layer.cornerRadius = 3.0f;
    btnDisappear.center = CGPointMake(rect.size.width - rectScreen.size.width/2, rectScreen.size.height - 80);
    
    [btnDisappear addTarget:self action:@selector(clickFinish:) forControlEvents:UIControlEventTouchUpInside];
    [ViewBackGround addSubview:btnDisappear];
    
    //页码指示
    [self.view addSubview:self.pageCtrl];
}

- (void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:FALSE];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self isViewLoaded] && ![self.view window]) {
        self.view = nil;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0){
    float fContentWidth = (targetContentOffset->x + 2)/[UIScreen mainScreen].bounds.size.width;
    
    self.pageCtrl.currentPage = fContentWidth;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}


//进入系统
- (void)clickFinish:(UIButton*)sender{
    if (self.blockComplete) {
        self.blockComplete();
    }
}


//页码标识
- (UIPageControl*)pageCtrl{
    if (!_pageCtrl) {
        CGRect rect = [UIScreen mainScreen].bounds;
        _pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 10)];
        _pageCtrl.center = CGPointMake(rect.size.width/2, rect.size.height-30);
        _pageCtrl.numberOfPages = [self.ARRPagePaths count];
        _pageCtrl.currentPage = 0;
        _pageCtrl.pageIndicatorTintColor = [UIColor grayColor];
        _pageCtrl.currentPageIndicatorTintColor = [UIColor redColor];
    }
    return _pageCtrl;
}

@end
