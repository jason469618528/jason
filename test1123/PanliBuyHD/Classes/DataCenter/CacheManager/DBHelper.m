//
//  DatabaseTool.m
//  PanliApp
//
//  Created by Liubin on 13-4-9.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "DBHelper.h"

@implementation DBHelper
/**
 *创建数据缓存表(CACHEKEY,CACHECONTENT,SAVEDTIME)
 */
#define CREATE_CACHE @"CREATE TABLE IF NOT EXISTS CACHEDATA(CACHEKEY TEXT PRIMARY KEY,CACHECONTENT BLOB,SAVEDTIME TEXT)"

/**
 *创建版本表
 */
#define CREATE_VERSION @"CREATE TABLE IF NOT EXISTS DATAVERSION(VERSION TEXT)"

/**
 *删除数据缓存表
 */
#define DROP_CACHE @"DROP TABLE IF EXISTS CACHEDATA"

/**
 *删除版本表
 */
#define DROP_VERSION @"DROP TABLE IF EXISTS DATAVERSION"

/**
 * 功能描述: 获取数据库保存地址
 * 输入参数: N/A
 * 输出参数: N/A
 * 返 回 值: 数据库路径
 */
+ (NSString *)getFilePath
{
    return [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"panli.sqlite"];
}

/**
 * 功能描述: 初始化数据库表
 * 输入参数: N/A
 * 输出参数: N/A
 * 返 回 值: YES-成功，NO-失败
 */
+ (BOOL)createTables
{
    //成功标识
    BOOL success;
    //添加或更新版本表信息
    NSString *insertVersion = [[NSString alloc] initWithFormat:@"INSERT OR REPLACE INTO DATAVERSION (VERSION) VALUES ('%@');",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    NSArray *sqlArray = [NSArray arrayWithObjects:CREATE_CACHE, CREATE_VERSION, insertVersion, nil];
    //获取数据库对象
    FMDatabase *db = [FMDatabase databaseWithPath:[self getFilePath]];
    [db open];    
    //开启事务
    [db beginTransaction];
    for (NSString *sqlStr in sqlArray)
    {
        [db executeUpdate:sqlStr];
    }
    //提交事务
    success = [db commit];    
    [db close];
    return success;
}

/**
 * 功能描述: 删除数据库所有表
 * 输入参数: N/A
 * 输出参数: N/A
 * 返 回 值: YES-成功，NO-失败
 */
+ (BOOL)dropTables
{
    //成功标识
    BOOL success;
    NSArray *sqlArray = [NSArray arrayWithObjects:DROP_CACHE, DROP_VERSION, nil];
    //获取数据库对象
    FMDatabase *db = [FMDatabase databaseWithPath:[self getFilePath]];
    [db open];
    //开启事务
    [db beginTransaction];
    for (NSString *sqlStr in sqlArray)
    {
        [db executeUpdate:sqlStr];
    }
    //提交事务
    success = [db commit];
    [db close];
    return success;
}

/**
 * 功能描述: 存放缓存数据
 * 输入参数: data 缓存数据对象 flag 是否清除之前的数据
 * 输出参数: N/A
 * 返 回 值: YES-成功，NO-失败
 */
+ (BOOL) setCacheData:(CacheData *)data isClear:(BOOL)flag
{
    BOOL success;
    FMDatabase *db = [FMDatabase databaseWithPath:[self getFilePath]];
    [db open];
    //更新缓存
    if (flag)
    {
        [db beginTransaction];
        [db executeUpdate:@"DELETE FROM CACHEDATA WHERE CACHEKEY = ?", data.cacheKey];
        if (data.cacheContent != nil)
        {
            [db executeUpdate:@"INSERT OR REPLACE INTO CACHEDATA (CACHEKEY,CACHECONTENT,SAVEDTIME) VALUES (?,?,?)", data.cacheKey, data.cacheContent, data.savedTime];
        }
        
        success = [db commit];
    }
    //添加缓存
    else
    {
        if (data.cacheContent != nil)
        {
            success = [db executeUpdate:@"INSERT OR REPLACE INTO CACHEDATA (CACHEKEY,CACHECONTENT,SAVEDTIME) VALUES (?,?,?)", data.cacheKey, data.cacheContent, data.savedTime];
        }
        else
        {
            success = YES;
        }
        
    }
    [db close];
    return success;
}

/**
 * 功能描述: 获取缓存数据
 * 输入参数: cacheKey 缓存数据标识
 * 输出参数: N/A
 * 返 回 值: 缓存数据对象，没有则返回nil
 */
+ (CacheData *)getCacheDate:(NSString *)cacheKey
{
    CacheData * data = nil;
    FMDatabase *db = [FMDatabase databaseWithPath:[self getFilePath]];
    [db open];
    FMResultSet *rs = [db executeQuery:@"SELECT CACHEKEY,CACHECONTENT,SAVEDTIME FROM CACHEDATA WHERE CACHEKEY = ?", cacheKey];
    if ([rs next])
    {
        data = [[CacheData alloc] init];
        data.cacheKey = cacheKey;
        data.cacheContent = [rs dataForColumnIndex:1];
        data.savedTime = [rs stringForColumnIndex:2];
    }
    [rs close];
    [db close];
    return data;
}

+ (NSString *)getDBVersion
{
    FMDatabase *db = [FMDatabase databaseWithPath:[DBHelper getFilePath]];
    
    [db open];
    
    FMResultSet *rs = [db executeQuery:@"SELECT VERSION FROM DATAVERSION"];
    
    NSString *versionNo = nil;
    
    if ([rs next]) {
        versionNo = [rs stringForColumnIndex:0];
    }
    
    [rs close];
    [db close];
    
    return versionNo;
}

@end
