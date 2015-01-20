//
//  MySelectGroupBuy.h
//  PanliApp
//
//  Created by jason on 13-8-16.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyJoinGroupBuy : NSObject <NSCoding>
{
    int _tuanId;
    NSString *_groupName;
    int _groupType;
    NSMutableArray *_products;
}

/**
 *团id，标识列
 */
@property (nonatomic, assign) int tuanId;

/**
 *标题
 */
@property (nonatomic, retain) NSString * groupName;

/**
 *0 单品，1 店铺
 */
@property (nonatomic, assign) int groupType;

/**
 *团内购买商品
 */
@property (nonatomic, retain) NSMutableArray *products;

@end
