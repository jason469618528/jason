//
//  ShipOrder.m
//  PanliApp
//
//  Created by jason on 13-4-15.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShipOrder.h"

@implementation ShipOrder

@synthesize orderId = _orderId;
@synthesize logisticsId = _logisticsId;
@synthesize expressUrl = _expressUrl;
@synthesize shipType = _shipType;
@synthesize status = _status;
@synthesize userScore = _userScore;
@synthesize custodyPrice = _custodyPrice;
@synthesize couponPrice = _couponPrice;
@synthesize shipDeliveryName = _shipDeliveryName;
@synthesize packageCode = _packageCode;

@synthesize shipPrice = _shipPrice;
@synthesize servicePrice = _servicePrice;
@synthesize giftPrice = _giftPrice;
@synthesize entryPrice = _entryPrice;
@synthesize promotionPrice = _promotionPrice;
@synthesize totalWeight = _totalWeight;
@synthesize giftContent = _giftContent;
@synthesize consignee = _consignee;
@synthesize telePhone = _telePhone;
@synthesize postcode = _postcode;

@synthesize shipArea = _shipArea;
@synthesize shipCountry = _shipCountry;
@synthesize shipAddress = _shipAddress;
@synthesize shipCity = _shipCity;
@synthesize shipRemark = _shipRemark;
@synthesize dealDate = _dealDate;
@synthesize confimDate = _confimDate;
@synthesize createDate = _createDate;
@synthesize totalPrice = _totalPrice;
@synthesize hasVoted = _hasVoted;

@synthesize canCaneOrder = _canCaneOrder;
@synthesize customService = _customService;
@synthesize marray_Products = _marray_Products;

@synthesize lastText = _lastText;
@synthesize lastTime = _lastTime;

@synthesize haveUnreadMessage = _haveUnreadMessage;
@synthesize haveRead = _haveRead;
/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_orderId forKey:@"OrderId"];
    [aCoder encodeInt:_logisticsId forKey:@"LogisticsId"];
    [aCoder encodeObject:_expressUrl forKey:@"ExpressUrl"];
    [aCoder encodeObject:_shipType forKey:@"ShipType"];
    [aCoder encodeInt:_status forKey:@"Status"];
    [aCoder encodeInt:_userScore forKey:@"UserScore"];
    [aCoder encodeFloat:_custodyPrice forKey:@"CustodyPrice"];
    [aCoder encodeFloat:_couponPrice forKey:@"CouponPrice"];
    [aCoder encodeObject:_shipDeliveryName forKey:@"ShipDeliveryName"];
    [aCoder encodeObject:_packageCode forKey:@"PackageCode"];
    
    [aCoder encodeFloat:_shipPrice forKey:@"ShipPrice"];
    [aCoder encodeFloat:_servicePrice forKey:@"ServicePrice"];
    [aCoder encodeFloat:_giftPrice forKey:@"GiftPrice"];
    [aCoder encodeFloat:_entryPrice forKey:@"EntryPrice"];
    [aCoder encodeFloat:_promotionPrice forKey:@"PromotionPrice"];
    [aCoder encodeInt:_totalWeight forKey:@"TotalWeight"];
    [aCoder encodeObject:_giftContent forKey:@"GiftContent"];
    [aCoder encodeObject:_consignee forKey:@"Consignee"];
    [aCoder encodeObject:_telePhone forKey:@"Telephone"];
    [aCoder encodeObject:_postcode forKey:@"Postcode"];
    
    [aCoder encodeObject:_shipArea forKey:@"ShipArea"];
    [aCoder encodeObject:_shipCountry forKey:@"ShipCountry"];
    [aCoder encodeObject:_shipAddress forKey:@"ShipAddress"];
    [aCoder encodeObject:_shipCity forKey:@"ShipCity"];
    [aCoder encodeObject:_shipRemark forKey:@"ShipRemark"];
    [aCoder encodeObject:_dealDate forKey:@"DealDate"];
    [aCoder encodeObject:_confimDate forKey:@"ConfimDate"];
    [aCoder encodeObject:_createDate forKey:@"CreateDate"];
    [aCoder encodeObject:_totalPrice forKey:@"TotalPrice"];
    [aCoder encodeBool:_hasVoted forKey:@"HasVoted"];
    
    [aCoder encodeBool:_canCaneOrder forKey:@"CanCancleOrder"];
    [aCoder encodeBool:_customService forKey:@"CustomService"];
    [aCoder encodeObject:_marray_Products forKey:@"UserProducts"];
    
    [aCoder encodeBool:_haveUnreadMessage forKey:@"HaveUnreadMessage"];
    [aCoder encodeBool:_haveRead forKey:@"HaveRead"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.orderId           = [aDecoder decodeObjectForKey:@"OrderId"];
        self.logisticsId       = [aDecoder decodeIntForKey:@"LogisticsId"];
        self.expressUrl        = [aDecoder decodeObjectForKey:@"ExpressUrl"];
        self.shipType          = [aDecoder decodeObjectForKey:@"ShipType"];
        self.status            = [aDecoder decodeIntForKey:@"Status"];
        self.userScore         = [aDecoder decodeIntForKey:@"UserScore"];
        self.custodyPrice      = [aDecoder decodeFloatForKey:@"CustodyPrice"];
        self.couponPrice       = [aDecoder decodeFloatForKey:@"CouponPrice"];
        self.shipDeliveryName  = [aDecoder decodeObjectForKey:@"ShipDeliveryName"];
        self.packageCode       = [aDecoder decodeObjectForKey:@"PackageCode"];
        
        self.shipPrice         = [aDecoder decodeFloatForKey:@"ShipPrice"];
        self.servicePrice      = [aDecoder decodeFloatForKey:@"ServicePrice"];
        self.giftPrice         = [aDecoder decodeFloatForKey:@"GiftPrice"];
        self.entryPrice        = [aDecoder decodeFloatForKey:@"EntryPrice"];
        self.promotionPrice    = [aDecoder decodeFloatForKey:@"PromotionPrice"];
        self.totalWeight       = [aDecoder decodeIntForKey:@"TotalWeight"];
        self.giftContent       = [aDecoder decodeObjectForKey:@"GiftContent"];
        self.consignee         = [aDecoder decodeObjectForKey:@"Consignee"];
        self.telePhone         = [aDecoder decodeObjectForKey:@"Telephone"];
        self.postcode          = [aDecoder decodeObjectForKey:@"Postcode"];
        
        self.shipArea          = [aDecoder decodeObjectForKey:@"ShipArea"];
        self.shipCountry       = [aDecoder decodeObjectForKey:@"ShipCountry"];
        self.shipAddress       = [aDecoder decodeObjectForKey:@"ShipAddress"];
        self.shipCity          = [aDecoder decodeObjectForKey:@"ShipCity"];
        self.shipRemark        = [aDecoder decodeObjectForKey:@"ShipRemark"];
        self.dealDate          = [aDecoder decodeObjectForKey:@"DealDate"];
        self.confimDate        = [aDecoder decodeObjectForKey:@"ConfimDate"];
        self.createDate        = [aDecoder decodeObjectForKey:@"CreateDate"];
        self.totalPrice        = [aDecoder decodeObjectForKey:@"TotalPrice"];
        self.hasVoted          = [aDecoder decodeBoolForKey:@"HasVoted"];
        
        self.canCaneOrder      = [aDecoder decodeBoolForKey:@"CanCancleOrder"];
        self.customService     = [aDecoder decodeBoolForKey:@"CustomService"];
        self.marray_Products   = [aDecoder decodeObjectForKey:@"UserProducts"];
        
        self.haveUnreadMessage = [aDecoder decodeBoolForKey:@"HaveUnreadMessage"];
        self.haveRead          = [aDecoder decodeBoolForKey:@"HaveRead"];
    }
    return self;
}

-(void)dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_orderId);
    SAFE_RELEASE(_expressUrl);
    SAFE_RELEASE(_shipType);
    SAFE_RELEASE(_shipDeliveryName);
    SAFE_RELEASE(_packageCode);
    SAFE_RELEASE(_giftContent);
    SAFE_RELEASE(_consignee);
    SAFE_RELEASE(_telePhone);
    SAFE_RELEASE(_postcode);
    SAFE_RELEASE(_shipArea);
    SAFE_RELEASE(_shipCountry);
    SAFE_RELEASE(_shipAddress);
    SAFE_RELEASE(_shipCity);
    SAFE_RELEASE(_shipRemark);
    SAFE_RELEASE(_dealDate);
    SAFE_RELEASE(_confimDate);
    SAFE_RELEASE(_createDate);
    SAFE_RELEASE(_totalPrice);
    SAFE_RELEASE(_marray_Products);
    
    SAFE_RELEASE(_lastText);
    SAFE_RELEASE(_lastTime);

    [super dealloc];
}

@end
