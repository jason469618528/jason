//
//  ConfigMacro.h
//  PanliApp
//
//  Created by Liubin on 14-4-3.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

/**************************************************
 * 内容描述: 环境配置
 * 创 建 人: 刘彬
 * 创建日期: 2014-04-03
 **************************************************/
#ifndef PanliApp_ConfigMacro_h
#define PanliApp_ConfigMacro_h

/**
 *环境配置开关,发布时请注释此宏
 */
#define DEBUG_FLAG

#ifdef DEBUG_FLAG
/***************开发环境*******************/
#define DLOG(...)           NSLog(__VA_ARGS__)
#define BASE_VERSIONURL     @"http://172.20.7.232:4001/Route.json"  // 路由请求地址

#define BASE_URL            @"http://172.20.7.232:8089/API/"         // 路由
//#define BASE_URL            [GlobalObj getRouteUrl]         // 路由

#define CLIENT_VERSION      @"5.2.0.i_dev"                          // 版本信息
#define PAYPAL_APPID        @"APP-80W284485P519543T"                // paypalID
#define PAYPAL_RECIPIENT    @"kaifa_1354167146_biz@panli.net"       // paypal账号
#define PAYPAL_PAYPALSTATE  ENV_SANDBOX                             // paypal充值环境
#define PAYPAL_ENVIRONMENT  PayPalEnvironmentSandbox                // paypal支付环境
#else
/***************正式环境*******************/
#define DLOG(...)
#define BASE_VERSIONURL     @"http://nav.panlidns.com/Route.json"    // 路由请求地址
#define BASE_URL            [GlobalObj getRouteUrl]                  // 路由
#define CLIENT_VERSION      @"3.1.0.i_rel"                           // 版本信息
#define PAYPAL_APPID        @"APP-51L458948G839561V"                 // paypalID
#define PAYPAL_RECIPIENT    @"paypal@panli.com"                      // paypal账号
#define PAYPAL_PAYPALSTATE  ENV_LIVE                                 // paypal充值环境
#define PAYPAL_ENVIRONMENT  PayPalEnvironmentProduction              // paypal支付环境
#endif

#define PAYPAL_CLIENTID_SANDBOX  @"AQCcSRBJlA3zr7fV9VANlFicRJgL1QGyCtCPWozFVpfpWpl507zcLP2GYfrA" // paypal 线下 Client ID
#define PAYPAL_CLIENTID_LIVE     @"AdbvWxDQtJlmwuaVHnSYU-hBBg155J_0SaOMAuGPXOZG7_AW7IJpYPp5C28z" // paypal 线上 Client ID

#endif
