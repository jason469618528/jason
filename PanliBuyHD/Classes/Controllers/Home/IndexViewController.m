//
//  IndexViewController.m
//  PanliBuyHD
//
//  Created by Liubin on 14-6-16.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "IndexViewController.h"
#import "LoginViewController.h"
#import "HelpBuyProductDetail.h"
#import "UserInfo.h"
#define DEFAULT_LIVE_COLOR [PanliHelper colorWithHexString:@"#cecece"]
#define INDEX_CELL_HEIGHT 60.0f
@interface IndexViewController ()
@end

@implementation IndexViewController
#pragma mark - Default
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
           return self;
}

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tab_Category.backgroundColor = [PanliHelper colorWithHexString:@"#f1f1f1"];
    //init数据
    _currentIndex = 0;
    isLoading = YES;
    [self.web_Category setScalesPageToFit:YES];
    arr_Data = [[NSMutableArray alloc] init];
    NSArray *arr_Name = @[LocalizedString(@"IndexViewController_arrName_item1",@"淘宝"),
                          LocalizedString(@"IndexViewController_arrName_item2",@"京东商城"),
                          LocalizedString(@"IndexViewController_arrName_item3",@"当当网"),
                          LocalizedString(@"IndexViewController_arrName_item4",@"易讯网"),
                          LocalizedString(@"IndexViewController_arrName_item5",@"亚马逊"),
                          LocalizedString(@"IndexViewController_arrName_item6",@"拍拍"), @"VANCL",
                          LocalizedString(@"IndexViewController_arrName_item7",@"唯品会")];
    NSArray *arr_Url =  [NSArray arrayWithObjects:@"http://www.taobao.com/",@"http://www.jd.com/",@"http://www.dangdang.com/",@"http://www.yixun.com/",@"http://www.amazon.cn/ref=z_cn?tag=zcn0e-23",@"http://www.paipai.com/",@"http://www.vancl.com/?source=bdzqbtd56a1cce0ea3fe76",@"http://www.vip.com/?utm_source=baiduzone", nil];
    for(int i = 0;i < arr_Name.count;i++)
    {
        indexCategory *mCategory = [[indexCategory alloc] init];
        mCategory.str_Name = [arr_Name objectAtIndex:i];
        mCategory.str_Url = [arr_Url objectAtIndex:i];
        [arr_Data addObject:mCategory];
    }
    
    //tableview 侧边线条
    UIView *view_Broadside = [[UIView alloc] initWithFrame:CGRectMake(self.tab_Category.frame.size.width - 1.5f, arr_Data.count * INDEX_CELL_HEIGHT, 1.5f, self.tab_Category.frame.size.height  - arr_Data.count * INDEX_CELL_HEIGHT)];
    view_Broadside.backgroundColor = DEFAULT_LIVE_COLOR;
    [self.tab_Category addSubview:view_Broadside];
    
    //load url
    [self webViewLoad:_currentIndex];
    //添加button
    [self reloadButton];
    //详情委托
    self.view_BuyDetail.skuDelegate = self;
    //重新加载详情
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshHelpProductDetail:)
                                                 name:@"HELPBUYPRODUCTDETIL_REFRESH"
                                               object:nil];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadButton
{
    //webView 刷新与返回
    UIButton *btn_goBack = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn_goBack.tag = 8001;
    [btn_goBack setImage:[UIImage imageNamed:@"btn_padHome_GoBack"] forState:UIControlStateNormal];
    btn_goBack.frame = CGRectMake(self.web_Category.frame.size.width - 2*INDEX_CELL_HEIGHT - 10.0f, 580.0f, INDEX_CELL_HEIGHT, INDEX_CELL_HEIGHT);
    [btn_goBack addTarget:self action:@selector(webViewBtnClick:) forControlEvents:UIControlEventTouchDown];
    [self.web_Category addSubview:btn_goBack];
    
    UIButton *btn_Refresh = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Refresh.tag = 8002;
    [btn_Refresh setImage:[UIImage imageNamed:@"btn_padHome_Refresh"] forState:UIControlStateNormal];
    btn_Refresh.frame = CGRectMake(btn_goBack.frame.origin.x + INDEX_CELL_HEIGHT, 580.0f, INDEX_CELL_HEIGHT, INDEX_CELL_HEIGHT);
    [btn_Refresh addTarget:self action:@selector(webViewBtnClick:) forControlEvents:UIControlEventTouchDown];
    [self.web_Category addSubview:btn_Refresh];

}
#pragma mark - btnClick
- (void)webViewBtnClick:(UIButton*)btn
{
    isLoading = YES;
    //设置请求无效
    [req_ProDetail.request clearDelegatesAndCancel];
    if(btn.tag == 8001)
    {
        //返回
        [self.web_Category goBack];
    }
    else
    {
        //刷新
        [self.web_Category reload];
    }
}

#pragma mark - button && webView FrameSize
- (void)reloadButtonFrame:(BOOL)isShow
{
    [UIView animateWithDuration:0.5 animations:^{
    //判断webView 显示位置
    if(isShow)
    {
        self.web_Category.frame = CGRectMake(self.web_Category.frame.origin.x, self.web_Category.frame.origin.y, MainScreenFrame_Width - self.tab_Category.frame.size.width - self.view_BuyDetail.frame.size.width , self.web_Category.frame.size.height);

        self.view_BuyDetail.frame = CGRectMake(MainScreenFrame_Width - self.view_BuyDetail.frame.size.width , 0.0f, self.view_BuyDetail.frame.size.width, self.view_BuyDetail.frame.size.height);
    }
    else
    {
        self.web_Category.frame = CGRectMake(self.web_Category.frame.origin.x, self.web_Category.frame.origin.y, MainScreenFrame_Width - self.tab_Category.frame.size.width, self.web_Category.frame.size.height);
        self.view_BuyDetail.frame = CGRectMake(MainScreenFrame_Width, 0.0f, self.view_BuyDetail.frame.size.width, self.view_BuyDetail.frame.size.height);
    }
    //重新计算button的位置
    UIButton *btn_goBack = (UIButton*)[self.view viewWithTag:8001];
     btn_goBack.frame = CGRectMake(self.web_Category.frame.size.width - 2*INDEX_CELL_HEIGHT - 10.0f, 580.0f, INDEX_CELL_HEIGHT, INDEX_CELL_HEIGHT);
    UIButton *btn_Refresh = (UIButton*)[self.view viewWithTag:8002];
    btn_Refresh.frame = CGRectMake(btn_goBack.frame.origin.x + INDEX_CELL_HEIGHT, 580.0f, INDEX_CELL_HEIGHT, INDEX_CELL_HEIGHT);
    }];
}

#pragma mark - didSelectSkuDelegate
- (void)didSelectSku:(SkuCombination *)iSkuCombination productCount:(int)count productRemark:(NSString *)remark
{
     //添加到购物车
    self.mSkuCombination = iSkuCombination;
    productCount = count;
    str_productRemark = remark;
    [self AddProductToCart];
}

- (void)hideDetail
{
    //隐藏详情委托
    [self reloadButtonFrame:NO];
}

#pragma mark - UIWebView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    DLOG(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    DLOG(@"webViewDidFinishLoad");
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    DLOG(@"request.URL:---------%@request.URL.baseURL----%@",request.URL,request.mainDocumentURL);
    NSString *str_URL = [NSString stringWithFormat:@"%@",request.mainDocumentURL];
    
    
    //匹配第三方网站
    NSRange eRangeSource = [str_URL rangeOfString:@"."];
    NSRange sourceRange = NSMakeRange(eRangeSource.location+1, str_URL.length - eRangeSource.location-1);
    NSString *source = [str_URL substringWithRange:sourceRange];
    NSRange endRangSource = [source rangeOfString:@"."];
    NSInteger endRangSourceIndex = endRangSource.location;
    NSRange endRange = NSMakeRange(0, endRangSourceIndex);
    NSString *endSource = [source substringWithRange:endRange];
    
    
    HelpBuySourceState sourceState = [super resuleIsHelpBuySourceType:endSource];
    BOOL isDetailShow = NO;
    
    //匹配是否商品详情
    NSRange eRange = [str_URL rangeOfString:@"."];
    NSInteger endIndex = eRange.location;
    NSRange codeRange = NSMakeRange(7, endIndex - 7);
    NSString *code = [str_URL substringWithRange:codeRange];
    switch (sourceState)
    {
        case taobao:
        {
            if([code isEqualToString:@"item"] || [code isEqualToString:@"detail"])
            {
                isDetailShow =  YES;
            }
            break;
        }
        case jd:
        {
            if([code isEqualToString:@"item"])
            {
                isDetailShow =  YES;
            }
            break;
        }
        case dangdang:
        {
            if([code isEqualToString:@"product"])
            {
                isDetailShow =  YES;
            }
            break;
        }
        case yixun:
        {
            if([code isEqualToString:@"item"])
            {
                isDetailShow =  YES;
            }
            break;
        }
        case amazon:
        {
            if([str_URL contains:@"product"])
            {
                isDetailShow =  YES;
            }
            break;
        }
        case paipai:
        {
            if([code isEqualToString:@"auction1"])
            {
                isDetailShow =  YES;
            }
            break;
        }
        case vancl:
        {
            if([code isEqualToString:@"item"])
            {
                isDetailShow =  YES;
            }
            break;
        }
        case vip:
        {
            if([str_URL contains:@"detail"])
            {
                isDetailShow =  YES;
            }
            break;
        }
            
        default:
        {
            isDetailShow =  NO;
            break;
        }
    }
    if(str_detailUrl)
    {
        str_detailUrl = nil;
    }
    //匹配到商品详情加载view 请求
    if(isDetailShow)
    {
//        self.view_BuyDetail.hidden = NO;
//        [UIView animateWithDuration:0.5 animations:^{
//            self.view_BuyDetail.frame = CGRectMake(UI_SCREEN_HEIGHT - self.tab_Category.frame.size.width - self.web_Category.frame.size.width, 0.0f, self.view_BuyDetail.frame.size.width, self.view_BuyDetail.frame.size.height);
//        }];
        
        str_detailUrl = str_URL;
        if(isLoading)
        {
            [self requestProductDetail];
        }
        isLoading = NO;
        [self reloadButtonFrame:YES];
    }
    else
    {
//        [UIView animateWithDuration:0.5 animations:^{
//            self.view_BuyDetail.frame = CGRectMake(UI_SCREEN_HEIGHT, 0.0f, self.view_BuyDetail.frame.size.width, self.view_BuyDetail.frame.size.height);
//        }];

//        self.view_BuyDetail.hidden = YES;
        [self reloadButtonFrame:NO];
    }
    
    return YES;
}

#pragma mark - UITableView Delegate && DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_Data.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *homeCategory = @"homeCategory";
    UITableViewCell *homeCell = [tableView dequeueReusableCellWithIdentifier:homeCategory];
    if(homeCell == nil)
    {
        homeCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeCategory];
        //名称
        UILabel *lab_Name = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 23.0f, 90.0f, 18.0f)];
        lab_Name.tag = 9001;
        lab_Name.font = DEFAULT_FONT(17.0f);
        lab_Name.backgroundColor = PL_COLOR_CLEAR;
        lab_Name.textColor = [PanliHelper colorWithHexString:@"#a5a5a5"];
        lab_Name.textAlignment = NSTextAlignmentCenter;
        [homeCell addSubview:lab_Name];

        //选中背景
        UIView *view_IsSelectBg = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 7.5f, INDEX_CELL_HEIGHT)];
        view_IsSelectBg.tag = 9002;
        view_IsSelectBg.backgroundColor = [PanliHelper colorWithHexString:@"#83c14a"];
        [homeCell addSubview:view_IsSelectBg];
        
        //底部线条
        UIView *view_Bottom = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 58.5f, tableView.frame.size.width, 1.5f)];
        view_Bottom.tag = 9003;
        view_Bottom.backgroundColor = DEFAULT_LIVE_COLOR;
        [homeCell addSubview:view_Bottom];
        
        //侧边线条
        UIView *view_Broadside = [[UIView alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 1.5f, 0.0f, 1.5f, INDEX_CELL_HEIGHT)];
        view_Broadside.tag = 9004;
        view_Broadside.backgroundColor = DEFAULT_LIVE_COLOR;
        [homeCell addSubview:view_Broadside];
        
        //顶部线条
        UIView *view_Top = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableView.frame.size.width, 1.5f)];
        view_Top.tag = 9005;
        view_Top.backgroundColor = DEFAULT_LIVE_COLOR;
        [homeCell addSubview:view_Top];
        
        homeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UILabel *lab_Name = (UILabel*)[homeCell viewWithTag:9001];
    indexCategory *mCategory = [arr_Data objectAtIndex:indexPath.row];
    lab_Name.text = mCategory.str_Name;
    //判断当前选中
    UIView *view_IsSelectBg = (UIView*)[homeCell viewWithTag:9002];
    UIView *view_Bottom = (UIView*)[homeCell viewWithTag:9003];
    UIView *view_Broadside = (UIView*)[homeCell viewWithTag:9004];
    UIView *view_Top = (UIView*)[homeCell viewWithTag:9005];

    if(_currentIndex == indexPath.row)
    {
        view_IsSelectBg.hidden = NO;
        view_Bottom.hidden = NO;
        view_Broadside.hidden = YES;
        view_Top.hidden = indexPath.row == 0 ? YES : NO;
        homeCell.backgroundColor = [PanliHelper colorWithHexString:@"#ffffff"];
    }
    else
    {
        view_IsSelectBg.hidden = YES;
        view_Bottom.hidden = YES;
        view_Broadside.hidden = NO;
        view_Top.hidden = YES;
        homeCell.backgroundColor = [PanliHelper colorWithHexString:@"#f1f1f1"];
    }
    return homeCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //判断是否点击同一个cell 不刷新
    if(_currentIndex != indexPath.row)
    {
        isLoading = YES;
        //删除之前的webview
        if(self.web_Category)
        {
            [self.web_Category removeFromSuperview];
            self.web_Category = nil;
        }
        if(self.web_Category == nil)
        {
            //重新加载webview
            self.web_Category = [[UIWebView alloc] initWithFrame:CGRectMake(self.tab_Category.frame.size.width, 0, MainScreenFrame_Width - self.tab_Category.frame.size.width, MainScreenFrame_Height - 72.0f - 20.0f)];
            self.web_Category.delegate = self;
            self.web_Category.autoresizesSubviews = YES;
            self.web_Category.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            [self.web_Category setScalesPageToFit:YES];
            [self.view addSubview:self.web_Category];
            //刷新button与buttonframe
            [self reloadButton];
            [self reloadButtonFrame:NO];
        }
        //加载Url
        _currentIndex = indexPath.row;
        [self webViewLoad:_currentIndex];
        [tableView reloadData];
    }
}
#pragma mark - webViewLoad Star
- (void)webViewLoad:(NSInteger)index
{
    indexCategory *mCategory = [arr_Data objectAtIndex:_currentIndex];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:mCategory.str_Url]];
    [self.web_Category loadRequest:request];
}

#pragma mark - request && response (productdetail)
//商品详情
-(void)requestProductDetail
{
    [self.view_BuyDetail reloadView:loading data:self.mSnatchProducts];
    req_ProDetail = req_ProDetail ? req_ProDetail : [[HelpBuyProductsDetailRequest alloc] init];
    rpt_ProDetail = rpt_ProDetail ? rpt_ProDetail : [[DataRepeater alloc]initWithName:RQNAME_FAVORITESPRODUCTDETAIL];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:str_detailUrl forKey:RQ_FAVORITE_PRODUCT_DETAIL_PARM_PRODUCTURL];
    UserInfo *mUserInfo = [GlobalObj getUserInfo];
    [params setValue:mUserInfo.userId forKey:RQ_FAVORITE_PRODUCT_DETAIL_PARM_USERID];
    rpt_ProDetail.requestParameters = params;
    rpt_ProDetail.notificationName = RQNAME_FAVORITESPRODUCTDETAIL;
    __weak IndexViewController *indexVC = self;
    rpt_ProDetail.compleBlock = ^(id repeater)
    {
        [indexVC GetProductDetail:repeater];
    };
    rpt_ProDetail.requestModal = PushData;
    rpt_ProDetail.networkRequest = req_ProDetail;
    [[DataRequestManager sharedInstance] sendRequest:rpt_ProDetail];
}

-(void)GetProductDetail:(DataRepeater *)repeater
{
    if(repeater.isResponseSuccess)
    {
        self.mSnatchProducts = repeater.responseValue;
        if (self.mSnatchProducts.price < 0)
        {
            [MBProgressHUD showInView:self.view_BuyDetail errorMessage:LocalizedString(@"IndexViewController_HUDErrMsg",@"该商品已下架")];
        }
        else
        {
            [self.view_BuyDetail reloadView:success data:self.mSnatchProducts];
        }
    }
    else
    {
        DLOG(@"%@",repeater.errorInfo.message);
        [self.view_BuyDetail reloadView:error data:self.mSnatchProducts];
    }
}
- (void)refreshHelpProductDetail:(NSNotificationCenter*)sender
{
    [self requestProductDetail];
}
#pragma mark - request && response (addProductsToCart)
-(void)AddProductToCart
{
    //开始发送网络请求
    [MBProgressHUD showInView:self.view_BuyDetail indicatorMessage:LocalizedString(@"IndexViewController_HUDIndMsg",@"正在提交代购...")];
    req_AddCart = req_AddCart ? req_AddCart : [[AddProductToCartRequest alloc] init];
    rpt_AddCart = rpt_AddCart ? rpt_AddCart : [[DataRepeater alloc]initWithName:RQNAME_ADDTOCART];
    //拼接Sku备注
    NSString *skuRemark = @"";
    if (self.mSkuCombination)
    {
        NSArray *skuArray = [self.mSnatchProducts.skus filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.skuId in %@",self.mSkuCombination.skuIds]];
        for (SkuObject *sku in skuArray)
        {
            skuRemark = [skuRemark stringByAppendingString:sku.propertyName];
            skuRemark = [skuRemark stringByAppendingString:@";"];
        }
    }
    else
    {
        skuRemark = nil;
    }
    
    //开始发送网络请求
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:self.mSkuCombination.combinationId forKey:RQ_ADDTOCART_PARM_SKUCOMBINATIONID];
    [params setValue:self.mSnatchProducts.productUrl forKey:RQ_ADDTOCART_PARM_PRODUCTURL];
    [params setValue:[NSString stringWithFormat:@"%d",productCount] forKey:RQ_ADDTOCART_PARM_BUYNUM];
    [params setValue:str_productRemark forKey:RQ_ADDTOCART_PARM_REMARK];
    [params setValue:self.mSnatchProducts.mark forKey:RQ_ADDTOCART_PARM_MARK];
    [params setValue:skuRemark forKey:RQ_ADDTOCART_PARM_SKUREMARK];
//    [params setValue:[NSString stringWithFormat:@"%d",_sourceType] forKey:RQ_ADDTOCART_PARM_SOURCE];
    rpt_AddCart.requestParameters = params;
    rpt_AddCart.notificationName = RQNAME_ADDTOCART;
    __weak IndexViewController *indexVC = self;
    rpt_AddCart.compleBlock = ^(id repeater)
    {
        [indexVC AddProductToCart:repeater];
    };
    rpt_AddCart.requestModal = PushData;
    rpt_AddCart.networkRequest = req_AddCart;
    [[DataRequestManager sharedInstance] sendRequest:rpt_AddCart];
}
-(void)AddProductToCart:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        [MBProgressHUD showInView:self.view_BuyDetail successMessage:LocalizedString(@"IndexViewController_HUDSucMsg",@"代购成功")];
//        [self reuqestCartNum];
    }
    else
    {
        [MBProgressHUD showInView:self.view_BuyDetail errorMessage:repeater.errorInfo.message];
    }
}

@end
