//
//  UserInfo.h
//  PanliApp
//
//  Created by Liubin on 13-4-9.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

/**************************************************
 * 内容描述: 用户信息
 * 创 建 人: 刘彬
 * 创建日期: 2013-04-09
 **************************************************/
@interface UserInfo : NSObject<NSCoding>
{
    NSString      *_userId;
    NSString      *_nickName;
    float         _balance;
    int           _integration;
    UserGroupType _userGroup;
    NSString      *_avatarUrl;
    BOOL          _isApproved;
    NSString      *_emailSite;
    
    int _couponNumber;
    int _order_ProductAcceptedNumber;
    int _order_IssueProductNumber;
    int _order_ProcessingNumber;
    int _ship_DeliveredpNumber;
    int _ship_ForConfirmNumber;
}

/**
 *用户ID
 */
@property (nonatomic, strong) NSString *userId;

/**
 *用户昵称
 */
@property (nonatomic, strong) NSString *nickName;

/**
 *用户余额
 */
@property (nonatomic, unsafe_unretained) float balance;

/**
 *用户积分
 */
@property (nonatomic, unsafe_unretained) int integration;

/**
 *用户类型(0：普通用户 1：金卡用户 2：白金卡用户 3：钻石卡用户 4：皇冠卡用户)
 */
@property (nonatomic, unsafe_unretained) UserGroupType userGroup;

/**
 *用户头像url
 */
@property (nonatomic, strong) NSString *avatarUrl;

/**
 *账号是否已经激活
 */
@property (nonatomic, unsafe_unretained) BOOL isApproved;

/**
 *注册邮箱地址
 */
@property (nonatomic, strong) NSString *emailSite;


/**
 *优惠券数量
 */
@property (nonatomic, unsafe_unretained) int couponNumber;


/**
 *已到panli
 */
@property (nonatomic, unsafe_unretained) int  order_ProductAcceptedNumber;

/**
 *问题商品
 */
@property (nonatomic, unsafe_unretained) int order_IssueProductNumber;

/**
 *处理中
 */
@property (nonatomic, unsafe_unretained) int order_ProcessingNumber;

/**
 *已发货
 */
@property (nonatomic, unsafe_unretained) int  ship_DeliveredpNumber;

/**
 *问题运单
 */
@property (nonatomic, unsafe_unretained) int  ship_ForConfirmNumber;
@end
