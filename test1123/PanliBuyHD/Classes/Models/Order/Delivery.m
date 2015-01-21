//
//  Delivery.m
//  PanliApp
//
//  Created by jason on 13-4-16.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "Delivery.h"

@implementation Delivery

@synthesize deliveryId = _deliveryId;
@synthesize shipItems =  _shipItems;
@synthesize deliveryName = _deliveryName;
@synthesize deliveryDate = _deliveryDate;
@synthesize shipSendType = _shipSendType;
@synthesize totalProductPrice = _totalProductPrice;
@synthesize custodyPrice = _custodyPrice;
@synthesize servicePrice = _servicePrice;
@synthesize shipPrice = _shipPrice;
@synthesize originalServicePrice = _originalServicePrice;
@synthesize originalShipPrice = _originalShipPrice;
@synthesize enterPrice = _enterPrice;

@synthesize weight = _weight;
@synthesize isVWeight = _isVWeight;
@synthesize isLightOverweight = _isLightOverweight;
@synthesize isHeavyOverweight = _isHeavyOverweight;
@synthesize isForbidden = _isForbidden;

@synthesize selectedCoupon = _selectedCoupon;

/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:_deliveryId forKey:@"DeliveryId"];
    [aCoder encodeObject:_shipItems forKey:@"ShipItems"];
    [aCoder encodeObject:_deliveryName forKey:@"DeliveryName"];
    [aCoder encodeObject:_deliveryDate forKey:@"DeliveryDate"];
    [aCoder encodeInt:_shipSendType forKey:@"ShipSendType"];
    [aCoder encodeFloat:_totalProductPrice forKey:@"TotalProductPrice"];
    [aCoder encodeFloat:_custodyPrice forKey:@"CustodyPrice"];
    [aCoder encodeFloat:_servicePrice forKey:@"ServicePrice"];
    [aCoder encodeFloat:_shipPrice forKey:@"ShipPrice"];
    [aCoder encodeFloat:_originalServicePrice forKey:@"OriginalServicePrice"];
    [aCoder encodeFloat:_originalShipPrice forKey:@"OriginalShipPrice"];
    [aCoder encodeFloat:_enterPrice forKey:@"EnterPrice"];
    [aCoder encodeFloat:_weight forKey:@"Weight"];
    [aCoder encodeBool:_isVWeight forKey:@"IsVWeight"];
    [aCoder encodeBool:_isLightOverweight forKey:@"IsLightOverweight"];
    [aCoder encodeBool:_isHeavyOverweight forKey:@"IsHeavyOverweight"];
    [aCoder encodeBool:_isForbidden forKey:@"IsForbidden"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.deliveryId        = [aDecoder decodeIntForKey:@"DeliveryId"];
        self.shipItems         = [aDecoder decodeObjectForKey:@"ShipItems"];
        self.deliveryName      = [aDecoder decodeObjectForKey:@"DeliveryName"];
        self.deliveryDate      = [aDecoder decodeObjectForKey:@"DeliveryDate"];
        self.shipSendType      = [aDecoder decodeIntForKey:@"ShipSendType"];
        self.totalProductPrice = [aDecoder decodeFloatForKey:@"TotalProductPrice"];
        self.custodyPrice      = [aDecoder decodeFloatForKey:@"CustodyPrice"];
        self.servicePrice      = [aDecoder decodeFloatForKey:@"ServicePrice"];
        self.shipPrice         = [aDecoder decodeFloatForKey:@"ShipPrice"];
        self.originalServicePrice      = [aDecoder decodeFloatForKey:@"OriginalServicePrice"];
        self.originalShipPrice         = [aDecoder decodeFloatForKey:@"OriginalShipPrice"];
        self.enterPrice        = [aDecoder decodeFloatForKey:@"EnterPrice"];
        self.weight            = [aDecoder decodeFloatForKey:@"Weight"];
        self.isVWeight         = [aDecoder decodeBoolForKey:@"IsVWeight"];
        self.isLightOverweight = [aDecoder decodeBoolForKey:@"IsLightOverweight"];
        self.isHeavyOverweight = [aDecoder decodeBoolForKey:@"IsHeavyOverweight"];
        self.isForbidden       = [aDecoder decodeBoolForKey:@"IsForbidden"];
    }
    return self;
}

- (void)dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_shipItems);
    SAFE_RELEASE(_deliveryName);
    SAFE_RELEASE(_deliveryDate);
    SAFE_RELEASE(_selectedCoupon);
    [super dealloc];
}

@end
