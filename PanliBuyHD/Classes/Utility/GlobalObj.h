//
//  GlobalObj.h
//  PanliApp
//
//  Created by Liubin on 13-4-11.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

/**************************************************
 * 内容描述: 存取全局对象类(提供全局对象存取操作)
 * 创 建 人: 刘彬
 * 创建日期: 2013-04-11
 **************************************************/
#import <Foundation/Foundation.h>

#define USER_INFO @"userInfo"
#define USER_INFO_SAVETIME @"userInfoSetTime"
#define USER_NAME_CACHE @"userName"
#define USER_CREDENTIAL @"userCredential"
#define USER_SHIPCOUNTRY @"shipCountry"
#define CATEGORY @"category"
#define ROUTEURL @"Host"

#define LAST_SHIP @"lastShip"

@class UserInfo;
@class ShipCountry;
@interface GlobalObj : NSObject

+ (void)setUserInfo:(UserInfo *)iUserInfo;
+ (void)setShipCountry:(NSMutableArray *)iShipCountry;
+ (void)setCategory:(NSMutableArray *)iCategory;
+ (UserInfo *)getUserInfo;
+ (NSString *)getCredential;
+ (NSMutableArray *)getShipCountry;
+ (NSMutableArray *)getCategory;
+ (NSString*)getRouteUrl;
+ (void)saveIsAlertViewShowing:(BOOL)isShow;
+ (BOOL)isAlertViewShowing;
+ (void)saveIsLastVersion:(BOOL)isNew;
+ (BOOL)isLastVersion;
+ (BOOL)isNotification;

+ (NSMutableArray *)getLastShipList;
+ (void)setLastShipList:(NSMutableArray *)iShips;
@end
