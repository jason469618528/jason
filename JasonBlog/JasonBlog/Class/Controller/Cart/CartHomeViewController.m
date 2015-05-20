//
//  CartHomeViewController.m
//  JasonBlog
//
//  Created by jason on 15-5-4.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import "CartHomeViewController.h"

@interface CartHomeViewController ()

@end

@implementation CartHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.tab_Main.editing = YES;
    
    UIBarButtonItem *bar_Left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(categoryClick:)];
    self.navigationItem.leftBarButtonItem = bar_Left;
    
    UIBarButtonItem *bar_Right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(categoryClick:)];
    self.navigationItem.rightBarButtonItem = bar_Right;
    
    //搜索条
    UISearchBar *bar_searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(60.0f, 0.0f, MainScreenFrame_Width - 120.0f, 44.0f)];
    bar_searchBar.backgroundColor = [UIColor redColor];
    bar_searchBar.tintColor = COLOR_GRAY;
    bar_searchBar.placeholder = @"搜索商品";
    bar_searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    bar_searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    self.navigationItem.titleView = bar_searchBar;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)categoryClick:(UIBarButtonItem*)barItem
{
    NSLog(@"分类");
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *homeString = @"homeString";
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:homeString];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeString];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d",(int)indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //判断是否可以删除
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

@end
