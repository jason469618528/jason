//
//  DataRequestRepeater.h
//  PanliApp
//
//  Created by Liubin on 13-4-10.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BaseHttpRequest;
@class ErrorInfo;

/**************************************************
 * 内容描述: 数据转发器
 * 创 建 人: 刘彬
 * 创建日期: 2012-04-10
 **************************************************/
/**
 *  请求成功处理Block
 */
typedef void(^CompletBlock)(id repeater);
@interface DataRepeater : NSObject
{
    /**
     *请求参数
     */
    NSString             *_requestName;//请求名
    NSMutableDictionary  *_requestParameters;//请求参数字典
    BaseHttpRequest      *_networkRequest;//请求对象    
    NSString             *_cacheKey;//缓存key
    BOOL                 _saveCache;//是否需要缓存数据
    BOOL                 _clearCache;//是否清除相关联的缓存数据
    float                _cacheValidTime;//缓存有效时间
    RequestModal         _RequestModal;//请求类型
    PushedCacheOperation _pushedCacheOperation;//推送数据操作
    

    /**
     *返回参数
     */
    BOOL                 _isResponseSuccess;//请求响应结果
    id                   _responseValue;//响应返回的数据
    RespondModal         _respondModal;//响应类型
    ErrorInfo            *_errorInfo;//错误信息
    
    id                   _updateDataSouce;//更新缓存的数据 
    NSString             *_notificationName;//响应通知名称
    CompletBlock         _compleBlock;//响应操作
}

#pragma mark - 请求所需参数
/**
 *请求名
 */
@property (nonatomic, strong) NSString *requestName;

/**
 *请求参数字典
 */
@property (nonatomic, strong) NSMutableDictionary *requestParameters;

/**
 *请求对象
 */
@property (nonatomic, strong) BaseHttpRequest *networkRequest;

/**
 *是否需要授权
 */
@property (nonatomic, assign) BOOL isAuth;

/**
 *缓存key
 */
@property (nonatomic, strong) NSString *cacheKey;

/**
 *是否需要缓存数据 不需要则缓存时间为0
 */
@property (nonatomic, unsafe_unretained) BOOL saveCache;

/**
 *是否清除相关联的缓存数据
 */
@property (nonatomic, unsafe_unretained) BOOL clearCache;

/**
 *缓存有效期（时间间隔（如：60秒））
 */
@property (nonatomic, unsafe_unretained) float cacheValidTime;

/**
 *页面请求类型
 */
@property (nonatomic, unsafe_unretained) RequestModal requestModal;

/**
 *推送数据操作
 */
@property (nonatomic, unsafe_unretained) PushedCacheOperation pushedCacheOperation;

/**
 *推送数据对象
 */
@property (nonatomic, strong) id updateDataSouce;



#pragma mark - 请求返回数据

/**
 *请求响应结果（YES-访问成功，NO-访问不成功）
 */
@property (nonatomic, unsafe_unretained) BOOL isResponseSuccess;

/**
 *返回结果
 */
@property (nonatomic, strong) id responseValue;

/**
 *页面响应类型
 */
@property (nonatomic, unsafe_unretained) RespondModal respondModal;

/**
 *返回错误信息
 */
@property (nonatomic, strong) ErrorInfo *errorInfo;

/**
 *请求返回数据响应的通知
 */
@property (nonatomic, strong) NSString *notificationName;
/**
 *请求返回数据响应的操作
 */
@property (nonatomic, copy) CompletBlock compleBlock;


#pragma mark - 构造函数
/**
 构造函数
 @param name 请求名
 */
-(id)initWithName:(NSString *)name;



@end
