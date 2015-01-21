//
//  Favorite.m
//  PanliApp
//
//  Created by jason on 13-6-5.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "FavoriteProducts.h"

@implementation FavoriteProducts

@synthesize productUrl = _productUrl;
@synthesize productName = _productName;
@synthesize thumbnail = _thumbnail;
@synthesize price = _price;
@synthesize shopName = _shopName;
@synthesize siteName = _siteName;
@synthesize favoriteID = _favoriteID;
@synthesize isFavorite = _isFavorite;
/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_productUrl forKey:@"ProductUrl"];
    [aCoder encodeObject:_productName forKey:@"ProductName"];
    [aCoder encodeObject:_thumbnail forKey:@"Thumbnail"];
    [aCoder encodeFloat:_price forKey:@"Price"];
    [aCoder encodeObject:_shopName forKey:@"ShopName"];
    [aCoder encodeObject:_siteName forKey:@"SiteName"];
    [aCoder encodeInt:_favoriteID forKey:@"FavoriteID"];
    [aCoder encodeBool:_isFavorite forKey:@"IsFavorite"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.productUrl = [aDecoder decodeObjectForKey:@"ProductUrl"];
        self.productName = [aDecoder decodeObjectForKey:@"ProductName"];
        self.thumbnail = [aDecoder decodeObjectForKey:@"Thumbnail"];
        self.price = [aDecoder decodeFloatForKey:@"Price"];
        self.shopName = [aDecoder decodeObjectForKey:@"ShopName"];
        self.siteName = [aDecoder decodeObjectForKey:@"SiteName"];
        self.favoriteID = [aDecoder decodeIntForKey:@"FavoriteID"];
        self.isFavorite = [aDecoder decodeBoolForKey:@"IsFavorite"];
    }
    return self;
}

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_productUrl);
    SAFE_RELEASE(_productName);
    SAFE_RELEASE(_thumbnail);
    SAFE_RELEASE(_shopName);
    SAFE_RELEASE(_siteName);
    [super dealloc];
}


@end
