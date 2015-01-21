//
//  DataRequestManager.m
//  PanliApp
//
//  Created by Liubin on 13-4-10.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "DataRequestManager.h"
#import "DataRepeater.h"
#import "CacheManager.h"
#import "ErrorInfo.h"
#import "BaseHttpRequest.h"

#pragma mark - interface private method
@interface DataRequestManager ()

/**
 远程数据请求
 @param repeater  数据转发器对象
 */
- (void)requestServer:(DataRepeater *)repeater;

/**
 本地数据请求
 @param repeater  数据转发器对象
 */
- (void)requestCache:(DataRepeater *)repeater;

///**
// 发送通知到页面
// @param repeater  数据转发器对象
// */postNotificationToView
//-(void)postNotificationToView:(DataRepeater *)repeater;

/**
 更新缓存数据
 @param repeater  数据转发器对象
 */
- (void)updateCacheData:(DataRepeater *)repeater;

@end

@implementation DataRequestManager

static DataRequestManager *singleton = nil;

+(DataRequestManager *)sharedInstance
{
    static dispatch_once_t token;
    dispatch_once(&token,^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

+(id)alloc
{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        singleton = [super alloc];
    });
    
    return singleton;
}
+ (id)new
{
    return [self sharedInstance];
}

#pragma mark - 实例化方法
- (id)init
{
    self = [super init];
    static dispatch_once_t token;
    dispatch_once(&token,^{
        if (self)
        {
            
        }
    });
    return self;
}


#pragma mark - 响应数据中心通知
/**
 * 功能描述: 响应数据请求发送通知
 * 输入参数: notification 通知对象
 * 输出参数: N/A   
 * 返 回 值: N/A
 */
//- (void)responseSendNotification:(NSNotification *)notification
//{
//    DataRepeater *repeater = (DataRepeater *)notification.object;
//    //如果是拉取数据，则先请求本地（如获取订单，运单等缓存数据）
//    if (repeater.requestModal == PullData)
//    {
//        // 本地缓存请求
//        [self performSelectorInBackground:@selector(requestCache:) withObject:repeater];
//    }
//    //如果是向服务器推送数据，直接访问服务器（如登陆）
//    else if (repeater.requestModal == PushData)
//    {
//        // 远程服务器请求
//        [self requestServer:repeater];
//    }
//    else
//    {
//        [self requestServer:repeater];
//    }
//}

- (void)sendRequest:(DataRepeater *)repeater
{
    //如果是拉取数据，则先请求本地（如获取订单，运单等缓存数据）
    if (repeater.requestModal == PullData)
    {
        // 本地缓存请求
        [self performSelectorInBackground:@selector(requestCache:) withObject:repeater];
    }
    //如果是向服务器推送数据，直接访问服务器（如登陆）
    else if (repeater.requestModal == PushData)
    {
        // 远程服务器请求
        [self requestServer:repeater];
    }
    else
    {
        [self requestServer:repeater];
    }
}

/**
 * 功能描述: 响应数据请求接收通知
 * 输入参数: notification 通知对象
 * 输出参数: N/A/
 * 返 回 值: N/A
 */
//- (void)responseReceiveNotification:(NSNotification *)notification
//{
//    DataRepeater *repeater = (DataRepeater *)notification.object;
//    //响应界面
//    repeater.respondModal = DisplayServerData;
//    //服务器响应异常
////    if ((repeater.errorInfo.code == USER_UNACTIVE ||
////         repeater.errorInfo.code == VERSION_LOW ||
////        repeater.errorInfo.code == VERSION_ERROR ||
////        repeater.                  errorInfo.code == UNAUTHORIZED) &&
////        ![GlobalObj isAlertViewShowing] && 
////        ![repeater.notificationName isEqual: RQNAME_USERLOGIN])
////    {
////        DLOG(@"%@ error, code is :%d",[repeater.networkRequest class], repeater.errorInfo.code);
////        [self performSelectorOnMainThread:@selector(postErrorNotificationToView:) withObject:repeater waitUntilDone:NO];
////    }
////    else
////    {
//
//        [self performSelectorOnMainThread:@selector(postNotificationToView:) withObject:repeater waitUntilDone:NO];
//        // 更新缓存
//        if (repeater.saveCache && repeater.isResponseSuccess)
//        {
//            [self performSelectorInBackground:@selector(updateCacheData:) withObject:repeater];
//        }
////    }
//    
//}

- (void)responseRequest:(DataRepeater *)repeater
{
    //响应界面
    repeater.respondModal = DisplayServerData;
    //服务器响应异常
    if ((repeater.errorInfo.code == USER_UNACTIVE ||
         repeater.errorInfo.code == VERSION_LOW ||
         repeater.errorInfo.code == VERSION_ERROR ||
         repeater.errorInfo.code == UNAUTHORIZED) &&
        ![GlobalObj isAlertViewShowing] &&
        ![repeater.requestName isEqual: RQNAME_USERLOGIN])
    {
        DLOG(@"%@ error, code is :%d",[repeater.networkRequest class], repeater.errorInfo.code);
        [self performSelectorOnMainThread:@selector(postErrorNotificationToView:) withObject:repeater waitUntilDone:NO];
    }
    else
    {
        // 更新缓存
        if (repeater.saveCache && repeater.isResponseSuccess)
        {
            [self performSelectorInBackground:@selector(updateCacheData:) withObject:repeater];
        }
        [self responseToView:repeater];
    }
}

#pragma mark - 数据请求
/**
 * 功能描述: 服务器请求
 * 输入参数: repeater 数据转发器对象
 * 输出参数: N/A
 * 返 回 值: N/A
 */
- (void)requestServer:(DataRepeater *)repeater
{
    repeater.isResponseSuccess = NO;
    if (![PanliHelper connectedToNetwork])
    {        
        // 网络连接失败
        repeater.errorInfo = [ErrorInfo initWithCode:NETWORK_ERROR message:@"网络不给力"];
        repeater.responseValue = nil;
        repeater.isResponseSuccess = NO;
        repeater.respondModal = DisplayServerData;
        // 直接返回页面
//        [self postNotificationToView:repeater];
        [self responseToView:repeater];
        return;
    }    
    // 发送服务器数据请求
    [repeater.networkRequest sendRequest:repeater];
}

/**
 * 功能描述: 本地请求
 * 输入参数: repeater 数据转发器对象
 * 输出参数: N/A
 * 返 回 值: N/A
 */
- (void)requestCache:(DataRepeater *)repeater
{
    @autoreleasepool
    {
        // 访问本地数据
        CacheManager *cacheManager = [[CacheManager alloc] init];
        CacheData *cacheData = [cacheManager requestCacheData:repeater];
        if (cacheData != nil)
        {
            //现在时间和上次保存时间的间隔
            float timeDiffValue = [[NSDate date] timeIntervalSince1970] - [cacheData.savedTime floatValue];
            
            //缓存数据失效
            if (repeater.cacheValidTime <=0 || timeDiffValue > repeater.cacheValidTime)
            {
                //清除缓存
                [cacheManager clearCacheData:cacheData.cacheKey];
                repeater.responseValue = nil;
                repeater.respondModal = DisplayServerData;
            }
            //缓存数据有效
            else
            {
                // 缓存内容有数据
                if (cacheData.cacheContent)
                {
                    @try
                    {
                        repeater.isResponseSuccess = YES;
                        repeater.responseValue = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData.cacheContent];
                        repeater.respondModal = DisplayCacheData;
//                        [self performSelectorOnMainThread:@selector(postNotificationToView:) withObject:repeater waitUntilDone:NO];
                        [self responseToView:repeater];
                        
                    }
                    @catch (NSException *exception)
                    {
                        repeater.responseValue = nil;
                        repeater.respondModal = DisplayServerData;
                    }
                    @finally
                    {
                        
                    }
                }
                else
                {
                    //清除缓存
                    [cacheManager clearCacheData:cacheData.cacheKey];
                    repeater.responseValue = nil;
                    repeater.respondModal = DisplayServerData;
                }
            }
        }
        else
        {
            repeater.responseValue = nil;
            repeater.respondModal = DisplayServerData;
        }

        
        if (repeater.respondModal == DisplayServerData)
        {
            // 网络请求
            [self requestServer:repeater];
        }
    }
}

/**
 * 功能描述: 更新缓存数据
 * 输入参数: repeater 数据转发器对象
 * 输出参数: N/A
 * 返 回 值: N/A
 */
- (void)updateCacheData:(DataRepeater *)repeater
{
    @autoreleasepool
    {        
        CacheManager *cacheManager = [[CacheManager alloc] init];
        //获取数据
        if (repeater.requestModal == PullData)
        {
            [cacheManager saveCacheData:repeater];
        }
        //推送数据
        else if (repeater.requestModal == PushData)
        {
            if (repeater.pushedCacheOperation != Cache_None)
            {
                [cacheManager updateCacheData:repeater];
            }
        }
    }
}

/**
 * 功能描述: 向页面发送通知
 * 输入参数: repeater 数据转发器对象
 * 输出参数: N/A
 * 返 回 值: N/A
 */
//-(void)postNotificationToView:(DataRepeater *)repeater {
//    
//    if (repeater.notificationName)
//    {
//        [[NSNotificationCenter defaultCenter] postNotificationName:repeater.notificationName
//                                                            object:repeater];
//    }
//}

- (void)responseToView:(DataRepeater *)repeater
{
    if (repeater.compleBlock != nil)
    {
        repeater.compleBlock(repeater);
    }
}

/**
 * 功能描述: 向页面发送服务器错误通知
 * 输入参数: repeater 数据转发器对象
 * 输出参数: N/A
 * 返 回 值: N/A
 */
-(void)postErrorNotificationToView:(DataRepeater *)repeater
{    
    [[NSNotificationCenter defaultCenter] postNotificationName:SERVER_ERROR_NOTIFICATION object:repeater];
}

@end
