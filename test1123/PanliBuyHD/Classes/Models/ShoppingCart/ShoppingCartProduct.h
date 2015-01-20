//
//  ShoppingCart.h
//  PanliApp
//
//  Created by jason on 13-5-4.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
@interface ShoppingCartProduct : Product

{
    int _buyNum;
    NSString *_dateCreated;
    BOOL _isAction;
    BOOL _isCombinationMeal;
    NSString *_itemId;
    NSString *_remark;
    float _vipPrice1;
    float _vipPrice2;
    float _vipPrice3;
    float _vipPrice4;
    BOOL _isFreightFee;
    BOOL _isBook;
    NSString *_cateGoryName;
    NSString *_subCategoryName;
    NSString *_shopName;
    NSString *_shipUrl;
    BOOL _isSelected;
    
    //优惠价
    float _promotionPrice;
    //促销价过期剩余时间(秒)
    int _promotionExpriedSeconds;
    NSString *_skuRemark;
    NSString *_skuComsId;
}
/**
 *购买数量
 */
@property (nonatomic, unsafe_unretained) int buyNum;

/**
 *创建时间
 */
@property(nonatomic,strong) NSString * dateCreated;

/**
 *
 */
@property (nonatomic, unsafe_unretained) BOOL  isAction;

/**
 *
 */
@property(nonatomic,unsafe_unretained) BOOL isCombinationMeal;

/**
 *ItemId
 */
@property (nonatomic, strong) NSString* itemId;


/**
 *备注
 */
@property (nonatomic, strong) NSString * remark;

/**
 *vip1
 */
@property(nonatomic,unsafe_unretained) float vipPrice1;

/**
 *vip2
 */
@property(nonatomic,unsafe_unretained) float vipPrice2;

/**
 *vip3
 */
@property(nonatomic,unsafe_unretained) float vipPrice3;

/**
 *vip3
 */
@property(nonatomic,unsafe_unretained) float vipPrice4;

/**
 *是否运费
 */
@property(nonatomic,unsafe_unretained) BOOL  isFreightFee;

/**
 *isbook
 */
@property(nonatomic,unsafe_unretained) BOOL  isBook;

/**
 *类别名称
 */
@property (nonatomic, strong) NSString * cateGoryName;

/**
 *子类名称
 */
@property (nonatomic, strong) NSString * subCategoryName;

/**
 *店铺名称
 */
@property (nonatomic, strong) NSString * shopName;

/**
 *店铺url
 */
@property(nonatomic,strong) NSString * shopUrl;

/**
 *是否被选中（画面用）
 */
@property (nonatomic, unsafe_unretained) BOOL isSelected;

/**
 *优惠价
 */
@property (nonatomic, unsafe_unretained) float promotionPrice;

/**
 *  促销价过期剩余时间(秒)
 */
@property (nonatomic, assign) int promotionExpriedSeconds;

/**
 *sku备注
 */
@property (nonatomic, strong) NSString * skuRemark;


/**
 *skucomId(组合id)
 */
@property (nonatomic, strong) NSString * skuComsId;

@end
