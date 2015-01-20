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

@interface IndexViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
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
}

/**
 *tableView
 */
@property (strong, nonatomic) IBOutlet UITableView *tab_Category;
@end
