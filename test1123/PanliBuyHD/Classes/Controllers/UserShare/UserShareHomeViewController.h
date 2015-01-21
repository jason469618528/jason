//
//  UserShareHomeViewController.h
//  PanliApp
//
//  Created by Liubin on 13-12-10.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserShareProductsRequest.h"
#import "CustomTableViewController.h"
#import "UserShareHomeCell.h"
#import "UserShareHomeTwoCell.h"
#import "UserShareFilterView.h"
#import "PageData.h"
#import "CustomerExceptionView.h"
#import "ShareProduct.h"
#import "BaseViewController.h"

/**************************************************
 * 内容描述: 用户分享首页
 * 创 建 人: 刘彬
 * 创建日期: 2013-12-10
 **************************************************/
@interface UserShareHomeViewController : BaseViewController<CustomTableViewControllerDelegate,UserShareHomeCellDelegate,UserShareFilterViewDelegate>
{
    UIButton *btn_navMenu;
    
    UIImageView *img_navMenu;
    
    UserShareFilterView *filterView;
    
    //已到货商品列表
    CustomTableViewController *tab_ReceivedProducts;
    
    //已分享商品列表
    CustomTableViewController *tab_SharedProducts;
    
    //赞过的商品列表
    CustomTableViewController *tab_PraisedProducts;

    //异常view
    CustomerExceptionView *exceptionView;
    
    //数据转发器
    DataRepeater *rpt_ReceivedProducts;
    DataRepeater *rpt_SharedProducts;
    DataRepeater *rpt_PraisedProducts;
    
    //数据请求
    UserShareProductsRequest *req_ReceivedProducts;
    UserShareProductsRequest *req_SharedProducts;
    UserShareProductsRequest *req_PraisedProducts;
    
    //是否第一次请求
    BOOL isFirstRequestReceived;
    BOOL isFirstRequestShared;
    BOOL isFirstRequestPraised;
    
    //页码
    int pageIndexReceived;
    int pageIndexShared;
    int pageIndexPraised;
    
    //是否正在请求过程中
    BOOL isRequestingReceived;
    BOOL isRequestingShared;
    BOOL isRequestingPraised;
    
    //当前显示的页面类型(0-分享商品 1-分享过的商品 2-赞过的商品)
    int showFlag;
}

/**
 *已收货的商品数据源
 */
@property (nonatomic, retain) NSMutableArray *receivedProductArray;

/**
 *已分享的商品数据源
 */
@property (nonatomic, retain) NSMutableArray *sharedProductArray;

/**
 *赞过的商品数据源
 */
@property (nonatomic, retain) NSMutableArray *praisedProductArray;


@end
