//
//  ShipCountry.m
//  PanliApp
//
//  Created by jason on 13-4-28.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShipCountry.h"

@implementation ShipCountry

@synthesize shipCountryId = _shipCountryId;
@synthesize code = _code;
@synthesize name = _name;
@synthesize order = _order;
@synthesize initial = _initial;
@synthesize isCommon = _isCommon;
/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:_shipCountryId forKey:@"ShipCountryId"];
    [aCoder encodeObject:_code forKey:@"Code"];
    [aCoder encodeObject:_name forKey:@"Name"];
    [aCoder encodeInt:_order forKey:@"ID"];
    [aCoder encodeObject:_initial forKey:@"Initial"];
    [aCoder encodeBool:_isCommon forKey:@"IsCommon"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.shipCountryId = (int)[aDecoder decodeIntegerForKey:@"ShipCountryId"];
        self.code = [aDecoder decodeObjectForKey:@"Code"];
        self.name = [aDecoder decodeObjectForKey:@"Name"];
        self.order = (int)[aDecoder decodeIntegerForKey:@"ID"];
        self.initial = [aDecoder decodeObjectForKey:@"Initial"];
        self.isCommon = [aDecoder decodeBoolForKey:@"IsCommon"];
    }
    return self;
}

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_code);
    SAFE_RELEASE(_name);
    SAFE_RELEASE(_initial);
    [super dealloc];
}
@end
