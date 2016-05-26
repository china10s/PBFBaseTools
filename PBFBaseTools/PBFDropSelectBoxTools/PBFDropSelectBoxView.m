//
//  PBFDropSelectBoxView.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 16/5/24.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import "PBFDropSelectBoxView.h"

//最大行数
const static int kPBFDropSelectBoxViewMaxRowNumber = 100;
//行高度
const static int kPBFDropSelectBoxViewRowHieght    = 44;

@interface PBFDropSelectBoxView()
@property(nonatomic,assign)CGPoint                  startPnt;
@property(nonatomic,assign)float                    width;
@property(nonatomic,assign)CGRect                   rectOld;
@property(nonatomic,strong)UITableView              *tbMainView;
@end

@implementation PBFDropSelectBoxView
- (instancetype)initWithAppearLine:(CGPoint)startPnt width:(float)width{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    self.startPnt = startPnt;
    self.width = width;
    self.isHide = TRUE;
    //增加点击手势
    UITapGestureRecognizer  *gester = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHide:)];
    [gester setNumberOfTapsRequired:1];
    [self addGestureRecognizer:gester];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    return nil;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [self addSubview:self.tbMainView];
}


//展示上拉列表
- (void)showUp:(UIView*)parentView showShadow:(BOOL)showShadow{
    [self showViewInner:TRUE parentView:parentView showShadow:showShadow];
}

//展示下拉列表
- (void)showDown:(UIView*)parentView showShadow:(BOOL)showShadow{
    [self showViewInner:FALSE parentView:parentView showShadow:showShadow];
}

//弹出
- (void)showViewInner:(BOOL)isUpper parentView:(UIView*)parentView showShadow:(BOOL)showShadow{
    if (!self.isHide) {
        return;
    }
    self.isHide = FALSE;
    //加载到背景View上去
    if (parentView) {
        [parentView addSubview:self];
    }
    else{
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    //计算位置
    [self calculateRow];
    CGRect rectMainViewBegin = CGRectMake(self.startPnt.x, self.startPnt.y, self.width, 0);
    CGRect rectMainViewEnd = CGRectMake(self.startPnt.x, self.startPnt.y - kPBFDropSelectBoxViewRowHieght*self.tbMainView.tag, self.width, kPBFDropSelectBoxViewRowHieght*self.tbMainView.tag);
    if(isUpper){//向上弹出
        rectMainViewEnd = CGRectMake(self.startPnt.x, self.startPnt.y - kPBFDropSelectBoxViewRowHieght*self.tbMainView.tag, self.width, kPBFDropSelectBoxViewRowHieght*self.tbMainView.tag);
    }
    else{//向下弹出
        rectMainViewEnd = CGRectMake(self.startPnt.x, self.startPnt.y, self.width, kPBFDropSelectBoxViewRowHieght*self.tbMainView.tag);
        [self.tbMainView reloadData];
    }
    [self.tbMainView reloadData];
    [self.tbMainView setFrame:rectMainViewBegin];
    [UIView animateWithDuration:0.3f animations:^{
        [self.tbMainView setFrame:rectMainViewEnd];
        //是否半透明显示背景
        if(showShadow){
            [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f]];
        }
    }];
    self.rectOld = rectMainViewBegin;
}


//手动关闭
- (void)hide{
    [UIView animateWithDuration:0.6f animations:^{
        [self.tbMainView setFrame:self.rectOld];
        [UIView animateWithDuration:0.3f animations:^{
            [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
            [self removeFromSuperview];
            self.isHide = TRUE;
            if(self.delegateSelf){
                [self.delegateSelf hideFinished];
            }
        }];
    }];
}

//计算表格高度
- (void)calculateRow{
    if (self.datasourceSelf) {
        for (int iIndex = 0; iIndex < kPBFDropSelectBoxViewMaxRowNumber; ++iIndex) {
            if (![self.datasourceSelf getTitleForRow:iIndex]) {
                _tbMainView.tag = iIndex;
                return;
            }
        }
    }
}

- (void)clickHide:(UITapGestureRecognizer*)gester{
    [self hide];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tbMainView.tag;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultCell"];
    //增加行内容
    UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,0, self.width, kPBFDropSelectBoxViewRowHieght)];
    [labTitle setText:[self.datasourceSelf getTitleForRow:[indexPath row]]];
    [labTitle setFont:[UIFont systemFontOfSize:15.0f]];
    [labTitle setTextAlignment:NSTextAlignmentCenter];
    //判断是否当前选中
    if (self.datasourceSelf) {
        int iSelRow = [self.datasourceSelf getSelectedRow];
        if (iSelRow == [indexPath row]) {
            [labTitle setTextColor:[UIColor redColor]];
        }
    }
    [cell.contentView addSubview:labTitle];
    //下划线
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, kPBFDropSelectBoxViewRowHieght-1, [UIScreen mainScreen].bounds.size.width, 1)];
    [viewLine setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [cell.contentView addSubview:viewLine];
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0){
    return TRUE;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0){
    [self.delegateSelf selRow:self iSelRow:[indexPath row]];
    [self hide];
}

#pragma mark - getter and setter
- (UITableView*)tbMainView{
    if (!_tbMainView) {
        _tbMainView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_tbMainView setDelegate:self];
        [_tbMainView setDataSource:self];
        [_tbMainView.layer setBorderWidth:1.0f];
        [_tbMainView.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];
        [self calculateRow];
    }
    return _tbMainView;
}

@end