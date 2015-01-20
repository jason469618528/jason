//
//  AppDelegate.m
//  PanliBuyHD
//
//  Created by Liubin on 14-6-13.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "PayPalMobile.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //国际化
    [InternationalControl initUserLanguage];//初始化应用语言
    
    [self.window makeKeyAndVisible];
    
    
    
    //设置navbar,tabbar
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0"))
    {
        [[UINavigationBar appearance] setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor blackColor],UITextAttributeFont : DEFAULT_FONT(16)}];
        [[UINavigationBar appearance] setBackgroundColor:PL_COLOR_CLEAR];
        [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
        [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    }
    //注册数据请求和接收通知
    dataRequestManager = [DataRequestManager sharedInstance];
    
    //设置paypal客户端id
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : PAYPAL_CLIENTID_LIVE,
                                                           PayPalEnvironmentSandbox : PAYPAL_CLIENTID_SANDBOX}];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
