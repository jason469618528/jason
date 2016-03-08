//
//  ToolHomeViewController.m
//  JasonBlog
//
//  Created by jason on 16/1/8.
//  Copyright © 2016年 PanliMobile. All rights reserved.
//

#import "ToolHomeViewController.h"

@interface ToolHomeViewController ()

@end

@implementation ToolHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = J_COLOR_WHITE;
    self.navigationItem.title = @"工具";
    // Do any additional setup after loading the view.
    CustomButton *btn_ToolClick = [CustomButton buttonWithType:UIButtonTypeCustom];
    btn_ToolClick.frame = CGRectMake(100.0f, 110.0f, 100.0f, 100.0f);
    btn_ToolClick.backgroundColor = J_COLOR_RED;
    [btn_ToolClick btnClickEventBlock:^{
        NSLog(@"asdfasdfasf");
    }];
    [self.view addSubview:btn_ToolClick];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController isCanBack:NO];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController isCanBack:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
