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

#define NUMBER_TABLEVIEW 3
typedef void(^blockAAAA)();

@interface MyHomeViewController ()
{
        IBOutlet UITableView *mainTableView;
}
@end

@implementation MyHomeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        [self testBolck:^int(id test) {
            return (int)test;
        }];
    
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

    mainTableView.rowHeight = 100.0f;
}
- (void)loadNewData
{
//    __weak typeof(self) weakSelf = self;
    
    // 添加传统的上拉刷新
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
//    [tableView addLegendFooterWithRefreshingBlock:^{
//        NSLog(@"more");
//    }];

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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view_Header = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, 50.0f)];
    view_Header.backgroundColor = [UIColor redColor];
    view_Header.alpha = 0.1;
    return view_Header;
}
@end
