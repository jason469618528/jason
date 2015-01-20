//
//  ShipReview.m
//  PanliApp
//
//  Created by jason on 13-4-16.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShipReview.h"

@implementation ShipReview

@synthesize userId = _userId;
@synthesize generalRate = _generalRate;
@synthesize receiveRate = _receiveRate;
@synthesize deliveryRate = _deliveryRate;
@synthesize customerRate = _customerRate;
@synthesize content = _content;
@synthesize shipID = _shipID;

/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_userId forKey:@"UserId"];
    [aCoder encodeObject:_generalRate forKey:@"GeneralRate"];
    [aCoder encodeObject:_receiveRate forKey:@"ReceiveRate"];
    [aCoder encodeObject:_deliveryRate forKey:@"DeliveryRate"];
    [aCoder encodeObject:_customerRate forKey:@"CustomerRate"];
    [aCoder encodeObject:_content forKey:@"Content"];
    [aCoder encodeObject:_shipID forKey:@"ShipID"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.userId       = [aDecoder decodeObjectForKey:@"UserId"];
        self.generalRate  = [aDecoder decodeObjectForKey:@"GeneralRate"];
        self.receiveRate  = [aDecoder decodeObjectForKey:@"ReceiveRate"];
        self.deliveryRate = [aDecoder decodeObjectForKey:@"DeliveryRate"];
        self.customerRate = [aDecoder decodeObjectForKey:@"CustomerRate"];
        self.content      = [aDecoder decodeObjectForKey:@"Content"];
        self.shipID       = [aDecoder decodeObjectForKey:@"ShipID"];
    }
    return self;
}

- (void)dealloc
{
    DLOG(@"%@ dealloc",[self class]);    
    SAFE_RELEASE(_userId);
    SAFE_RELEASE(_generalRate);
    SAFE_RELEASE(_receiveRate);
    SAFE_RELEASE(_deliveryRate);
    SAFE_RELEASE(_customerRate);
    SAFE_RELEASE(_content);
    SAFE_RELEASE(_shipID);
    [super dealloc];
}

@end
