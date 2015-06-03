//
//  MacroDefinition.h
//  JasonBlog
//
//  Created by jason on 15-5-4.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#ifndef JasonBlog_MacroDefinition_h
#define JasonBlog_MacroDefinition_h

#define SAFE_RELEASE(x) [x release]; x = nil;

#define ALL_LOG(...) NSLog(__VA_ARGS__)

/***************常用路径**************/
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/***************常用尺寸**************/
#define UI_NAVIGATION_BAR_HEIGHT    44.0f
#define UI_TAB_BAR_HEIGHT           49.0f
#define UI_STATUS_BAR_HEIGHT        20.0f
#define UI_SCREEN_WIDTH             ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT            ([[UIScreen mainScreen] bounds].size.height)
#define UI_KAYBOARD_HEIGHT          216.0f

#define MainScreenFrame         [[UIScreen mainScreen] bounds]
#define MainScreenFrame_Width   MainScreenFrame.size.width
#define MainScreenFrame_Height  MainScreenFrame.size.height-20

/***************常用字体**************/
#define DEFAULT_FONT(s) [UIFont fontWithName:@"Arial" size:s]
#define DEFAULT_BOLD_FONT(s) [UIFont fontWithName:@"Arial-BoldMT" size:s]

#define DEFAULT_STHeitiSC_Light_FONT(s) [UIFont fontWithName:@"STHeitiSC-Light" size:s]
#define DEFAULT_STHeitiSC_Medium_FONT(s) [UIFont fontWithName:@"STHeitiSC-Medium" size:s]

#define DEFAULT_HELVETICA_THIN_FONT(s) [UIFont fontWithName:@"HelveticaNeue-Thin" size:s]
#define DEFAULT_HELVETICA_Regular_FONT(s) [UIFont fontWithName:@"HelveticaNeue-Regular" size:s]
#define DEFAULT_HELVETICA_LIGNT_FONT(s) [UIFont fontWithName:@"HelveticaNeue-Light" size:s]



/***************常用颜色**************/
#define J_COLOR_CLEAR [UIColor clearColor]
#define J_COLOR_GRAY  [UIColor grayColor]
#define J_COLOR_WHITE [UIColor whiteColor]
#define J_COLOR_BLACK [UIColor blackColor]
#define J_COLOR_RED   [UIColor redColor]
#define J_COLOR_LOW_GRAY [PanliHelper colorWithHexString:@"#5d5d5d"]
#define J_COLOR_NAVBAR_TITLE [PanliHelper colorWithHexString:@"#4B4B4B"]

/***************设备相关**************/
#define IS_568H ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : \
NO)
/**
 *判断是否大于等于ios7
 */
#define IS_IOS7 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
/**
 *判断是否大于等于ios8
 */
#define IS_IOS8 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")
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

/**
 *首页url抓取商品详情
 */
#define HOME_URL_BUYDETAIL @"homeUrlBuyDetail"
/*
 Usage sample:
 
 if (SYSTEM_VERSION_LESS_THAN(@"4.0")) {
 ...
 }
 
 if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"3.1.1")) {
 ...
 }
 
 */

/**
 *  国际化文件Bundle
 */
#define InternationalBundle [InternationalControl bundle]

#define LocalizedString(key,comment) NSLocalizedStringFromTableInBundle(key, @"International", InternationalBundle, comment)

#endif
