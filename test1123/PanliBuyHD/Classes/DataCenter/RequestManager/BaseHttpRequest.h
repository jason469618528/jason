//
//  BaseHttpRequest.h
//  PanliApp
//
//  Created by Liubin on 13-4-10.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "DataRepeater.h"
#import "ErrorInfo.h"
#import "JSON.h"
#import "NSUserDefaults+Helper.h"

@class DataRepeater;

/**************************************************
 * 内容描述: Http请求基类
 * 创 建 人: 刘彬
 * 创建日期: 2013-04-10
 **************************************************/
@interface BaseHttpRequest : NSObject<ASIHTTPRequestDelegate>
{
    /**
     *请求标签
     */
    NSString *tag;
    
    ASIHTTPRequest *_request;
    id _repteater;
    int _timeout;
    int _threadId;
}


/**
 *asi请求对象
 */
@property (nonatomic,strong) ASIHTTPRequest *request;

/**
 *数据请求转发器对象
 */
@property (nonatomic,strong) DataRepeater *repeater;

/**
 *超时时间
 */
@property (nonatomic,unsafe_unretained) int timeout;

/**
 *线程ID
 */
@property (nonatomic,unsafe_unretained) int threadId;

/**
 * 功能描述: 发送http请求
 * 输入参数: repeater 数据请求转发器
 * 输出参数: N/A
 * 返 回 值: N/A
 */
- (void)sendRequest:(id)repeater;

/**
 * 功能描述: 设置请求头
 * 输入参数: repeater 数据请求转发器
 * 返 回 值: N/A
 */
- (void)setHeader;

/**
 * 功能描述: check状态码
 * 输入参数: jsonValue json
 * 返 回 值: 错误信息
 */
- (ErrorInfo *)checkResponseError:(NSDictionary*)jsonValue;

@end
