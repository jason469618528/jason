//
//  RequestMacro.h
//  PanliApp
//
//  Created by Liubin on 14-4-3.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

/**************************************************
 * 内容描述: 请求相关
 * 创 建 人: 刘彬
 * 创建日期: 2014-04-03
 **************************************************/
#ifndef PanliApp_RequestMacro_h
#define PanliApp_RequestMacro_h

/*****************接口响应编码******************/
#define SERVER_SUCCESS   0    //服务器响应正常
#define USER_UNACTIVE    79   //用户未激活
#define VERSION_LOW      80   //客户端版本太低,需要更新
#define VERSION_ERROR    81   //客户端版本错误
#define CONFIG_LOW       82   //客户端配置文件版本过低
#define UNAUTHORIZED     83   //未经过登录授权认证
#define SERVER_ERROR     99   //服务器错误
#define CODE_ERROR       1000 //状态码解析错误
#define NETWORK_ERROR    101  //网络不通
#define SERVER_EXCEPTION 102  //服务器异常
#define TIMEOUT_ERROR    103  //请求超时
#define API_SUCCESS      1    //接口响应成功

/*****************接口响应参数******************/
#define RP_PARAM_STATUS         @"Status"
#define RP_PARAM_STATUS_CODE    @"StatusCode"
#define RP_PARAM_STATUS_MESSAGE @"StatusMessage"
#define RP_PARAM_RESULT         @"Result"
#define RP_PARAM_VERSION        @"Version"
#define RP_PARAM_DATE           @"Date"

/*****************响应超时定义******************/
#define TIMEOUT_S 15
#define TIMEOUT_M 30
#define TIMEOUT_L 45

/*****************请求通知定义******************/
#define SERVER_ERROR_NOTIFICATION  @"SERVER_ERROR_NOTIFICATION"

#define TABBAR_NEW_NOTIFICATION    @"TABBAR_NEW_NOTIFICATION"
#define TABBAR_NONE_NOTIFICATION   @"TABBAR_NONE_NOTIFICATION"

/*****************国际化通知定义******************/
#define CHANGE_LANGUAGE_NOTIFICATION    @"CHANGE_LANGUAGE_NOTIFICATION"

#endif
