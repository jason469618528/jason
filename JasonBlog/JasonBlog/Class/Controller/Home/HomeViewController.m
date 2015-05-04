//
//  HomeViewController.m
//  JasonBlog
//
//  Created by jason on 15-5-4.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import "HomeViewController.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationBar.translucent = YES;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
//    UIButton *btn_nav_back = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn_nav_back.frame = CGRectMake(0.0f, 0.0f, 100.0f, 100.0f);
//    [btn_nav_back setBackgroundColor:[UIColor redColor]];
//    [self.view addSubview:btn_nav_back];
    
    UITableView *tab_Test = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, MainScreenFrame_Height - UI_TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    tab_Test.delegate = self;
    tab_Test.dataSource = self;
    [self.view addSubview:tab_Test];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableviewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *homeString = @"homeString";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeString];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeString];
        cell.backgroundColor = [UIColor blueColor];
    }
    cell.textLabel.text = @"1200000";
    return cell;
}


@end
