//
//  SnatchProducts.m
//  PanliApp
//
//  Created by jason on 13-6-18.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "SnatchProducts.h"
#import "SkuObject.h"
#import "SkuCombination.h"

@implementation SnatchProducts

@synthesize productName = _productName;
@synthesize productUrl = _productUrl;
@synthesize thumbnail = _thumbnail;
@synthesize shopInfo = _shopInfo;
@synthesize site = _site;
@synthesize skus = _skus;
@synthesize skuCombinations = _skuCombinations;
@synthesize pictureArray = _pictureArray;
@synthesize price = _price;
@synthesize freight = _freight;
@synthesize vipDiscount = _vipDiscount;
@synthesize mark = _mark;
@synthesize promotionPrice = _promotionPrice;
@synthesize promotionExpried = _promotionExpried;


- (id)initWithDictionary:(NSDictionary *)iDictionary
{
    if (self = [super init])
    {
        //基础属性
        self.productName      = [iDictionary objectForKey:@"ProductName"];
        self.productUrl       = [iDictionary objectForKey:@"ProductUrl"];
        self.thumbnail        = [iDictionary objectForKey:@"Thumbnail"];
        self.price            = [[iDictionary objectForKey:@"Price"] floatValue];
        self.freight          = [[iDictionary objectForKey:@"Freight"] floatValue];
        self.mark             = [iDictionary objectForKey:@"Mark"];
        self.vipDiscount      = [[iDictionary objectForKey:@"VIPDiscount"] floatValue];
        self.promotionPrice   = [[iDictionary objectForKey:@"PromotionPrice"] floatValue];
        self.promotionExpried = [iDictionary objectForKey:@"PromotionExpried"];
        self.pictureArray     = [PanliHelper getValue:Q_TYPE_ARRAY inJsonDictionary:iDictionary propertyName:@"PictureArray"];
        
        //店铺信息
        NSDictionary *shopDic = [PanliHelper getValue:Q_TYPE_DICTIONARY inJsonDictionary:iDictionary propertyName:@"ShopInfo"];
        ShopDetail *mShopDetail = [[ShopDetail alloc] initWithDictionary:shopDic];
        self.shopInfo = mShopDetail;
        
        //site
        NSDictionary *siteDic = [PanliHelper getValue:Q_TYPE_DICTIONARY inJsonDictionary:iDictionary propertyName:@"Site"];
        SiteModel *mSite = [[SiteModel alloc] initWithDictionary:siteDic];
        self.site = mSite;
        
        //skus
        NSArray *tempSkuArr = [PanliHelper getValue:Q_TYPE_ARRAY inJsonDictionary:iDictionary propertyName:@"Skus"];
        NSMutableArray *mSkuArr = [[NSMutableArray alloc] init];
        for (NSDictionary *skuDic in tempSkuArr)
        {
            SkuObject *mSku = [[SkuObject alloc] initWithDictionary:skuDic];
            [mSkuArr addObject:mSku];
        }
        self.skus = mSkuArr;
        
        //skuCombination
        NSArray *tempSkuCombinationArr = [PanliHelper getValue:Q_TYPE_ARRAY inJsonDictionary:iDictionary propertyName:@"SkuCombinations"];
        NSMutableArray *mSkuCombinationArr = [[NSMutableArray alloc] init];
        for (NSDictionary *skuCombinationDic in tempSkuCombinationArr)
        {
            SkuCombination *mSkuCombination = [[SkuCombination alloc] initWithDictionary:skuCombinationDic];
            [mSkuCombinationArr addObject:mSkuCombination];
        }
        self.skuCombinations = mSkuCombinationArr;
    }
    return self;
}


/**
 *序列化
 */
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_productName forKey:@"ProductName"];
    [aCoder encodeObject:_productUrl forKey:@"ProductUrl"];
    [aCoder encodeObject:_thumbnail forKey:@"Thumbnail"];
    [aCoder encodeObject:_shopInfo forKey:@"ShopInfo"];
    [aCoder encodeObject:_site forKey:@"Site"];
    [aCoder encodeObject:_skus forKey:@"Skus"];
    [aCoder encodeObject:_skuCombinations forKey:@"SkuCombinations"];
    [aCoder encodeObject:_pictureArray forKey:@"ProductImgs"];
    [aCoder encodeFloat:_price forKey:@"Price"];
    [aCoder encodeFloat:_freight forKey:@"Freight"];
    [aCoder encodeFloat:_vipDiscount forKey:@"VIPDiscount"];
    [aCoder encodeObject:_mark forKey:@"Mark"];
    [aCoder encodeFloat:_promotionPrice forKey:@"PromotionPrice"];
    [aCoder encodeObject:_promotionExpried forKey:@"PromotionExpried"];

}

/**
 *反序列化
 */
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.productName = [aDecoder decodeObjectForKey:@"ProductName"];
        self.productUrl = [aDecoder decodeObjectForKey:@"ProductUrl"];
        self.thumbnail = [aDecoder decodeObjectForKey:@"Thumbnail"];
        self.shopInfo = [aDecoder decodeObjectForKey:@"ShopInfo"];
        self.site = [aDecoder decodeObjectForKey:@"Site"];
        self.skus = [aDecoder decodeObjectForKey:@"Skus"];
        self.skuCombinations = [aDecoder decodeObjectForKey:@"SkuCombinations"];
        self.pictureArray = [aDecoder decodeObjectForKey:@"ProductImgs"];
        self.price = [aDecoder decodeFloatForKey:@"Price"];       
        self.freight = [aDecoder decodeFloatForKey:@"Freight"];
        self.vipDiscount = [aDecoder decodeFloatForKey:@"VIPDiscount"];
        self.mark = [aDecoder decodeObjectForKey:@"Mark"];
        self.promotionPrice = [aDecoder decodeFloatForKey:@"PromotionPrice"];
        self.promotionExpried = [aDecoder decodeObjectForKey:@"PromotionExpried"];

    }
    return self;
}

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
}


@end
