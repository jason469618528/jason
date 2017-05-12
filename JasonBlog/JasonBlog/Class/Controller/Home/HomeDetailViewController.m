//
//  HomeDetailViewController.m
//  JasonBlog
//
//  Created by jason on 15-5-7.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "CartHomeViewController.h"

@interface HomeDetailViewController ()

@end

@implementation HomeDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"测试";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UIButton *btn_nav_back = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn_nav_back.frame = CGRectMake(0.0f, 0.0f, 54.0f, 44.0f);
//    btn_nav_back.tag = 999;
//    [btn_nav_back setImage:[UIImage imageNamed:@"btn_navbar_back"]forState:UIControlStateNormal];
//    [btn_nav_back setImage:[UIImage imageNamed:@"btn_navbar_back_on"] forState:UIControlStateHighlighted];
//    btn_nav_back.imageEdgeInsets = IS_IOS7 ? UIEdgeInsetsMake(0, -34, 0, 0) : UIEdgeInsetsZero;
//    [btn_nav_back setTitle:@"返回" forState:UIControlStateNormal];
//    [btn_nav_back setTitle:@"返回" forState:UIControlStateHighlighted];
//    [btn_nav_back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn_nav_back setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
//    btn_nav_back.titleEdgeInsets = IS_IOS7 ? UIEdgeInsetsMake(0, -54, 0, 0) : UIEdgeInsetsZero;
//    [btn_nav_back addTarget:self action:@selector(navBackClick) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * btn_Left = [[UIBarButtonItem alloc] initWithCustomView:btn_nav_back];
//    self.navigationItem.leftBarButtonItem = btn_Left;
    
    UIBarButtonItem *leftBackItem = self.navigationItem.leftBarButtonItem;
    UIBarButtonItem *leftBackItem2 = self.navigationController.navigationItem.leftBarButtonItem;
    UIBarButtonItem *backItem = self.navigationItem.backBarButtonItem;

    
    NSString *str_expirationtime = @"2015-06-30";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *expirationData = [dateFormatter dateFromString:str_expirationtime];
    NSDate *test111 = [expirationData dateByAddingTimeInterval:-(3*30*24*60*60)];
    if([test111 compare:[NSDate date]] != NSOrderedDescending) {
        NSLog(@"快到期");
    }
    
    UIButton *btn_ToolClick = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_ToolClick.frame = CGRectMake(100.0f, 100.0f, 100.0f, 100.0f);
    btn_ToolClick.backgroundColor = J_COLOR_RED;
    [btn_ToolClick addTarget:self action:@selector(ToolClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_ToolClick];
}

- (void)ToolClick {
//    UIPageControl *pageControl = [[UIPageControl alloc] init];
//    pageControl.backgroundColor = J_COLOR_RED;
//    pageControl.numberOfPages = 5;
//    pageControl.currentPage = 0;
//    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
//    pageControl.pageIndicatorTintColor = [UIColor grayColor];
//    CGSize pageSize = [pageControl sizeForNumberOfPages:5];
//    pageControl.bounds = CGRectMake(0.0f, 0.0f, pageSize.width, pageSize.height);
//    pageControl.center = CGPointMake(self.view.center.x, 50.0f);
//    [self.view addSubview:pageControl];
    //prefs:root=NOTIFICATIONS_ID
//    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//    if([[UIApplication sharedApplication] canOpenURL:url])
//    {
//        NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
//        [[UIApplication sharedApplication] openURL:url];
//    }
    
    CartHomeViewController *detailVC = [[CartHomeViewController alloc] init];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
    
    UIBarButtonItem *leftBackItem = self.navigationItem.leftBarButtonItem;
    UIBarButtonItem *leftBackItem2 = self.navigationController.navigationItem.leftBarButtonItem;
    UIBarButtonItem *backItem = self.navigationItem.backBarButtonItem;
    UIBarButtonItem *backItem2 = self.navigationController.navigationBar.backItem.backBarButtonItem;
}

- (void)testBlock:(void(^)(id result))AAA {
    AAA(@"aa");
}

- (void)navBackClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
