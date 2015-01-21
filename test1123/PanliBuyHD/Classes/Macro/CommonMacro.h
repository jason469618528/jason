//
//  CommonMacro.h
//  PanliApp
//
//  Created by Liubin on 14-4-3.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

/**************************************************
 * 内容描述: 系统公共宏
 * 创 建 人: 刘彬
 * 创建日期: 2013-04-07
 **************************************************/
#ifndef PanliApp_CommonMacro_h
#define PanliApp_CommonMacro_h

#define SAFE_RELEASE(x)  x = nil;

#define ALL_LOG(...) NSLog(__VA_ARGS__)

/***************常用路径**************/
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/***************常用字体**************/
#define DEFAULT_FONT(s) [UIFont fontWithName:@"Arial" size:s]
#define DEFAULT_BOLD_FONT(s) [UIFont fontWithName:@"Arial-BoldMT" size:s]

/***************常用颜色**************/
#define PL_COLOR_CLEAR [UIColor clearColor]
#define PL_COLOR_GRAY  [UIColor grayColor]
#define PL_COLOR_WHITE [UIColor whiteColor]
#define PL_COLOR_BLACK [UIColor blackColor]
#define PL_COLOR_RED   [UIColor redColor]
#define PL_COLOR_LOW_GRAY [PanliHelper colorWithHexString:@"#5d5d5d"]
#define PL_COLOR_NAVBAR_TITLE [PanliHelper colorWithHexString:@"#4B4B4B"]

/***************设备相关**************/
#define IS_568H ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : \
NO)
/**
 *判断是否ios7
 */
#define IS_IOS7 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
/*
 *获取系统版本号
 */
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
/*
 *判断系统版本是否与v相等
 */
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
/*
 *判断系统版本是否大于v
 */
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
/*
 *判断系统版本是否大于等于v
 */
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
/*
 *判断系统版本是否小于v
 */
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

/*
 *判断系统版本是否小于等于v
 */
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/***************常用尺寸**************/
#define UI_NAVIGATION_BAR_HEIGHT    44.0f
#define UI_TAB_BAR_HEIGHT           49.0f
#define UI_STATUS_BAR_HEIGHT        20.0f
#define UI_SCREEN_WIDTH             320.0f
#define UI_SCREEN_HEIGHT            ([[UIScreen mainScreen] bounds].size.height)
#define UI_KAYBOARD_HEIGHT          352.0f

#define TOOLBAR_WIDTH 79.0f


#define MainScreenFrame         [[UIScreen mainScreen] bounds]
//#define MainScreenFrame_Width   MainScreenFrame.size.width
//#define MainScreenFrame_Height  MainScreenFrame.size.height-20
#define LEFT_SPLITEVIEW_WIDTH   320.0f
#define Right_SpliteView_Width  703.0f

#define MainScreenFrame_Width         (SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(@"7.1")?([[UIScreen mainScreen] bounds].size.height):([[UIScreen mainScreen] bounds].size.width))
#define MainScreenFrame_Height        (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")?([[UIScreen mainScreen] bounds].size.height-20):([[UIScreen mainScreen] bounds].size.width-20))


/*
 Usage sample:
 
 if (SYSTEM_VERSION_LESS_THAN(@"4.0")) {
 ...
 }
 
 if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"3.1.1")) {
 ...
 }
 
 */

#define NOTIFICATION_NAME_POP_LOGIN  @"USER_POP_LOGIN"
#define NOTIFICATION_NAME_LOGIN      @"USER_LOGIN"
#define NOTIFICATION_NAME_LOGOUT     @"USER_LOGOUT"


/**
 *  国际化文件Bundle
 */
#define InternationalBundle [InternationalControl bundle]

#define LocalizedString(key,comment) NSLocalizedStringFromTableInBundle(key, @"International", InternationalBundle, comment)

#endif
