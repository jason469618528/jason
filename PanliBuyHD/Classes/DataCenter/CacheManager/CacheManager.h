//
//  CacheManager.h
//  PanliApp
//
//  Created by Liubin on 13-4-9.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CacheData.h"
#import "DBHelper.h"
#import "DataRepeater.h"

/**************************************************
 * 内容描述: 数据缓存操作类
 * 创 建 人: 刘彬
 * 创建日期: 2013-04-09
 **************************************************/
@interface CacheManager : NSObject

/**
 * 功能描述: 获取缓存数据
 * 输入参数: repeater 数据转发器对象
 * 输出参数: N/A
 * 返 回 值: 缓存对象
 */
-(CacheData *)requestCacheData:(DataRepeater *) repeater;

/**
 * 功能描述: 更新缓存数据
 * 输入参数: repeater 数据转发器对象
 * 输出参数: N/A
 * 返 回 值: N/A
 */
- (void)updateCacheData:(DataRepeater *) repeater;

/**
 * 功能描述: 保存缓存数据
 * 输入参数: repeater 数据转发器对象
 * 输出参数: N/A
 * 返 回 值: N/A
 */
- (void)saveCacheData:(DataRepeater *)repeater;

/**
 * 功能描述: 清除缓存数据
 * 输入参数: repeater 数据转发器对象
 * 输出参数: N/A
 * 返 回 值: N/A
 */
- (void)clearCacheData:(NSString *)cacheKey;


@end
