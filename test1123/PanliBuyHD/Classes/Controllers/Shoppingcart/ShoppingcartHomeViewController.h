//
//  ShoppingcartHomeViewController.h
//  PanliBuyHD
//
//  Created by Liubin on 14-6-16.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "BaseViewController.h"
#import "ShoppingCartProductList.h"
#import "ShoppingCartProduct.h"
#import "GetCartListRequest.h"
#import "CartDeleteProductRequest.h"
#import "SetCartProductCountRequest.h"
#import "SetCartProductRemarkRequest.h"
#import "CartPayRequest.h"
#import "CartDeleteProductRequest.h"
@interface ShoppingcartHomeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    BOOL keyboardShowing;
    
    //获取购物车
    GetCartListRequest *req_CartList;
    DataRepeater *rpt_CartList;
    
    //删除购物车商品
    CartDeleteProductRequest *req_DeleteProduct;
    DataRepeater *rpt_DeleteProduct;
    
    //修改商品数量
    SetCartProductCountRequest *req_SetProductCount;
    DataRepeater *rpt_SetProductCount;
    
    //修改商品备注
    SetCartProductRemarkRequest *req_SetCartRemark;
    DataRepeater *rpt_SetCarRemark;
    
    //购物车支付
    CartPayRequest *req_Pay;
    DataRepeater *rpt_Pay;
    /**
     *无状态
     */
    UIView *noneDataView;
}
/**
 *全选
 */
@property (weak, nonatomic) IBOutlet UIButton *btn_AllSelect;
/**
 *提交价格
 */
@property (strong, nonatomic) IBOutlet UILabel *lab_submitPrice;
/**
 *提交按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *btn_Submit;
/**
 *tableView
 */
@property (strong, nonatomic) IBOutlet UITableView *tab_Shopping;
/**
 *提交View
 */
@property (strong, nonatomic) IBOutlet UIView *view_Submit;
/**
 *数据源
 */
@property (nonatomic, strong) NSMutableArray * marr_ShoppingCart;
/**
 *是否全选
 */
@property (nonatomic, unsafe_unretained) BOOL isAllSelect;
/**
 *总价
 */
@property (nonatomic, unsafe_unretained) float totalPrice;
/**
 *总邮费
 */
@property (nonatomic, unsafe_unretained) float totalFreight;

-(IBAction)allSelect:(id)sender;
@end
