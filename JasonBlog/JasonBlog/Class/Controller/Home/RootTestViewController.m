//
//  RootTestViewController.m
//  JasonBlog
//
//  Created by iyb-hj on 2017/8/7.
//  Copyright © 2017年 PanliMobile. All rights reserved.
//

#import "RootTestViewController.h"
#import "CustomerTabbarController.h"

@interface RootTestViewController ()

@end

@implementation RootTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomerTabbarController *rootVC = [[CustomerTabbarController alloc] init];
    [self.view addSubview:rootVC.view];
    [self addChildViewController:rootVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
