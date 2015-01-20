//
//  ParameterMacro.h
//  PanliApp
//
//  Created by Liubin on 14-4-3.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

/**************************************************
 * 内容描述: 接口请求参数宏
 * 创 建 人: 刘彬
 * 创建日期: 2013-04-10
 **************************************************/
#ifndef PanliApp_ParameterMacro_h
#define PanliApp_ParameterMacro_h

/**
 *通用请求参数
 */
#define RQ_PUBLIC_PARAM_VERSION  @"ClientVersion" // 版本号
#define RQ_PUBLIC_PARAM_USERBILL @"Credential"    // 用户票据
#define RQ_PUBLIC_PARAM_LANGUAGE @"Language"      // 语言

/**
 *获取用户资料 (7.1.1)   (只需传版本号加票据就可)
 */

/**
 *版本号
 */
#define RQ_ROUTEURL_PARAM_VERSION @"version"

/**
 *获取用户信息
 */
#define RQ_USERINFOS_PARAM_USERINFO  @"userInfo"
#define RQ_USERINFOS_PARAM_MESSAGENO @"messageNo"
#define RQ_USERINFOS_PARAM_SYSMESSNO @"sysMessNo"
#define RQ_USERINFOS_PARAM_ORDERNO   @"orderNo"
#define RQ_USERINFOS_PARAM_SHIPNO    @"shipNo"

/**
 *上传头像
 */
#define RQ_USER_UPLOADAVATAR_PARM_PICFILE    @"picFile"

/**
 *修改登录密码
 */
#define RQ_USER_MODIFYPASSWORD_PARM_OLDPASSWORD @"oldPassword"
#define RQ_USER_MODIFYPASSWORD_PARM_NEWPASSWORD @"newPassword"

/**
 *用户登陆请求参数 (7.1.2)
 */
#define RQ_LOGIN_PARAM_USERNAME    @"username"
#define RQ_LOGIN_PARAM_PASSWORD    @"password"
#define RQ_LOGIN_PARAM_DEVICETOKEN @"deviceToken"
#define RQ_LOGIN_PARAM_LONGITUDE   @"longitude"
#define RQ_LOGIN_PARAM_LATITUDE    @"latitude"

/**
 *获取用户订单列表 (7.4)
 */
#define RQ_USERORDERS_PARAM_STATUS @"status"


/**
 *获取用户运单列表   (7.5)
 */
#define RQ_SHIPORDERS_PARAM_STATUS @"status"
#define RQ_SHIPORDERS_PARAM_INDEX  @"index"
#define RQ_SHIPORDERS_PARAM_COUNT  @"count"

/**
 *获取运单详细 (7.6)
 */
#define RQ_SHIPDETAIL_PARAM_SHIPID @"shipId"

/**
 *获取运单物流信息 (7.7)
 */
#define RQ_SHIPEXPRESS_PARAM_EXPRESSURL @"expressUrl"
#define RQ_SHIPEXPRESS_PARAM_EXPRESSNO  @"ExpressNo"

/**
 *获取用户短信主题列表 (7.8)
 */
#define RQ_USERMESSAGETOPICCS_PARAM_OBJECTTYPE @"objectType"
#define RQ_USERMESSAGETOPICCS_PARAM_INDEX      @"index"
#define RQ_USERMESSAGETOPICCS_PARAM_COUNT      @"count"

/**
 *获取用户短信回复详细 (7.9)
 */
#define  RQ_MESSAGEDETAIL_PARAM_TOPICID @"topicId"
#define  RQ_MESSAGEDETAIL_PARAM_INDEX   @"index"
#define  RQ_MESSAGEDETAIL_PARAM_COUNT   @"count"

/**
 *账户消费记录
 */
#define RQ_USER_ACCOUNTRECORDS_PARM_TYPE @"type"
#define RQ_USER_ACCOUNTRECORDS_PARM_PAGEINDEX @"pageIndex"
#define RQ_USER_ACCOUNTRECORDS_PARM_PAGESIZE @"pageSize"

/**
 *积分兑换优惠券
 */
#define RQ_USER_SCOREEXCHANGE_PARM_TYPE @"type"

/**
 *删除用户送货地址
 */
#define RQ_USER_DELETEDELIVERYADDRESS_PARM_ADDRESSID @"addressId"

//积分
#define RQNAME_USER_SCORERECORDS @"User/ScoreRecords.json"
/**
 *积分记录
 */
#define RQ_USER_SCORERECORDS_PARM_TYPE @"type"
#define RQ_USER_SCORERECORDS_PARM_PAGEINDEX @"pageIndex"
#define RQ_USER_SCORERECORDS_PARM_PAGESIZE @"pageSize"

/**
 *根据短信主题ID发送短信 (7.10)
 */
#define RQ_SENDMESSAGEBYTOPIDID_PARAM_TOPICID @"topicId"
#define RQ_SENDMESSAGEBYTOPIDID_PARAM_CONTENT @"content"

/**
 *根据对象ID发送短消息 (7.11)
 */
#define RQ_SENDMESSAGEBYOBJECTID_PARAM_OBJECTID   @"objectId"
#define RQ_SENDMESSAGEBYOBJECTID_PARAM_OBJECTTYPE @"objectType"
#define RQ_SENDMESSAGEBYOBJECTID_PARAM_CONTENT    @"content"

/**
 *获取用户系统消息 (7.12)
 */
#define RQ_SYSTEMMESSAGE_PARAM_INDEX @"index"
#define RQ_SYSTEMMESSAGE_PARAM_COUNT @"count"

/**
 *标记系统短信为已读 (7.13)
 */
#define RQ_SYSMESSAGEISREAD_PARAM_TOPICID     @"topicId"

/**
 *获取配置文件 (7.14)
 */
#define RQ_APPINIT_PARAM_CONFIGVERSION    @"configVersion"

/**
 *获取商品流转信息  (7.15)
 */
#define RQ_PRODUCTSTATUSRECORD_PARAM_PRODUCTID    @"productId"

/**
 *获取运单流转信息  (7.16)
 */
#define RQ_SHIPSTATUSRECORD_PARAM_SHIPID     @"shipId"

/**
 *获取商品物流跟踪信息  (7.17)
 */
#define RQ_PRODUCTEXPRESS_PARAM_EXPRESSURL    @"expressUrl"
#define RQ_PRODUCTEXPRESS_PARAM_EXPRESSNO     @"expressNo"

/**
 *生成充值订单  (7.18)
 */
#define RQ_RECHARGEORDERCREATE_PARAM_AMOUNT         @"amount"
#define RQ_RECHARGEORDERCREATE_PARAM_RECHARGETYPE   @"rechargeType"

/**
 *Paypal充值对账接口  (7.19)
 */
#define RQ_PAYPALRECHARGENOTIFY_PARAM_PAYKEY    @"payKey"

/**
 *获取充值信息  (7.20)    (只需传版本号加票据就可)
 */

/**
 *意见反馈  (7.21)
 */
#define RQ_ADDFEEDBACK_PARAM_CONTENT    @"content"

/**
 *确认收货 (7.22.1)
 */
#define RQ_CONFIMRECEIVED_PARAM_SHIPID    @"shipId"

/**
 *运单评价  (7.22.2)
 */
#define RQ_RATE_PARAM_SHIPID          @"shipId"
#define RQ_RATE_PARAM_CUSTOMERRATE    @"customerRate"
#define RQ_RATE_PARAM_DELIVERYRATE    @"deliveryRate"
#define RQ_RATE_PARAM_RECEIVERATE     @"receiveRate"
#define RQ_RATE_PARAM_GENERALRATE     @"generalRate"
#define RQ_RATE_PARAM_ADVICE          @"advice"


/**
 *获取各种状态运单最新动态数量 (7.22.3)  (只需传版本号加票据就可)
 */

/**
 *获取运送方案  (7.22.4)
 */
#define RQ_DELIVERYSOLUTION_PARAM_USERPRODUCTIDS    @"UserProductIds"
#define RQ_DELIVERYSOLUTION_PARAM_COUNTRYID         @"CountryID"

/**
 *提交运单  (7.22.5)
 */
#define RQ_SUBMITSHIPORDER_PARAM_SOLUTIONID       @"SolutionId"
#define RQ_SUBMITSHIPORDER_PARAM_COUPONS          @"Coupons"
#define RQ_SUBMITSHIPORDER_PARAM_USERADDRESSID    @"UserAddressId"
#define RQ_SUBMITSHIPORDER_PARAM_REMARK           @"Remark"
#define RQ_SUBMITSHIPORDER_PARAM_COUNTRYID        @"CountryId"
/**
 *撤销运单  (7.22.6)
 */
#define RQ_CANCELSHIPORDER_PARAM_SHIPID    @"shipId"

/**
 *获取运单评价 (7.22.7)
 */
#define RQ_REVIEW_PARAM_SHIPID    @"shipId"

/**
 *修改商品备注  (7.23.1)
 */
#define RQ_REMARK_PARAM_USERPRODUCTID    @"UserProductId"
#define RQ_REMARK_PARAM_REMARK           @"Remark"

/**
 *获取国家列表  (7.24.1)    (只需传版本号加票据就可)
 */

/**
 *获取问题列表  (7.24.3)
 */
#define RQ_GUIDE_PARAM_TYPE @"type"

/**
 *获取优惠券  (7.25.1)   (只需传版本号加票据就可)
 */

/**
 *新增,更新送货地址 (7.25.2)
 */
#define RQ_DELIVERYADDRESS_PARAM_ID             @"Id"
#define RQ_DELIVERYADDRESS_PARAM_CONSIGNEE      @"Consignee"
#define RQ_DELIVERYADDRESS_PARAM_ZIP            @"Zip"
#define RQ_DELIVERYADDRESS_PARAM_TELEPHONE      @"Telephone"
#define RQ_DELIVERYADDRESS_PARAM_COUNTRY        @"Country"
#define RQ_DELIVERYADDRESS_PARAM_CITY           @"City"
#define RQ_DELIVERYADDRESS_PARAM_ADDRESS        @"Address"
#define RQ_DELIVERYADDRESS_PARAM_DADDTIME       @"DAddtime"
#define RQ_DELIVERYADDRESS_PARAM_NCOUNTRYID     @"NCountryID"
#define RQ_DELIVERYADDRESS_PARAM_KEEPPACKING    @"KeepPacking"
#define RQ_DELIVERYADDRESS_PARAM_REMARK         @"Remark"

/**
 *获取我的送货地址  (7.25.3)  (只需传版本号加票据就可)
 */

/**
 *获取各种状态订单最新动态数量 (7.26.1)  (只需传版本号加票据就可)
 */


/**
 *删除送货车商品 (7.26.2)
 */
#define RQ_DELETEORDER_PARAM_PROID     @"proID"

/**
 *ObjectId获取短信聊天记录 (7.27.1)
 */
#define RQ_MESSAGEBYOBJECTID_PARAM_OBJECTID     @"objectId"
#define RQ_MESSAGEBYOBJECTID_PARAM_OBJECTTYPE   @"objectType"
#define RQ_MESSAGEBYOBJECTID_PARAM_INDEX        @"index"
#define RQ_MESSAGEBYOBJECTID_PARAM_PAGESIZE     @"pagesize"


/**
 *获取可拼单的商品  (7.28.1)
 */
#define RQ_JOINBUYPRODUCTS_PARAM_CATEGORYID @"categoryId"
#define RQ_JOINBUYPRODUCTS_PARAM_MINPRICE   @"minPrice"
#define RQ_JOINBUYPRODUCTS_PARAM_MAXPRICE   @"maxPrice"
#define RQ_JOINBUYPRODUCTS_PARAM_ORDERING   @"ordering"
#define RQ_JOINBUYPRODUCTS_PARAM_PAGEINDEX  @"pageIndex"
#define RQ_JOINBUYPRODUCTS_PARAM_PAGESIZE   @"pageSize"

/**
 *拼单购支付  (7.28.2)
 */
#define RQ_JOINBUYPAY_PARAM_PROID         @"proID"
#define RQ_JOINBUYPAY_PARAM_PAYFEIGHT     @"payFeight"
#define RQ_JOINBUYPAY_PARAM_COMBINATIONID @"combinationId"
#define RQ_JOINBUYPAY_PARAM_NUM           @"num"
#define RQ_JOINBUYPAY_PARAM_UNITPRICE     @"unitPrice"
#define RQ_JOINBUYPAY_PARAM_REMARK        @"remark"
#define RQ_JOINBUYPAY_PARAM_SKUREMARK     @"skuRemark"
/**
 *获取拼单购商品详细属性信息 (7.28.3)
 */
#define RQ_JOINBUYPRODUCTDETAIL_PARAM_PROURL @"proUrl"
#define RQ_JOINBUYPRODUCTDETAIL_PARAM_PROID  @"proID"

/**
 *获取我的购物车  (7.29.1)   无形参
 */

/**
 *购物车商品结算  (7.29.2)
 */
#define RQ_SHOPCARTPRODUCTPAY_PARAM_PROURLS    @"proUrls"
#define RQ_SHOPCARTPRODUCTPAY_PARAM_SKUCOMSIDS @"skuComsIds"

/**
 *批量删除购物车商品  (7.29.3)
 */
#define RQ_SHOPCARTDELETEPRODUCT_PARAM_PROURLS    @"proUrls"
#define RQ_SHOPCARTDELETEPRODUCT_PARAM_SKUCOMSIDS @"skuComsIds"

/**
 *修改购物车内商品的数量 (7.29.4)
 */
#define RQ_SHOPCARTPRODUCTCOUNT_PARAM_URL       @"url"
#define RQ_SHOPCARTPRODUCTCOUNT_PARAM_COUNT     @"count"
#define RQ_SHOPCARTPRODUCTCOUNT_PARAM_SKUCOMSID @"skuComsId"

/**
 *购物车备注  (7.29.5)
 */
#define RQ_SHOPCARTPAYREMARK_PARAM_PROURL    @"proUrl"
#define RQ_SHOPCARTPAYREMARK_PARAM_REMARK    @"remark"
#define RQ_SHOPCARTPAYREMARK_PARAM_SKUCOMSID @"skuComsId"

/**
 *获取用户配置信息 (7.30.1)无形参
 */

/**
 *更新用户配置信息 (7.30.2)
 */
#define RQ_UPDATEUSERCONFIG_PARAM_USERCONFIG @"UserConfig"

/**
 *费用估算 (7.31.1)
 */
#define RQ_ESTIMATES_PARM_TYPE          @"type"
#define RQ_ESTIMATES_PARM_SHIPCOUNTRYID @"shipCountryId"
#define RQ_ESTIMATES_PARM_PRICE         @"price"
#define RQ_ESTIMATES_PARM_WEIGHT        @"weight"

/**
 *版本检查 (7.31.3)
 */
#define RQ_CHECKUPDATE_PARM_VERSION @"version"


//app 2.0 新增

/**
 *搜索商品 (by keyword 7.32.1)
 */
#define RQ_SEARCH_PARM_KEYWORDS          @"keywords"
#define RQ_SEARCH_PARM_CATEGORYID        @"CategoryId"
#define RQ_SEARCH_PARM_ORDERPARAM        @"orderParam" // 1.默认排序 2.按销量 3.按价格
#define RQ_SEARCH_PARM_PAGECOUNT         @"pageCount"
#define RQ_SEARCH_PARM_PAGEINDEX         @"pageIndex"
#define RQ_SEARCH_PARM_TYPE              @"type" // 0.自定义分类搜索 1.普通搜索
#define RQ_SEARCH_PARM_SIGN              @"sign"

/**
 *店铺商品详情 ( 7.32.2)
 */
#define RQ_SHOP_SEARCH_PARM_SHOPNAME           @"shopName"
#define RQ_SHOP_SEARCH_PARM_SORT               @"sort"
#define RQ_SHOP_SEARCH_PARM_SOURCETYPE         @"sourceType"
#define RQ_SHOP_SEARCH_PARM_PAGECOUNT          @"pageCount"
#define RQ_SHOP_SEARCH_PARM_PAGEINDEX          @"pageIndex"

/**
 *获取商品类别(无参数)(7.32.3)
 */

/**
 *获取自定义类别(无参数)(7.32.4)
 */

/**
 *添加商品到收藏夹 (7.33.1)
 */
#define RQ_ADDFAVORITE_PARM_PRODUCTURL   @"productUrl"
#define RQ_ADDFAVORITE_PARM_MARK         @"mark"

/**
 *收藏店铺 (7.33.2)
 */
#define RQ_ADDFAVORITESHOP_PARM_SITEURL @"siteUrl"
#define RQ_ADDFAVORITESHOP_PARM_KEEPER  @"keeper"


/**
 *商品详情 (7.33.3)
 */
#define RQ_FAVORITE_PRODUCT_DETAIL_PARM_PRODUCTURL        @"productUrl"
#define RQ_FAVORITE_PRODUCT_DETAIL_PARM_MARK              @"mark"
#define RQ_FAVORITE_PRODUCT_DETAIL_PARM_USERID            @"userId"
#define RQ_FAVORITE_PRODUCT_DETAIL_PARM_ISDESCRIPTION     @"isDescription"
#define RQ_FAVORITE_PRODUCT_DETAIL_PARM_ISPICTUREARRAY    @"isPictureArray"
#define RQ_FAVORITE_PRODUCT_DETAIL_PARM_ISPRODUCTPROPERTY @"isProductProperty"

/**
 *店铺详情 (7.33.3)
 */
#define RQ_FAVORITE_SHOP_DETAIL_PARM_SHOPURL @"shopUrl"


/**
 *删除收藏商品 (7.33.5)
 */
#define RQ_DELETEFAVORITE_PARM_IDS     @"ids"
#define RQ_DELETEFAVORITE_PARM_TYPE    @"type" //(F删除商品 S 删除店铺)


/**
 *获取收藏商品列表 or 获取收藏店铺列表 (7.33.6)
 */
#define RQ_GETCOLLECT_PARM_TYPE              @"type" //(F商品 S 店铺)
#define RQ_GETCOLLECT_PARM_PAGECOUNT         @"pageCount"
#define RQ_GETCOLLECT_PARM_PAGEINDEX         @"pageIndex"

/**
 *获取关注类别/标签列表(0.分类 1.标签)
 */
#define RQ_GETCATEGORYORTAGFAVORITELIST_PARM_TYPE @"type"
#define RQ_GETCATEGORYORTAGFAVORITELIST_PARM_PAGESIZE @"pageSize"
#define RQ_GETCATEGORYORTAGFAVORITELIST_PARM_PAGEINDEX @"pageIndex"

/**
 *添加商品到购物车 (7.33.7)
 */
#define RQ_ADDTOCART_PARM_SKUCOMBINATIONID @"skuCombinationId"
#define RQ_ADDTOCART_PARM_PRODUCTURL       @"ProductUrl"
#define RQ_ADDTOCART_PARM_BUYNUM           @"buyNum"
#define RQ_ADDTOCART_PARM_REMARK           @"remark"
#define RQ_ADDTOCART_PARM_MARK             @"mark"
#define RQ_ADDTOCART_PARM_TOTALPRICE       @"totalPrice"
#define RQ_ADDTOCART_PARM_SKUREMARK        @"skuRemark"
#define RQ_ADDTOCART_PARM_SOURCE           @"source"
/**
 *获取商品信息 (36)
 */
#define RQ_GETUSERPRODUCT_PARM_PRODUCTID           @"productId"

/**
 *获取购物车商品数量(7.33.8)
 */

/**
 *用户注册 (7.34.1)
 */
#define RQ_REGISTER_PARM_EMAIL              @"email"
#define RQ_REGISTER_PARM_USERNAME           @"userName"
#define RQ_REGISTER_PARM_PASSWORD           @"password"
#define RQ_REGISTER_PARM_WHICHONE           @"whichone"

/**
 *团列表 (7.36.1)
 */
#define RQ_GROUPBUYLIST_PARM_PAGEINDEX           @"pageIndex"
#define RQ_GROUPBUYLIST_PARM_PAGECOUNT           @"pageCount"

/**
 *团店铺内商品 (7.36.2)
 */
#define RQ_GROUPBUYSHOPPRODUCTS_PARM_GROUPBUYID          @"tuanId"
#define RQ_GROUPBUYSHOPPRODUCTS_PARM_SHOPNAME            @"shopName"
#define RQ_GROUPBUYSHOPPRODUCTS_PARM_SORT                @"sort"
#define RQ_GROUPBUYSHOPPRODUCTS_PARM_SOURCETYPE          @"sourceType"
#define RQ_GROUPBUYSHOPPRODUCTS_PARM_DISCOUNTRANGE       @"discountRange"
#define RQ_GROUPBUYSHOPPRODUCTS_PARM_PAGEINDEX           @"pageIndex"
#define RQ_GROUPBUYSHOPPRODUCTS_PARM_PAGECOUNT           @"pageCount"

/**
 *我开的团   (7.36.3)
 */
#define RQ_MYCREATEGROUP_PARM_PAGEINDEX           @"pageIndex"
#define RQ_MYCREATEGROUP_PARM_PAGECOUNT           @"pageCount"

/**
 *我包的团 (7.36.4)
 */
#define RQ_MYJOINGROUP_PARM_PAGEINDEX           @"pageIndex"
#define RQ_MYJOINGROUP_PARM_PAGECOUNT           @"pageCount"

/**
 *开团   (7.36.5)  暂不可用
 */

/**
 *抱团   (7.36.6)
 */
#define RQ_JOINGROUP_PARM_TUANID        @"tuanId"
#define RQ_JOINGROUP_PARM_GROUPTYPE     @"groupType"
#define RQ_JOINGROUP_PARM_DISCOUNTRANGE @"discountRange"
#define RQ_JOINGROUP_PARM_BAOTUANINFO   @"baotuanInfo"


/**
 *团商品详情   (7.36.7)
 */
#define RQ_GROUPBUYPRODUCTDETAIL_PARM_PRODUCTURL    @"productUrl"
#define RQ_GROUPBUYPRODUCTDETAIL_PARM_TUANID        @"tuanId"
#define RQ_GROUPBUYPRODUCTDETAIL_PARM_DISCOUNTRANGE @"discountRange"

/**
 *团消息列表   (7.36.8)
 */
#define RQ_GROUPBUYMESSAGE_PARM_GROUPID   @"tuanId"
#define RQ_GROUPBUYMESSAGE_PARM_PAGEINDEX @"pageIndex"
#define RQ_GROUPBUYMESSAGE_PARM_PAGECOUNT @"pageCount"

/**
 *发消息   (7.36.9)
 */
#define RQ_GROUPBUYSENDMSG_PARM_GROUPID  @"tuanId"
#define RQ_GROUPBUYSENDMSG_PARM_USERID   @"userId"
#define RQ_GROUPBUYSENDMSG_PARM_CONTENT  @"content"

/**
 *专题列表  (7.37.1)  无
 */
#define RQ_SPECIALECOMMEND_LIST_PARM_PAGEINDEX @"pageIndex"
#define RQ_SPECIALECOMMEND_LIST_PARM_PAGECOUNT @"pageCount"


/**
 *专题分区 (7.37.2)  无
 */
#define RQ_SPECIALRECOMMEND_PARTS_PRAM_TOPICID  @"topicId"
#define RQ_SPECIALRECOMMEND_PARTS_PRAM_USERID  @"userId"

/**
 *删除分区内商品  (7.37.3)
 */
#define RQ_SPECIALRECOMMEND_DELETEPRODUCT_PRAM_ID  @"id"

/**
 *获取商品图片
 */
#define RQ_COMMON_GETPRODUCTIMAGE_PARM_PRODUCTID @"productId"
#define RQ_COMMON_GETPRODUCTIMAGE_PARM_TYPE      @"imgType"


/**
 *摇奖 (7.38.2) (1-产品 2-程序 3-设计)
 */
#define RQ_ACTIVITY_GETPRIZE_PARM_BOSS @"boss"

/**
 *获奖记录 (7.38.3) (0,所有 1,未使用 2,已使用)
 */
#define RQ_ACTIVITY_USERPRIZES_PARM_TYPE @"type"


/**
 *问题列表  (7.38.4)
 */
#define RQ_PANLIROBOT_QALIST_PARM_TYPE @"type"

/**
 *用户分享相关商品列表
 */
#define RQ_USERSHARE_PARM_TYPE      @"type"
#define RQ_USERSHARE_PARM_PAGEINDEX @"pageIndex"
#define RQ_USERSHARE_PARM_PAGECOUNT @"pageCount"

/**
 *添加分享
 */
#define RQ_MAKESHARE_PARM_PRODUCTID  @"productId"
#define RQ_MAKESHARE_PARM_SCORE       @"score"
#define RQ_MAKESHARE_PARM_DESCRIPTION @"description"
#define RQ_MAKESHARE_PARM_PICTURES    @"pictures"

/**
 *分享购列表
 */
#define RQ_SHAREPRODUCTS_PARM_TYPE       @"type"
#define RQ_SHAREPRODUCTS_PARM_CATEGORYID @"categoryId"
#define RQ_SHAREPRODUCTS_PARM_PAGEINDEX  @"pageIndex"
#define RQ_SHAREPRODUCTS_PARM_PAGECOUNT  @"pageCount"

/**
 *获取分享详情
 */
#define RQ_SHAREPRODUCTDETAILS_PARM_PRODUCTURL @"productUrl"

/**
 *获取分享购话题关联的分享信息
 */
#define RQ_SHARETOPICRELATEDSHAREPRODUCTS_PARM_ID        @"id"
#define RQ_SHARETOPICRELATEDSHAREPRODUCTS_PARM_THEME     @"theme"
#define RQ_SHARETOPICRELATEDSHAREPRODUCTS_PARM_PAGEINDEX @"pageIndex"
#define RQ_SHARETOPICRELATEDSHAREPRODUCTS_PARM_PAGECOUNT @"pageCount"

/**
 *赞与取消赞
 */
#define RQ_SHAREBUYPRAISE_PARM_TYPE       @"type"
#define RQ_SHAREBUYPRAISE_PARM_PRODUCTID @"productId"

/**
 *用户是否赞过
 */
#define RQ_SHAREBUY_ISPRAISE_PARM_USERID    @"userId"
#define RQ_SHAREBUY_ISPRAISE_PARM_PRODUCTID @"productId"

/**
 *联合登录
 */
#define RQ_LOGIN_FACEBOOK_PARM_TYPE        @"type"
#define RQ_LOGIN_FACEBOOK_PARM_CODE        @"code"
#define RQ_LOGIN_FACEBOOK_PARM_DEVICETOKEN @"deviceToken"
#define RQ_LOGIN_FACEBOOK_PARM_LONGITUDE   @"longitude"
#define RQ_LOGIN_FACEBOOK_PARM_LATITUDE    @"latitude"

#endif
