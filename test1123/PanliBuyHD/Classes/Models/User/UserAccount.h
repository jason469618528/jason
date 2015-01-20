//
//  UserAccount.h
//  PanliApp
//
//  Created by jason on 14-5-13.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>
/**************************************************
 * 内容描述: 用户账户记录
 * 创 建 人: jason
 * 创建日期: 2014-5-13
 **************************************************/
@interface UserAccount : NSObject
{
    NSString *_flowNo;
    int _type;
    float _amount;
    float _balance;
    NSString *_description;
    NSString *_tradeTime;
}
/**
 *流水号
 */
@property (nonatomic, retain) NSString *flowNo;

/**
 *类型(1:收入 2:支出)
 */
@property (nonatomic, assign) int type;

/**
 *金额
 */
@property (nonatomic, assign) float amount;

/**
 *余额
 */
@property (nonatomic, assign) float balance;

/**
 *说明
 */
@property (nonatomic, retain) NSString *description;

/**
 *交易时间
 */
@property (nonatomic, retain) NSString *tradeTime;

- (id)initWithDictionary:(NSDictionary *)iDictionary;

@end
