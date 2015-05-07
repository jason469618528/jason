//
//  HomeViewController.m
//  JasonBlog
//
//  Created by jason on 15-5-4.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import "HomeDetailViewController.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tab_Main;
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    [[RequestManager sharedInstance] sendRequestSuccess:^(id response) {
        NSLog(@"%@",response);
    } error:^(NSError *responseError) {
        NSLog(@"%@",responseError);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableviewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 || indexPath.section == 1)
    {
        return 200.0f;
    }
    else
    {
        return 100.f;
    }
    
    return 0.0f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *homeString = @"homeString";
    HomeCell*cell = [tableView dequeueReusableCellWithIdentifier:homeString];
    if(!cell)
    {
        cell = (HomeCell*)[[[NSBundle mainBundle] loadNibNamed:@"HomeCell" owner:self options:nil] firstObject];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section)
    {
        return 50.0f;
    }
    return 0.1f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HomeDetailViewController *detailVC = [[HomeDetailViewController alloc] init];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
