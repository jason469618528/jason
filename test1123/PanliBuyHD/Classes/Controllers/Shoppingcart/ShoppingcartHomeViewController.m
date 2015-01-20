//
//  ShoppingcartHomeViewController.m
//  PanliBuyHD
//
//  Created by Liubin on 14-6-16.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "ShoppingcartHomeViewController.h"
#import "ShoppingHomeCell.h"
#import "UserInfo.h"
#define BTN_ALL_SELECT 9001
#define BTN_SUBMIT 9002
@interface ShoppingcartHomeViewController ()
/**
 *正在修改数量或备注的商品
 */
@property (nonatomic, strong) ShoppingCartProduct *editingProduct;
@end

@implementation ShoppingcartHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [PanliHelper setExtraCellLineHidden:self.tab_Shopping];
    [PanliHelper setExtraCellPixelExcursion:self.tab_Shopping];
    //init
    self.marr_ShoppingCart = [[NSMutableArray alloc] init];
    [self reloadTotalPrice];
    
    /**********************************************************************
     *****************************无数据view********************************
     **********************************************************************/
    noneDataView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, MainScreenFrame_Height)];
    noneDataView.backgroundColor = [PanliHelper colorWithHexString:@"#ebebeb"];
    noneDataView.hidden = YES;
    [self.view insertSubview:noneDataView aboveSubview:self.tab_Shopping];
    
    UIImageView *icon_cart = [[UIImageView alloc] init];
    icon_cart.frame = CGRectMake((MainScreenFrame_Width - 117) /2,(MainScreenFrame_Height - 80)/2, 117, 94);
    icon_cart.image = [UIImage imageNamed:@"bg_Cart_NULL"];
    [noneDataView addSubview:icon_cart];
    
    UILabel *lab_Title = [[UILabel alloc]initWithFrame:CGRectMake(icon_cart.frame.origin.x - 20.0f, icon_cart.frame.origin.y + 94.0f + 10.0f, 200, 17)];
    lab_Title.backgroundColor = PL_COLOR_CLEAR;
    lab_Title.textColor = [PanliHelper colorWithHexString:@"#a2a2a2"];
    lab_Title.font = DEFAULT_FONT(16);
    lab_Title.text = LocalizedString(@"ShoppingcartHomeViewController_labTitle",@"您的购物车暂时为空");
    [noneDataView addSubview:lab_Title];
    
//    UIButton *btn_back = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn_back.tag = 1003;
//    btn_back.frame = CGRectMake(75, 260, 161, 43);
//    [btn_back setBackgroundImage:[UIImage imageNamed:@"btn_GoHome"]forState:UIControlStateNormal];
//    [btn_back setBackgroundImage:[UIImage imageNamed:@"btn_GoHome_on"] forState:UIControlStateHighlighted];
//    [btn_back addTarget:self action:@selector(shoppingCartButtonClick:)forControlEvents:UIControlEventTouchUpInside];
//    [noneDataView addSubview:btn_back];

    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.isAllSelect = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:@"SET_CART_COUNT_KEYBOARDSHOW" object:nil];
    
    //键盘隐藏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:@"SET_CART_COUNT_KEYBOARDHIDE" object:nil];
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(editProductCountResponse:)
//                                                 name:RQNAME_SHOPCART_PRODUCTCOUNT
//                                               object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(editProductRemarkResponse:)
//                                                 name:RQNAME_SHOPCART_REMARKS
//                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(editProductCountRequest:)
                                                 name:@"SET_SHOPPINGCART_PRODUCT_COUNT"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(editProductRemarkRequest:)
                                                 name:@"SET_SHOPPINGCART_PRODUCT_REMARK"
                                               object:nil];

    [super checkLoginWithBlock:
     ^{
         [self getShopCartRequest:YES];
    }];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.marr_ShoppingCart = nil;
    self.editingProduct = nil;
//    req_CartList = nil;
//    req_DeleteProduct = nil;
//    req_SetCartRemark = nil;
//    req_SetProductCount = nil;
//    
//    rpt_CartList = nil;
//    rpt_DeleteProduct = nil;
//    rpt_SetCarRemark = nil;
//    rpt_SetProductCount = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - request and response
-(void)getShopCartRequest:(BOOL)isShowHud
{
    if(isShowHud)
    {
        [self showHUDIndicatorMessage:LocalizedString(@"ShoppingcartHomeViewController_HUDIndMsg1",@"正在加载购物车...")];
    }
    req_CartList = req_CartList ? req_CartList : [[GetCartListRequest alloc] init];
    rpt_CartList = rpt_CartList ? rpt_CartList : [[DataRepeater alloc] initWithName:RQNAME_SHOPCART_LIST];
    rpt_CartList.notificationName = RQNAME_SHOPCART_LIST;
    __weak ShoppingcartHomeViewController *shoppingVC = self;
    rpt_CartList.compleBlock = ^(id repeater)
    {
        [shoppingVC getShopCartResponse:repeater];
    };
    rpt_CartList.isAuth = YES;
    rpt_CartList.requestModal = PullData;
    rpt_CartList.networkRequest = req_CartList;
    [[DataRequestManager sharedInstance] sendRequest:rpt_CartList];
}

-(void)getShopCartResponse:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        [self hideHUD];
        self.marr_ShoppingCart = repeater.responseValue;
    }
    else
    {
        [self showHUDErrorMessage:repeater.errorInfo.message];
        self.marr_ShoppingCart = nil;
    }
    [self refreshView];
}

-(void)deleteProductRequest:(NSIndexPath *)indexPath
{
    [self showHUDIndicatorMessage:LocalizedString(@"ShoppingcartHomeViewController_HUDIndMsg2",@"正在提交...")];
    req_DeleteProduct = req_DeleteProduct ? req_DeleteProduct : [[CartDeleteProductRequest alloc] init];
    ShoppingCartProductList *mProductList = [self.marr_ShoppingCart objectAtIndex:indexPath.section];
    ShoppingCartProduct *mProduct = [mProductList.marr_ProductList objectAtIndex:indexPath.row];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:mProduct.productUrl forKey:RQ_SHOPCARTDELETEPRODUCT_PARAM_PROURLS];
    [params setValue:mProduct.skuComsId forKey:RQ_SHOPCARTDELETEPRODUCT_PARAM_SKUCOMSIDS];
    
    rpt_DeleteProduct = rpt_DeleteProduct ? rpt_DeleteProduct : [[DataRepeater alloc]initWithName:RQNAME_SHOPCART_DELETEPRODUCTS];
    rpt_DeleteProduct.notificationName = RQNAME_SHOPCART_DELETEPRODUCTS;
    __weak ShoppingcartHomeViewController *shoppingVC = self;
    rpt_DeleteProduct.compleBlock = ^(id repeater)
    {
        [shoppingVC deleteProductResponse:repeater];
    };
    rpt_DeleteProduct.isAuth = YES;
    rpt_DeleteProduct.requestModal = PushData;
    rpt_DeleteProduct.requestParameters = params;
    rpt_DeleteProduct.updateDataSouce = indexPath;
    rpt_DeleteProduct.networkRequest = req_DeleteProduct;
    [[DataRequestManager sharedInstance] sendRequest:rpt_DeleteProduct];
}

-(void)deleteProductResponse:(DataRepeater *)repeater
{
    if (repeater.isResponseSuccess)
    {
        [self showHUDSuccessMessage:LocalizedString(@"ShoppingcartHomeViewController_HUDSucMsg1",@"删除成功")];
        //更新数据源
        NSIndexPath *indexPath = repeater.updateDataSouce;
        ShoppingCartProductList *mProductList = [self.marr_ShoppingCart objectAtIndex:indexPath.section];
        ShoppingCartProduct *mProduct = [mProductList.marr_ProductList objectAtIndex:indexPath.row];
        if (mProductList.marr_ProductList.count <= 1)
        {
            [self.marr_ShoppingCart removeObject:mProductList];
        }
        else
        {
            [mProductList.marr_ProductList removeObject:mProduct];
        }
    }
    else
    {
        [self showHUDErrorMessage:repeater.errorInfo.message];
    }
    [self refreshView];
}

-(void)editProductCountRequest:(NSNotification *)sender
{
    [self showHUDIndicatorMessage:LocalizedString(@"ShoppingcartHomeViewController_HUDIndMsg2",@"正在提交...")];
    req_SetProductCount = req_SetProductCount ? req_SetProductCount : [[SetCartProductCountRequest alloc]init];
    rpt_SetProductCount = rpt_SetProductCount ? rpt_SetProductCount : [[DataRepeater alloc]initWithName:RQNAME_SHOPCART_PRODUCTCOUNT];
    
    NSDictionary *setDic = sender.object;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[setDic valueForKey:@"url"] forKey:RQ_SHOPCARTPRODUCTCOUNT_PARAM_URL];
    [params setValue:[setDic valueForKey:@"count"] forKey:RQ_SHOPCARTPRODUCTCOUNT_PARAM_COUNT];
    [params setValue:[setDic valueForKey:@"skuComsIds"] forKey:RQ_SHOPCARTPRODUCTCOUNT_PARAM_SKUCOMSID];
    
    //保留正在修改数量的商品
    self.editingProduct = [setDic valueForKey:@"modifiedProduct"];
    
    rpt_SetProductCount.notificationName = RQNAME_SHOPCART_PRODUCTCOUNT;
    __weak ShoppingcartHomeViewController *shoppingVC = self;
    rpt_SetProductCount.compleBlock = ^(id repeater)
    {
        [shoppingVC editProductCountResponse:repeater];
    };
    rpt_SetProductCount.isAuth = YES;
    rpt_SetProductCount.requestModal = PushData;
    rpt_SetProductCount.requestParameters = params;
    rpt_SetProductCount.updateDataSouce = [setDic valueForKey:@"count"];
    rpt_SetProductCount.networkRequest = req_SetProductCount;
    [[DataRequestManager sharedInstance] sendRequest:rpt_SetProductCount];
}

-(void)editProductCountResponse:(DataRepeater *)repeater
{
    if (repeater.isResponseSuccess)
    {
        [self showHUDSuccessMessage:LocalizedString(@"ShoppingcartHomeViewController_HUDSucMsg2",@"修改数量成功")];
        self.editingProduct.buyNum = [repeater.updateDataSouce intValue];
    }
    else
    {
        [self showHUDErrorMessage:repeater.errorInfo.message];
    }
   [self refreshView];
}

-(void)editProductRemarkRequest:(NSNotification *)sender
{
    [self showHUDIndicatorMessage:LocalizedString(@"ShoppingcartHomeViewController_HUDIndMsg2",@"正在提交...")];
    
    req_SetCartRemark = req_SetCartRemark ? req_SetCartRemark : [[SetCartProductRemarkRequest alloc]init];
    rpt_SetCarRemark = rpt_SetCarRemark ? rpt_SetCarRemark : [[DataRepeater alloc]initWithName:RQNAME_SHOPCART_REMARKS];
    
    NSDictionary *setDic = sender.object;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[setDic valueForKey:@"url"] forKey:RQ_SHOPCARTPAYREMARK_PARAM_PROURL];
    [params setValue:[setDic valueForKey:@"Remark"] forKey:RQ_SHOPCARTPAYREMARK_PARAM_REMARK];
    [params setValue:[setDic valueForKey:@"skuComsIds"] forKey:RQ_SHOPCARTPAYREMARK_PARAM_SKUCOMSID];
    //保留正在修改数量的商品
    self.editingProduct = [setDic valueForKey:@"modifiedProduct"];
    
    
    rpt_SetCarRemark.notificationName = RQNAME_SHOPCART_REMARKS;
    __weak ShoppingcartHomeViewController *shoppingVC = self;
    rpt_SetCarRemark.compleBlock = ^(id repeater)
    {
        [shoppingVC editProductRemarkResponse:repeater];
    };
    rpt_SetCarRemark.isAuth = YES;
    rpt_SetCarRemark.requestModal = PushData;
    rpt_SetCarRemark.requestParameters = params;
    rpt_SetCarRemark.updateDataSouce = [setDic valueForKey:@"Remark"];
    rpt_SetCarRemark.networkRequest = req_SetCartRemark;

    [[DataRequestManager sharedInstance] sendRequest:rpt_SetCarRemark];
}

-(void)editProductRemarkResponse:(DataRepeater *)repeater
{
    if (repeater.isResponseSuccess)
    {
        [self showHUDSuccessMessage:LocalizedString(@"ShoppingcartHomeViewController_HUDSucMsg3",@"修改备注成功")];
        self.editingProduct.remark = repeater.updateDataSouce;
    }
    else
    {
        [self showHUDErrorMessage:repeater.errorInfo.message];
    }
    [self refreshView];
}
- (void)payRequest
{
    [self showHUDIndicatorMessage:LocalizedString(@"ShoppingcartHomeViewController_HUDIndMsg2",@"正在提交...")];
    req_Pay = req_Pay ? req_Pay:[[CartPayRequest alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[self GetSelectedProductUrl] forKey:RQ_SHOPCARTPRODUCTPAY_PARAM_PROURLS];
    NSString *str_SkuComsIds = [self GetSelectedProductSkuComsIds];
    if(![NSString isEmpty:str_SkuComsIds])
    {
        [params setValue:str_SkuComsIds forKey:RQ_SHOPCARTPRODUCTPAY_PARAM_SKUCOMSIDS];
    }
    rpt_Pay = rpt_Pay ? rpt_Pay : [[DataRepeater alloc]initWithName:RQNAME_SHOPCART_PAY];
    rpt_Pay.notificationName = RQNAME_SHOPCART_PAY;
    __weak ShoppingcartHomeViewController *shoppingVC = self;
    rpt_Pay.compleBlock = ^(id repeater)
    {
        [shoppingVC CartPayResponse:repeater];
    };
    rpt_Pay.isAuth = YES;
    rpt_Pay.requestModal = PushData;
    rpt_Pay.requestParameters = params;
    rpt_Pay.networkRequest = req_Pay;
    [[DataRequestManager sharedInstance] sendRequest:rpt_Pay];
}

-(void)CartPayResponse:(DataRepeater *)repeater
{
    if(repeater.isResponseSuccess)
    {
        [self showHUDSuccessMessage:LocalizedString(@"ShoppingcartHomeViewController_HUDSucMsg4",@"提交成功")];
        
        //成功之后把选中的商品删除
        for (ShoppingCartProductList *shopList in self.marr_ShoppingCart)
        {
            //最大邮费
            for (ShoppingCartProduct *product in shopList.marr_ProductList)
            {
                if (product.isSelected)
                {
                    if (shopList.marr_ProductList.count <= 1)
                    {
                        [self.marr_ShoppingCart removeObject:shopList];
                    }
                    else
                    {
                        [shopList.marr_ProductList removeObject:product];
                    }
                }
            }
        }
        
    }
    else
    {
        [self showHUDErrorMessage:repeater.errorInfo.message];
    }
    [self refreshView];
}
/**
 * 功能描述: 请求完成之后刷新view
 * 输入参数: N/A
 * 返 回 值: N/A
 */
-(void)refreshView
{
    [self.tab_Shopping reloadData];
    [self reloadTotalPrice];
    if (self.marr_ShoppingCart && self.marr_ShoppingCart.count > 0)
    {
        noneDataView.hidden = YES;
        self.view_Submit.hidden = NO;
    }
    else
    {
        noneDataView.hidden = NO;
        self.view_Submit.hidden = YES;
    }
}

#pragma mark - keyboard notification
- (void)keyboardWillShow:(NSNotification *)notification
{
    keyboardShowing = YES;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    keyboardShowing = NO;
}



#pragma mark - UITableView Delegate && DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.marr_ShoppingCart.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ShoppingCartProductList *mShoppingCartProductList = (ShoppingCartProductList *)[self.marr_ShoppingCart objectAtIndex:section];
    return mShoppingCartProductList.marr_ProductList.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *shoppingHome = @"shoppingHome";
    ShoppingHomeCell *homeCell = (ShoppingHomeCell*)[tableView dequeueReusableCellWithIdentifier:shoppingHome];
    if(homeCell == nil)
    {
        homeCell= (ShoppingHomeCell *)[[[NSBundle mainBundle] loadNibNamed:@"ShoppingHomeCell" owner:self options:nil] lastObject];
        homeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ShoppingCartProductList *m_Cart = [self.marr_ShoppingCart objectAtIndex:indexPath.section];
    ShoppingCartProduct *mShoppingCartProduct = [m_Cart.marr_ProductList objectAtIndex:indexPath.row];
    UIView *viewBG = [[UIView alloc] init];
    viewBG.backgroundColor = [PanliHelper colorWithHexString:@"#f3f3f3"];
    homeCell.backgroundView = viewBG;
    [homeCell setShopoingHomeView:mShoppingCartProduct];
    return homeCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(keyboardShowing)
    {
        return;
    }
    ShoppingCartProductList *m_Cart = [self.marr_ShoppingCart objectAtIndex:indexPath.section];
    ShoppingCartProduct *mShoppingCartProduct = [m_Cart.marr_ProductList objectAtIndex:indexPath.row];
    //改变商品选中状态
    if (!mShoppingCartProduct.isSelected)
    {
        mShoppingCartProduct.isSelected = YES;
    }
    else
    {
        mShoppingCartProduct.isSelected = NO;
    }
    
    //改变门店选中状态
    BOOL isAllSelected = YES;
    for (ShoppingCartProduct *product in m_Cart.marr_ProductList)
    {
        if (!product.isSelected)
        {
            isAllSelected = NO;
        }
    }
    m_Cart.isSelected = isAllSelected;
    
    //判断是否全选
    BOOL isSelected = YES;
    for (ShoppingCartProductList *cartList in self.marr_ShoppingCart)
    {
        if(cartList.isSelected)
        {
            continue;
        }
        else
        {
            isSelected = NO;
            [(UIButton *)[self.view viewWithTag:BTN_ALL_SELECT] setTitle:LocalizedString(@"ShoppingcartHomeViewController_BTN_ALL_SELECT1",@"全不选") forState:UIControlStateNormal];
            break;
        }
    }
    if (isSelected)
    {
       [(UIButton *)[self.view viewWithTag:BTN_ALL_SELECT] setTitle:LocalizedString(@"ShoppingcartHomeViewController_BTN_ALL_SELECT2",@"全选") forState:UIControlStateNormal];
    }
    self.isAllSelect = isSelected;
    
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndex:indexPath.section];
    [tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationNone];
    //更新总价
    [self reloadTotalPrice];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ShoppingCartProductList *mShoppingCartProductList = (ShoppingCartProductList*)[self.marr_ShoppingCart objectAtIndex:section];
    
    UIView *view_Header = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableView.frame.size.width, 53.0f)];
    view_Header.backgroundColor = [PanliHelper colorWithHexString:@"#e2e2e2"];
    
    //全选
    UIButton *btn_sectionAllSelect = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_sectionAllSelect.tag = section;
    //判断是否全选
    if (mShoppingCartProductList.isSelected)
    {
        [btn_sectionAllSelect setImage:[UIImage imageNamed:@"btn_padSC_isSelect_on"] forState:UIControlStateNormal];
    }
    else
    {
        [btn_sectionAllSelect setImage:[UIImage imageNamed:@"btn_padSC_isSelect"] forState:UIControlStateNormal];
    }

    [btn_sectionAllSelect addTarget:self action:@selector(sectionAllSelect:) forControlEvents:UIControlEventTouchDown];
    btn_sectionAllSelect.frame = CGRectMake(12.0f, -12.0f, 80.0f, 80.0f);
    [view_Header addSubview:btn_sectionAllSelect];
    
    //店铺名
    UILabel *lab_ShopName = [[UILabel alloc] initWithFrame:CGRectMake(100.0f, 20.0f, 433.0f, 16.0f)];
    lab_ShopName.backgroundColor = PL_COLOR_CLEAR;
    lab_ShopName.textColor = [PanliHelper colorWithHexString:@"#6e6e6e"];
    lab_ShopName.text = [NSString stringWithFormat:LocalizedString(@"ShoppingcartHomeViewController_labShopName1",@"店铺:%@"),mShoppingCartProductList.shopName];
    lab_ShopName.font = DEFAULT_FONT(15.0f);
    lab_ShopName.textAlignment = UITextAlignmentLeft;
    [view_Header addSubview:lab_ShopName];
    
    //获取选中商品中的最大邮费
    float maxFreight = 0.0f;
    for (ShoppingCartProduct *product in mShoppingCartProductList.marr_ProductList)
    {
        if (product.isSelected)
        {
            if (product.freight > maxFreight)
            {
                maxFreight = product.freight;
            }
        }
    }
    if (maxFreight > 0)
    {
        lab_ShopName.text =[NSString stringWithFormat:LocalizedString(@"ShoppingcartHomeViewController_labShopName2",@"店铺:%@(运费:￥%.f)"),mShoppingCartProductList.shopName,maxFreight];
    }
    //数量
    UILabel *lab_Count = [[UILabel alloc] initWithFrame:CGRectMake(lab_ShopName.frame.origin.x + lab_ShopName.frame.size.width + 35.0f, 20.0f, 100.0f, 16.0f)];
    lab_Count.backgroundColor = PL_COLOR_CLEAR;
    lab_Count.textColor = [PanliHelper colorWithHexString:@"#6e6e6e"];
    lab_Count.text = LocalizedString(@"ShoppingcartHomeViewController_labCount",@"数量(件)");
    lab_Count.font = DEFAULT_FONT(15.0f);
    [view_Header addSubview:lab_Count];
    
    //商品总价
    UILabel *lab_Price = [[UILabel alloc] initWithFrame:CGRectMake(lab_Count.frame.origin.x + lab_Count.frame.size.width + 35.0f, 20.0f, 100.0f, 16.0f)];
    lab_Price.backgroundColor = PL_COLOR_CLEAR;
    lab_Price.textColor = [PanliHelper colorWithHexString:@"#6e6e6e"];
    lab_Price.text = LocalizedString(@"ShoppingcartHomeViewController_labPrice",@"商品总价(元)");
    lab_Price.font = DEFAULT_FONT(15.0f);
    [view_Header addSubview:lab_Price];
    
    //商品备注
    UILabel *lab_Remark = [[UILabel alloc] initWithFrame:CGRectMake(lab_Price.frame.origin.x + lab_Price.frame.size.width + 35.0f, 20.0f, 140.0f, 16.0f)];
    lab_Remark.backgroundColor = PL_COLOR_CLEAR;
    lab_Remark.textColor = [PanliHelper colorWithHexString:@"#6e6e6e"];
    lab_Remark.text = LocalizedString(@"ShoppingcartHomeViewController_labRemark",@"商品备注(100字内)");
    lab_Remark.font = DEFAULT_FONT(15.0f);
    [view_Header addSubview:lab_Remark];
    return view_Header;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self deleteProductRequest:indexPath];
    }
}

#pragma mark - shoppingCart btnClick envent
//店铺全选
- (void)sectionAllSelect:(UIButton*)btn
{
    NSInteger index = btn.tag;
    ShoppingCartProductList *mShoppingCartList = (ShoppingCartProductList*)[self.marr_ShoppingCart objectAtIndex:index];
    for (ShoppingCartProduct *product in mShoppingCartList.marr_ProductList)
    {
        product.isSelected = !mShoppingCartList.isSelected;
    }
    if (mShoppingCartList.isSelected)
    {
        mShoppingCartList.isSelected = NO;
    }
    else
    {
        mShoppingCartList.isSelected = YES;
    }
    
    NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndex:index];
    [self.tab_Shopping reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationNone];
    for (int i = 0; i <  mShoppingCartList.marr_ProductList.count; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:index];
        [self.tab_Shopping reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    //更新总价
    [self reloadTotalPrice];
    //判断是否全选
    BOOL isAllSelected = YES;
    for (ShoppingCartProductList *cartList in self.marr_ShoppingCart)
    {
        if(cartList.isSelected)
        {
            continue;
        }
        else
        {
            isAllSelected = NO;
            [(UIButton *)[self.view viewWithTag:BTN_ALL_SELECT] setTitle:LocalizedString(@"ShoppingcartHomeViewController_BTN_ALL_SELECT2",@"全选") forState:UIControlStateNormal];
            break;
        }
    }
    if (isAllSelected)
    {
       [(UIButton *)[self.view viewWithTag:BTN_ALL_SELECT] setTitle:LocalizedString(@"ShoppingcartHomeViewController_BTN_ALL_SELECT1",@"全不选") forState:UIControlStateNormal];
    }
    self.isAllSelect = isAllSelected;
}


#pragma mark - btn event
-(IBAction)allSelect:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    switch (btn.tag)
    {
            //全选
        case BTN_ALL_SELECT:
        {
            //反选
            if(self.isAllSelect)
            {
                for (ShoppingCartProductList *m_Cart in self.marr_ShoppingCart)
                {
                    m_Cart.isSelected = NO;
                    for (ShoppingCartProduct *product in m_Cart.marr_ProductList)
                    {
                        product.isSelected = NO;
                    }
                }
                self.isAllSelect = NO;
                [btn setTitle:LocalizedString(@"ShoppingcartHomeViewController_BTN_ALL_SELECT1",@"全不选") forState:UIControlStateNormal];
            }
            //正选
            else
            {
                for (ShoppingCartProductList *m_Cart in self.marr_ShoppingCart)
                {
                    m_Cart.isSelected = YES;
                    for (ShoppingCartProduct *product in m_Cart.marr_ProductList)
                    {
                        product.isSelected = YES;
                    }
                }
                self.isAllSelect = YES;
                [btn setTitle:LocalizedString(@"ShoppingcartHomeViewController_BTN_ALL_SELECT2",@"全选") forState:UIControlStateNormal];
            }
            [self reloadTotalPrice];
            [self.tab_Shopping reloadData];
            break;
        }
            //全选
        case BTN_SUBMIT:
        {
            if([NSString isEmpty:[self GetSelectedProductUrl]])
            {
                [self showHUDErrorMessage:LocalizedString(@"ShoppingcartHomeViewController_HUDErrMsg",@"请选择商品")];
                return;
            }
            [super checkLoginWithBlock:^{
                [self payRequest];
            }];
            break;
        }

    }
}

//计算总价
- (void) reloadTotalPrice
{
    //总价
    self.totalPrice = 0.0f;
    //总邮费
    self.totalFreight = 0.0f;
    for (ShoppingCartProductList *shopList in self.marr_ShoppingCart)
    {
        //最大邮费
        float maxFreight = 0.0f;
        for (ShoppingCartProduct *product in shopList.marr_ProductList)
        {
            if (product.isSelected)
            {
                //判断vip价格
                UserInfo *mUser = [GlobalObj getUserInfo];
                float price = 0.0;
                switch (mUser.userGroup)
                {
                    case NormalUser:
                        price = [PanliHelper getMinPriceWithCostPrice:product.price
                                                       promotionPrice:product.promotionPrice
                                                             vipPrice:0];
                        break;
                    case GoldCard:
                        price = [PanliHelper getMinPriceWithCostPrice:product.price
                                                       promotionPrice:product.promotionPrice
                                                             vipPrice:product.vipPrice1];
                        break;
                    case PlatinumCard:
                        price = [PanliHelper getMinPriceWithCostPrice:product.price
                                                       promotionPrice:product.promotionPrice
                                                             vipPrice:product.vipPrice2];
                        break;
                    case DiamondCard:
                        price = [PanliHelper getMinPriceWithCostPrice:product.price
                                                       promotionPrice:product.promotionPrice
                                                             vipPrice:product.vipPrice3];
                        break;
                    case CrownCars:
                        price = [PanliHelper getMinPriceWithCostPrice:product.price
                                                       promotionPrice:product.promotionPrice
                                                             vipPrice:product.vipPrice4];
                        break;
                    default:
                        price = [PanliHelper getMinPriceWithCostPrice:product.price
                                                       promotionPrice:product.promotionPrice
                                                             vipPrice:0];
                        break;
                }
                
                self.totalPrice += (price * product.buyNum);
                if (product.freight > maxFreight)
                {
                    maxFreight = product.freight;
                }
            }
        }
        self.totalFreight += maxFreight;
        self.totalPrice += maxFreight;
    }
    NSString *str_Total = [NSString stringWithFormat:LocalizedString(@"ShoppingcartHomeViewController_strTotal",@"共计(含运费￥%.2f) : ￥%.2f"),self.totalFreight,self.totalPrice];
    NSString *str_TotalFreight = [NSString stringWithFormat:@"%.2f",self.totalFreight];
    NSString *str_totalprice = [NSString stringWithFormat:@"%.2f",self.totalPrice];
    //富文本
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0"))
    {
        //判断富文本颜色
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:str_Total];
        
        [str addAttribute:NSForegroundColorAttributeName value:[PanliHelper colorWithHexString:@"#6d6d6d"] range:NSMakeRange(0,6)];
        
        [str addAttribute:NSForegroundColorAttributeName value:[PanliHelper colorWithHexString:@"#ff8042"] range:NSMakeRange(6,str_TotalFreight.length+1)];
        
        [str addAttribute:NSForegroundColorAttributeName value:[PanliHelper colorWithHexString:@"#6d6d6d"] range:NSMakeRange( 6 + str_TotalFreight.length+1,1)];
        
        [str addAttribute:NSForegroundColorAttributeName value:[PanliHelper colorWithHexString:@"#ff8042"] range:NSMakeRange( 6 + str_TotalFreight.length + 2,str_totalprice.length + 4)];
        
        self.lab_submitPrice.attributedText = str;
    }
    else
    {
        self.lab_submitPrice.text = str_Total;
    }
    
    if (self.isAllSelect)
    {
        [(UIButton *)[self.view viewWithTag:BTN_ALL_SELECT] setTitle:LocalizedString(@"ShoppingcartHomeViewController_BTN_ALL_SELECT1",@"全不选") forState:UIControlStateNormal];
    }
    else
    {
        [(UIButton *)[self.view viewWithTag:BTN_ALL_SELECT] setTitle:LocalizedString(@"ShoppingcartHomeViewController_BTN_ALL_SELECT2",@"全选") forState:UIControlStateNormal];
    }
}

/**
 * 功能描述: 拼接选中的url
 * 输入参数: N/A
 * 返 回 值: url列表
 */
- (NSString *)GetSelectedProductUrl
{
    NSString *proUrlList = @"";
    for (ShoppingCartProductList *shopList in self.marr_ShoppingCart)
    {
        for (ShoppingCartProduct *product in shopList.marr_ProductList)
        {
            if (product.isSelected)
            {
                if (![NSString isEmpty:proUrlList])
                {
                    proUrlList = [proUrlList stringByAppendingString:@","];
                }
                proUrlList = [proUrlList stringByAppendingString:product.productUrl];
            }
        }
    }
    return proUrlList;
}

/**
 * 功能描述: 拼接选中的skuComsId
 * 输入参数: N/A
 * 返 回 值: SkuComsid列表
 */
- (NSString *)GetSelectedProductSkuComsIds
{
    NSString *proSkuIDList = @"";
    int selectCount = 0;
    
    for (ShoppingCartProductList *shopList in self.marr_ShoppingCart)
    {
        for (ShoppingCartProduct *product in shopList.marr_ProductList)
        {
            if (product.isSelected)
            {
                if (selectCount != 0)
                {
                    proSkuIDList = [proSkuIDList stringByAppendingString:@","];
                }
                proSkuIDList = [proSkuIDList stringByAppendingString:product.skuComsId];
                selectCount ++;
            }
        }
    }
    return proSkuIDList;
}
@end
