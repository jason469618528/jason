//
//  BaseProduct.m
//  PanliApp
//
//  Created by Liubin on 13-8-19.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "BaseProduct.h"

@implementation BaseProduct

@synthesize productName = _productName;
@synthesize productUrl = _productUrl;
@synthesize thumbnail = _thumbnail;
@synthesize price = _price;
@synthesize pictureHeight = _pictureHeight;
@synthesize pictureWHRatio = _pictureWHRatio;


- (id)initWithDictionary:(NSDictionary *)iDictionary
{
    self = [super init];
    if (self && iDictionary)
    {
        self.productName = [iDictionary objectForKey:@"ProductName"];
        self.productUrl = [iDictionary objectForKey:@"ProductUrl"];
        self.thumbnail = [iDictionary objectForKey:@"Thumbnail"];
        self.price = [[iDictionary objectForKey:@"Price"] floatValue];
        self.pictureHeight = [[iDictionary objectForKey:@"PictureHeight"] floatValue];
        self.pictureWHRatio = [[iDictionary objectForKey:@"PictureWHRatio"] floatValue];
    }
    return self;
}
/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_productName forKey:@"productName"];
    [aCoder encodeObject:_productUrl forKey:@"productUrl"];
    [aCoder encodeObject:_thumbnail forKey:@"thumbnail"];
    [aCoder encodeFloat:_price forKey:@"price"];
    [aCoder encodeFloat:_pictureHeight forKey:@"pictureHeight"];
    [aCoder encodeFloat:_pictureWHRatio forKey:@"pictureWHRatio"];
}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.productName = [aDecoder decodeObjectForKey:@"productName"];
        self.productUrl = [aDecoder decodeObjectForKey:@"productUrl"];
        self.thumbnail = [aDecoder decodeObjectForKey:@"thumbnail"];
        self.price = [aDecoder decodeIntForKey:@"price"];
        self.pictureHeight = [aDecoder decodeIntForKey:@"pictureHeight"];
        self.pictureWHRatio = [aDecoder decodeIntForKey:@"pictureWHRatio"];
    }
    return self;
}

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_productName);
    SAFE_RELEASE(_productUrl);
    SAFE_RELEASE(_thumbnail);
    [super dealloc];
}

@end
