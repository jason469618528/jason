//
//  ShopDetail.m
//  PanliApp
//
//  Created by jason on 13-6-7.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShopDetail.h"

@implementation ShopDetail


@synthesize shopName = _shopName;
@synthesize shopUrl = _shopUrl;
@synthesize logo = _logo;
@synthesize credit = _credit;
@synthesize deliverySpeed = _deliverySpeed;
@synthesize instruction = _instruction;
@synthesize keeperName = _keeperName;
@synthesize positiveRatio= _positiveRatio;
@synthesize serviceAttitude = _serviceAttitude;


- (id)initWithDictionary:(NSDictionary *)iDictionary
{
    if (self = [super init])
    {
        self.shopName        = [iDictionary objectForKey:@"ShopName"];
        self.shopUrl         = [iDictionary objectForKey:@"ShopUrl"];
        self.logo            = [iDictionary objectForKey:@"Logo"];
        self.credit          = [iDictionary objectForKey:@"Credit"] ? [[iDictionary objectForKey:@"Credit"] intValue] : 0;
        self.deliverySpeed   = [[iDictionary objectForKey:@"DeliverySpeed"] floatValue];
        self.instruction     = [iDictionary objectForKey:@"Instruction"];
        self.keeperName      = [iDictionary objectForKey:@"Keeper"];
        self.positiveRatio   = [iDictionary objectForKey:@"PositiveRatio"] ? [[iDictionary objectForKey:@"PositiveRatio"] floatValue] : 0;
        self.serviceAttitude = [[iDictionary objectForKey:@"ServiceAttitude"] floatValue];
    }
    return self;
}

/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_shopName forKey:@"ShopName"];
    [aCoder encodeObject:_shopUrl forKey:@"ShopUrl"];
    [aCoder encodeObject:_logo forKey:@"Logo"];
    [aCoder encodeInt:_credit forKey:@"Credit"];
    [aCoder encodeFloat:_deliverySpeed forKey:@"DeliverySpeed"];
    [aCoder encodeObject:_instruction forKey:@"Instruction"];
    [aCoder encodeObject:_keeperName forKey:@"KeeperName"];
    [aCoder encodeFloat:_positiveRatio forKey:@"PositiveRatio"];
    [aCoder encodeFloat:_serviceAttitude forKey:@"ServiceAttitude"];

}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.shopName = [aDecoder decodeObjectForKey:@"ShopName"];
        self.shopUrl = [aDecoder decodeObjectForKey:@"ShopUrl"];
        self.logo = [aDecoder decodeObjectForKey:@"Logo"];
        self.credit = [aDecoder decodeIntForKey:@"Credit"];
        self.deliverySpeed = [aDecoder decodeFloatForKey:@"DeliverySpeed"];
        self.instruction = [aDecoder decodeObjectForKey:@"Instruction"];
        self.keeperName = [aDecoder decodeObjectForKey:@"KeeperName"];
        self.positiveRatio = [aDecoder decodeBoolForKey:@"PositiveRatio"];
        self.serviceAttitude = [aDecoder decodeBoolForKey:@"ServiceAttitude"];
    }
    return self;
}
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
}

@end
