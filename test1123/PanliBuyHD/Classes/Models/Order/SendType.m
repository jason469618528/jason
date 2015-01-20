//
//  SendType.m
//  PanliApp
//
//  Created by jason on 13-5-7.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "SendType.h"

@implementation SendType

@synthesize deliveryId = _deliveryId;
@synthesize time = _time;
@synthesize deliveryName = _deliveryName;
@synthesize entryPrice = _entryPrice;
@synthesize productPrice = _productPrice;
@synthesize shipPrice = _shipPrice;
@synthesize sumPrice = _sumPricel;

/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:_deliveryId forKey:@"DeliveryID"];
    [aCoder encodeObject:_time forKey:@"Time"];
    [aCoder encodeObject:_deliveryName forKey:@"DeliveryName"];
    [aCoder encodeFloat:_entryPrice forKey:@"EntryPrice"];
    [aCoder encodeFloat:_productPrice forKey:@"ProductPrice"];
    [aCoder encodeFloat:_shipPrice forKey:@"ShipPrice"];
    [aCoder encodeFloat:_sumPricel forKey:@"SumPrice"];
  
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.deliveryId = [aDecoder decodeIntForKey:@"DeliveryID"];
        self.time = [aDecoder decodeObjectForKey:@"Time"];
        self.deliveryName = [aDecoder decodeObjectForKey:@"DeliveryName"];
        self.entryPrice = [aDecoder decodeFloatForKey:@"EntryPrice"];
        self.productPrice = [aDecoder decodeFloatForKey:@"ProductPrice"];
        self.shipPrice = [aDecoder decodeFloatForKey:@"ShipPrice"];
        self.sumPrice = [aDecoder decodeFloatForKey:@"SumPrice"];
  
    }
    return self;
}

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_time);
    SAFE_RELEASE(_deliveryName);
    [super dealloc];
}
@end
