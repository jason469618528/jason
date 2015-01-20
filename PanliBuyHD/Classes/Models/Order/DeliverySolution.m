//
//  DeliverySolution.m
//  PanliApp
//
//  Created by jason on 13-4-16.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "DeliverySolution.h"

@implementation DeliverySolution

@synthesize deliveryGourpId = _deliveryGourpId;
@synthesize shipItems = _shipItems;
@synthesize isHidden = _isHidden;
@synthesize totalShipPrice = _totalShipPrice;
@synthesize totalServicePrice = _totalServicePrice;
@synthesize totalCustodyPrice = _totalCustodyPrice;
@synthesize hasForbidden = _hasForbidden;
@synthesize hasOverWeight = _hasOverWeight;
@synthesize orderValue = _orderValue;
@synthesize deliveryInfo = _deliveryInfo;

/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_deliveryGourpId forKey:@"DeliveryGourpId"];
    [aCoder encodeObject:_shipItems forKey:@"ShipItems"];
    [aCoder encodeBool:_isHidden forKey:@"IsHidden"];
    [aCoder encodeFloat:_totalShipPrice forKey:@"TotalShipPrice"];
    [aCoder encodeFloat:_totalServicePrice forKey:@"TotalServicePrice"];
    [aCoder encodeFloat:_totalCustodyPrice forKey:@"TotalCustodyPrice"];
    [aCoder encodeBool:_hasForbidden forKey:@"HasForbidden"];
    [aCoder encodeBool:_hasOverWeight forKey:@"HasOverWeight"];
    [aCoder encodeInt:_orderValue forKey:@"OrderValue"];
    [aCoder encodeObject:_deliveryInfo forKey:@"DeliveryInfo"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.deliveryGourpId   = [aDecoder decodeObjectForKey:@"DeliveryGourpId"];
        self.shipItems         = [aDecoder decodeObjectForKey:@"ShipItems"];
        self.isHidden          = [aDecoder decodeBoolForKey:@"IsHidden"];
        self.totalShipPrice    = [aDecoder decodeFloatForKey:@"TotalShipPrice"];
        self.totalServicePrice = [aDecoder decodeFloatForKey:@"TotalServicePrice"];
        self.totalCustodyPrice = [aDecoder decodeFloatForKey:@"TotalCustodyPrice"];
        self.hasForbidden      = [aDecoder decodeBoolForKey:@"HasForbidden"];
        self.hasOverWeight     = [aDecoder decodeBoolForKey:@"HasOverWeight"];
        self.orderValue        = [aDecoder decodeIntForKey:@"OrderValue"];
        self.deliveryInfo      = [aDecoder decodeObjectForKey:@"DeliveryInfo"];


    }
    return self;
}

- (void)dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_deliveryGourpId);
    SAFE_RELEASE(_shipItems);
    SAFE_RELEASE(_deliveryInfo);
    [super dealloc];
}

@end
