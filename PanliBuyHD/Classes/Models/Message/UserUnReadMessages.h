//
//  UserUnReadMessages.h
//  PanliApp
//
//  Created by Liubin on 14-6-11.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

/**************************************************
 * 内容描述: 用户未读短信
 * 创 建 人: 刘彬
 * 创建日期: 2013-04-09
 **************************************************/
@interface UserUnReadMessages : NSObject<NSCoding>
{
    NSString       *_userId;
    int            _customerMsgCount;
    int            _sysmessMsgCount;
    NSMutableArray *_productObjIds;
    NSMutableArray *_shipObjIds;
    NSMutableArray *_parcelObjIds;
}

/**
 *用户ID
 */
@property (nonatomic, retain) NSString *userId;

/**
 *客服短信数量
 */
@property (nonatomic, assign) int customerMsgCount;

/**
 *系统短信数量
 */
@property (nonatomic, assign) int sysmessMsgCount;

/**
 *未读短信商品ID列表
 */
@property (nonatomic, retain) NSMutableArray *productObjIds;

/**
 *未读短信运单ID列表
 */
@property (nonatomic, retain) NSMutableArray *shipObjIds;

/**
 *未读短信包裹ID列表
 */
@property (nonatomic, retain) NSMutableArray *parcelObjIds;

@end
