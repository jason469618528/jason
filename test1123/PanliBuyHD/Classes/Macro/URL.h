//
//  URL.h
//  PanliApp
//
//  Created by Liubin on 13-4-10.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

/**************************************************
 * 内容描述: 服务器接口URL宏
 * 创 建 人: 刘彬
 * 创建日期: 2013-04-07
 **************************************************/
#ifndef PanliApp_URL_h
#define PanliApp_URL_h

/**
 *图文详情Url拼接
 */
#define URL_DETAIL @"content/prodescription.aspx?mark=%@"

#define URL_GUIDE_DETAIL @"content/guideqacontent.aspx?id=%d"

#define FACEBOOKLOGIN_URL @"content/facebooklogon.aspx?id=panli"

#define URL_LIVE800 @"content/live800.aspx?id=panli"

/**
 *接口url
 */
#pragma mark - request url
//用户路由
#define RQNAME_GETROUTE @"GetRouteUrl"


//用户资料获取 (7.1)
#define RQNAME_USERINFOS @"User/UserInfos.json"

//用户登录 (7.2)
#define RQNAME_USERLOGIN @"User/logon.json"

//获取优惠券 (7.25.1)
#define RQNAME_GETCOUPON_ORDER @"User/Coupon.json/order"
#define RQNAME_GETCOUPON_MYPANLI @"User/Coupon.json/mypanli"

//获取用户订单列表 (7.4)
#define RQNAME_USERORDERS @"Order/GetuserOrders.json"


//获取用户运单列表 (7.5)
//1.全部运单信息
#define RQNAME_USERSHIPORDERSALLSHIP @"Ship/GetUserShipOrders.json/AllShip"
//2.已发货运单信息
#define RQNAME_USERSHIPORDERSSHIPPEDSHIP @"Ship/GetUserShipOrders.json/ShippedShip"
//3.问题运单信息
#define RQNAME_USERSHIPORDERSISSUESHIP @"Ship/GetUserShipOrders.json/IssueShip"


//获取运单详细 (7.6)
#define RQNAME_USERSHIPDETAIL @"Ship/GetShipDetail.json"

//获取运单物流信息 (7.7)
#define RQNAME_USERSHIPEXPRESS @"Ship/Express.json"
#define RQNAME_USERSHIPEXPRESS_SHIPDETAIL @"Ship/Express.json/ShipDetail"
#define RQNAME_USERSHIPEXPRESS_SHIPLIST @"Ship/Express.json/ShipList"
//获取用户短信主题列表 (7.8)
#define RQNAME_USERMESSAGETOPICS @"Message/GetUserMessageTopics.json"

//获取用户短信回复详细 (7.9)
#define RQNAME_USERMESSAGEDETAIL @"Message/GetMessageDetail.json"

//根据短信主题ID发送短消息 (7.10)
#define RQNAME_SENDMESSAGEBYTOPICID @"Message/SendMessageByTopicId.json"

//根据对象ID发送短消息 (7.11)
#define RQNAME_SENDMESSAGEBYOBJECTID @"Message/SendMessageByObjectId.json"

//获取用户系统短信 (7.12)
#define RQNAME_GETSYSMSG @"Message/GetSysMsg.json"

//标记系统短信为已读 (7.13)
#define RQNAME_SETSYSMESSAGEISREAD @"Message/SetSysMessageIsRead.json"

//获取配置文件 (7.14)
#define RQNAME_APPINIT @"app/AppInit.json"

//获取商品流转信息 (7.15)
#define RQNAME_GETPRODUCTSTATUSRECORD @"Order/GetProductStatusRecord.json"

//获取运单流转信息 (7.16)
#define RQNAME_GETSHIPSTATUSREORD @"Ship/GetShipStatusRecord.json"

//获取商品物流跟踪信息 (7.17)
#define RQNAME_GETPRODUCTEXPRESS @"Order/GetProductExpress.json"

//生成订单充值 (7.18)
#define RQNAME_RECHARGEORDERCREATE @"Payment/RechargeOrderCreate.json"

//Paypal充值对账接口 (7.19)
#define RQNAME_PAYPALRECHARGENOTIFY @"Payment/PaypalRechargeNotify.json"

//获取充值信息 (7.20)
#define RQNAME_RECHARGEINFO @"Payment/RechargeInfo.json"

//意见反馈 (7.21)
#define RQNAME_ADDFEEDBACK @"Feedback/AddFeedBack.json"

//确认收货 (7.22.1)
#define RQNAME_CONFIRMRECEIVED @"Ship/ConfirmReceived.json"

//运单评价 (7.22.2)
#define RQNAME_SHIPRATE @"Ship/Rate.json"

//获取各种状态运单最新动态数量 (7.22.3)
#define RQNAME_STATENUMBER @"Ship/StateNumber.json"

//获取运送方案 (7.22.4)
#define RQNAME_DELIVERYSOLUTION @"Ship/DeliverySolution.json"

//提交运单 (7.22.5)
#define RQNAME_SUBMITSHIPORDER @"Ship/SubmitShipOrder.json"

//撤销运单 (7.22.6)
#define RQNAME_CANCELSHIPORDER @"Ship/CancelShipOrder.json"

//获取运单评价 (7.22.7)
#define RQNAME_SHIPREVIEW @"Ship/Review.json"

//修改商品备注 (7.23.1)
#define RQNAME_PRODUCTREMARK @"Product/Remark.json"

//获取国家列表 (7.24.1)
#define RQNAME_GETCOUNTRY @"Data/Country.json"

//获取问题列表 (7.24.3)
#define RQNAME_GETGUIDE @"Data/Guides.json"

//获取优惠券 (7.25.1)
#define RQNAME_GETCOUPON @"User/Coupon.json"

//新增,更新送货地址 (7.25.2) [post 方法]
#define RQNAME_UPDATADELIVERYADDRESS @"User/DeliveryAddress.json"

//获取我的送货地址  (7.25.3) [get 方法]
#define RQNAME_GETDELIVERYADDRESS @"User/DeliveryAddress.json/GetAddress"

//获取各种状态订单最新动态数量 (7.26.1)
#define RQNAME_GETORDERSSTATENUMBER @"Order/StateNumber.json"

//删除商品 (7.26.2)
#define RQNAME_DELETEPRODUCT @"Order/DeleteProduct.json"

//根据OBECTID获取短信聊天记录 (7.27.1)
#define RQNAME_CONSULTINGMESSAGELISTBYOBJECTID @"Message/ConsultingMEssageLIstByObjectID.json"

//获取可拼单的商品  (7.28.1)
#define RQNAME_PIECE_GETPRODUCTLIST @"Piece/Products.json"

//拼单购支付 (7.28.2)
#define RQNAME_PIECE_PAY @"Piece/Pay.json"

//获取拼单购商品详情属性信息 (7.28.3)
#define RQNAME_PIECE_PRODUCTDETAIL @"Piece/ProductDetail.json"

//获取首页拼单购 (7.28.4)
#define RQNAME_PIECE_INDEX @"Piece/SimpleProducts.json"

//获取我的购物车 (7.29.1)
#define RQNAME_SHOPCART_LIST @"Cart/List.json"

//购物车确认支付   (7.29.2)
#define RQNAME_SHOPCART_PAY @"Cart/Pay.json"

//批量删除购物车商品   (7.29.3)
#define RQNAME_SHOPCART_DELETEPRODUCTS @"Cart/DeleteProducts.json"

//修改购物车商品的数量 (7.29.4)
#define RQNAME_SHOPCART_PRODUCTCOUNT @"Cart/SetProductCount.json"

//更改购物车备注  (7.29.5)
#define RQNAME_SHOPCART_REMARKS @"Cart/SetProductRemark.json"

//获取用户配置信息  (7.30.1)
#define RQNAME_USERCONFIG @"Config/UserConfig.json"

//更新用户配置信息  (7.30.2)
#define RQNAME_UPDATEUSERCONFIG @"Config/UpdateUserConfig.json"

//版本检查  (7.30.3)
#define RQNAME_CHECKUPDATA @"App/CheckUpdate.json"

//费用估算   (7.31.1)
#define RQNAME_ESTIMATES @"Tools/Estimates.json"

//账户消费记录
#define RQNAME_USER_ACCOUNTRECORDS @"User/AccountRecords.json"

//积分兑换优惠券
#define RQNAME_USER_SCOREEXCHANGE @"User/ScoreExchange.json"

//删除用户送货地址
#define RQNAME_USER_DELETEDELIVERYADDRESS @"User/DeleteDeliveryAddress.json"

//app 2.0 新增接口

//搜索商品  (by keyword 7.32.1)
#define RQNAME_SEARCHPRODUCTS @"Search/Search.json"

//店铺商品 (7.32.2)
#define RQNAME_GETPRODUCTBYSHOP @"Product/GetProductByShop.json"

//获取商品类别 ( 7.32.3)
#define RQNAME_ALLCATEGORY @"Category/AllCategory.json"

//获取自定义分类 ( 7.32.4)
#define RQNAME_CUSTOMCATEGORY @"Category/CustomCategory.json"

//添加商品到收藏夹 (7.33.1)
#define RQNAME_ADDPRODUCTTOFAVORITES @"Favorites/AddFavorite.json"

//添加店铺到收藏夹 (7.33.2)
#define RQNAME_ADDSHOPSTOFAVORITES @"Favorites/AddFavoriteShop.json"

//商品详情 (7.33.3)
#define RQNAME_FAVORITESPRODUCTDETAIL @"Product/ProductDetail.json"

//店铺详情 (7.33.4)
#define RQNAME_FAVORITESSHOPDETAIL @"Shop/ShopDetail.json"

//删除收藏商品 or 删除店铺 (7.33.5)
#define RQNAME_DELETEFAVORITES @"Favorites/DeleteFavoriteOrShop.json"
#define RQNAME_DELETEFAVORITES_ShopDetail @"Favorites/DeleteFavoriteOrShop.json/ShopDetail"
#define RQNAME_DELETEFAVORITES_FaList @"Favorites/DeleteFavoriteOrShop.json/FaList"
#define RQNAME_DELETEFAVORITES_ProductDetail @"Favorites/DeleteFavoriteOrShop.json/ProductDetail"
#define RQNAME_DELETEFAVORITES_CATEGORYORTAG @"Favorites/DeleteFavoriteOrShop.json/CategoryOrTag"

/****************获取收藏商品列表 or 专辑 or 收藏店铺列表  (7.33.6)**************/
//获取收藏商品
#define RQNAME_LIST_FAVORITES_ORDERS @"Favorites/FavoriteOrShopList.json/Orders"

//获取关注类别(专辑)列表
#define RQNAME_FAVORITE_GETCATEGORY_LIST @"Favorites/GetCategoryOrTagFavoriteList.json"

//获取收藏店铺
#define RQNAME_FAVORITESSHOPS_LIST @"Favorites/FavoriteOrShopList.json/Shops"

//添加商品到购物车  (7.33.7)
#define RQNAME_ADDTOCART @"Cart/AddToShoppingCart.json"

//获取商品详情
#define RQNAME_GETUSERPRODUCT  @"Order/GetUserProduct.json"

//获取购物车商品数量
#define RQNAME_NUMOFSHOPPINGCART  @"Cart/NumOfShoppingCart.json"

//用户注册  （7.34.1）
#define RQNAME_REGISTER  @"User/Register.json"

//验证邮箱  （7.34.1）
#define RQNAME_REGISTER_CHECKEMAIL  @"User/Register.json/CheckEmail"

//验证用户名  （7.34.1）
#define RQNAME_REGISTER_CHECKUSERNAME  @"User/Register.json/CheckUserName"

//团购列表   (7.36.1)
#define RQNAME_TUAN_TUANLIST  @"Tuan/List.json"

//团店铺内商品列表 (7.36.2)
#define RQNAME_TUAN_TUANSHOPPRODUCTSLIST  @"Tuan/ShopProductList.json"

//我开的团   (7.36.3)
#define RQNAME_TUAN_MYKAITUAN  @"Tuan/KaiTuanList.json"

//我抱的团   (7.36.4)
#define RQNAME_TUAN_MYBAOTUAN  @"Tuan/BaoTuanList.json"

//开团   (7.36.5)
#define RQNAME_TUAN_KAITUAN  @"Tuan/KaiTuan.json"

//抱团   (7.36.6)
#define RQNAME_TUAN_BAOTUAN  @"Tuan/BaoTuan.json"

//团商品详情   (7.36.7)
#define RQNAME_TUAN_PRODUCTDETAIL  @"Tuan/TuanSnatchProduct.json"

//团消息列表   (7.36.8)
#define RQNAME_TUAN_MESSAGES  @"Tuan/TuanMessages.json"

//发消息   (7.36.9)
#define RQNAME_TUAN_SENDMESSAGE  @"Tuan/SendMessage.json"

//获取团封面  (7.36.10)
#define RQNAME_TUAN_INDEX  @"Tuan/TuanFrontCover.json"

//专题列表   (7.37.1)
#define RQNAME_SPECIAL_TOPICS   @"SpecialRecommend/Topics.json"

//专题分区   (7.37.2)
#define RQNAME_SPECIAL_PARTS   @"SpecialRecommend/Parts.json"

//删除分区内商品
#define RQNAME_SPECIAL_DELETESRPRODUCT   @"SpecialRecommend/DeleteSRProduct.json"

//获取商品图片   (7.38.1)
#define RQNAME_COMMON_GETPRODUCTIMGURL    @"Common/GetProductImgUrl.json"

//摇奖 (7.38.2)
#define RQNAME_ACTIVITY_GETPRIZE    @"Activity/GetPrize.json"

//中奖记录 (7.38.3)
#define RQNAME_ACTIVITY_USERPRIZE    @"Activity/UserPrizes.json"

//活动状态 (7.38.4 无)
#define RQNAME_ACTIVITY_ACTIVITYSTATUS    @"Activity/ActivityStatus.json"

//问答 (7.38.5)
#define RQNAME_PANLIROBOT_QALIST    @"PanliRobot/QAList.json"

//首页广告栏 (7.39.1)
#define RQNAME_ADVERTINFO @"Advert/AdvertInfo.json"

//已收货商品列表
#define RQNAME_USERSHARE_RECEIVEDPRODUCTS @"ReceivedProducts"

//已分享商品列表
#define RQNAME_USERSHARE_SHAREDPRODUCTS @"ShareedProducts"

//已赞商品列表
#define RQNAME_USERSHARE_PRAISEDPRODUCTS @"PraisedProducts"

//添加分享
#define RQNAME_SHARE_MakeShare @"Share/MakeShare.json"

//分享购列表
//首页
#define RQNAME_SHARE_SHAREPRODUCTS_INDEX @"Share/ShareProducts.json/Index"
//分享购首页
#define RQNAME_SHARE_SHAREPRODUCTS_SHAREBUY_HOME @"Share/ShareProducts.json/ShareBuyHome"

//类目
#define RQNAME_SHARE_SHAREPRODUCTS_CATEGORY @"Share/ShareProducts.json/Category"

//获取分享详情
#define RQNAME_SHARE_USERSHAREDETAILS @"Share/UserShareDetails.json"

//获取分享购话题列表
#define RQNAME_SHARE_SHARETOPICS_HOME @"Share/ShareTopics.json/Home"
#define RQNAME_SHARE_SHARETOPICS_USERSHARE @"Share/ShareTopics.json/UserShare"

//获取分享购话题关联的分享信息
#define RQNAME_SHARE_SHARETOPICRELATEDSHAREPRODUCTS @"Share/ShareTopicRelatedShareProducts.json"

//赞与取消赞
#define RQNAME_SHARE_SHAREBUYPRAISE @"Share/MakePraise.json"

//用户是否赞过
#define RQNAME_SHARE_ISPRAISEDBYSELF @"Share/IsPraisedBySelf.json"

//联合登录
#define RQNAME_LOGIN_FACEBOOKUNIONLOGON @"User/UnionLogon.json"
//上传头像
#define RQNAME_USER_UPLOADAVATAR @"User/UploadAvatar.json"

//修改登录密码
#define RQNAME_USER_MODIFYPASSWORD @"User/ModifyPassword.json"


/**************************************************
 **************************************************
 **************************************************
 短信信息
 **************************************************
 **************************************************
 **************************************************/
//获取用户未读短信
#define RQNAME_GETUSERUNREADMESSAGES @"Message/GetUserUnReadMessages.json"

#endif
