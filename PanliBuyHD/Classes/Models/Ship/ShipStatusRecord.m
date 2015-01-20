//
//  ShipStatusRecord.m
//  PanliApp
//
//  Created by jason on 13-4-15.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShipStatusRecord.h"

@implementation ShipStatusRecord

@synthesize shipId = _shipId;
@synthesize status = _status;

/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_shipId forKey:@"ShipId"];
    [aCoder encodeInt:_status forKey:@"Status"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.shipId = [aDecoder decodeObjectForKey:@"ShipId"];
        self.status = [aDecoder decodeIntForKey:@"Status"];
    }
    return self;
}

- (void)dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_shipId);
    [super dealloc];
}

@end
