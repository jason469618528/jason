//
//  ShipOrder.h
//  PanliApp
//
//  Created by jason on 13-4-15.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShipOrder : NSObject<NSCoding>

{
    NSString * _orderId;
    int  _logisticsId;
    NSString * _expressUrl;
    NSString * _shipType;
    ShipStatus  _status;
    int  _userScore;
    float  _custodyPrice;
    float  _couponPrice;
    NSString * _shipDeliveryName;
    NSString * _packageCode;
    
    float  _shipPrice;
    float  _servicePrice;
    float  _giftPrice;
    float  _entryPrice;
    float  _promotionPrice;
    int  _totalWeight;
    NSString * _giftContent;
    NSString * _consignee;
    NSString * _telePhone;
    NSString * _postcode;
    
    NSString * _shipArea;
    NSString * _shipCountry;
    NSString * _shipAddress;
    NSString * _shipCity;
    NSString * _shipRemark;
    NSString * _dealDate;
    NSString * _confimDate;
    NSString * _createDate;
    NSString * _totalPrice;
    BOOL  _hasVoted;

    BOOL  _canCaneOrder;
    BOOL  _customService;
    NSMutableArray *_marray_Products;
    
    NSString *_lastText;
    NSString *_lastTime;
    
    BOOL _haveUnreadMessage;
    
    BOOL _havaRead;
}
//最后一条信息
@property (nonatomic, retain)  NSString *lastText;
//最后一条信息 时间
@property (nonatomic, retain) NSString * lastTime;
/**
 *运单号
 */
@property (nonatomic, retain) NSString *  orderId;

/**
 *运送方式(物流)
 */
@property (nonatomic,assign) int   logisticsId;

/**
 *物流Url
 */
@property (nonatomic, retain) NSString *  expressUrl;

/**
 *0.商品运单 1.包裹直运
 */
@property (nonatomic, retain) NSString * shipType;

/**
 *shipstatus枚举
 */
@property (nonatomic, assign) ShipStatus  status;

/**
 *国内转送扣除的积分
 */
@property (nonatomic,assign) int  userScore;

/**
 *保管费
 */
@property (nonatomic,assign) float   custodyPrice;

/**
 *优惠券折价
 */
@property (nonatomic,assign) float   couponPrice;

/**
 *运送方式
 */
@property (nonatomic, retain) NSString *  shipDeliveryName;

/**
 *包裹号
 */
@property (nonatomic, retain) NSString *  packageCode;

/**
 *运费 
 */
@property (nonatomic,assign) float   shipPrice;

/**
 *服务费
 */
@property (nonatomic,assign) float   servicePrice;

/**
 *礼品价格
 */
@property (nonatomic,assign) float   giftPrice;

/**
 *报关费
 */
@property (nonatomic,assign) float   entryPrice;

/**
 *优惠价格
 */
@property (nonatomic,assign) float   promotionPrice;

/**
 *运单重量
 */
@property (nonatomic,assign) int   totalWeight;

/**
 *赠言
 */
@property (nonatomic, retain) NSString *  giftContent;

/**
 *收货人
 */
@property (nonatomic, retain) NSString *  consignee;

/**
 *收货人电话 
 */
@property (nonatomic, retain) NSString *  telePhone;

/**
 *邮编
 */
@property (nonatomic, retain) NSString *  postcode;

/**
 *收货地区
 */
@property (nonatomic, retain) NSString *  shipArea;

/**
 *收货国家
 */
@property (nonatomic, retain) NSString *  shipCountry;

/**
 *收货人地址
 */
@property (nonatomic, retain) NSString *  shipAddress;

/**
 *收货城市
 */
@property (nonatomic, retain) NSString *  shipCity;

/**
 *运单备注
 */
@property (nonatomic, retain) NSString *  shipRemark;

/**
 *交易时间
 */
@property (nonatomic, retain) NSString *  dealDate;

/**
 *提交时间
 */
@property (nonatomic, retain) NSString *  confimDate;

/**
 *创建时间
 */
@property (nonatomic, retain) NSString *  createDate;

/**
 *总运费 
 */
@property (nonatomic, retain) NSString *  totalPrice;

/**
 *是否评价过
 */
@property (nonatomic,assign)BOOL hasVoted;

/**
 *是否允许撤销
 */
@property (nonatomic,assign) BOOL   canCaneOrder;

/**
 *是否可以联系客服 
 */
@property (nonatomic,assign) BOOL  customService;

/**
 *UserProducts对象
 */
@property(nonatomic,retain) NSMutableArray *marray_Products;


/**
 *是否有新短信
 */
@property (nonatomic, assign) BOOL haveUnreadMessage;

/**
 *动态信息是否已读
 */
@property (nonatomic, assign) BOOL haveRead;

@end
