//
//  PBFTabPageFlow.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/4/14.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import "PBFTabPageFlow.h"
#import "PBFColorTools.h"
#import "PBFConvert.h"

#define kPBFTabPageFlowTabHeight       40

@interface PBFTabPageFlow ()
@property (nonatomic,strong)NSArray         *ARRCtrl;           //Tab页
@property (nonatomic,strong)NSMutableArray  *ARRBtn;            //Buttons按钮
@property (nonatomic,strong)UIView          *ViewSelTab;        //选择按钮标示
//顶部按钮背景
@property (nonatomic,strong)UIScrollView    *ViewBackGround;    //按钮背景滚动页面
//顶部按钮宽度
@property (nonatomic,assign)int             INWidth;            //宽度
@property (nonatomic,strong)UIScrollView    *SCRContentView;    //下部VIEW背景
@end

@implementation PBFTabPageFlow
#pragma mark - life cycle
- (instancetype)initWithControl:(NSString*)strName{
    return [self initWithControl:strName arryCtrls:nil];
}

- (void)setControls:(NSArray*)arryCtrls{
    self.ARRCtrl = arryCtrls;
    self.INWidth = [UIScreen mainScreen].bounds.size.width/[self.ARRCtrl count];
}

- (instancetype)initWithControl:(NSString*)strName arryCtrls:(NSArray*)arryCtrls{
    self = [super init];
    self.ARRCtrl = arryCtrls;
    self.tabBarItem.title = strName;
    self.navigationItem.title = strName;
    self.INWidth = [UIScreen mainScreen].bounds.size.width/[self.ARRCtrl count];
    self.colBtnBackground = [PBFColorTools sharedInstance].redColorSystem;
    self.colBtnSelForeColor = [PBFColorTools sharedInstance].redColorSystem;
    self.colBtnUnSelForeColor = [UIColor blackColor];
    self.colFlagBackground = [UIColor whiteColor];
    self.colFlagForeColor = [UIColor whiteColor];
    return self;
}

//加载view
- (void)loadView{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    //按钮总宽度是否超过宽度
    BOOL isPassWidth = FALSE;
    CGRect rect = [UIScreen mainScreen].bounds;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.ViewBackGround];
    [self.ViewBackGround addSubview:self.ViewSelTab];
    [self.view addSubview:self.SCRContentView];
    
    CGFloat fWidthMax = 0;//按钮中最大宽度
    NSMutableArray  *arrBtnWith = [[NSMutableArray alloc] init];//若超过屏幕宽度后，每个按钮应有宽度
    //计算，如果文本长度超过屏幕宽度，适配之
    for( int i = 0 ; i < [_ARRCtrl count] ; ++i ){
        //加上按钮
        UIViewController* ctrlTmp = [_ARRCtrl objectAtIndex:i];
        CGRect rectBtn = [ctrlTmp.title boundingRectWithSize:CGSizeMake(1000, 10) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        CGFloat fWidth = rectBtn.size.width + 10;
        fWidthMax = fWidth < fWidthMax?fWidthMax:fWidth;
        [arrBtnWith addObject:[NSNumber numberWithFloat:fWidth]];
    }
    
    //设置按钮背景
    rect.size.height = kPBFTabPageFlowTabHeight;
    if (fWidthMax*[_ARRCtrl count] > [UIScreen mainScreen].bounds.size.width) {//超过屏幕宽度
        rect.size.width = fWidthMax*[_ARRCtrl count];
        self.ViewBackGround.contentSize = rect.size;
        self.ViewBackGround.contentOffset = CGPointMake(0, 0);
        
        CGRect rectSelTab = self.ViewSelTab.frame;
        rectSelTab.size.width = 10;
        self.ViewSelTab.frame = rectSelTab;
        isPassWidth = TRUE;
    }
    else{
        self.ViewBackGround.contentSize = rect.size;
        self.ViewBackGround.contentOffset = CGPointMake(0, 0);
        isPassWidth = FALSE;
    }
    
    CGRect rectButton = CGRectZero;
    //加上按钮
    for( int i = 0 ; i < [_ARRCtrl count] ; ++i ){
        rectButton.size.height = kPBFTabPageFlowTabHeight;
        if (isPassWidth) {
            rectButton.size.width = [[arrBtnWith objectAtIndex:i] doubleValue];
        }
        else{
            rectButton.size.width = _INWidth;
        }
        UIViewController* ctrlTmp = [_ARRCtrl objectAtIndex:i];
        UIButton *btnTmp = [[UIButton alloc] initWithFrame:rectButton];
        btnTmp.titleLabel.font = [UIFont systemFontOfSize:14];
        [btnTmp setTitle:ctrlTmp.title forState:UIControlStateNormal];
        [btnTmp setTitleColor:self.colBtnSelForeColor forState:UIControlStateSelected];
        [btnTmp setTitleColor:self.colBtnUnSelForeColor forState:UIControlStateNormal];
        btnTmp.tag = i;
        [btnTmp addTarget:self action:@selector(clickTabChange:) forControlEvents:UIControlEventTouchUpInside];
        [self.ARRBtn addObject:btnTmp];
        [self.ViewBackGround addSubview:btnTmp];
        
        rectButton.origin.x += rectButton.size.width;
    }
    
    //反向加上ViewControl
    for( long i = [_ARRCtrl count]-1 ; i >= 0 ; --i ){
        UIViewController* ctrlTmp = [_ARRCtrl objectAtIndex:i];
        //加上页面
        CGRect rect = ctrlTmp.view.frame;
        rect.origin.x += rect.size.width*i;
        ctrlTmp.view.frame = rect;
        [self.SCRContentView addSubview:ctrlTmp.view];
        
        //定义parentViewController;
        [self addChildViewController:ctrlTmp];
    }
    //self.iCurPageIndex = 0;
}


- (void)viewWillAppear:(BOOL)animated{
    //[self scrollToPage:self.iCurPageIndex];
}

- (void)viewDidAppear:(BOOL)animated{
    [self baseScrollToPage:self.iCurPageIndex];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageWidth = scrollView.frame.size.width;
    int ICurPage = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth + 1);
    [self baseScrollToPage:ICurPage];
}


#pragma mark - UITableViewDelegate


#pragma mark - CustomDelegate
- (void)clickTabChange:(UIButton*)btn{
    [self baseScrollToPage:btn.tag];
}

#pragma mark - private methods
//指定滚动到某一页
- (void)baseScrollToPage:(long)pag{
    if ([self.ARRBtn count] <= pag) {
        return;
    }
    if(_ARRCtrl && [_ARRCtrl count] > 0){
        [UIView animateWithDuration:.3f animations:^(void){
            UIButton *btnTab = [self.ARRBtn objectAtIndex:pag];
            CGPoint pntCenter = _ViewSelTab.center;
            pntCenter.x = btnTab.center.x;
            _ViewSelTab.center = pntCenter;
        }];
        //下部content移动
        int IWidth = [UIScreen mainScreen].bounds.size.width;
        [self.SCRContentView setContentOffset:CGPointMake(IWidth*pag, 0) animated:TRUE];
        //手动调用viewWillAppear和didDisappear
        for( int i = 0 ;i < [_ARRCtrl count] ; ++i){
            UIViewController *CTRLTmp = [_ARRCtrl objectAtIndex:i];
            UIButton *btnTab = [self.ARRBtn objectAtIndex:i];
            if (i == pag) {
                [CTRLTmp viewWillAppear:NO];
                //按钮颜色
                [btnTab setSelected:TRUE];
            }
            else{
                [CTRLTmp viewWillDisappear:NO];
                [CTRLTmp viewDidDisappear:NO];
                //按钮颜色
                [btnTab setSelected:FALSE];
            }
        }
        self.iCurPageIndex = pag;
    }
}


#pragma mark - getters and setters
//按钮背景
- (UIScrollView*)ViewBackGround{
    if (!_ViewBackGround) {
        CGRect rect = [UIScreen mainScreen].bounds;
        rect.size.height = kPBFTabPageFlowTabHeight;
        _ViewBackGround = [[UIScrollView alloc] initWithFrame:rect];
        //[_ViewBackGround setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_ViewBackGround setBackgroundColor:self.colBtnBackground];
        _ViewBackGround.showsHorizontalScrollIndicator = FALSE;
    }
    return _ViewBackGround;
}


//选择按钮
- (UIView*)ViewSelTab{
    if (!_ViewSelTab) {
        _ViewSelTab = [[UIView alloc] initWithFrame:CGRectMake(10, kPBFTabPageFlowTabHeight-2, _INWidth - 20, 2)];
        [_ViewSelTab setTranslatesAutoresizingMaskIntoConstraints:NO];
        _ViewSelTab.backgroundColor = self.colFlagBackground;
    }
    return _ViewSelTab;
}


//滚动背景
- (UIScrollView*)SCRContentView{
    if (!_SCRContentView) {
        //n倍宽度
        CGRect rect = [UIScreen mainScreen].bounds;
        rect = [UIScreen mainScreen].bounds;
        rect.size.height -= kPBFTabPageFlowTabHeight;
        rect.origin.y = kPBFTabPageFlowTabHeight;
        _SCRContentView = [[UIScrollView alloc] initWithFrame:rect];
        //首先滑动到首页
        _SCRContentView.contentOffset = CGPointMake(0, 0);
        //_SCRContentView.backgroundColor = [UIColor blueColor];
        _SCRContentView.pagingEnabled = YES;
        //contentView
        rect.size.width = rect.size.width*[_ARRCtrl count];
        _SCRContentView.contentSize = rect.size;
        _SCRContentView.delegate = self;
        _SCRContentView.bounces = NO;
    }
    return _SCRContentView;
}

//按钮列表
- (NSMutableArray*)ARRBtn{
    if (!_ARRBtn) {
        _ARRBtn = [[NSMutableArray alloc] init];
    }
    return _ARRBtn;
}

@end