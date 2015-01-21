//
//  DatabaseTool.h
//  PanliApp
//
//  Created by Liubin on 13-4-9.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "CacheData.h"

/**************************************************
 * 内容描述: 数据库操作类
 * 创 建 人: 刘彬
 * 创建日期: 2013-04-09
 **************************************************/
@interface DBHelper : NSObject

/**
 * 功能描述: 获取数据库保存地址
 * 输入参数: N/A
 * 输出参数: N/A
 * 返 回 值: 数据库路径
 */
+ (NSString *)getFilePath;

/**
 * 功能描述: 初始化数据库表
 * 输入参数: N/A
 * 输出参数: N/A
 * 返 回 值: YES-成功，NO-失败
 */
+ (BOOL)createTables;

/**
 * 功能描述: 删除数据库所有表
 * 输入参数: N/A
 * 输出参数: N/A
 * 返 回 值: YES-成功，NO-失败
 */
+ (BOOL)dropTables;

/**
 * 功能描述: 存放缓存数据
 * 输入参数: data 缓存数据对象 flag 是否清除之前的数据
 * 输出参数: N/A
 * 返 回 值: YES-成功，NO-失败
 */
+ (BOOL) setCacheData:(CacheData *)data isClear:(BOOL)flag;

/**
 * 功能描述: 获取缓存数据
 * 输入参数: cacheKey 缓存数据标识
 * 输出参数: N/A
 * 返 回 值: 缓存数据对象，没有则返回nil
 */
+ (CacheData *) getCacheDate:(NSString *)cacheKey;

/**
 * 功能描述: 获取数据库版本
 * 输入参数: N/A
 * 输出参数: N/A
 * 返 回 值: 版本号
 */
+ (NSString *)getDBVersion;

@end
