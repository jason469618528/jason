//
//  AppDelegate.m
//  JasonBlog
//
//  Created by jason on 15-1-19.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomerTabbarController.h"
#import "SearchDetailViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

NSString *BraintreeDemoAppDelegatePaymentsURLScheme = @"com.panli.panlimobile.JasonBlog.payments";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = UIColor.whiteColor;
    [self.window makeKeyAndVisible];

    //去除navbar 黑线
//    [[UINavigationBar appearance] setBackgroundColor:COLOR_CLEAR];
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
//    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
//                                      forBarPosition:UIBarPositionAny
//                                          barMetrics:UIBarMetricsDefault];
    
//    [[UITabBar appearance] setBarStyle:UIBarStyleBlack];
    
    
//    UIImage *backButtonImage = [[UIImage imageNamed:@"AppIcon57x57"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage  forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, backButtonImage.size.height*2) forBarMetrics:UIBarMetricsDefault];
    
    //设置tabbar 文字颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil]forState:UIControlStateSelected];
    
    CustomerTabbarController *tabVC = [[CustomerTabbarController alloc] init];
    self.window.rootViewController = tabVC;
    
//    SearchDetailViewController *rootVC = [[SearchDetailViewController alloc] init];
//    self.window.rootViewController = rootVC;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    //将要进入后台
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents]; // 让后台可以处理多媒体的事件
    NSLog(@"%s",__FUNCTION__);
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil]; //后台播放
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
    //进入后台
    NSLog(@"%s",__FUNCTION__);
//    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"Inmysong" ofType:@"mp3"];
//    NSURL *url = [[NSURL alloc] initFileURLWithPath:musicPath];
//    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//    [self.player prepareToPlay];
//    [self.player setVolume:1];
//    self.player.numberOfLoops = -1; //设置音乐播放次数  -1为一直循环
//    if(self.player)
//    {
//        [self.player play]; //播放
//    }
    NSError *error;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:&error];
    [session setCategory:AVAudioSessionCategoryPlayback error:&error];
    NSString *filePath    = [[NSBundle mainBundle]pathForResource:@"Inmysong" ofType:@"mp3"];
    BOOL fileExit = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (fileExit) {
        self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:filePath ] error:nil ];
        [self.player prepareToPlay];
        [self.player play]; //播放

    }
//    AVAudioSession *session = [AVAudioSession sharedInstance];
//    [session setActive:YES error:nil];
//    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
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

//- (BOOL)application:(UIApplication *)application  openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    return [Braintree handleOpenURL:url sourceApplication:sourceApplication];
//}
@end
