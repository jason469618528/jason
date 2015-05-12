//
//  AppDelegate.m
//  JasonBlog
//
//  Created by jason on 15-1-19.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "SearchHomeViewController.h"
#import "MyHomeViewController.h"
#import "CartHomeViewController.h"
#import "OtherHomeViewController.h"
#define TABBAR_TITLE_Y (-3.0f)
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    
    //去除navbar 黑线
//    [[UINavigationBar appearance] setBackgroundColor:COLOR_CLEAR];
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
//    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
//                                      forBarPosition:UIBarPositionAny
//                                          barMetrics:UIBarMetricsDefault];
    
//    [[UITabBar appearance] setBarStyle:UIBarStyleBlack];
    
    [[UINavigationBar appearance] setTranslucent:NO];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil]forState:UIControlStateSelected];
    
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.width);
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    homeVC.navigationItem.title = @"首页";
    UINavigationController *nav_Home = [[UINavigationController alloc] initWithRootViewController:homeVC];

    SearchHomeViewController *searchVC = [[SearchHomeViewController alloc] init];
    searchVC.navigationItem.title = @"搜索";
    UINavigationController *nav_search = [[UINavigationController alloc] initWithRootViewController:searchVC];

    CartHomeViewController *cartVC = [[CartHomeViewController alloc] init];
    cartVC.navigationItem.title = @"购物车";
    UINavigationController *nav_cart = [[UINavigationController alloc] initWithRootViewController:cartVC];

    MyHomeViewController *myVC = [[MyHomeViewController alloc] init];
    myVC.navigationItem.title = @"我的";
    UINavigationController *nav_my = [[UINavigationController alloc] initWithRootViewController:myVC];

    OtherHomeViewController *otherVC = [[OtherHomeViewController alloc] init];
    otherVC.navigationItem.title = @"更多";
    UINavigationController *nav_other = [[UINavigationController alloc] initWithRootViewController:otherVC];

    
    UITabBarController *tabVC = [[UITabBarController alloc] init];
    tabVC.tabBar.barTintColor = [UIColor whiteColor];
    tabVC.tabBar.tintColor = [UIColor whiteColor];
    tabVC.viewControllers = @[nav_Home,nav_search,nav_cart,nav_my,nav_other];
    tabVC.selectedIndex = 0;
    
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


    self.window.rootViewController = tabVC;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
