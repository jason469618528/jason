//
//  ShareBuyDetailViewController.m
//  PanliApp
//
//  Created by Liubin on 13-12-10.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShareBuyDetailViewController.h"
#import "CustomUIImageView.h"
//#import "SearchProductDetailViewController.h"
#import "UserInfo.h"
#import "CustomerNavagationBarController.h"
#define SHAREBUYDETAIL_COUNT 4

#define TAG_PRAISE_REQUEST 1020

@interface ShareBuyDetailViewController ()

@end

@implementation ShareBuyDetailViewController
@synthesize mainSharePrduct = _mainSharePrduct;
@synthesize refreshHomeDelegate = _refreshHomeDelegate;
#pragma mark - default
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_mainSharePrduct);
    SAFE_RELEASE(arr_DetailInfo);
    SAFE_RELEASE(rpt_SharedProductDetails);
    SAFE_RELEASE(req_SharedProductDetails);
    SAFE_RELEASE(req_UserIsPraised);
    SAFE_RELEASE(rpt_UserIsPraised);
    SAFE_RELEASE(rpt_MakePraise);
    SAFE_RELEASE(req_MakePraise);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    [super viewDidLoadWithBackButtom:YES];
    self.navigationItem.title = LocalizedString(@"ShareBuyDetailViewController_Nav_Title", @"分享详情");
    
    //tableview
    tab_ShareBuyDetail = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT - 50.0f) style:UITableViewStylePlain];
    tab_ShareBuyDetail.delegate = self;
    tab_ShareBuyDetail.dataSource = self;
    tab_ShareBuyDetail.separatorColor = PL_COLOR_CLEAR;
    tab_ShareBuyDetail.backgroundColor = [PanliHelper colorWithHexString:@"#f2f2f2"];
    [PanliHelper setExtraCellLineHidden:tab_ShareBuyDetail];
    [self.view addSubview:tab_ShareBuyDetail];
    [tab_ShareBuyDetail release];
    
    
    //获取tableViewHead
    tab_ShareBuyDetail.tableHeaderView = [self getTableViewHeadView];
    
    
    //底部栏
    view_Bottom = [[UIView alloc]initWithFrame:CGRectMake(0.0, MainScreenFrame_Width - 20 - UI_NAVIGATION_BAR_HEIGHT - 77.0f, MainScreenFrame_Height - 300, 50.0f)];
    view_Bottom.backgroundColor = [PanliHelper colorWithHexString:@"#f7f7f7"];
    [[view_Bottom layer] setBorderWidth:1];
    [[view_Bottom layer] setBorderColor:[PanliHelper colorWithHexString:@"#e0e0e0"].CGColor];
    [self.view addSubview:view_Bottom];
    [view_Bottom release];
    
    //赞
    btn_Praise = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Praise.frame = CGRectMake(MainScreenFrame_Height - 300.0f - 300.0f, 10.0f, 120.5f, 32.5f);
    btn_Praise.tag = 10010;
    if(isPraise)
    {
        [btn_Praise setBackgroundImage:[UIImage imageNamed:@"btn_ShareDetail_CancelPraise"] forState:UIControlStateNormal];
        [btn_Praise setBackgroundImage:[UIImage imageNamed:@"btn_ShareDetail_CancelPraise_on"] forState:UIControlStateHighlighted];
    }
    else
    {
        [btn_Praise setBackgroundImage:[UIImage imageNamed:@"btn_ShareDetail_Praise"] forState:UIControlStateNormal];
        [btn_Praise setBackgroundImage:[UIImage imageNamed:@"btn_ShareDetail_Praise_on"] forState:UIControlStateHighlighted];
    }
    [btn_Praise addTarget:self action:@selector(shareBuyDetailClick:) forControlEvents:UIControlEventTouchUpInside];
    [view_Bottom addSubview:btn_Praise];
    
    //购买
    UIButton *btn_Buy = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Buy.frame = CGRectMake(btn_Praise.frame.size.width + btn_Praise.frame.origin.x + 22.5f, 10.0f, 120.5f, 32.5f);
    btn_Buy.tag = 10011;
    [btn_Buy setBackgroundImage:[UIImage imageNamed:@"btn_ShareDetail_Buy"] forState:UIControlStateNormal];
    [btn_Buy setBackgroundImage:[UIImage imageNamed:@"btn_ShareDetail_Buy_on"] forState:UIControlStateHighlighted];
    [btn_Buy addTarget:self action:@selector(shareBuyDetailClick:) forControlEvents:UIControlEventTouchUpInside];
    [view_Bottom addSubview:btn_Buy];
    
    //异常View
    exceptionView_ShareBuyDetail = [[CustomerExceptionView alloc]init];
    exceptionView_ShareBuyDetail.frame = CGRectMake(0.0f, 200.0f, MainScreenFrame_Height - 300, MainScreenFrame_Width - 20 - UI_NAVIGATION_BAR_HEIGHT - 72.0f);
    exceptionView_ShareBuyDetail.hidden = YES;
    [tab_ShareBuyDetail addSubview:exceptionView_ShareBuyDetail];
    [exceptionView_ShareBuyDetail release];

    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(getProductDetailResponse:)
//                                                 name:RQNAME_SHARE_USERSHAREDETAILS
//                                               object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(getProductPraiseResponse:)
//                                                 name:RQNAME_SHARE_SHAREBUYPRAISE
//                                               object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(getUserPraisedDetail:)
//                                                 name:RQNAME_SHARE_ISPRAISEDBYSELF
//                                               object:nil];
    
    [self shareBuyDetailRequset];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self userIsPraisedRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewHeadView
- (UIView*)getTableViewHeadView
{
    //tableView HeadView
    UIView *view_Head = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Height - 300, 199.0f)] autorelease];
    
    CustomUIImageView *bg_HeadView = [[CustomUIImageView alloc] initWithFrame:CGRectMake((MainScreenFrame_Height - 300 - 200) / 2, 0.0f, 200.0f, 199.0f)];
    [bg_HeadView setCustomImageWithURL:[NSURL URLWithString:_mainSharePrduct.thumbnail] placeholderImage:[UIImage imageNamed:@"btn_ShareHome_Recommend_None"]];
    [view_Head addSubview:bg_HeadView];
    [bg_HeadView release];
    
    UIView *v_line = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 199.0f, MainScreenFrame_Width, 1.0f)];
    v_line.backgroundColor = [PanliHelper colorWithHexString:@"#cbcbcb"];
    [view_Head addSubview:v_line];
    [v_line release];
    
    bg_HeadPraise = [[UIImageView alloc] init];
    bg_HeadPraise.frame = CGRectMake((MainScreenFrame_Height - 300 - 200) / 2 + 200.0f - 46.5f, 170.0f, 46.5f, 19.5f);
    bg_HeadPraise.image = [UIImage imageNamed:@"bg_ShareDetail_Praise"];
    [view_Head addSubview:bg_HeadPraise];
    [bg_HeadPraise release];
    
    //好评数
    lab_Praise = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, 30.0f, 20.0f)];
    lab_Praise.text = [NSString stringWithFormat:@"%d",_mainSharePrduct.numberOfPraise];
    lab_Praise.font = DEFAULT_FONT(13.0f);
    lab_Praise.backgroundColor = PL_COLOR_CLEAR;
    lab_Praise.textColor = [PanliHelper colorWithHexString:@"#fff6ff"];
    lab_Praise.textAlignment = UITextAlignmentLeft;
    [bg_HeadPraise addSubview:lab_Praise];
    [lab_Praise release];
    
    return view_Head;
}

#pragma mark - isPraised reqeust && Response
- (void)userIsPraisedRequest
{
    [btn_Praise setUserInteractionEnabled:NO];
    req_UserIsPraised = req_UserIsPraised ? req_UserIsPraised : [[ShareBuyIsPraisedBySelfRequest alloc] init];
    NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setValue:[NSString stringWithFormat:@"%d",_mainSharePrduct.shareProductId] forKey:RQ_SHAREBUY_ISPRAISE_PARM_PRODUCTID];
    
    UserInfo *mUserInfo = [GlobalObj getUserInfo];
    if(![NSString isEmpty:mUserInfo.userId] || mUserInfo != nil)
    {
        [params setValue:mUserInfo.userId forKey:RQ_SHAREBUY_ISPRAISE_PARM_USERID];
    }
    rpt_UserIsPraised = rpt_UserIsPraised ? rpt_UserIsPraised : [[DataRepeater alloc]initWithName:RQNAME_SHARE_ISPRAISEDBYSELF];
    rpt_UserIsPraised.requestParameters = params;
    rpt_UserIsPraised.notificationName = RQNAME_SHARE_ISPRAISEDBYSELF;
    rpt_UserIsPraised.requestModal = PushData;
    rpt_UserIsPraised.networkRequest = req_UserIsPraised;
    
    rpt_UserIsPraised.isAuth = YES;
    __unsafe_unretained __typeof(self) weakSelf = self;
    rpt_UserIsPraised.compleBlock = ^(id repeater){
        [weakSelf getUserPraisedDetail:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:rpt_UserIsPraised];
}

- (void)getUserPraisedDetail:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        [btn_Praise setUserInteractionEnabled:YES];
        isPraise = [repeater.responseValue boolValue];
    }
    else
    {
        isPraise = NO;
    }
    [self reloadButton];
}

#pragma mark - Detail reqeust && Response
- (void)shareBuyDetailRequset
{
    //隐藏异常页面
    [exceptionView_ShareBuyDetail setHidden:YES];
    [self showHUDIndicatorMessage:LocalizedString(@"ShareBuyDetailViewController_HUDIndMsg",@"正在加载...")];
    req_SharedProductDetails = req_SharedProductDetails ? req_SharedProductDetails : [[ShareBuyProductDetailRequest alloc] init];
    NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setValue:_mainSharePrduct.productUrl forKey:RQ_SHAREPRODUCTDETAILS_PARM_PRODUCTURL];

    rpt_SharedProductDetails = rpt_SharedProductDetails ? rpt_SharedProductDetails : [[DataRepeater alloc]initWithName:RQNAME_SHARE_USERSHAREDETAILS];
    rpt_SharedProductDetails.requestParameters = params;
    rpt_SharedProductDetails.notificationName = RQNAME_SHARE_USERSHAREDETAILS;
    rpt_SharedProductDetails.requestModal = PushData;
    rpt_SharedProductDetails.networkRequest = req_SharedProductDetails;
    
    rpt_SharedProductDetails.isAuth = YES;
    __unsafe_unretained __typeof(self) weakSelf = self;
    rpt_SharedProductDetails.compleBlock = ^(id repeater){
        [weakSelf getProductDetailResponse:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:rpt_SharedProductDetails];
}

- (void)getProductDetailResponse:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        [self hideHUD];
        arr_DetailInfo = [repeater.responseValue retain];
        [tab_ShareBuyDetail reloadData];
        //如果无商品显示无商品view
        if(arr_DetailInfo == nil || arr_DetailInfo.count == 0)
        {
            exceptionView_ShareBuyDetail.image = [UIImage imageNamed:@"bg_myGroup_error"];
            exceptionView_ShareBuyDetail.title = LocalizedString(@"ShareBuyDetailViewController_exceptionViewShareBuyDetail1",@"暂时没有分享详情");
            [exceptionView_ShareBuyDetail setNeedsDisplay];
            [exceptionView_ShareBuyDetail setHidden:NO];
        }
    }
    else
    {
        ErrorInfo* errorInfo = repeater.errorInfo;
        if (errorInfo.code == NETWORK_ERROR)
        {
            view_Bottom.hidden = YES;
            exceptionView_ShareBuyDetail.image = [UIImage imageNamed:@"icon_None_NetWork"];
            exceptionView_ShareBuyDetail.title = LocalizedString(@"ShareBuyDetailViewController_exceptionViewShareBuyDetail2",@"网络不给力");
            exceptionView_ShareBuyDetail.detail = @"";
            exceptionView_ShareBuyDetail.hidden = NO;
            [exceptionView_ShareBuyDetail setNeedsDisplay];
        }
        else
        {
            [self showHUDErrorMessage:errorInfo.message];
        }
    }
}

#pragma mark - Request && Response  (user is Praise)
- (void)isPraiseRequest
{
    [self showHUDIndicatorMessage:LocalizedString(@"ShareBuyDetailViewController_HUDIndMsg",@"正在加载...")];
    req_MakePraise = req_MakePraise ? req_MakePraise : [[ShareBuyPraiseRequest alloc] init];
    NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setValue:[NSString stringWithFormat:@"%d",_mainSharePrduct.shareProductId] forKey:RQ_SHAREBUYPRAISE_PARM_PRODUCTID];
    [params setValue:[NSString stringWithFormat:@"%d",isPraise] forKey:RQ_SHAREBUYPRAISE_PARM_TYPE];
    
    rpt_MakePraise = rpt_MakePraise ? rpt_MakePraise : [[DataRepeater alloc]initWithName:RQNAME_SHARE_SHAREBUYPRAISE];
    rpt_MakePraise.requestParameters = params;
    rpt_MakePraise.notificationName = RQNAME_SHARE_SHAREBUYPRAISE;
    rpt_MakePraise.requestModal = PushData;
    rpt_MakePraise.networkRequest = req_MakePraise;
    
    rpt_MakePraise.isAuth = YES;
    __unsafe_unretained __typeof(self) weakSelf = self;
    rpt_MakePraise.compleBlock = ^(id repeater){
        [weakSelf getProductPraiseResponse:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:rpt_MakePraise];
}

- (void)getProductPraiseResponse:(DataRepeater*)repeater
{
    
    if(repeater.isResponseSuccess)
    {
        [self hideHUD];
        if(isPraise)
        {
            isPraise = NO;
            _mainSharePrduct.numberOfPraise --;
            [btn_Praise setBackgroundImage:[UIImage imageNamed:@"btn_ShareDetail_Praise"] forState:UIControlStateNormal];
            [btn_Praise setBackgroundImage:[UIImage imageNamed:@"btn_ShareDetail_Praise_on"] forState:UIControlStateHighlighted];
        }
        else
        {
            isPraise = YES;
            _mainSharePrduct.numberOfPraise ++;
            [btn_Praise setBackgroundImage:[UIImage imageNamed:@"btn_ShareDetail_CancelPraise"] forState:UIControlStateNormal];
            [btn_Praise setBackgroundImage:[UIImage imageNamed:@"btn_ShareDetail_CancelPraise_on"] forState:UIControlStateHighlighted];
        }
        //放大动画
        [UIView beginAnimations:@"praiseAnimation"context:NULL];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationRepeatAutoreverses:NO];
        [UIView setAnimationRepeatCount:1];
        bg_HeadPraise.frame = CGRectMake((MainScreenFrame_Height - 300 - 200) / 2 + 200.0f - 46.5f, 165.0f, 51.5f, 24.5f);
        bg_HeadPraise.frame = CGRectMake((MainScreenFrame_Height - 300 - 200) / 2 + 200.0f - 46.5f, 170.0f, 46.5f, 19.5f);
        [UIView commitAnimations];
        
        lab_Praise.text = [NSString stringWithFormat:@"%d",_mainSharePrduct.numberOfPraise];
    
        //刷新选荐数据
        if(_refreshHomeDelegate != nil && [_refreshHomeDelegate respondsToSelector:@selector(refreshRecommend)])
        {
            [_refreshHomeDelegate refreshRecommend];
        }

    }
    else
    {
        ErrorInfo *errorInfo = repeater.errorInfo;
        [self showHUDErrorMessage:errorInfo.message];
    }
}
#pragma mark - reloadButton
- (void)reloadButton
{
    if(isPraise)
    {
        [btn_Praise setBackgroundImage:[UIImage imageNamed:@"btn_ShareDetail_CancelPraise"] forState:UIControlStateNormal];
        [btn_Praise setBackgroundImage:[UIImage imageNamed:@"btn_ShareDetail_CancelPraise_on"] forState:UIControlStateHighlighted];
    }
    else
    {
        [btn_Praise setBackgroundImage:[UIImage imageNamed:@"btn_ShareDetail_Praise"] forState:UIControlStateNormal];
        [btn_Praise setBackgroundImage:[UIImage imageNamed:@"btn_ShareDetail_Praise_on"] forState:UIControlStateHighlighted];
    }
}

#pragma mark - Click event
- (void)shareBuyDetailClick:(UIButton*)sender
{
   
        switch (sender.tag)
        {
                //赞
            case 10010:
            {
                 [super checkLoginWithBlock:^{
                     [self isPraiseRequest];
                 } andLoginTag:TAG_PRAISE_REQUEST];
                break;
            }
                //购买
            case 10011:
            {
//                BaseProduct *mBaseProduct = [[BaseProduct alloc] init];
//                mBaseProduct.productName = _mainSharePrduct.productName;
//                mBaseProduct.productUrl = _mainSharePrduct.productUrl;
//                mBaseProduct.thumbnail = _mainSharePrduct.thumbnail;
//                mBaseProduct.price = _mainSharePrduct.price;
//                SearchProductDetailViewController *detailVC = [[[SearchProductDetailViewController alloc] init] autorelease];
//                detailVC.mBaseProduct = mBaseProduct;
//                [mBaseProduct release];
//                detailVC.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:detailVC animated:YES];
                break;
            }
            default:
                break;
        }
}

/**
 *  用户登录成功之后，继续之前的操作
 */
- (void)userDidLogin:(NSNotification *)sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"%@LoginDoneNotification",[self class]] object:nil];
    int tag = [sender.object intValue];
    if (tag == TAG_PRAISE_REQUEST)
    {
        [self isPraiseRequest];
    }
}

#pragma mark - UITableViewDelegate && UITableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  arr_DetailInfo.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShareBuyDetail *m_ShareBuyDetail = [arr_DetailInfo objectAtIndex:indexPath.row];
    CGSize remarkSize = [m_ShareBuyDetail.message sizeWithFont:DEFAULT_FONT(13.0f) constrainedToSize:CGSizeMake(262.0f, 500.0f) lineBreakMode:NSLineBreakByCharWrapping];
    if(m_ShareBuyDetail.pictureArray.count > 0)
    {
        int imageCount = 1;
        
        if (m_ShareBuyDetail.pictureArray.count % SHAREBUYDETAIL_COUNT == 0)
        {
            imageCount = (int)m_ShareBuyDetail.pictureArray.count / SHAREBUYDETAIL_COUNT;
            return  50.0f * (m_ShareBuyDetail.pictureArray.count / SHAREBUYDETAIL_COUNT) + remarkSize.height + 20.0f + 33.0f + imageCount * 10.0f;
        }
        else
        {
            imageCount = (int)m_ShareBuyDetail.pictureArray.count / SHAREBUYDETAIL_COUNT + 1;
            return 50.0f * (m_ShareBuyDetail.pictureArray.count / SHAREBUYDETAIL_COUNT + 1) + remarkSize.height + 20.0f + 33.0f + imageCount * 10.0f;
        }
    }
    else
    {
            return remarkSize.height + 33.0f + 2.0f + 10.0f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ShareBuyDetaiilCell";
    ShareBuyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[[ShareBuyDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.goToImageDelegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ShareBuyDetail *m_ShareBuyDetail = [arr_DetailInfo objectAtIndex:indexPath.row];
    [cell setDisplayData:m_ShareBuyDetail];
    return cell;
}

#pragma mark - ShareBuyDetailCell goToImageDetail
- (void)shareBuyDetailGoToImage:(ShareBuyDetail *)shareBuyDetail ImageRow:(int)imageRow
{
    CustomerNavagationBarController *navCtrl = (CustomerNavagationBarController *)self.navigationController;
    navCtrl.canDragBack = NO;
    
    FullScreenImageView *v_FullImage = [[FullScreenImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Height - 300, MainScreenFrame_Width - 20 - UI_NAVIGATION_BAR_HEIGHT - 72.0f) imageArray:shareBuyDetail.pictureArray showIndex:imageRow];
    v_FullImage.delegate = self;
    [self.navigationController.view addSubview:v_FullImage];
    [v_FullImage release];
}

- (void)fullImageDidRemove
{
    CustomerNavagationBarController *navCtrl = (CustomerNavagationBarController *)self.navigationController;
    navCtrl.canDragBack = YES;
}


@end
