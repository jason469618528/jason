//
//  CommonEnum.h
//  PanliApp
//
//  Created by Liubin on 14-4-3.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

/**************************************************
 * 内容描述: 系统公共枚举
 * 创 建 人: 刘彬
 * 创建日期: 2013-04-09
 **************************************************/
#ifndef PanliApp_CommonEnum_h
#define PanliApp_CommonEnum_h

/**
 *页面请求类型
 */
typedef enum
{
    //页面向服务器推送数据
    PushData,
    //页面向服务器拉取数据
    PullData
}RequestModal;

/**
 *页面响应类型
 */
typedef enum
{
    //当本地缓存没有数据或本地缓存失效，请求服务器数据页面显示等待状态
    DisplayLoading,
    //本地缓存数据有效，直接显示本地缓存数据
    DisplayCacheData,
    //访问服务器结束，返回显示
    DisplayServerData
}RespondModal;

/**
 *页面向服务器推送数据后，cacha数据库操作
 */
typedef enum
{
    //无操作
    Cache_None,
    //插入数据
    Cache_Insert,
    //删除数据
    Cache_Delete
}PushedCacheOperation;

/**
 *用户组类型枚举
 */
typedef enum
{
    //普通用户
    NormalUser = 0,
    //金卡用户
    GoldCard = 1,
    //白金卡用户
    PlatinumCard = 2,
    //钻石卡用户
    DiamondCard = 3,
    //皇冠卡用户
    CrownCars = 4,
    
}UserGroupType;

/**
 *系统消息类型枚举
 */
typedef enum
{
    //用户间的私信
    Private = 0,
    //网站公告
    Notice = 1,
    //团购通知
    ShopGroupNotification = 11,
    //优惠券通知
    CouponNotification = 31,
    //线下充值审核通知
    LocalRechargeNotification = 41,
    //其他通知
    OtherNotification = 99,
    
}SysMsgType;

/**
 *用户短信objtype枚举
 */
typedef enum
{
    //商品短信
    OrderMessage = 0,
    //运单短信
    ShipMessage = 1,
    //包裹短信
    PackageMessage = 2,
}MessageType;

/**
 *用户商品状态枚举
 */
typedef enum
{
    //未处理
    ProductUnhandled = 1,
    //处理中
    ProductProcessing = 2,
    //订购中
    Purchasing = 3,
    //已订购
    Pruchased = 4,
    //无货
    OutOfStock = 5,
    //无效商品
    InvalidProduct=6,
    //问题商品
    IssueProduct = 7,
    //退货处理中
    ExchangeHandling = 8,
    //联系卖家中
    UnableToContactSeller = 9,
    //商品已到
    ProductAccepted = 10,
    //拼单失败
    JoinBuyError = 11,
    //无需展示状态
    GoodsReturned = -1,
    
}UserProductStatus;

/**
 *运单状态
 */
typedef enum
{
    //未处理
    ShipUnhandled = 0,
    //已接单
    OrderReceived = 1,
    //发货中
    Deliverying = 2,
    //已发货
    Deliverd = 3,
    //信息错误
    IncorrectInfo = 4,
    //已出关退包
    ChuguanPackageReturned = 5,
    //未出关退包
    WeichuguanPackageReturned = 6,
    //重发
    RedeliveredFreely = 7,
    //付费重发
    Redeliverd = 8,
    //二次免费重发
    RedeliverdDually = 9,
    //包裹二次退回
    PackageReturnedDually = 10,
    //处理中
    ShipProcessing = 11,
    //运输方式错误
    Untransportable = 12,
    //确认收包
    Received = -1,
    //取消
    Canceled = -2,
    //财务审核完成
    Audited = -3,
    //状态出错
    StateError = 99,
    
}ShipStatus;



/**
 *优惠券枚举
 */
typedef enum
{
    //未激活
    Unactivated = 0,
    //待使用
    ToUseThe = 1,
    //已使用
    HasBeenUsed = 2,
    //过期的
    OverDue = 4,
    //失效的
    Disabled = 5,
    //快过期了(待使用)
    Unvalid = 6,
    
}CouponStatus;

/**
 *运单
 */
typedef enum
{
    //处理中（默认）
    InHand=11,
    //已发货
    Delivered=3,
    //确认收包
    AffirmReceivePackage=-1,
    //未处理
    Untreated=0,
    //待确认
    ToBeConfirmed=4,
    
}ShipOrderStatus;


/**
 *冲值
 */
typedef enum  PaymentStatuses
{
    PAYMENTSTATUS_SUCCESS,
    PAYMENTSTATUS_FAILED,
    PAYMENTSTATUS_CANCELED,
}PaymentStatus;

/**
 *运单显示状态
 */
typedef enum  ShipState
{
    //已发货
    YFHWay = 0,
    //待确认
    DCLWay = 1,
    //处理中
    CLCWay = 2,
    //未处理
    WCLWay = 3,
    //已收货
    YSHWay=4,
    //已取消
    shipCanceled = 5,
    
}ShipDisState;

/**
 *商品显示状态
 */
typedef enum  OrderState
{
    YetDGOrder = 1,
    Inpanli = 2,
    IssueOrder = 3,
    UntreatedOrder = 4,
    Inhand = 5,
    InvalidOrder = 6,
    
}OrderDisState;

/**
 *Notificationtype推送
 */
typedef enum  notificationType
{
    //通用
    Common = 1,
    
    //商品已到
    ArrivedPanli = 2,
    
    //运单已发货
    ShipDeliveryed = 3,
    
    //客服短信
    CustomerMessage= 4,
    
    //团购消息
    TuanMessage = 5,
    
    //免打扰
    NoDisturb = 6,
    
}NotificationTypeState;

/**
 *Notificationtype推送
 */
typedef enum  EstimatesType
{
    //代购
    AgencyBuy =1,
    //自助购
    OwnBuy = 2,
    //国际转运
    InternationalShip=3,
    
    
}EstimatesTypeState;

/**
 *团购类型
 */
typedef enum GroupBuyType
{
    //团单品
    ProductGroup = 0,
    //团店铺
    ShopGroup = 1,
    
}GroupBuyTypeState;

/**
 *优惠类型
 */
typedef enum  PreferentialType
{
    //按价格优惠（满多少件多少钱）
    PriceBased =1,
    //按总件数优惠（满多少件多少折）
    QuantityBased = 2,
    //按总金额优惠（满多少钱多少折）
    TotalValueBased = 3,
    
}PreferentialTypeState;

/**
 *团购范围
 */
typedef enum GroupBuyRange
{
    //全部商品
    AllProduct = 0,
    //指定商品
    AppointProduct = 1,
    //正价商品
    NoDiscountProduct =2,
    
}GroupBuyRangeState;

/**
 *我开的团状态
 */
typedef enum MyCreateGroupBuyType
{
    // 团购中
    GroupPurchasing = 1,
    //待审核
    Unaudited = 2,
    // 未通过审核
    NotApproved = 3,
    //审核通过
    Approved = 4,
    //已截团
    Ended = 5,
    //成功截团
    SuccessfulEnd = 6,
    //组团失败
    FailedTour = 7,
}MyCreateGroupBuyState;



/**
 *优惠券来源状态
 */
typedef enum MyCouponSourceType
{
    //积分兑换
    PointReward = 1,
    //商城购买
    Bought = 2,
    //活动发放
    Promotion = 3,
    //他人赠送
    Gift = 4,
    //抽奖获得
    LuckyDraw = 5,
    //抽奖获得
    NewYearLuckyDraw = 6,
    //优秀分享
    SetExcellent = 7,
    //活动发放
    DHL6Year = 8,
    //活动发送
    MayPaypalTaiwan = 9,
    //注册
    Resister30NotConsumption = 10,
    //系统赠送
    SystemGiving = 11,
    //活动放
    Localizedmarketing = 12,
}MyCouponSourceState;


typedef enum HelpBuySourceType
{
    //淘宝
    taobao = 1,
    //京东
    jd = 2,
    //当当
    dangdang = 3,
    //易讯
    yixun = 4,
    //亚马逊
    amazon = 5,
    //拍拍
    paipai = 6,
    //凡客
    vancl = 7,
    //唯品会
    vip = 8,
}HelpBuySourceState;


#endif
