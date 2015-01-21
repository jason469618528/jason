//
//  ShoppingCart.m
//  PanliApp
//
//  Created by jason on 13-5-4.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShoppingCartProduct.h"

@implementation ShoppingCartProduct

@synthesize buyNum = _buyNum;
@synthesize dateCreated = _dateCreated;
@synthesize isAction = _isAction;
@synthesize isCombinationMeal = _isCombinationMeal;
@synthesize itemId = _itemId;
@synthesize remark = _remark;
@synthesize vipPrice1 = _vipPrice1;
@synthesize vipPrice2 = _vipPrice2;
@synthesize vipPrice3 = _vipPrice3;
@synthesize vipPrice4 = _vipPrice4;
@synthesize isFreightFee = _isFreightFee;
@synthesize isBook = _isBook;
@synthesize cateGoryName = _cateGoryName;
@synthesize subCategoryName = _subCategoryName;
@synthesize shopName = _shopName;
@synthesize shopUrl = _shopUrl;
@synthesize isSelected = _isSelected;
@synthesize promotionPrice = _promotionPrice;
@synthesize promotionExpriedSeconds = _promotionExpriedSeconds;
@synthesize skuRemark = _skuRemark;
@synthesize skuComsId = _skuComsId;
///**
// *序列化
// */
//- (void) encodeWithCoder:(NSCoder *)aCoder
//{
////    [super encodeWithCoder:aCoder];
//    [aCoder encodeInt:_buyNum forKey:@"BuyNum"];
//    [aCoder encodeObject:_dateCreated forKey:@"DateCreated"];
//    [aCoder encodeBool:_isAction forKey:@"IsAction"];
//    [aCoder encodeBool:_isCombinationMeal forKey:@"IsCombinationMeal"];
//    
//    [aCoder encodeObject:_itemId forKey:@"ItemId"];
//    [aCoder encodeObject:_remark forKey:@"Remark"];
//    [aCoder encodeFloat:_vipPrice1 forKey:@"VIPPrice1"];
//    [aCoder encodeFloat:_vipPrice2 forKey:@"VIPPrice2"];
//    
//    [aCoder encodeFloat:_vipPrice3 forKey:@"VIPPrice3"];
//    [aCoder encodeFloat:_vipPrice4 forKey:@"VIPPrice4"];
//    [aCoder encodeBool:_isFreightFee forKey:@"IsFreightFee"];
//    [aCoder encodeBool:_isBook forKey:@"IsBook"];
//    
//    [aCoder encodeObject:_cateGoryName forKey:@"CategoryName"];
//    [aCoder encodeObject:_subCategoryName forKey:@"SubCategoryName"];
//    [aCoder encodeObject:_shopName forKey:@"ShopName"];
//    [aCoder encodeObject:_shopUrl forKey:@"ShopUrl"];
//    
//    [aCoder encodeFloat:_promotionPrice forKey:@"PromotionPrice"];
//    [aCoder encodeObject:_skuRemark forKey:@"SkuRemark"];
//    [aCoder encodeObject:_skuComsId forKey:@"SkuComsId"];
//}
//

/**
 *反序列化
 */
//- (id) initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super initWithCoder:aDecoder])
//    {
//        self.buyNum = [aDecoder decodeIntForKey:@"BuyNum"];
//        self.dateCreated = [aDecoder decodeObjectForKey:@"DateCreated"];
//        self.isAction = [aDecoder decodeBoolForKey:@"IsAction"];
//        self.isCombinationMeal = [aDecoder decodeBoolForKey:@"IsCombinationMeal"];
//        
//        self.itemId = [aDecoder decodeObjectForKey:@"ItemId"];
//        self.remark = [aDecoder decodeObjectForKey:@"Remark"];
//        self.vipPrice1 = [aDecoder decodeFloatForKey:@"VIPPrice1"];
//        self.vipPrice2 = [aDecoder decodeFloatForKey:@"VIPPrice2"];
//        
//        self.vipPrice3 = [aDecoder decodeFloatForKey:@"VIPPrice3"];
//        self.vipPrice4 = [aDecoder decodeFloatForKey:@"VIPPrice4"];
//        self.isFreightFee = [aDecoder decodeBoolForKey:@"IsFreightFee"];
//        self.isBook = [aDecoder decodeBoolForKey:@"IsBook"];
//        
//        self.cateGoryName = [aDecoder decodeObjectForKey:@"CategoryName"];
//        self.subCategoryName = [aDecoder decodeObjectForKey:@"SubCategoryName"];
//        self.shopName = [aDecoder decodeObjectForKey:@"ShopName"];
//        self.shopUrl = [aDecoder decodeObjectForKey:@"ShopUrl"];
//        
//        self.promotionPrice = [aDecoder decodeFloatForKey:@"PromotionPrice"];
//        self.promotionExpriedSeconds = [aDecoder decodeIntForKey:@"PromotionExpriedSeconds"];
//        self.skuRemark = [aDecoder decodeObjectForKey:@"SkuRemark"];
//        self.skuComsId = [aDecoder decodeObjectForKey:@"SkuComsId"];
//        
//    }
//    return self;
//}

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
}

@end
