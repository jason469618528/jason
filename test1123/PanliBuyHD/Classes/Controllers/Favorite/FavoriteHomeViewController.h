//
//  FavoriteHomeViewController.h
//  PanliBuyHD
//
//  Created by guo on 14-10-10.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "BaseViewController.h"
#import "FavoriteProductsOrShopsRequest.h"
#import "CustomerExceptionView.h"
#import "CustomTableViewController.h"
#import "DeleteFavoriteOrShopRequest.h"
typedef enum FavoriteViewType
{
    view_Products = 0,
    view_Category = 1,
    view_Shops = 2,
}FavoriteType;

typedef enum FavoriteRefresh
{
    refresh_All = 0,
    refresh_Product = 1,
    refresh_Category = 2,
    refresh_Shop = 3,
}FavoriteRefreshType;

@interface FavoriteHomeViewController : BaseViewController<CustomTableViewControllerDelegate>
{
    //右侧的TableView
    CustomTableViewController *_displayFavoriteInfoTable;
    
    //左侧 收藏分类 数据源
    NSArray *_favoriteCategoryArray;
    
    //右侧 收藏详细信息 数据源
    NSMutableArray *_productsDetailedArray;
    NSMutableArray *_shopsDetailedArray;
    
    //当前选中 收藏分类 的cell索引 和 cell的显示名字
    int _currentIndex;
    
    //请求 收藏的商品或店铺
    FavoriteProductsOrShopsRequest *favorite_Products_Request;
    DataRepeater *repeater_Favorite_Products;
    
    //请求 收藏的店铺
    FavoriteProductsOrShopsRequest *favorite_Shops_Request;
    DataRepeater *repeater_Favorite_Shops;
    
    //接收 返回的数据--收藏的商品
    DataRepeater *_productsRepeater;
    //接收 返回的数据--收藏的店铺
    DataRepeater *_shopsRepeater;
    
    //删除 收藏信息
    DeleteFavoriteOrShopRequest *req_DeleteFavoriteOnly;
    DataRepeater *data_DeleteFavoriteOnly;
    
    //页码
    int _pageIndexProduct;
    int _pageIndexShop;
    
    //是否是下拉刷新
    BOOL _isRequestAll;
    BOOL _isPullDownProduct;
    BOOL _isPullDownShop;
    
    //当前显示view
    FavoriteType viewType;
    
    //异常视图
    CustomerExceptionView *_info_ExceptionView;
    
}

@property (retain, nonatomic) CustomTableViewController *displayFavoriteInfoTable;
@property (retain, nonatomic) NSArray *favoriteCategoryArray;
@property (retain, nonatomic) NSMutableArray *productsDetailedArray;
@property (retain, nonatomic) NSMutableArray *shopsDetailedArray;
@property (retain, nonatomic) CustomerExceptionView *info_ExceptionView;

@property (assign, nonatomic) int pageIndexProduct;
@property (assign, nonatomic) int pageIndexShop;
@property (assign, nonatomic) BOOL isRequestAll;
@property (assign, nonatomic) BOOL isPullDownProduct;
@property (assign, nonatomic) BOOL isPullDownShop;

@property (assign, nonatomic) int currentIndex;
@property (retain, nonatomic) DataRepeater *productsRepeater;
@property (retain, nonatomic) DataRepeater *shopsRepeater;

@property (weak, nonatomic) IBOutlet UITableView *favoriteCategoryTable;

@end
