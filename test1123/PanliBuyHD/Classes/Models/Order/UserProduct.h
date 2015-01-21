//
//  UserProduct.h
//  PanliApp
//
//  Created by jason on 13-4-15.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "Product.h"

@interface UserProduct : Product

{
    int  _userProductId;
    int  _count;
    int  _weight;
    NSString * _weightDate;
    NSString * _remark;
    UserProductStatus  _userProductStatus;
    BOOL _isGroup;
    BOOL _isPiece;
    BOOL _isGift;
    BOOL _isForbidden;
    
    BOOL _isLightOverWeight;
    BOOL _isHeavyOverWeight;
    BOOL _canReturns;
    BOOL _canDeliver;
    BOOL _isYellowWarning;
    BOOL _isRedWarning;
    NSString * _expressUrl;
    NSString * _expressNo;
    int _status;
    NSString *_sendMessageId;
    NSString *_orderDate;
    NSString *_skuRemark;
    
    BOOL _haveUnreadMessage;
    BOOL _isSelected;
}

/**
 *用户商品ID
 */
@property (nonatomic,assign) int   userProductId;

/**
 *商品数量
 */
@property (nonatomic,assign) int   count;

/**
 *商品重量
 */
@property (nonatomic,assign) int   weight;

/**
 *入库时间
 */
@property (nonatomic, strong) NSString *  weightDate;

/**
 *商品备注
 */
@property (nonatomic, strong) NSString *  remark;

/**
 *订单商品状态
 */
@property (nonatomic, assign) UserProductStatus   userProductStatus;

/**
 *团购商品
 */
@property (nonatomic,assign) BOOL isGroup;

/**
 *拼单购商品
 */
@property (nonatomic,assign) BOOL isPiece;

/**
 *赠品
 */
@property (nonatomic,assign) BOOL isGift;

/**
 *是否为敏感物品
 */
@property (nonatomic,assign) BOOL isForbidden;

/**
 *是否超重
 */
@property (nonatomic,assign) BOOL isLightOverWeight;

/**
 *是否重抛
 */
@property (nonatomic,assign) BOOL isHeavyOverWeight;

/**
 *是否可退货
 */
@property (nonatomic,assign) BOOL canReturns;

/**
 *是否可提交运送
 */
@property (nonatomic,assign) BOOL canDeliver;

/**
 *保管期超过一个月，未超3个月，黄色警告
 */
@property (nonatomic,assign) BOOL isYellovWarning;

/**
 *保管期超过3个月，红色警告
 */
@property (nonatomic,assign) BOOL isRedWarning;

/**
 *物流地址
 */
@property (nonatomic, strong) NSString *  expressUrl;

/**
 *物流编号
 */
@property (nonatomic, strong) NSString *  expressNo;

@property (nonatomic, assign) int status;

/**
 *发送客服短信id
 */
@property (nonatomic, strong) NSString * sendMessageId;


/**
 *下单时间
 */
@property (nonatomic, strong) NSString * orderDate;

/**
 *sku备注
 */
@property (nonatomic, strong) NSString * skuRemark;

/**
 *是否有新短信
 */
@property (nonatomic, assign)  BOOL  haveUnreadMessage;

/**
 *是否选中
 */
@property (nonatomic, assign)  BOOL  isSelected;
@end
