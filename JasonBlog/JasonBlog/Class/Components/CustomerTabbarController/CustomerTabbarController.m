//
//  CustomerTabbarController.m
//  JasonBlog
//
//  Created by jason on 15-5-13.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import "CustomerTabbarController.h"
#import "HomeViewController.h"
#import "SearchHomeViewController.h"
#import "MyHomeViewController.h"
#import "CartHomeViewController.h"
#import "OtherHomeViewController.h"
#import "CustomerNavgaionController.h"
#define TABBAR_TITLE_Y (-3.0f)
@interface CustomerTabbarController ()

@end

@implementation CustomerTabbarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    homeVC.navigationItem.title = @"首页";
    CustomerNavgaionController *nav_Home = [[CustomerNavgaionController alloc] initWithRootViewController:homeVC];
    
    SearchHomeViewController *searchVC = [[SearchHomeViewController alloc] init];
    searchVC.navigationItem.title = @"搜索";
    CustomerNavgaionController *nav_search = [[CustomerNavgaionController alloc] initWithRootViewController:searchVC];
    
    CartHomeViewController *cartVC = [[CartHomeViewController alloc] init];
//    cartVC.navigationItem.title = @"购物车";
    CustomerNavgaionController *nav_cart = [[CustomerNavgaionController alloc] initWithRootViewController:cartVC];
    
    MyHomeViewController *myVC = [[MyHomeViewController alloc] init];
    myVC.navigationItem.title = @"我的";
    CustomerNavgaionController *nav_my = [[CustomerNavgaionController alloc] initWithRootViewController:myVC];
    
    OtherHomeViewController *otherVC = [[OtherHomeViewController alloc] init];
    otherVC.navigationItem.title = @"更多";
    CustomerNavgaionController *nav_other = [[CustomerNavgaionController alloc] initWithRootViewController:otherVC];
    
    UIImage *img_home = [UIImage imageNamed:@"tabbar_icon_news_highlight"];
    img_home =  [img_home imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"tabbar_icon_news_normal"] selectedImage:img_home];
    [homeVC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0.0f, TABBAR_TITLE_Y)];
    
    
    UIImage *img_search = [UIImage imageNamed:@"tabbar_icon_found_highlight"];
    img_search =  [img_search imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    searchVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"搜索" image:[UIImage imageNamed:@"tabbar_icon_found_normal"] selectedImage:img_search];
    [searchVC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0.0f, TABBAR_TITLE_Y)];
    
    
    UIImage *img_cart = [UIImage imageNamed:@"tabbar_icon_reader_highlight"];
    img_cart =  [img_cart imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    cartVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"购物车" image:[UIImage imageNamed:@"tabbar_icon_reader_normal"] selectedImage:img_cart];
    [cartVC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0.0f, TABBAR_TITLE_Y)];
    
    
    UIImage *img_my = [UIImage imageNamed:@"tabbar_icon_me_highlight"];
    img_my =  [img_my imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    myVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"tabbar_icon_me_normal"] selectedImage:img_my];
    [myVC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0.0f, TABBAR_TITLE_Y)];
    
    UIImage *img_other = [UIImage imageNamed:@"tabbar_icon_media_highlight"];
    img_other =  [img_other imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    otherVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"更多" image:[UIImage imageNamed:@"tabbar_icon_media_normal"] selectedImage:img_other];
    [otherVC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0.0f, TABBAR_TITLE_Y)];
    
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.tintColor = [UIColor whiteColor];
    self.viewControllers = @[nav_Home,nav_search,nav_cart,nav_my,nav_other];
    self.selectedIndex = 0;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
