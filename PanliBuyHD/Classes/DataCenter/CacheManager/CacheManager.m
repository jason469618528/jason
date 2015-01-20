//
//  CacheManager.m
//  PanliApp
//
//  Created by Liubin on 13-4-9.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "CacheManager.h"

@implementation CacheManager

/**
 * 功能描述: 请求缓存数据
 * 输入参数: repeater 数据转发器对象
 * 输出参数: N/A
 * 返 回 值: 缓存对象
 */
- (CacheData *)requestCacheData:(DataRepeater *)repeater
{
    return [DBHelper getCacheDate:repeater.cacheKey];
}

/**
 * 功能描述: 更新缓存数据
 * 输入参数: repeater 数据转发器对象
 * 输出参数: N/A
 * 返 回 值: N/A
 */
- (void)updateCacheData:(DataRepeater *)repeater
{
    if (!repeater.updateDataSouce)
    {
        return;
    }    
    // 获取已保存的缓存
    CacheData *oldcacheData = [DBHelper getCacheDate:repeater.cacheKey];    
    // 编码
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:repeater.updateDataSouce];    
    // 封装缓存对象
    CacheData *cacheData = [[CacheData alloc] init];
    [cacheData setCacheKey:repeater.cacheKey];
    [cacheData setCacheContent:data];
    //数据是否缓存
    if (repeater.saveCache && oldcacheData.savedTime)
    {
        [cacheData setSavedTime:oldcacheData.savedTime];
    }
    else
    {
        [cacheData setSavedTime:@"0"];
    }
    
    // 保存缓存
    [DBHelper setCacheData:cacheData isClear:repeater.clearCache];
}

/**
 * 功能描述: 保存缓存数据
 * 输入参数: repeater 数据转发器对象
 * 输出参数: N/A
 * 返 回 值: N/A
 */
- (void)saveCacheData:(DataRepeater *)repeater
{
    if (!repeater.responseValue)
    {
        return;
    }
    if ([repeater.responseValue isKindOfClass:[NSArray class]] && ((NSArray *)repeater.responseValue).count == 0)
    {
        return;
    }
    // 编码
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:repeater.responseValue];
    // 封装对象
    CacheData *cacheData = [[CacheData alloc] init];
    [cacheData setCacheKey:repeater.cacheKey];
    [cacheData setCacheContent:data];
    //数据是否缓存
    if (repeater.saveCache)
    {
        [cacheData setSavedTime:[NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]]];
    }
    else
    {
        [cacheData setSavedTime:@"0"];
    }    
    // 保存缓存
    [DBHelper setCacheData:cacheData isClear:repeater.clearCache];
}

/**
 * 功能描述: 清除缓存数据
 * 输入参数: repeater 数据转发器对象
 * 输出参数: N/A
 * 返 回 值: N/A
 */
- (void)clearCacheData:(NSString *)cacheKey
{
    if (cacheKey)
    {
        CacheData *cacheData = [[CacheData alloc] init];
        cacheData.cacheKey = cacheKey;
        cacheData.cacheContent = nil;
        cacheData.savedTime = nil;
        [DBHelper setCacheData:cacheData isClear:YES];
    }
}

@end
