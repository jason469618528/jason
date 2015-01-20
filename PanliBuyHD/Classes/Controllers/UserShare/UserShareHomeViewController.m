//
//  UserShareHomeViewController.m
//  PanliApp
//
//  Created by Liubin on 13-12-10.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "UserShareHomeViewController.h"
#import "UserShareViewController.h"
#import "ShareBuyDetailViewController.h"
#import "UpdateVersionView.h"
#import "CustomerUpdateVersion.h"

#define UPDATEVERSION_USERSHAREHOME @"UserShareHomeView"

@interface UserShareHomeViewController ()

@end

#define kPageSizes 10
@implementation UserShareHomeViewController

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(tab_ReceivedProducts);
    SAFE_RELEASE(tab_SharedProducts);
    SAFE_RELEASE(tab_PraisedProducts);
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}


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
//    [super viewDidLoadWithBackButtom:YES];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.backgroundColor = [PanliHelper colorWithHexString:@"#f4f4f4"];
    //顶部目录按钮和下拉view
    btn_navMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_navMenu.frame = CGRectMake(0.0f, 0.0f, 130.0f, 44.0f);
    [btn_navMenu setTitle:LocalizedString(@"UserShareHomeViewController_btnNavMenu",@"分享商品") forState:UIControlStateNormal];
    [btn_navMenu setTitleColor:PL_COLOR_NAVBAR_TITLE forState:UIControlStateNormal];
    [btn_navMenu addTarget:self action:@selector(filterViewAction) forControlEvents:UIControlEventTouchUpInside];
    img_navMenu = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_userShare_menu_down"]];
    img_navMenu.frame = CGRectMake(110.0f, 18.0f, 11.0, 7.5f);
    [btn_navMenu addSubview:img_navMenu];
    [img_navMenu release];
    self.navigationItem.titleView = btn_navMenu;
    
    filterView = [[UserShareFilterView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width - 300, 0.0f)];
    filterView.delegate = self;
    [self.view addSubview:filterView];
    [filterView release];

    //已确认收货
    tab_ReceivedProducts = [[CustomTableViewController alloc] init];
    tab_ReceivedProducts.loadingStyle = head_none;
    tab_ReceivedProducts.view.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Height, MainScreenFrame_Width);
    tab_ReceivedProducts.tableView.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Height - 300, MainScreenFrame_Height - 20 - UI_NAVIGATION_BAR_HEIGHT - 72);
    tab_ReceivedProducts.tableStyle = UITableViewStylePlain;
    tab_ReceivedProducts.tableView.backgroundColor = [PanliHelper colorWithHexString:@"#EEEEEE"];
    tab_ReceivedProducts.tableView.separatorColor = PL_COLOR_CLEAR;
    tab_ReceivedProducts.customTableViewDelegate = self;
    [self.view insertSubview:tab_ReceivedProducts.view belowSubview:filterView];
    
    //已分享
    tab_SharedProducts = [[CustomTableViewController alloc] init];
    tab_SharedProducts.loadingStyle = head_none;
    tab_SharedProducts.view.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, MainScreenFrame_Width);
    tab_SharedProducts.tableView.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Width - 300, MainScreenFrame_Height - 20 - UI_NAVIGATION_BAR_HEIGHT - 72);
    tab_SharedProducts.tableStyle = UITableViewStylePlain;
    tab_SharedProducts.tableView.backgroundColor = [PanliHelper colorWithHexString:@"#EEEEEE"];
    tab_SharedProducts.tableView.separatorColor = PL_COLOR_CLEAR;
    tab_SharedProducts.customTableViewDelegate = self;
    [self.view insertSubview:tab_SharedProducts.view belowSubview:tab_ReceivedProducts.view];
    
    //已赞
    tab_PraisedProducts = [[CustomTableViewController alloc] init];
    tab_PraisedProducts.loadingStyle = head_none;
    tab_PraisedProducts.view.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Height, MainScreenFrame_Width);
    tab_PraisedProducts.tableView.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Width - 300, MainScreenFrame_Height - 20 - UI_NAVIGATION_BAR_HEIGHT - 72);
    tab_PraisedProducts.tableStyle = UITableViewStylePlain;
    tab_PraisedProducts.tableView.backgroundColor = [PanliHelper colorWithHexString:@"#EEEEEE"];
    tab_PraisedProducts.tableView.separatorColor = PL_COLOR_CLEAR;
    tab_PraisedProducts.customTableViewDelegate = self;
    [self.view insertSubview:tab_PraisedProducts.view belowSubview:tab_ReceivedProducts.view];

    //无商品view
    exceptionView = [[CustomerExceptionView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width - 300, MainScreenFrame_Height - 20 - UI_NAVIGATION_BAR_HEIGHT - 72)];
    [self.view insertSubview:exceptionView belowSubview:tab_ReceivedProducts.view];
    [exceptionView release];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(getReceivedProductsResponse:)
//                                                 name:RQNAME_USERSHARE_RECEIVEDPRODUCTS
//                                               object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(getSharedProductsResponse:)
//                                                 name:RQNAME_USERSHARE_SHAREDPRODUCTS
//                                               object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(getPraisedProductsResponse:)
//                                                 name:RQNAME_USERSHARE_PRAISEDPRODUCTS
//                                               object:nil];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    isFirstRequestReceived = YES;
    isFirstRequestShared   = YES;
    isFirstRequestPraised  = YES;
    
    pageIndexReceived = 1;
    pageIndexShared   = 1;
    pageIndexPraised  = 1;
    
    [tab_ReceivedProducts requestData:YES];
    [tab_SharedProducts requestData:YES];
    [tab_PraisedProducts requestData:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    SAFE_RELEASE(req_ReceivedProducts);
    SAFE_RELEASE(req_SharedProducts);
    SAFE_RELEASE(req_PraisedProducts);
    SAFE_RELEASE(rpt_ReceivedProducts);
    SAFE_RELEASE(rpt_SharedProducts);
    SAFE_RELEASE(rpt_PraisedProducts);
    self.receivedProductArray = nil;
    self.sharedProductArray = nil;
    self.praisedProductArray = nil;
}

- (void)filterViewAction
{
    [UIView animateWithDuration:0.2 animations:^{
        CGAffineTransform currentTransform = img_navMenu.transform;
        CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,M_PI);
        [img_navMenu setTransform:newTransform];
    }];
    [filterView action];
}

#pragma mark - filterView Delegate
-(void)filterDidSelectedWithIndex:(int)index
{
    [self filterViewAction];
    showFlag = index;
    switch (index)
    {
        case 0:
        {
            img_navMenu.frame = CGRectMake(110.0f, 18.0f, 11.0, 7.5f);
            [btn_navMenu setTitle:LocalizedString(@"UserShareHomeViewController_btnNavMenu",@"分享商品") forState:UIControlStateNormal];
            if ((self.receivedProductArray && self.receivedProductArray.count > 0) ||isRequestingReceived)
            {
                [self.view bringSubviewToFront:tab_ReceivedProducts.view];
            }
            else
            {
                exceptionView.image = [UIImage imageNamed:@"icon_None_Ship"];
                exceptionView.title = LocalizedString(@"UserShareHomeViewController_exceptionView1_title",@"暂时没有可以分享的商品!");
                exceptionView.detail = LocalizedString(@"UserShareHomeViewController_exceptionView1_detail",@"您可以将已确认收货运单内的商品分享给大家!");
                [exceptionView setNeedsDisplay];
                [self.view bringSubviewToFront:exceptionView];
            }
            break;
        }
            
        case 1:
        {
            img_navMenu.frame = CGRectMake(125.0f, 18.0f, 11.0, 7.5f);
            [btn_navMenu setTitle:LocalizedString(@"UserShareHomeViewController_btnNavMenu2",@"已分享的商品") forState:UIControlStateNormal];
            if ((self.sharedProductArray && self.sharedProductArray.count > 0) || isRequestingShared)
            {
                [self.view bringSubviewToFront:tab_SharedProducts.view];
            }
            else
            {
                exceptionView.image = [UIImage imageNamed:@"icon_None_Ship"];
                exceptionView.title = LocalizedString(@"UserShareHomeViewController_exceptionView2_title",@"暂时还没有分享过的商品!");
                exceptionView.detail = LocalizedString(@"UserShareHomeViewController_exceptionView1_detail",@"您可以将已确认收货运单内的商品分享给大家!");
                [exceptionView setNeedsDisplay];
                [self.view bringSubviewToFront:exceptionView];
            }
            break;
        }
            
        case 2:
        {
            img_navMenu.frame = CGRectMake(115.0f, 18.0f, 11.0, 7.5f);
            [btn_navMenu setTitle:LocalizedString(@"UserShareHomeViewController_btnNavMenu3",@"赞过的商品") forState:UIControlStateNormal];
            [self.view bringSubviewToFront:tab_PraisedProducts.view];
            if ((self.praisedProductArray && self.praisedProductArray.count > 0) || isRequestingPraised)
            {
                [self.view bringSubviewToFront:tab_PraisedProducts.view];
            }
            else
            {
                exceptionView.image = [UIImage imageNamed:@"icon_None_Ship"];
                exceptionView.title = LocalizedString(@"UserShareHomeViewController_exceptionView3_title",@"您还没有发现给栗的商品!");
                exceptionView.detail = LocalizedString(@"UserShareHomeViewController_exceptionView3_detail",@"去分享购逛逛,送出您给栗!");
                [exceptionView setNeedsDisplay];
                [self.view bringSubviewToFront:exceptionView];
            }
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - request and response
-(void)customTableView:(CustomTableViewController *)customTableView sendRequset:(BOOL)isFirst
{
    //已确认收货
    if (customTableView == tab_ReceivedProducts)
    {
        [tab_ReceivedProducts.view setUserInteractionEnabled:NO];
        isFirstRequestReceived = isFirst;
        isRequestingReceived = YES;
        if (isFirst)
        {
            pageIndexReceived = 1;
        }
        req_ReceivedProducts = req_ReceivedProducts ? req_ReceivedProducts : [[UserShareProductsRequest alloc] init];
        NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
        [params setValue:@"0" forKey:RQ_USERSHARE_PARM_TYPE];
        [params setValue:[NSString stringWithFormat:@"%d",pageIndexReceived] forKey:RQ_USERSHARE_PARM_PAGEINDEX];
        [params setValue:[NSString stringWithFormat:@"%d",kPageSizes+5] forKey:RQ_USERSHARE_PARM_PAGECOUNT];
        rpt_ReceivedProducts = rpt_ReceivedProducts ? rpt_ReceivedProducts : [[DataRepeater alloc]initWithName:RQNAME_USERSHARE_RECEIVEDPRODUCTS];
        rpt_ReceivedProducts.requestParameters = params;
        rpt_ReceivedProducts.notificationName = RQNAME_USERSHARE_RECEIVEDPRODUCTS;
        rpt_ReceivedProducts.requestModal = PullData;
        rpt_ReceivedProducts.networkRequest = req_ReceivedProducts;
        
        rpt_ReceivedProducts.isAuth = YES;
        __unsafe_unretained __typeof(self) weakSelf = self;
        rpt_ReceivedProducts.compleBlock = ^(id repeater){
            [weakSelf getReceivedProductsResponse:repeater];
        };
        [[DataRequestManager sharedInstance] sendRequest:rpt_ReceivedProducts];
    }
    //已分享
    else if (customTableView == tab_SharedProducts)
    {
        [tab_SharedProducts.view setUserInteractionEnabled:NO];
        isFirstRequestShared = isFirst;
        isRequestingShared = YES;
        if (isFirst)
        {
            pageIndexShared = 1;
        }
        req_SharedProducts = req_SharedProducts ? req_SharedProducts : [[UserShareProductsRequest alloc] init];
        NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
        [params setValue:@"1" forKey:RQ_USERSHARE_PARM_TYPE];
        [params setValue:[NSString stringWithFormat:@"%d",pageIndexShared] forKey:RQ_USERSHARE_PARM_PAGEINDEX];
        [params setValue:[NSString stringWithFormat:@"%d",kPageSizes] forKey:RQ_USERSHARE_PARM_PAGECOUNT];
        rpt_SharedProducts = rpt_SharedProducts ? rpt_SharedProducts : [[DataRepeater alloc]initWithName:RQNAME_USERSHARE_SHAREDPRODUCTS];
        rpt_SharedProducts.requestParameters = params;
        rpt_SharedProducts.notificationName = RQNAME_USERSHARE_SHAREDPRODUCTS;
        rpt_SharedProducts.requestModal = PullData;
        rpt_SharedProducts.networkRequest = req_SharedProducts;
        
        rpt_SharedProducts.isAuth = YES;
        __unsafe_unretained __typeof(self) weakSelf = self;
        rpt_SharedProducts.compleBlock = ^(id repeater){
            [weakSelf getSharedProductsResponse:repeater];
        };
        [[DataRequestManager sharedInstance] sendRequest:rpt_SharedProducts];
    }
    //已赞
    else if (customTableView == tab_PraisedProducts)
    {
        [tab_PraisedProducts.view setUserInteractionEnabled:NO];
        isFirstRequestPraised = isFirst;
        isRequestingPraised = YES;
        if (isFirst)
        {
            pageIndexPraised = 1;
        }
        req_PraisedProducts = req_PraisedProducts ? req_PraisedProducts : [[UserShareProductsRequest alloc] init];
        NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
        [params setValue:@"2" forKey:RQ_USERSHARE_PARM_TYPE];
        [params setValue:[NSString stringWithFormat:@"%d",pageIndexPraised] forKey:RQ_USERSHARE_PARM_PAGEINDEX];
        [params setValue:[NSString stringWithFormat:@"%d",kPageSizes] forKey:RQ_USERSHARE_PARM_PAGECOUNT];
        rpt_PraisedProducts = rpt_PraisedProducts ? rpt_PraisedProducts : [[DataRepeater alloc]initWithName:RQNAME_USERSHARE_PRAISEDPRODUCTS];
        rpt_PraisedProducts.requestParameters = params;
        rpt_PraisedProducts.notificationName = RQNAME_USERSHARE_PRAISEDPRODUCTS;
        rpt_PraisedProducts.requestModal = PullData;
        rpt_PraisedProducts.networkRequest = req_PraisedProducts;

        rpt_PraisedProducts.isAuth = YES;
        __unsafe_unretained __typeof(self) weakSelf = self;
        rpt_PraisedProducts.compleBlock = ^(id repeater){
            [weakSelf getPraisedProductsResponse:repeater];
        };
        [[DataRequestManager sharedInstance] sendRequest:rpt_PraisedProducts];
    }
    
}

-(void)getReceivedProductsResponse:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        PageData *mPageData = repeater.responseValue;
        if (isFirstRequestReceived)
        {
            self.receivedProductArray = mPageData.list;
            [tab_ReceivedProducts hideLoadingView];
        }
        else
        {
            [self.receivedProductArray addObjectsFromArray:mPageData.list];
        }
        [tab_ReceivedProducts.tableView reloadData];
        //判断是否有数据
        if (self.receivedProductArray.count == 0 && showFlag == 0)
        {
            exceptionView.image = [UIImage imageNamed:@"icon_None_Ship"];
            exceptionView.title = LocalizedString(@"UserShareHomeViewController_exceptionView1_title",@"暂时没有可以分享的商品!");
            exceptionView.detail = LocalizedString(@"UserShareHomeViewController_exceptionView1_detail",@"您可以将已确认收货运单内的商品分享给大家!");
            [exceptionView setNeedsDisplay];
            [self.view bringSubviewToFront:exceptionView];
        }
        if(self.receivedProductArray.count != 0)
        {
            //蒙板
            [CustomerUpdateVersion updateVersionWithKey:UPDATEVERSION_USERSHAREHOME complete:^{
                UpdateVersionView *guideView = [[UpdateVersionView alloc] initWithFrame:CGRectMake(0.0f,0.0f, MainScreenFrame_Height, UI_SCREEN_HEIGHT) shadowLayerImage: (IS_568H ? [UIImage imageNamed:@"bg_UpdateVersion_UserShareHome_h568"] : [UIImage imageNamed:@"bg_UpdateVersion_UserShareHome"])];
                [self.tabBarController.view addSubview:guideView];
                [guideView release];
                
            }];
        }
        //判断是否有更多
        [tab_ReceivedProducts doAfterRequestSuccess:isFirstRequestReceived AndHavaMore:mPageData.hasNext];
        if (mPageData.list && mPageData.list.count > 0)
        {
            pageIndexReceived++;
        }
    }
    else
    {
        if (isFirstRequestReceived)
        {
            [tab_ReceivedProducts hideLoadingView];
        }
        
        [tab_ReceivedProducts doAfterRequsetFailure:isFirstRequestReceived errorInfo:repeater.errorInfo];
    }
    isRequestingReceived = NO;
    [tab_ReceivedProducts.view setUserInteractionEnabled:YES];
}

-(void)getSharedProductsResponse:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        PageData *mPageData = repeater.responseValue;
        if (isFirstRequestShared)
        {
            self.sharedProductArray = mPageData.list;
            [tab_SharedProducts hideLoadingView];
        }
        else
        {
            [self.sharedProductArray addObjectsFromArray:mPageData.list];
        }
        [tab_SharedProducts.tableView reloadData];
        //判断是否有数据
        if (self.sharedProductArray.count == 0 && showFlag == 1)
        {
            exceptionView.image = [UIImage imageNamed:@"icon_None_Ship"];
            exceptionView.title = LocalizedString(@"UserShareHomeViewController_exceptionView2_title",@"暂时还没有分享过的商品!");
            exceptionView.detail = LocalizedString(@"UserShareHomeViewController_exceptionView1_detail",@"您可以将已确认收货运单内的商品分享给大家!");
            [exceptionView setNeedsDisplay];
            [self.view bringSubviewToFront:exceptionView];
        }
        //判断是否有更多
        [tab_SharedProducts doAfterRequestSuccess:isFirstRequestShared AndHavaMore:mPageData.hasNext];
        if (mPageData.list && mPageData.list.count > 0)
        {
            pageIndexShared++;
        }
    }
    else
    {
        if (isFirstRequestShared)
        {
            [tab_SharedProducts hideLoadingView];
        }
        
        [tab_SharedProducts doAfterRequsetFailure:isFirstRequestShared errorInfo:repeater.errorInfo];
    }
    isRequestingShared = NO;
    [tab_SharedProducts.view setUserInteractionEnabled:YES];
}

-(void)getPraisedProductsResponse:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        PageData *mPageData = repeater.responseValue;
        if (isFirstRequestPraised)
        {
            self.praisedProductArray = mPageData.list;
            [tab_PraisedProducts hideLoadingView];
        }
        else
        {
            [self.praisedProductArray addObjectsFromArray:mPageData.list];
        }
        [tab_PraisedProducts.tableView reloadData];
        //是否有数据
        if (self.praisedProductArray.count == 0 && showFlag == 2)
        {
            exceptionView.image = [UIImage imageNamed:@"icon_None_Ship"];
            exceptionView.title = LocalizedString(@"UserShareHomeViewController_exceptionView2_title",@"暂时还没有分享过的商品!");
            exceptionView.detail = LocalizedString(@"UserShareHomeViewController_exceptionView1_detail",@"您可以将已确认收货运单内的商品分享给大家!");
            [exceptionView setNeedsDisplay];
            [self.view bringSubviewToFront:exceptionView];
        }
        //判断是否有更多
        [tab_PraisedProducts doAfterRequestSuccess:isFirstRequestPraised AndHavaMore:mPageData.hasNext];
        if (mPageData.list && mPageData.list.count > 0)
        {
            pageIndexPraised++;
        }
    }
    else
    {
        if (isFirstRequestPraised)
        {
            [tab_PraisedProducts hideLoadingView];
        }
        
        [tab_PraisedProducts doAfterRequsetFailure:isFirstRequestPraised errorInfo:repeater.errorInfo];
    }
    isRequestingPraised = NO;
    [tab_PraisedProducts.view setUserInteractionEnabled:YES];
}

#pragma mark - tableview datasource and delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //已确认收货
    if (tableView == tab_ReceivedProducts.tableView)
    {
        if (self.receivedProductArray.count%3 == 0)
        {
            return self.receivedProductArray.count/3;
        }
        else
        {
            return self.receivedProductArray.count/3 + 1;
        }
    }
    //已分享
    else if (tableView == tab_SharedProducts.tableView)
    {
        return self.sharedProductArray.count;
    }
    //已赞
    else if (tableView == tab_PraisedProducts.tableView)
    {
        return self.praisedProductArray.count;
    }
    return  0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //已确认收货
    if (tableView == tab_ReceivedProducts.tableView)
    {
        static NSString *cellIdentifier = @"ReceivedCell";
        UserShareHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[[UserShareHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        NSInteger index = indexPath.row * 6;
        NSMutableArray *dataArray = [NSMutableArray new];
        for (NSInteger i = index; i < self.receivedProductArray.count && i < index + 6; i++)
        {
            [dataArray addObject:[self.receivedProductArray objectAtIndex:i]];
        }
        [cell setData:dataArray];
        [dataArray release];
        return cell;
    }
    //已分享
    else if (tableView == tab_SharedProducts.tableView)
    {
        static NSString *cellIdentifier = @"SharedCell";
        UserShareHomeTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[[UserShareHomeTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setData:[self.sharedProductArray objectAtIndex:indexPath.row]];
        return cell;

    }
    //已赞
    else if (tableView == tab_PraisedProducts.tableView)
    {
        static NSString *cellIdentifier = @"PraisedCell";
        UserShareHomeTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[[UserShareHomeTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setData:[self.praisedProductArray objectAtIndex:indexPath.row]];
        return cell;

    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //已确认收货
    if (tableView == tab_ReceivedProducts.tableView)
    {
        return 102.0f;
    }
    //已分享
    else if (tableView == tab_SharedProducts.tableView)
    {
        return 100.0f;
    }
    //已赞
    else if (tableView == tab_PraisedProducts.tableView)
    {
        return 100.0f;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //已确认收货
    if (tableView == tab_ReceivedProducts.tableView)
    {
        return;
    }
    //已分享
    else if (tableView == tab_SharedProducts.tableView)
    {
        ShareProduct *mShareProduct = [self.sharedProductArray objectAtIndex:indexPath.row];
        ShareBuyDetailViewController *shareBuyDetailVC = [[[ShareBuyDetailViewController alloc] init] autorelease];
        shareBuyDetailVC.mainSharePrduct = mShareProduct;
        [self.navigationController pushViewController:shareBuyDetailVC animated:YES];
    }
    //已赞
    else if (tableView == tab_PraisedProducts.tableView)
    {
        ShareProduct *mShareProduct = [self.praisedProductArray objectAtIndex:indexPath.row];
        ShareBuyDetailViewController *shareBuyDetailVC = [[[ShareBuyDetailViewController alloc] init] autorelease];
        shareBuyDetailVC.mainSharePrduct = mShareProduct;
        [self.navigationController pushViewController:shareBuyDetailVC animated:YES];
    }
    return;
}

#pragma mark - sharecell delegate
- (void)ShareWithProduct:(ShareProduct *)product
{
    UserShareViewController *userShareVC = [[[UserShareViewController alloc] init] autorelease];
    userShareVC.mProduct = product;
    [self.navigationController pushViewController:userShareVC animated:YES];
}
@end
