//
//  MyHomeViewController.m
//  JasonBlog
//
//  Created by jason on 15-5-4.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import "MyHomeViewController.h"
#import <MJRefresh.h>
#import "MyHomeCell.h"
#import "ToolHomeViewController.h"

#define NUMBER_TABLEVIEW 10
typedef void(^blockAAAA)();

@interface MyHomeViewController ()
{
        IBOutlet UITableView *mainTableView;
        UIButton *btn_nav_back;
}
@property (nonatomic, strong) UIView *bckView;
@property (nonatomic, assign) CGFloat alpha;
@end

@implementation MyHomeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        [self testBolck:^int(id test) {
            return (int)test;
        }];
    
//    self.navigationItem.title = @"我的";

    
//    __weak typeof(self) weakSelf = self;
//    
//    // 添加传统的下拉刷新
//    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
//    [tableView addLegendHeaderWithRefreshingBlock:^{
//        [weakSelf loadNewData];
//        NSLog(@"loading");
//        //开始加载
//    }];
//    
//    // 马上进入刷新状态
//    [tableView.legendHeader beginRefreshing];
    
    btn_nav_back = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_nav_back.frame = CGRectMake(0.0f, 0.0f, 54.0f, 44.0f);
    btn_nav_back.tag = 999;
    [btn_nav_back setTitle:@"设置" forState:UIControlStateNormal];
    [btn_nav_back setTitle:@"设置" forState:UIControlStateHighlighted];
    [btn_nav_back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_nav_back setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [btn_nav_back addTarget:self action:@selector(navBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * btn_Left = [[UIBarButtonItem alloc] initWithCustomView:btn_nav_back];
    self.navigationItem.leftBarButtonItem = btn_Left;

    mainTableView.rowHeight = 100.0f;
    mainTableView.separatorColor = J_COLOR_CLEAR;
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.alpha = 0.0; // 初始化透明度
    UIView *backgroundView = [[self.navigationController valueForKey:@"_navigationBar"] valueForKey:@"_backgroundView"]; //获取bar背景view
    backgroundView.backgroundColor = [UIColor blueColor]; // 颜色
    backgroundView.alpha = self.alpha; //渐变
    self.bckView = backgroundView;
}
    
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    self.bckView.alpha = self.alpha;
}
    
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.bckView.alpha = 1.0;
}
    
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y + 32;
    CGFloat alpha = 0;
    NSLog(@"offset = %.0f",offset);
    if (offset < 0) {
        self.alpha = alpha = 0;
    }else {
        self.alpha = alpha = 1 - ((115 - 100 - offset) / (115 - 100));
    }
    NSLog(@"alpha = %.2f",self.alpha);
    self.bckView.alpha = alpha;
}
    

- (void)loadNewData
{
//    __weak typeof(self) weakSelf = self;
//    添加传统的上拉刷新
//    设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
//    [tableView addLegendFooterWithRefreshingBlock:^{
//        NSLog(@"more");
//    }];
}
    
- (void)navBackClick
{
//    ToolHomeViewController *toolHome = [[ToolHomeViewController alloc] init];
//    toolHome.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:toolHome animated:YES];
    
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.keyPath = @"transform.rotation.z";
//    animation.duration = 3.f;
//    animation.fromValue = @(0);
//    animation.toValue = @(2*M_PI);
//    animation.repeatCount = INFINITY;
//    animation.removedOnCompletion = NO;
//    [btn_nav_back.layer addAnimation:animation forKey:nil];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
//    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(50, 0)];
//    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(150, 0)];
//    [view.layer addAnimation:animation forKey:nil];
    
    
    CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];
    animation.autoreverses = YES;    //回退动画（动画可逆，即循环）
    animation.duration = 1.0f;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;//removedOnCompletion,fillMode配合使用保持动画完成效果
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [view.layer addAnimation:animation forKey:@"aAlpha"];
    
    [self testBolck:^int(id test) {
        NSLog(@"%@",test);
        return 30;
    }];
    
    [UIView commitAnimations];
    
    
    
}

- (void)testBolck:(int(^)(id test))blockTest
{
    NSLog(@"%d",blockTest(@"aa"));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableviewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return NUMBER_TABLEVIEW;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *homeString = @"homeString";
    MyHomeCell*cell = [tableView dequeueReusableCellWithIdentifier:homeString];
    if(!cell)
    {
        cell = [[MyHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeString];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
   
    return cell;
}
    
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 50.0f;
//}
//
//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view_Header = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, 50.0f)];
//    view_Header.backgroundColor = [UIColor redColor];
//    view_Header.alpha = 0.1;
//    return view_Header;
//}
@end
