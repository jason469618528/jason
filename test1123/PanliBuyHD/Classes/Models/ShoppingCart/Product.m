//
//  Product.m
//  PanliApp
//
//  Created by jason on 13-4-15.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "Product.h"

@implementation Product

@synthesize productName = _productName;
@synthesize productUrl = _productUrl;
@synthesize freight = _freight;
@synthesize image = _image;
@synthesize thumbnail = _thumbnail;
@synthesize price = _price;
@synthesize description = _description;
@synthesize proId = _proId;

///**
// *序列化
// */
//- (void) encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:_productName forKey:@"ProductName"];
//    [aCoder encodeObject:_productUrl forKey:@"ProductUrl"];
//    [aCoder encodeFloat:_freight forKey:@"Freight"];
//    [aCoder encodeObject:_image forKey:@"Image"];
//    [aCoder encodeObject:_thumbnail forKey:@"Thumnail"];
//    [aCoder encodeFloat:_price forKey:@"Price"];
//    [aCoder encodeObject:_description forKey:@"Description"];
//    [aCoder encodeInt:_proId forKey:@"ProId"];
//    
//}
///**
// *反序列化
// */
//- (id) initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super init])
//    {
//        self.productName       = [aDecoder decodeObjectForKey:@"ProductName"];
//        self.productUrl        = [aDecoder decodeObjectForKey:@"ProductUrl"];
//        self.freight           = [aDecoder decodeFloatForKey:@"Freight"];
//        self.image             = [aDecoder decodeObjectForKey:@"Image"];
//        self.thumbnail         = [aDecoder decodeObjectForKey:@"Thumnail"];
//        self.price             = [aDecoder decodeFloatForKey:@"Price"];
//        self.description       = [aDecoder decodeObjectForKey:@"Description"];
//        self.proId             = [aDecoder decodeIntForKey:@"ProId"];
//    }
//    return self;
//}


-(void)dealloc
{
    DLOG(@"%@ dealloc",[self class]);
}

@end
