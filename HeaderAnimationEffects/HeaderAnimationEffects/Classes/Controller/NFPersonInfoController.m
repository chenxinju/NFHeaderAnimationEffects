//
//  NFPersonInfoController.m
//  HeaderAnimationEffects
//
//  Created by chenxinju on 16/6/22.
//  Copyright © 2016年 Innovation. All rights reserved.
//

#import "NFPersonInfoController.h"
#import "UINavigationBar+Extion.h"
#import "UIView+Extion.h"
#import "UIAlertView+show.h"

#define Max_OffsetY  50

#define WeakSelf(x)      __weak typeof (self) x = self

#define HalfF(x) ((x)/2.0f)


#define  Statur_HEIGHT   [[UIApplication sharedApplication] statusBarFrame].size.height
#define  NAVIBAR_HEIGHT  (self.navigationController.navigationBar.frame.size.height)
#define  INVALID_VIEW_HEIGHT (Statur_HEIGHT + NAVIBAR_HEIGHT)

static NSString * cellreuseIdentifier = @"NFPersonInfoController";
@interface NFPersonInfoController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NFBottomBar * bottomBar;
@property (nonatomic,strong)UIImageView * avatarView;
@property (nonatomic,strong)UILabel * messageLabel;
@property (nonatomic,strong)UIView * headBackView;
@property (nonatomic,strong)UIImageView * headImageView;
@property (nonatomic,strong)UITableView * displayTableView;
@property (nonatomic, assign,readonly) CGFloat lastPosition;

@end

@implementation NFPersonInfoController



- (NFBottomBar *)bottomBar
{
    if (!_bottomBar) {
        
        WeakSelf(ws);
        _bottomBar = [[NFBottomBar alloc] initWithFrame:CGRectMake(0, kScreenHeight - HalfF(128),kScreenWidth , HalfF(128))];
        _bottomBar.block = ^(BottomBarType type)
        {
            [ws clickBottomBarEvent:type];
        };
    }
    return _bottomBar;
}

- (void)clickBottomBarEvent:(BottomBarType)type
{
    if (type == BottomBarType_Original)
    {
        [UIView animateWithDuration:0.2 animations:^{
            [self.navigationController.navigationBar ps_setTransformIdentity];
        }];
        
    }
    else if (type == BottomBarType_Up)
    {
        [UIView animateWithDuration:0.2 animations:^{
            [self.navigationController.navigationBar ps_setTranslationY:- INVALID_VIEW_HEIGHT];
        }];
    }
}
#pragma mark --
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self scrollViewDidScroll:self.displayTableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar ps_reset];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self resetHeaderView];
    
    self.displayTableView.tableHeaderView = self.headBackView;
    [self.view addSubview:self.displayTableView];
    
    [self.view addSubview:self.bottomBar];
    
    _displayTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.bottomBar.height)];
    
    
    //导航
    [self.navigationController.navigationBar ps_setBackgroundColor:[UIColor clearColor]];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"left" style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:(UIBarButtonItemStylePlain) target:self action:@selector(right)];
    
    
}

#pragma mark -  左 / 右按钮点击方法 
- (void)back {
    [UIAlertView showAlertWithTitle:@"要返回?"];
    
}
- (void)right {
    [UIAlertView showAlertWithTitle:@"要跳转?"];
   
}


- (void)resetHeaderView
{
    self.headImageView.frame = self.headBackView.bounds;
    [self.headBackView addSubview:self.headImageView];
    
    self.avatarView.centerX = self.headBackView.centerX;
    self.avatarView.centerY = self.headBackView.centerY -  HalfF(70);
    [self.headBackView addSubview:self.avatarView];
    
    self.messageLabel.text = @"iOS学习 : 18318318388";
    self.messageLabel.y = CGRectGetMaxY(self.avatarView.frame) + HalfF(20);
    self.messageLabel.size = CGSizeMake(kScreenWidth - HalfF(30), 30);
    self.messageLabel.centerX = self.headBackView.centerX;
    [self.headBackView addSubview:self.messageLabel];
    
}
#pragma mark -  UITableViewDataSource-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HalfF(100);
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell * tableViewCell = [tableView dequeueReusableCellWithIdentifier:cellreuseIdentifier];
    if (!tableViewCell) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellreuseIdentifier];
    }
    tableViewCell.textLabel.text = @"图片下拉放大，导航上拉渐变";
    return tableViewCell;
}


#pragma mark -  UITableViewDelegate
//开始拖拽
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
//停止
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offset_Y = scrollView.contentOffset.y;
    
    //NSLog(@"上下偏移量 OffsetY:%f ->",offset_Y);
    
    //1.处理图片放大
    CGFloat imageH = self.headBackView.size.height;
    CGFloat imageW = kScreenWidth;
    
    //下拉
    if (offset_Y < 0)
    {
        CGFloat totalOffset = imageH + ABS(offset_Y);
        CGFloat f = totalOffset / imageH;
        
        //如果想下拉固定头部视图不动，y和h 是要等比都设置。如不需要则y可为0
        self.headImageView.frame = CGRectMake(-(imageW * f - imageW) * 0.5, offset_Y, imageW * f, totalOffset);
    }
    else
    {
        self.headImageView.frame = self.headBackView.bounds;
    }
    
    //2.处理导航颜色渐变  3.底部工具栏动画
    
    if (offset_Y > Max_OffsetY)
    {
        CGFloat alpha = MIN(1, 1 - ((Max_OffsetY + INVALID_VIEW_HEIGHT - offset_Y) / INVALID_VIEW_HEIGHT));
        
        [self.navigationController.navigationBar ps_setBackgroundColor:[NavigationBarBGColor colorWithAlphaComponent:alpha]];
        
        if (offset_Y - _lastPosition > 5)
        {
            //向上滚动
            _lastPosition = offset_Y;
            
            [self bottomForwardDownAnimation];
        }
        else if (_lastPosition - offset_Y > 5)
        {
            // 向下滚动
            _lastPosition = offset_Y;
            [self bottomForwardUpAnimation];
        }
        self.title = alpha > 0.8 ? @"导航栏":@"";
    }
    else
    {
        [self.navigationController.navigationBar ps_setBackgroundColor:[NavigationBarBGColor colorWithAlphaComponent:0]];
        
        [self bottomForwardUpAnimation];
    }
    
    //滚动至顶部
    
    if (offset_Y < 0) {
        [self bottomForwardUpAnimation];
        
    }
    
    //滚动至底部
    CGSize size = _displayTableView.contentSize;
    
    float y = offset_Y + _displayTableView.height;
    float h = size.height;
    float reload_distance = 10;
    
    if (y > h - _bottomBar.height + reload_distance)
    {
        [self bottomForwardUpAnimation];
    }
}

- (void)bottomForwardDownAnimation
{
    WeakSelf(ws);
    [UIView animateWithDuration:0.2 animations: ^{
        ws.bottomBar.transform = CGAffineTransformMakeTranslation(0, ws.bottomBar.height);
    } completion: ^(BOOL finished) {
    }];
}

- (void)bottomForwardUpAnimation
{
    WeakSelf(ws);
    [UIView animateWithDuration:0.2 animations: ^{
        ws.bottomBar.transform = CGAffineTransformIdentity;
    } completion: ^(BOOL finished) {
    }];
}


#pragma mark - 懒加载
- (UITableView*)displayTableView
{
    if (_displayTableView == nil) {
        _displayTableView  = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _displayTableView.delegate = self;
        _displayTableView.dataSource = self;
        _displayTableView.showsVerticalScrollIndicator = NO;
    }
    return _displayTableView;
}

- (UIView*)headBackView
{
    if (_headBackView == nil) {
        _headBackView = [UIView new];
        _headBackView.userInteractionEnabled = YES;
        _headBackView.frame = CGRectMake(0, 0, kScreenWidth,200);
    }
    return _headBackView;
}

- (UIImageView*)headImageView
{
    if (_headImageView == nil)
    {
        _headImageView = [UIImageView new];
        _headImageView.image = [UIImage imageNamed:@"bg-1"];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.clipsToBounds = YES;
        _headImageView.backgroundColor = [UIColor orangeColor];
    }
    return _headImageView;
}

- (UIImageView*)avatarView
{
    if (_avatarView == nil) {
        _avatarView = [UIImageView new];
        _avatarView.image = [UIImage imageNamed:@"icon"];
        _avatarView.contentMode = UIViewContentModeScaleToFill;
        _avatarView.size = CGSizeMake(80, 80);
        [_avatarView setLayerWithCr:_avatarView.width / 2];
    }
    return _avatarView;
}

- (UILabel*)messageLabel
{
    if (_messageLabel == nil) {
        _messageLabel = [UILabel new];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:16];
        _messageLabel.textColor = [UIColor whiteColor];
    }
    return _messageLabel;
}


- (void)dealloc
{
    _headBackView = nil;
    _headImageView = nil;
    _displayTableView = nil;
    _bottomBar = nil;
}

@end
