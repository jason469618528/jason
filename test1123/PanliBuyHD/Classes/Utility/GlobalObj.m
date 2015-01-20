//
//  GlobalObj.m
//  PanliApp
//
//  Created by Liubin on 13-4-11.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "GlobalObj.h"
#import "UserInfo.h"
//#import "ShipCountry.h"
#import "NSDate+Helper.h"
#import "NSString+Helper.h"
#import "NSUserDefaults+Helper.h"



static BOOL isAlertViewShowing = NO;
static BOOL isLastVersion = NO;
static BOOL isNotificationShow = NO;

@implementation GlobalObj

/**
 * 功能描述: 保存用户信息
 * 输入参数: userInfo userInfo对象
 * 输出参数: N/A
 * 返 回 值: N/A
 */
+ (void)setUserInfo:(UserInfo *)iUserInfo
{
    if (iUserInfo != nil)
    {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:iUserInfo];
        //保存用户信息
        [NSUserDefaults saveObject:data forKey:USER_INFO];
        //保存时间（用于判断用户信息有效期限）
        [NSUserDefaults saveObject:[[NSDate date] formatWithString:@"yyyy-MM-dd HH:mm:ss"] forKey:USER_INFO_SAVETIME];
        //保存最后登录用户名（用于自动显示在登录界面）
        [NSUserDefaults saveObject:iUserInfo.nickName forKey:USER_NAME_CACHE];
    }
    else
    {
        //清空相关信息
        [NSUserDefaults saveObject:nil forKey:USER_INFO];
        [NSUserDefaults saveObject:nil forKey:USER_INFO_SAVETIME];
        [NSUserDefaults saveObject:nil forKey:USER_CREDENTIAL];
    }
}

/**
 * 功能描述: 获取用户信息
 * 输入参数: N/A
 * 输出参数: N/A
 * 返 回 值: userInfo对象，没有则为nil
 */
+ (UserInfo *)getUserInfo
{
    UserInfo *oUserInfo = nil;
    if ([NSUserDefaults getObjectForKey:USER_INFO])
    {
        NSString *dateString = [NSUserDefaults getObjectForKey:USER_INFO_SAVETIME];
        NSDate *minValidDate = [NSDate dateWithTimeIntervalSinceNow:-24*60*60*7];
        NSDate *saveDate = [dateString formatToDateWithString:@"yyyy-MM-dd HH:mm:ss"];
        //判断用户是否失效
        if ([saveDate compare:minValidDate] != NSOrderedDescending)
        {
            [self setUserInfo:nil];
        }
        else
        {
            oUserInfo = [NSKeyedUnarchiver unarchiveObjectWithData:[NSUserDefaults getObjectForKey:USER_INFO]];
        }
    }
    return oUserInfo;
}

/**
 * 功能描述: 获取用户票据
 * 输入参数: N/A
 * 输出参数: N/A
 * 返 回 值: 票据
 */
+ (NSString *)getCredential
{
    return [NSUserDefaults getObjectForKey:USER_CREDENTIAL];
}

/**
 *保存运送地址
 */
+(void)setShipCountry:(NSMutableArray *)iShipCountry
{
    if (iShipCountry)
    {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:iShipCountry];
        [NSUserDefaults saveObject:data forKey:USER_SHIPCOUNTRY];
    }
    else
    {
        [NSUserDefaults saveObject:nil forKey:USER_SHIPCOUNTRY];
    }
}

/**
 *获取运送地址
 */
+(NSMutableArray *)getShipCountry
{
    NSMutableArray *oShipCountry = nil;
    if ([NSUserDefaults getObjectForKey:USER_SHIPCOUNTRY])
    {
        oShipCountry = [NSKeyedUnarchiver unarchiveObjectWithData:[NSUserDefaults getObjectForKey:USER_SHIPCOUNTRY]] ;
    }
    return oShipCountry;
}

/**
 *保存类目
 */
+(void)setCategory:(NSMutableArray *)iCategory
{
    if (iCategory)
    {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:iCategory];
        [NSUserDefaults saveObject:data forKey:CATEGORY];
    }
    else
    {
        [NSUserDefaults saveObject:nil forKey:CATEGORY];
    }
}

/**
 *获取类目
 */
+(NSMutableArray *)getCategory
{
    NSMutableArray *oCategory = nil;
    if ([NSUserDefaults getObjectForKey:CATEGORY])
    {
        oCategory = [NSKeyedUnarchiver unarchiveObjectWithData:[NSUserDefaults getObjectForKey:CATEGORY]];
    }
    
    return oCategory;
}


/**
 *获取路由url
 */
+(NSString*)getRouteUrl
{
    return [NSUserDefaults getObjectForKey:ROUTEURL];
}


+ (void)saveIsAlertViewShowing:(BOOL)isShow
{
    isAlertViewShowing = isShow;
}

+ (BOOL)isAlertViewShowing
{
    return isAlertViewShowing;
}

/**
 *保存当前版本状态(是否有更新)
 */
+(void)saveIsLastVersion:(BOOL)isNew
{
    isLastVersion = isNew;
}

/**
 *获取当前版本是否更新
 */
+(BOOL)isLastVersion
{
    return isLastVersion;
}

/**
 *获取推送状态
 */
+ (BOOL)isNotification
{
    return isNotificationShow;
}


/**
 *保存运送地址
 */
+ (void)setLastShipList:(NSMutableArray *)iShips
{
    if (iShips)
    {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:iShips];
        [NSUserDefaults saveObject:data forKey:LAST_SHIP];
    }
    else
    {
        [NSUserDefaults saveObject:nil forKey:LAST_SHIP];
    }
}

/**
 *获取运送地址
 */
+ (NSMutableArray *)getLastShipList
{
    NSMutableArray *oShipList = nil;
    if ([NSUserDefaults getObjectForKey:LAST_SHIP])
    {
        oShipList = [NSKeyedUnarchiver unarchiveObjectWithData:[NSUserDefaults getObjectForKey:LAST_SHIP]] ;
    }
    return oShipList;
}

@end
