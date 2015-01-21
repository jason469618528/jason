//
//  FavoriteShops.m
//  PanliBuyHD
//
//  Created by guo on 14-10-13.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "FavoriteShops.h"

@implementation FavoriteShops
@synthesize shopUrl = _shopUrl;
@synthesize shopName = _shopName;
@synthesize keeperName = _keeperName;
@synthesize credit = _credit;
@synthesize logo = _logo;
@synthesize instruction = _instruction;;
@synthesize positiveRatio = _positiveRatio;
@synthesize favoriteID = _favoriteID;
@synthesize isFavorite = _isFavorite;
@synthesize siteName = _siteName;

/**
 *序列化
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_shopUrl forKey:@"ShopUrl"];
    [aCoder encodeObject:_shopName forKey:@"ShopName"];
    [aCoder encodeObject:_keeperName forKey:@"KeeperName"];
    [aCoder encodeInt:_credit forKey:@"Credit"];
    [aCoder encodeObject:_logo forKey:@"Logo"];
    [aCoder encodeObject:_instruction forKey:@"Instruction"];
    [aCoder encodeFloat:_positiveRatio forKey:@"PositiveRatio"];
    [aCoder encodeInt:_favoriteID forKey:@"FavoriteID"];
    [aCoder encodeBool:_isFavorite forKey:@"IsFavorite"];
    [aCoder encodeObject:_siteName forKey:@"SiteName"];
}

/**
 *  反序列化
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.shopUrl = [aDecoder decodeObjectForKey:@"ShopUrl"];
        self.shopName = [aDecoder decodeObjectForKey:@"ShopName"];
        self.keeperName = [aDecoder decodeObjectForKey:@"KeeperName"];
        self.credit = [aDecoder decodeIntForKey:@"Credit"];
        self.logo = [aDecoder decodeObjectForKey:@"Logo"];
        self.instruction = [aDecoder decodeObjectForKey:@"Instruction"];
        self.positiveRatio = [aDecoder decodeFloatForKey:@"PositiveRatio"];
        self.favoriteID = [aDecoder decodeIntForKey:@"FavoriteID"];
        self.isFavorite = [aDecoder decodeBoolForKey:@"IsFavorite"];
        self.siteName = [aDecoder decodeObjectForKey:@"SiteName"];
    }
    
    return self;
}

@end
