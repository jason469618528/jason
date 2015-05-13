//
//  HomeDetailViewController.m
//  JasonBlog
//
//  Created by jason on 15-5-7.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import "HomeDetailViewController.h"

@interface HomeDetailViewController ()

@end

@implementation HomeDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"测试";
    self.view.backgroundColor = [UIColor redColor];
    UIButton *btn_navBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_navBack.frame = CGRectMake(0.0f, 0.0f, 50.0f, 50.0f);
    btn_navBack.backgroundColor = [UIColor redColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn_navBack];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
