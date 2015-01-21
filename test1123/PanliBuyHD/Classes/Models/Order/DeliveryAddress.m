//
//  DeliveryAddress.m
//  PanliApp
//
//  Created by jason on 13-4-16.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "DeliveryAddress.h"

@implementation DeliveryAddress


@synthesize deliveryAddressId = _deliveryAddressId;
@synthesize userId = _userId;
@synthesize consignee = _consignee;
@synthesize zip = _zip;
@synthesize telephone = _telephone;
@synthesize country = _country;
@synthesize city = _city;
@synthesize address = _address;
@synthesize dAddtime = _dAddtime;
@synthesize nCountryID = _nCountryID;

@synthesize keepPacking = _keepPacking;
@synthesize remark = _remark;

/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:_deliveryAddressId forKey:@"Id"];
    [aCoder encodeObject:_userId forKey:@"UserId"];
    [aCoder encodeObject:_consignee forKey:@"Consignee"];
    [aCoder encodeObject:_zip forKey:@"Zip"];
    [aCoder encodeObject:_telephone forKey:@"Telephone"];
    [aCoder encodeObject:_country forKey:@"Country"];
    [aCoder encodeObject:_city forKey:@"City"];
    [aCoder encodeObject:_address forKey:@"Address"];
    [aCoder encodeObject:_dAddtime forKey:@"DAddtime"];
    [aCoder encodeInt:_nCountryID forKey:@"NCountryID"];    
    [aCoder encodeObject:_keepPacking forKey:@"KeepPacking"];
    [aCoder encodeObject:_remark forKey:@"Remark"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.deliveryAddressId = [aDecoder decodeIntForKey:@"Id"];
        self.userId            = [aDecoder decodeObjectForKey:@"UserId"];
        self.consignee         = [aDecoder decodeObjectForKey:@"Consignee"];
        self.zip               = [aDecoder decodeObjectForKey:@"Zip"];
        self.telephone         = [aDecoder decodeObjectForKey:@"Telephone"];
        self.country           = [aDecoder decodeObjectForKey:@"Country"];
        self.city              = [aDecoder decodeObjectForKey:@"City"];
        self.address           = [aDecoder decodeObjectForKey:@"Address"];
        self.dAddtime          = [aDecoder decodeObjectForKey:@"DAddtime"];
        self.nCountryID        = [aDecoder decodeIntForKey:@"NCountryID"];        
        self.keepPacking       = [aDecoder decodeObjectForKey:@"KeepPacking"];
        self.remark            = [aDecoder decodeObjectForKey:@"Remark"];
    }
    return self;
}


- (void)dealloc
{
    DLOG(@"%@ dealloc",[self class]);    
    SAFE_RELEASE(_userId);
    SAFE_RELEASE(_consignee);
    SAFE_RELEASE(_zip);
    SAFE_RELEASE(_telephone);
    SAFE_RELEASE(_city);
    SAFE_RELEASE(_address);
    SAFE_RELEASE(_dAddtime);
    SAFE_RELEASE(_country);
    SAFE_RELEASE(_keepPacking);
    SAFE_RELEASE(_remark);
    [super dealloc];
}

@end
