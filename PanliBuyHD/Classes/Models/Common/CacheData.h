//
//  CacheData.h
//  PanliApp
//
//  Created by Liubin on 13-4-9.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

/**************************************************
 * 内容描述: 数据缓存对象
 * 创 建 人: liubin
 * 创建日期: 2013-04-09
 **************************************************/

@interface CacheData : NSObject
{
    NSString *_cacheKey;
    NSData *_cacheContent;
    NSString *_savedTime;
}

/**
 *数据缓存标识
 */
@property (nonatomic, strong) NSString *cacheKey;

/**
 *缓存数据
 */
@property (nonatomic, strong) NSData *cacheContent;

/**
 *保存时间
 */
@property (nonatomic, strong) NSString *savedTime;

@end
