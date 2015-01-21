//
//  DataRequestManager.h
//  PanliApp
//
//  Created by Liubin on 13-4-10.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataRepeater.h"

/**************************************************
 * 内容描述: 数据请求管理类
 * 创 建 人: 刘彬
 * 创建日期: 2013-04-10
 **************************************************/
@interface DataRequestManager : NSObject



+(DataRequestManager *)sharedInstance;

- (void)sendRequest:(DataRepeater *)repeater;
- (void)responseRequest:(DataRepeater *)repeater;

@end
