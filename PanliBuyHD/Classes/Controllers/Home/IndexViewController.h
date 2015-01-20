//
//  IndexViewController.h
//  PanliBuyHD
//
//  Created by Liubin on 14-6-16.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "BaseViewController.h"
#import "indexCategory.h"
#import "HelpBuyProductDetail.h"
#import "HelpBuyProductsDetailRequest.h"
#import "SnatchProducts.h"
#import "AddProductToCartRequest.h"
#import "SkuCombination.h"

@interface IndexViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,helpbuySkuDelegate>
{
    /**
     *当前选中
     */
    NSInteger _currentIndex;
    /**
     *数据源
     */
    NSMutableArray *arr_Data;
    /**
     *判断是否重新加载
     */
    BOOL isLoading;
    
    /**
     *获取商品详情URL
     */
    NSString *str_detailUrl;
    
    //商品详情
    HelpBuyProductsDetailRequest *req_ProDetail;
    DataRepeater *rpt_ProDetail;
    
    //添加购物车
    AddProductToCartRequest *req_AddCart;
    DataRepeater *rpt_AddCart;
    
    /**
     *商品数量与备注
     */
    int productCount;
    NSString *str_productRemark;

}

/**
 *webView
 */
@property (strong, nonatomic) IBOutlet UIWebView *web_Category;
/**
 *tableView
 */
@property (strong, nonatomic) IBOutlet UITableView *tab_Category;
/**
 *购物详情
 */
@property (strong, nonatomic) IBOutlet HelpBuyProductDetail *view_BuyDetail;

/**
 *详情数据
 */
@property (nonatomic, strong) SnatchProducts *mSnatchProducts;
/**
 *sku
 */
@property (nonatomic, strong) SkuCombination * mSkuCombination;

@end
