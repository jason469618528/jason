//
//  WayBillDetailViewController.m
//  PanliApp
//
//  Created by jason on 13-4-23.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ShipDetailViewController.h"
#import "ShipDetail.h"
#import "ProductCell.h"
#import "ShipDetailCell.h"
#import "ShipStatusRecord.h"
#import "ExpressInfo.h"
#import "MessageDetailViewController.h"
#import "CustomAlertView.h"
#import "ShipEvaluateViewController.h"
#import "SVWebViewController.h"
#import "CustomerExceptionView.h"
#import "ShipStatusDetailCell.h"
#import "ShipDetailOrdersCell.h"
#import "CustomerNavagationBarController.h"

#define UITABLEVIEW_WIDTH (MainScreenFrame_Width - 320.0f)
#define MESSAGE_CELL_HEIGHT 39.5f
@interface ShipDetailViewController ()
@end

@implementation ShipDetailViewController
@synthesize str_ShipId = _str_ShipId;
@synthesize str_ShipExpressUrl = _str_ShipExpressUrl;
@synthesize str_ShipExpressNo = _str_ShipExpressNo;
@synthesize mShipOrder = _mShipOrder;
@synthesize arr_OrderObject = _arr_OrderObject;
@synthesize isNewDisplayStateDelegate;

#pragma mark - default
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(scr_ShipScroll);
    SAFE_RELEASE(arr_ShipOrders);
    SAFE_RELEASE(arr_Logistics);
    SAFE_RELEASE(arr_Schedule);
    SAFE_RELEASE(marr_ShipDetail);
    
    SAFE_RELEASE(tab_Schedule);
    SAFE_RELEASE(tab_Logistics);
    SAFE_RELEASE(tab_ShipDetail);
    SAFE_RELEASE(tab_ShipOrders);
    
    SAFE_RELEASE(req_ShipDetail);
    SAFE_RELEASE(req_ShipSchedule);
    SAFE_RELEASE(req_ShipLogistics);
    SAFE_RELEASE(req_ConfimReceived);
    SAFE_RELEASE(req_CancelShip);
    SAFE_RELEASE(view_PopView);
    SAFE_RELEASE(_str_ShipId);
    SAFE_RELEASE(_str_ShipExpressUrl);
    SAFE_RELEASE(_str_ShipExpressNo);
    SAFE_RELEASE(data_ShipDetail);
    
    
    SAFE_RELEASE(data_ShipSchedule);
    SAFE_RELEASE(data_ShipLogistics);
    SAFE_RELEASE(data_ConfimReceived);
    SAFE_RELEASE(data_CancelShip);
    
    SAFE_RELEASE(_mShipOrder);
    SAFE_RELEASE(_arr_OrderObject);
    SAFE_RELEASE(mShipDetail);
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
    //返回按钮
//    [self viewDidLoadWithBackButtom:YES];
    self.navigationItem.title = LocalizedString(@"ShipDetailViewController_Nav_Title",@"运单详情");
    marr_ShipDetail = [[NSMutableArray alloc] init];

    isShipDetailFlag = NO;
    isScheduleFlag = NO;
    isLogisticsFlag = NO;
    isShipOrdersFlag = NO;
    isReqLogisticsFlag = NO;
    scheduleHeightFlag = scheduleHeightFlag = 0.0f;
    //初始scrollview
    scr_ShipScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width - 320, MainScreenFrame_Height  - UI_NAVIGATION_BAR_HEIGHT - 72 + 50)];
    [scr_ShipScroll setBackgroundColor:[PanliHelper colorWithHexString:@"#ebebeb"]];
    scr_ShipScroll.bounces = YES;
    scr_ShipScroll.clipsToBounds = YES;
    scr_ShipScroll.showsHorizontalScrollIndicator = NO;
    scr_ShipScroll.showsVerticalScrollIndicator = NO;
    scr_ShipScroll.scrollsToTop = NO;
    scr_ShipScroll.delegate = self;
    [self.view addSubview:scr_ShipScroll];

    [self createAllEmptyPagesForScrollView];
    
    //联系客户or删除运单
    view_Bottom = [[UIView alloc]initWithFrame:CGRectMake(0.0, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT - 72, MainScreenFrame_Width - 320, 50.0f)];
    view_Bottom.backgroundColor = [PanliHelper colorWithHexString:@"#f7f7f7"];
    [[view_Bottom layer] setBorderWidth:1];
    [[view_Bottom layer] setBorderColor:[PanliHelper colorWithHexString:@"#e0e0e0"].CGColor];
    view_Bottom.hidden = YES;
    [self.view addSubview:view_Bottom];
    [view_Bottom release];
    
    [self RequestShipSchedule];
    [self RequestShipDetail];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //运单详情
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(ShipDetail:)
//                                                 name:RQNAME_USERSHIPDETAIL
//                                               object:nil];
//    
//    //进度追踪
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(ShipSchedule:)
//                                                 name:RQNAME_GETSHIPSTATUSREORD
//                                               object:nil];
//    
//    //物流
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(ShipLogistics:)
//                                                 name:RQNAME_USERSHIPEXPRESS
//                                               object:nil];
//    
//    //确认收货
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(ConfirmRecieived:)
//                                                 name:RQNAME_CONFIRMRECEIVED
//                                               object:nil];
//    
//    //撤消订单
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(CancelShipOrders:)
//                                                 name:RQNAME_CANCELSHIPORDER
//                                               object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 初始view
-(void)createAllEmptyPagesForScrollView
{
    //商品详情
    tab_ShipDetail = [[UITableView alloc]initWithFrame:CGRectMake(10.0f,10.0f, UITABLEVIEW_WIDTH, 83.5f)];
    tab_ShipDetail.delegate = self;
    tab_ShipDetail.dataSource = self;
    tab_ShipDetail.tag = 2222;
    tab_ShipDetail.scrollEnabled = NO;
    [tab_ShipDetail layer].borderWidth = 1.0f;
    [tab_ShipDetail layer].borderColor = [PanliHelper colorWithHexString:@"#cfcfcf"].CGColor;
    tab_ShipDetail.separatorColor = PL_COLOR_CLEAR;
    [PanliHelper setExtraCellLineHidden:tab_ShipDetail];
    [scr_ShipScroll addSubview:tab_ShipDetail];

    //进度表
    tab_Schedule = [[UITableView alloc]initWithFrame:CGRectMake(10.0f, tab_ShipDetail.frame.origin.y + tab_ShipDetail.frame.size.height + 10, UITABLEVIEW_WIDTH, 79.0f)];
    tab_Schedule.delegate = self;
    tab_Schedule.dataSource = self;
    tab_Schedule.tag = 0000;
    tab_Schedule.scrollEnabled = NO;
    [tab_Schedule layer].borderWidth = 1.0f;
    [tab_Schedule layer].borderColor = [PanliHelper colorWithHexString:@"#cfcfcf"].CGColor;
    tab_Schedule.separatorColor = PL_COLOR_CLEAR;
    [PanliHelper setExtraCellLineHidden:tab_Schedule];
    [scr_ShipScroll addSubview:tab_Schedule];
  
    //物流表
    tab_Logistics = [[UITableView alloc]initWithFrame:CGRectMake(10.0f,tab_Schedule.frame.origin.y + tab_Schedule.frame.size.height + 10, UITABLEVIEW_WIDTH, 139.0f)];
    tab_Logistics.delegate = self;
    tab_Logistics.dataSource = self;
    tab_Logistics.tag = 1111;
    tab_Logistics.scrollEnabled = NO;
    [tab_Logistics layer].borderWidth = 1.0f;
    [tab_Logistics layer].borderColor = [PanliHelper colorWithHexString:@"#cfcfcf"].CGColor;
    tab_Logistics.separatorColor = PL_COLOR_CLEAR;
    [PanliHelper setExtraCellLineHidden:tab_Logistics];
    [scr_ShipScroll addSubview:tab_Logistics];
    
    //商品表
    tab_ShipOrders = [[UITableView alloc]initWithFrame:CGRectMake(10.0f,tab_Logistics.frame.origin.y + tab_Logistics.frame.size.height + 10, UITABLEVIEW_WIDTH, 45.0f)];
    tab_ShipOrders.delegate = self;
    tab_ShipOrders.dataSource = self;
    tab_ShipOrders.tag = 3333;
    tab_ShipOrders.scrollEnabled = NO;
    [tab_ShipOrders layer].borderWidth = 1.0f;
    [tab_ShipOrders layer].borderColor = [PanliHelper colorWithHexString:@"#cfcfcf"].CGColor;
    [PanliHelper setExtraCellLineHidden:tab_ShipOrders];
    [scr_ShipScroll addSubview:tab_ShipOrders];
    
    scr_ShipScroll.contentSize = CGSizeMake(MainScreenFrame_Width - 320, tab_ShipDetail.frame.size.height + tab_Schedule.frame.size.height + tab_Logistics.frame.size.height + tab_ShipOrders.frame.size.height + 50.0f + 50.0f);
}


#pragma mark - 请求运单详情
-(void)RequestShipDetail
{
    [self showHUDIndicatorMessage:LocalizedString(@"ShipDetailViewController_HUDIndMsg1",@"正在加载...")];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:_str_ShipId forKey:RQ_SHIPDETAIL_PARAM_SHIPID];
    req_ShipDetail = req_ShipDetail ? req_ShipDetail : [[ShipDetailRequest alloc]init];
    data_ShipDetail = data_ShipDetail ? data_ShipDetail : [[DataRepeater alloc]initWithName:RQNAME_USERSHIPDETAIL];
    data_ShipDetail.requestParameters = params;
    data_ShipDetail.notificationName = RQNAME_USERSHIPDETAIL;
    data_ShipDetail.requestModal = PullData;
    data_ShipDetail.networkRequest = req_ShipDetail;
    [params release];
    
    data_ShipDetail.isAuth = YES;
    __unsafe_unretained __typeof(self) weakSelf = self;
    data_ShipDetail.compleBlock = ^(id repeater){
        [weakSelf ShipDetail:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:data_ShipDetail];
    
}

-(void)ShipDetail:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        [self hideHUD];
        ShipDetail *mo_ShipDetail = (ShipDetail*)repeater.responseValue;
       //商品
        NSArray *arr = mo_ShipDetail.userProducts;
        if(arr.count <= 0)
        {
            tab_ShipOrders.backgroundColor = PL_COLOR_WHITE;
        }
        else
        {
            arr_ShipOrders = [mo_ShipDetail.userProducts retain];
        }
        
        [tab_ShipOrders reloadData];
        
        //获取个人信息
        mShipDetail = [mo_ShipDetail retain];
        [marr_ShipDetail addObject:[NSString stringWithFormat:LocalizedString(@"ShipDetailViewController_marrShipDetail_item1",@"收货人:%@"),mo_ShipDetail.consignee]];
        [marr_ShipDetail addObject:[NSString stringWithFormat:LocalizedString(@"ShipDetailViewController_marrShipDetail_item2",@"地址:%@"),mo_ShipDetail.shipAddress]];
        [marr_ShipDetail addObject:[NSString stringWithFormat:LocalizedString(@"ShipDetailViewController_marrShipDetail_item3",@"国家:%@"),mo_ShipDetail.shipArea]];
        [marr_ShipDetail addObject:[NSString stringWithFormat:LocalizedString(@"ShipDetailViewController_marrShipDetail_item4",@"收货人电话:%@"),mo_ShipDetail.telePhone]];
        [marr_ShipDetail addObject:[NSString stringWithFormat:LocalizedString(@"ShipDetailViewController_marrShipDetail_item5",@"邮编:%@"),mo_ShipDetail.postcode]];
        [marr_ShipDetail addObject:[NSString stringWithFormat:LocalizedString(@"ShipDetailViewController_marrShipDetail_item6",@"所在城市:%@"),mo_ShipDetail.shipCity]];
        [tab_ShipDetail reloadData];
        
        //获取运单状态
        i_ShipState = mo_ShipDetail.status;
        //运单评价状态
        b_RateState = mo_ShipDetail.hasVoted;
        //刷新底部按钮
        [self loadPopView];
    }
    else
    {
        ErrorInfo* errorInfo = repeater.errorInfo;
        if (errorInfo.code == NETWORK_ERROR)
        {
            CustomerExceptionView *exceptionView = [[CustomerExceptionView alloc]init];
            exceptionView.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Width - 320, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT);
            exceptionView.image = [UIImage imageNamed:@"icon_None_NetWork"];
            exceptionView.title = LocalizedString(@"ShipDetailViewController_exceptionView",@"网络不给力");
            exceptionView.detail = @"";
            [exceptionView setNeedsDisplay];
            [exceptionView setHidden:NO];
            [tab_ShipOrders addSubview:exceptionView];
            [exceptionView release];
        }
        else
        {
            [self showHUDErrorMessage:errorInfo.message];
        }
    }
}


#pragma mark - 进度追踪请求
-(void)RequestShipSchedule
{
    req_ShipSchedule = req_ShipSchedule ? req_ShipSchedule : [[ShipRecordRequest alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:_str_ShipId forKey:RQ_SHIPSTATUSRECORD_PARAM_SHIPID];
    data_ShipSchedule = data_ShipSchedule?data_ShipSchedule : [[DataRepeater alloc]initWithName:RQNAME_GETSHIPSTATUSREORD];
    data_ShipSchedule.requestParameters = params;
    data_ShipSchedule.notificationName = RQNAME_GETSHIPSTATUSREORD;
    data_ShipSchedule.requestModal = PullData;
    data_ShipSchedule.networkRequest = req_ShipSchedule;
    [params release];
    
    data_ShipSchedule.isAuth = YES;
    __unsafe_unretained __typeof(self) weakSelf = self;
    data_ShipSchedule.compleBlock = ^(id repeater){
        [weakSelf ShipSchedule:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:data_ShipSchedule];
}
-(void)ShipSchedule:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        NSArray *arr = repeater.responseValue;
        if(arr.count <= 0)
        {
            
            UIImageView * bg_Main=[[UIImageView alloc]initWithImage:[UIImage imageNamed: @"icon_None_Schedule"]];
            bg_Main.frame=CGRectMake(120, 140, 80,80);
            [tab_Schedule addSubview:bg_Main];
            [bg_Main release];
            
            UILabel *lab_Title = [[UILabel alloc]initWithFrame:CGRectMake(105, 240, 200, 18)];
            lab_Title.text = LocalizedString(@"ShipDetailViewController_labTitle1",@"暂无相关信息");
            lab_Title.backgroundColor = PL_COLOR_CLEAR;
            lab_Title.textColor = PL_COLOR_GRAY;
            lab_Title.font = DEFAULT_FONT(18);
            [tab_Schedule addSubview:lab_Title];
            [lab_Title release];
        }
        else
        {
            arr_Schedule = [repeater.responseValue retain];
            [tab_Schedule reloadData];
        }
       
    }
    else
    {
        ErrorInfo* errorInfo = repeater.errorInfo;
        if (errorInfo.code == NETWORK_ERROR)
        {
            CustomerExceptionView *exceptionView = [[CustomerExceptionView alloc]init];
            exceptionView.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Width - 320, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT);
            exceptionView.image = [UIImage imageNamed:@"icon_None_NetWork"];
            exceptionView.title = LocalizedString(@"ShipDetailViewController_exceptionView",@"网络不给力");
            exceptionView.detail = @"";
            [exceptionView setNeedsDisplay];
            [exceptionView setHidden:NO];
            [tab_Schedule addSubview:exceptionView];
            [exceptionView release];
        }
        else
        {
            [self showHUDErrorMessage:errorInfo.message];
        }
    }
    //请求物流
    if([NSString isEmpty:_str_ShipExpressNo] || [NSString isEmpty:_str_ShipExpressUrl])
    {
        UIImageView * bg_Main=[[UIImageView alloc]initWithImage:[UIImage imageNamed: @"icon_None_Logistics"]];
        bg_Main.frame=CGRectMake(90, 140, 149,91);
        [tab_Logistics addSubview:bg_Main];
        [bg_Main release];
        
        UILabel *lab_Title = [[UILabel alloc]initWithFrame:CGRectMake(80, 240, 200, 18)];
        lab_Title.text = LocalizedString(@"ShipDetailViewController_labTitle2",@"暂时没有物流信息哦!");
        lab_Title.backgroundColor = PL_COLOR_CLEAR;
        lab_Title.textColor = PL_COLOR_GRAY;
        lab_Title.font = DEFAULT_FONT(18);
        [tab_Logistics addSubview:lab_Title];
        [lab_Title release];
    }
    else
    {
        [self RequestShipExpress];
    }
}

#pragma mark - 请求物流
-(void)RequestShipExpress
{
 
    req_ShipLogistics = req_ShipLogistics? req_ShipLogistics : [[ShipExpressRequest alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setValue:_str_ShipExpressUrl forKey:RQ_SHIPEXPRESS_PARAM_EXPRESSURL];
    [params setValue:_str_ShipExpressNo forKey:RQ_SHIPEXPRESS_PARAM_EXPRESSNO];
    
    data_ShipLogistics = data_ShipLogistics ? data_ShipLogistics : [[DataRepeater alloc]initWithName:RQNAME_USERSHIPEXPRESS];
    data_ShipLogistics.requestParameters = params;
    data_ShipLogistics.notificationName = RQNAME_USERSHIPEXPRESS;
    data_ShipLogistics.requestModal = PullData;
    data_ShipLogistics.networkRequest = req_ShipLogistics;
    [params release];
    
    data_ShipLogistics.isAuth = YES;
    __unsafe_unretained __typeof(self) weakSelf = self;
    data_ShipLogistics.compleBlock = ^(id repeater){
        [weakSelf ShipLogistics:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:data_ShipLogistics];
}

-(void)ShipLogistics:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        NSArray *arr = repeater.responseValue;
        if(arr.count <= 0)
        {
            UIImageView * bg_Main=[[UIImageView alloc]initWithImage:[UIImage imageNamed: @"icon_None_Logistics"]];
            bg_Main.frame=CGRectMake(90, 140, 149,91);
            [tab_Logistics addSubview:bg_Main];
            [bg_Main release];
            
            UILabel *lab_Title = [[UILabel alloc]initWithFrame:CGRectMake(80, 240, 200, 18)];
            lab_Title.text = LocalizedString(@"ShipDetailViewController_labTitle2",@"暂时没有物流信息哦!");
            lab_Title.backgroundColor = PL_COLOR_CLEAR;
            lab_Title.textColor = PL_COLOR_GRAY;
            lab_Title.font = DEFAULT_FONT(18);
            [tab_Logistics addSubview:lab_Title];
            [lab_Title release];
            return;
        }
        else
        {
            arr_Logistics = [repeater.responseValue retain];
            [tab_Logistics reloadData];
        }
    }
    else
    {
        if(repeater.errorInfo.code == 6 || repeater.errorInfo.code == 7|| repeater.errorInfo.code == 8)
        {
            UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(10, 105.0f, 230, 30)];
            label.text=LocalizedString(@"ShipDetailViewController_label",@"暂时没有相关物流信息");
            label.backgroundColor=PL_COLOR_CLEAR;
            label.font = DEFAULT_FONT(15.0f);
            label.textColor = [PanliHelper colorWithHexString:@"#4bb21b"];
            [tab_Logistics addSubview:label];
            
            UIButton *  SkipButton=[UIButton buttonWithType:UIButtonTypeCustom];
            [SkipButton setImage:[UIImage imageNamed:@"btn_ShipDetail_Query"] forState:UIControlStateNormal];
            [SkipButton setImage:[UIImage imageNamed:@"btn_ShipDetail_Query_on"] forState:UIControlStateHighlighted];
            SkipButton.frame=CGRectMake(195.0f, 105.0f, 92.5f, 26.5f);
            [SkipButton addTarget:self action:@selector(SkipurlClick) forControlEvents:UIControlEventTouchUpInside];
            [tab_Logistics addSubview:SkipButton];
            [label release];
            
            isReqLogisticsFlag = YES;
            [tab_Logistics reloadData];
        }
        else
        {
            ErrorInfo* errorInfo = repeater.errorInfo;
            if (errorInfo.code == NETWORK_ERROR)
            {
                CustomerExceptionView *exceptionView = [[CustomerExceptionView alloc]init];
                exceptionView.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Width - 320.0f, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT);
                exceptionView.image = [UIImage imageNamed:@"icon_None_NetWork"];
                exceptionView.title = LocalizedString(@"ShipDetailViewController_exceptionView",@"网络不给力");
                exceptionView.detail = @"";
                [exceptionView setNeedsDisplay];
                [exceptionView setHidden:NO];
                [tab_Logistics addSubview:exceptionView];
                [exceptionView release];
            }
            else
            {
                [self showHUDErrorMessage:errorInfo.message];
            }
        }
    }
}

#pragma mark - 判断右边导航事件
- (void)loadPopView
{
    //获取运单展示状态
    int orderStates = [super getShipStateWithStatus:i_ShipState];
    //判断底部是否出现
    if((
        orderStates == YFHWay
        || orderStates == DCLWay
        || (orderStates == CLCWay && (i_ShipState == OrderReceived || i_ShipState == Deliverying))
        || orderStates == WCLWay
        || (orderStates == YSHWay && !b_RateState)
        )
       && _arr_OrderObject.count > 0)
    {
        view_Bottom.hidden = NO;
    }
    //删除之前的popView
    for (UIView *view in view_Bottom.subviews)
    {
        if([view isKindOfClass:[PopView class]])
        {
            [view removeFromSuperview];
        }
    }
    switch (orderStates)
    {
            //已发货
        case YFHWay:
        {
            view_PopView = [[PopView alloc] initWithButtonCount:2 isNewMessage:_mShipOrder.haveUnreadMessage isDisplayIcon:YES];
            [view_PopView.btn_top setImage:[UIImage imageNamed:@"btn_Common_SendMessage"] forState:UIControlStateNormal];
            [view_PopView.btn_top setImage:[UIImage imageNamed:@"btn_Common_SendMessage_on"] forState:UIControlStateHighlighted];
            [view_PopView.btn_top addTarget:self action:@selector(sendMessageClick) forControlEvents:UIControlEventTouchUpInside];
            [view_PopView.btn_bottom setImage:[UIImage imageNamed:@"btn_ShipDetail_ConfirmShip"] forState:UIControlStateNormal];
            [view_PopView.btn_bottom setImage:[UIImage imageNamed:@"btn_ShipDetail_ConfirmShip_on"] forState:UIControlStateHighlighted];
            [view_PopView.btn_bottom addTarget:self action:@selector(ConfirmReceivedClick) forControlEvents:UIControlEventTouchUpInside];
            [view_Bottom addSubview:view_PopView];
            break;
        }
            //待确认
        case DCLWay:
        {
            if(i_ShipState == 4 ||i_ShipState == 12)
            {
                view_PopView = [[PopView alloc] initWithButtonCount:2 isNewMessage:_mShipOrder.haveUnreadMessage isDisplayIcon:YES];
                [view_PopView.btn_top setImage:[UIImage imageNamed:@"btn_Common_SendMessage"] forState:UIControlStateNormal];
                [view_PopView.btn_top setImage:[UIImage imageNamed:@"btn_Common_SendMessage_on"] forState:UIControlStateHighlighted];
                [view_PopView.btn_top addTarget:self action:@selector(sendMessageClick) forControlEvents:UIControlEventTouchUpInside];
                [view_PopView.btn_bottom setImage:[UIImage imageNamed:@"btn_ShipDetail_CancelShip"] forState:UIControlStateNormal];
                [view_PopView.btn_bottom setImage:[UIImage imageNamed:@"btn_ShipDetail_CancelShip_on"] forState:UIControlStateHighlighted];
                [view_PopView.btn_bottom addTarget:self action:@selector(DeleteShipClick) forControlEvents:UIControlEventTouchUpInside];
                [view_Bottom addSubview:view_PopView];
            }
            else
            {
                view_PopView = [[PopView alloc] initWithButtonCount:1 isNewMessage:_mShipOrder.haveUnreadMessage isDisplayIcon:YES];
                [view_PopView.btn_top setImage:[UIImage imageNamed:@"btn_Common_SendMessage"] forState:UIControlStateNormal];
                [view_PopView.btn_top setImage:[UIImage imageNamed:@"btn_Common_SendMessage_on"] forState:UIControlStateHighlighted];
                [view_PopView.btn_top addTarget:self action:@selector(sendMessageClick) forControlEvents:UIControlEventTouchUpInside];
                [view_Bottom addSubview:view_PopView];
            }
            break;
        }
            //处理中
        case CLCWay:
        {
                view_PopView = [[PopView alloc] initWithButtonCount:1 isNewMessage:_mShipOrder.haveUnreadMessage isDisplayIcon:YES];
                [view_PopView.btn_top setImage:[UIImage imageNamed:@"btn_Common_SendMessage"] forState:UIControlStateNormal];
                [view_PopView.btn_top setImage:[UIImage imageNamed:@"btn_Common_SendMessage_on"] forState:UIControlStateHighlighted];
                [view_PopView.btn_top addTarget:self action:@selector(sendMessageClick) forControlEvents:UIControlEventTouchUpInside];
                [view_Bottom addSubview:view_PopView];
                break;
        }
            //未处理
        case WCLWay:
        {
            view_PopView = [[PopView alloc] initWithButtonCount:1 isNewMessage:_mShipOrder.haveUnreadMessage isDisplayIcon:NO];
            [view_PopView.btn_top setImage:[UIImage imageNamed:@"btn_ShipDetail_CancelShip"] forState:UIControlStateNormal];
            [view_PopView.btn_top setImage:[UIImage imageNamed:@"btn_ShipDetail_CancelShip_on"] forState:UIControlStateHighlighted];
            [view_PopView.btn_top addTarget:self action:@selector(DeleteShipClick) forControlEvents:UIControlEventTouchUpInside];
            [view_Bottom addSubview:view_PopView];
            break;
        }
            //已收货
        case YSHWay:
        {
            view_PopView = [[PopView alloc] initWithButtonCount:1 isNewMessage:_mShipOrder.haveUnreadMessage isDisplayIcon:NO];
            [view_PopView.btn_top setImage:[UIImage imageNamed:@"btn_ShipDetail_evaluateShip"] forState:UIControlStateNormal];
            [view_PopView.btn_top setImage:[UIImage imageNamed:@"btn_ShipDetail_evaluateShip_on"] forState:UIControlStateHighlighted];
            [view_PopView.btn_top addTarget:self action:@selector(EvaluateShip) forControlEvents:UIControlEventTouchUpInside];
            [view_Bottom addSubview:view_PopView];
            break;
        }
    }
    view_PopView.backgroundColor = PL_COLOR_CLEAR;
}



#pragma mark - 确认收货
-(void)RequestConfirmReceived
{
    [self.view setUserInteractionEnabled:NO];
   
    req_ConfimReceived = req_ConfimReceived ? req_ConfimReceived : [[ConfimReceivedRequest alloc]init];
   
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setValue:_str_ShipId forKey:RQ_CONFIMRECEIVED_PARAM_SHIPID];
    
    data_ConfimReceived = data_ConfimReceived ? data_ConfimReceived : [[DataRepeater alloc]initWithName:RQNAME_CONFIRMRECEIVED];
    data_ConfimReceived.requestParameters = params;
    data_ConfimReceived.notificationName = RQNAME_CONFIRMRECEIVED;
    data_ConfimReceived.requestModal = PushData;
    data_ConfimReceived.networkRequest = req_ConfimReceived;
    [params release];
    
    data_ConfimReceived.isAuth = YES;
    __unsafe_unretained __typeof(self) weakSelf = self;
    data_ConfimReceived.compleBlock = ^(id repeater){
        [weakSelf ConfirmRecieived:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:data_ConfimReceived];
}

-(void)ConfirmRecieived:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        ShipEvaluateViewController *v_Evaluate = [[[ShipEvaluateViewController alloc]init]autorelease];
        v_Evaluate.str_ScoreCount = repeater.responseValue;
        v_Evaluate.str_Image = @"icon_IsPatch_on";
        v_Evaluate.str_ShipId = _str_ShipId;
        v_Evaluate.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:v_Evaluate animated:YES];
    }
    else
    {
        [self showHUDErrorMessage:repeater.errorInfo.message];
    }
    
    [self.view setUserInteractionEnabled:YES];
}


#pragma mark - 撤消订单
-(void)RequestCancelShipOrder
{
    [self showHUDIndicatorMessage:LocalizedString(@"ShipDetailViewController_HUDIndMsg2",@"正在提交...")];
    req_CancelShip = req_CancelShip ?req_CancelShip : [[CancelShipRequest alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:_str_ShipId forKey:RQ_CANCELSHIPORDER_PARAM_SHIPID];
    data_CancelShip = data_CancelShip ? data_CancelShip : [[DataRepeater alloc]initWithName:RQNAME_CANCELSHIPORDER];
    data_CancelShip.requestParameters = params;
    data_CancelShip.notificationName = RQNAME_CANCELSHIPORDER;
    data_CancelShip.requestModal = PushData;
    data_CancelShip.networkRequest = req_CancelShip;
    [params release];
    
    data_CancelShip.isAuth = YES;
    __unsafe_unretained __typeof(self) weakSelf = self;
    data_CancelShip.compleBlock = ^(id repeater){
        [weakSelf CancelShipOrders:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:data_CancelShip];
    
}
-(void)CancelShipOrders:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        [_arr_OrderObject removeObject:_mShipOrder];
        [self performSelector:@selector(delNotification:) withObject:@"name" afterDelay:0.5f];
        [self showHUDSuccessMessage:LocalizedString(@"ShipDetailViewController_HUDSucMsg",@"删除成功")];
    }
    else
    {
        [self showHUDErrorMessage:repeater.errorInfo.message];
    }
}


#pragma mark - UITableviewDataSource && UITableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //进度追踪
    if(tab_Schedule == tableView)
    {
        if(isScheduleFlag)
        {
            return scheduleHeightFlag + 79.0f;
        }
        else
        {
            return 79.0f;
        }

    }
    //物流追踪
    else if(tab_Logistics == tableView)
    {
        if(isLogisticsFlag)
        {
            return logisticsHeightFlag + 139.0f;
        }
        else
        {
            return 139.0f;
        }
    }
    //商品详情
    else if(tab_ShipDetail == tableView)
    {
        if(isShipDetailFlag)
        {
            return 6*33.0f + 83.5;
        }
        else
        {
            return 83.5f;
        }
    }
    //商品物品
    else if(tab_ShipOrders == tableView)
    {
       UserProduct *userProduct = [arr_ShipOrders objectAtIndex:indexPath.row];
        CGSize  singleLineSize = [userProduct.skuRemark sizeWithFont:DEFAULT_FONT(14) constrainedToSize:CGSizeMake(MainScreenFrame_Width - 320.0f, 20.0f) lineBreakMode:NSLineBreakByCharWrapping];
       CGSize skuSize = [userProduct.skuRemark sizeWithFont:DEFAULT_FONT(14) constrainedToSize:CGSizeMake(MainScreenFrame_Width - 320.0f, 500.0f) lineBreakMode:NSLineBreakByCharWrapping];
        if(isShipOrdersFlag)
        {
            return arr_ShipOrders.count * 76.0f + 45.0f + skuSize.height - singleLineSize.height;
        }
        else
        {
            return 45.0f;
        }
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //进度详情
   if(tableView.tag == 0000)
   {
        static NSString *str_Schedule = @"Schedulecell";
        ShipDownListCell *cell_Schedule = [tableView dequeueReusableCellWithIdentifier:str_Schedule];
       cell_Schedule.cellClickDelegate = self;
        if(cell_Schedule == nil)
        {            
            cell_Schedule=[[[ShipDownListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str_Schedule]autorelease];
            cell_Schedule.selectionStyle=UITableViewCellAccessoryNone;
        }
           [cell_Schedule SetData:arr_Schedule ViewType:1 isSelect:isScheduleFlag isReqStatus:NO shipModel:_mShipOrder];
           if(arr_Schedule.count <= 0)
           {
               cell_Schedule.userInteractionEnabled = NO;
           }
           else
           {
               cell_Schedule.userInteractionEnabled = YES;
           }
       return cell_Schedule;
    }
    //物流详情
    else if(tableView.tag == 1111)
    {
        static NSString *str_Logistics = @"Logisticscell";
        
        ShipDownListCell * cell_Logistics = [tableView dequeueReusableCellWithIdentifier:str_Logistics];
        cell_Logistics.cellClickDelegate = self;
        if(cell_Logistics == nil)
        {
            cell_Logistics = [[[ShipDownListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str_Logistics]autorelease];
            cell_Logistics.selectionStyle = UITableViewCellAccessoryNone;
        }
       
        [cell_Logistics SetData:arr_Logistics ViewType:0 isSelect:isLogisticsFlag isReqStatus:isReqLogisticsFlag shipModel:_mShipOrder];
    
//        if(arr_Logistics.count <= 0)
//        {
//            cell_Logistics.userInteractionEnabled = NO;
//        }
//        else
//        {
//            cell_Logistics.userInteractionEnabled = YES;
//        }
        return cell_Logistics;
    }
    //商品详情
    else if(tableView.tag == 2222)
    {
        static NSString *str_ShipDetail = @"ShipDetailCell";
        ShipStatusDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:str_ShipDetail];
        if(cell == nil)
        {
            cell = [[[ShipStatusDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str_ShipDetail]autorelease];
            cell.selectionStyle = UITableViewCellAccessoryNone;
        }
        [cell SetData:mShipDetail isSelect:isShipDetailFlag messageData:marr_ShipDetail];
        return cell;
    }
    //商品
    else if(tableView.tag == 3333)
    {
        static NSString *str_ShipOrder = @"ShipOrderCell";
        ShipDetailOrdersCell *Ordercell = [tableView dequeueReusableCellWithIdentifier:str_ShipOrder];
        if(Ordercell == nil)
        {
            Ordercell = [[[ShipDetailOrdersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str_ShipOrder] autorelease];
            Ordercell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [Ordercell SetData:arr_ShipOrders isSelect:isShipOrdersFlag];
        return Ordercell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    tab_ShipDetail.frame = CGRectMake(10.0f,10.0f, UITABLEVIEW_WIDTH, tab_ShipDetail.frame.size.height);
    //进度详情
    if(tableView.tag == 0000)
    {
        if(!isScheduleFlag)
        {
            isScheduleFlag = YES;
            
            tab_Schedule.frame = CGRectMake(10.0f,tab_ShipDetail.frame.origin.y + tab_ShipDetail.frame.size.height + 10, UITABLEVIEW_WIDTH, scheduleHeightFlag + 79.0f);
            
            tab_Logistics.frame = CGRectMake(10.0f,tab_Schedule.frame.origin.y + tab_Schedule.frame.size.height + 10 , UITABLEVIEW_WIDTH, tab_Logistics.frame.size.height);
            
            tab_ShipOrders.frame = CGRectMake(10.0f,tab_Logistics.frame.origin.y + tab_Logistics.frame.size.height + 10 , UITABLEVIEW_WIDTH, tab_ShipOrders.frame.size.height);
        }
        else
        {
            isScheduleFlag = NO;
            
            tab_Schedule.frame = CGRectMake(10.0f,tab_ShipDetail.frame.origin.y + tab_ShipDetail.frame.size.height + 10, UITABLEVIEW_WIDTH, 79.0f);
            
            tab_Logistics.frame = CGRectMake(10.0f,tab_Schedule.frame.origin.y + tab_Schedule.frame.size.height + 10, UITABLEVIEW_WIDTH, tab_Logistics.frame.size.height);
            
            tab_ShipOrders.frame = CGRectMake(10.0f,tab_Logistics.frame.origin.y + tab_Logistics.frame.size.height + 10, UITABLEVIEW_WIDTH, tab_ShipOrders.frame.size.height);
        }
        DLOG(@"scheduleHeightFlag%f",scheduleHeightFlag);
    }
    //物流详情
    else if(tableView.tag == 1111)
    {
        //如果为空点击效果去除
        if(arr_Logistics.count <= 0)
        {
            return;
        }
        if(!isLogisticsFlag)
        {
            isLogisticsFlag = YES;
            
            tab_Schedule.frame = CGRectMake(10.0f,tab_ShipDetail.frame.origin.y + tab_ShipDetail.frame.size.height + 10, UITABLEVIEW_WIDTH,tab_Schedule.frame.size.height);
            
            tab_Logistics.frame = CGRectMake(10.0f,tab_Schedule.frame.origin.y + tab_Schedule.frame.size.height + 10 , UITABLEVIEW_WIDTH,logisticsHeightFlag + 139.0f);
            
            tab_ShipOrders.frame = CGRectMake(10.0f,tab_Logistics.frame.origin.y + tab_Logistics.frame.size.height + 10 , UITABLEVIEW_WIDTH, tab_ShipOrders.frame.size.height);
        }
        else
        {
            isLogisticsFlag = NO;
            
            tab_Schedule.frame = CGRectMake(10.0f,tab_ShipDetail.frame.origin.y + tab_ShipDetail.frame.size.height + 10, UITABLEVIEW_WIDTH, tab_Schedule.frame.size.height);
            
            tab_Logistics.frame = CGRectMake(10.0f,tab_Schedule.frame.origin.y + tab_Schedule.frame.size.height + 10, UITABLEVIEW_WIDTH, 139.0f);
            
            tab_ShipOrders.frame = CGRectMake(10.0f,tab_Logistics.frame.origin.y + tab_Logistics.frame.size.height + 10, UITABLEVIEW_WIDTH, tab_ShipOrders.frame.size.height);
        }
        DLOG(@"logisticsHeightFlag%f",logisticsHeightFlag);
    }
    //商品详情
    else if(tableView.tag == 2222)
    {
        if(!isShipDetailFlag)
        {
            isShipDetailFlag = YES;
            tab_ShipDetail.frame = CGRectMake(10.0f,10.0f, UITABLEVIEW_WIDTH, 83.5f + 6 * 33.0f);
            tab_Schedule.frame = CGRectMake(10.0f,tab_ShipDetail.frame.origin.y + tab_ShipDetail.frame.size.height + 10, UITABLEVIEW_WIDTH, tab_Schedule.frame.size.height);
            tab_Logistics.frame = CGRectMake(10.0f,tab_Schedule.frame.origin.y + tab_Schedule.frame.size.height + 10 , UITABLEVIEW_WIDTH, tab_Logistics.frame.size.height);
            tab_ShipOrders.frame = CGRectMake(10.0f,tab_Logistics.frame.origin.y + tab_Logistics.frame.size.height + 10 , UITABLEVIEW_WIDTH, tab_ShipOrders.frame.size.height);
        }
        else
        {
            isShipDetailFlag = NO;
            tab_ShipDetail.frame = CGRectMake(10.0f,10.0f, UITABLEVIEW_WIDTH, 83.5f);
            tab_Schedule.frame = CGRectMake(10.0f,tab_ShipDetail.frame.origin.y + tab_ShipDetail.frame.size.height + 10, UITABLEVIEW_WIDTH, tab_Schedule.frame.size.height);
            tab_Logistics.frame = CGRectMake(10.0f,tab_Schedule.frame.origin.y + tab_Schedule.frame.size.height + 10, UITABLEVIEW_WIDTH, tab_Logistics.frame.size.height);
            tab_ShipOrders.frame = CGRectMake(10.0f,tab_Logistics.frame.origin.y + tab_Logistics.frame.size.height + 10, UITABLEVIEW_WIDTH, tab_ShipOrders.frame.size.height);
        }
    }
    //商品
    else if(tableView.tag == 3333)
    {
        
    UserProduct *userProduct = [arr_ShipOrders objectAtIndex:indexPath.row];
    CGSize  singleLineSize = [userProduct.skuRemark sizeWithFont:DEFAULT_FONT(14) constrainedToSize:CGSizeMake(MainScreenFrame_Width - 320.0f, 20.0f) lineBreakMode:NSLineBreakByCharWrapping];
    CGSize skuSize = [userProduct.skuRemark sizeWithFont:DEFAULT_FONT(14) constrainedToSize:CGSizeMake(MainScreenFrame_Width - 320.0f, 500.0f) lineBreakMode:NSLineBreakByCharWrapping];
        
    if(!isShipOrdersFlag)
    {
        isShipOrdersFlag = YES;
        tab_ShipDetail.frame = CGRectMake(10.0f,10.0f, UITABLEVIEW_WIDTH, tab_ShipDetail.frame.size.height);
        
        tab_Schedule.frame = CGRectMake(10.0f,tab_ShipDetail.frame.origin.y + tab_ShipDetail.frame.size.height + 10, UITABLEVIEW_WIDTH,tab_Schedule.frame.size.height);
        
        tab_Logistics.frame = CGRectMake(10.0f,tab_Schedule.frame.origin.y + tab_Schedule.frame.size.height + 10 , UITABLEVIEW_WIDTH,tab_Logistics.frame.size.height);
        
        tab_ShipOrders.frame = CGRectMake(10.0f,tab_Logistics.frame.origin.y + tab_Logistics.frame.size.height + 10 , UITABLEVIEW_WIDTH, arr_ShipOrders.count*76.0f + 45.0f + skuSize.height - singleLineSize.height);
    }
    else
    {
        isShipOrdersFlag = NO;
        tab_ShipDetail.frame = CGRectMake(10.0f,10.0f, UITABLEVIEW_WIDTH, tab_ShipDetail.frame.size.height);
        
        tab_Schedule.frame = CGRectMake(10.0f,tab_ShipDetail.frame.origin.y + tab_ShipDetail.frame.size.height + 10, UITABLEVIEW_WIDTH, tab_Schedule.frame.size.height);
        
        tab_Logistics.frame = CGRectMake(10.0f,tab_Schedule.frame.origin.y + tab_Schedule.frame.size.height + 10, UITABLEVIEW_WIDTH, tab_Logistics.frame.size.height);
        
        tab_ShipOrders.frame = CGRectMake(10.0f,tab_Logistics.frame.origin.y + tab_Logistics.frame.size.height + 10, UITABLEVIEW_WIDTH, 45.0f);
    }
    }
    scr_ShipScroll.contentSize = CGSizeMake(MainScreenFrame_Width - 320.0f, tab_ShipDetail.frame.size.height + tab_Schedule.frame.size.height + tab_Logistics.frame.size.height + tab_ShipOrders.frame.size.height + 50.0f + 50.0f);
    [tableView reloadData];
}




#pragma mark - ShipDownListDelegate (size height)
- (void)SendShipDownListCellHeight:(CGFloat)Tableviewheight Type:(int)cellType
{
    //type 1:为包裹处理 0:国际物流
    if(cellType)
    {
        scheduleHeightFlag = Tableviewheight;
    }
    else
    {
        logisticsHeightFlag = Tableviewheight;
    }
}

#pragma mark - 发送短信
-(void)sendMessageClick
{
    //判断是否已读
    if(_mShipOrder.haveUnreadMessage)
    {
        _mShipOrder.haveUnreadMessage = NO;
        [self loadPopView];
        if([isNewDisplayStateDelegate respondsToSelector:@selector(isShipNewDisplayState)])
        {
            [isNewDisplayStateDelegate isShipNewDisplayState];
        }
    }

    MessageDetailViewController *v_MsgDetail = [[[MessageDetailViewController alloc]init]autorelease];
    v_MsgDetail.str_objectId = _str_ShipId;
    v_MsgDetail.messageType = ShipMessage;
    v_MsgDetail.str_messageTopic = [NSString stringWithFormat:LocalizedString(@"ShipDetailViewController_vMsgDetail",@"关于运单(%@)的短信"),_str_ShipId];
    [self.navigationController pushViewController:v_MsgDetail animated:YES];
}

#pragma mark - 确认收货
-(void)ConfirmReceivedClick
{
    CustomAlertView *v_Alert = [[CustomAlertView alloc]initWithTitle:@""
                                                             message:LocalizedString(@"ShipDetailViewController_CustomAlertView_Msg",@"已经收到这个包裹了吗!")
                                                            delegate:self
                                                   cancelButtonTitle:LocalizedString(@"Common_Btn_Cancel", @"取消")
                                                   otherButtonTitles:LocalizedString(@"Common_Btn_Sure", @"确定"), nil];
    v_Alert.tag = 99999;
    v_Alert.bg_AlertMain = @"bg_Alert_Normal";
    v_Alert.btn_ClickLeft = @"btn_Alert_Submit";
    v_Alert.btn_ClickLeft_on = @"btn_Alert_Submit_on";
    v_Alert.btn_ClickRight = @"btn_Alert_Cancel";
    v_Alert.btn_ClickRight_on = @"btn_Alert_Cancel_on";
    [v_Alert show];
    [v_Alert release];
    
}

#pragma mark - 删除运单
-(void)DeleteShipClick
{
    UIAlertView *v_Alert = [[UIAlertView alloc]initWithTitle:LocalizedString(@"ShipDetailViewController_AlertView_Title",@"Panli提醒")
                                                             message:LocalizedString(@"ShipDetailViewController_AlertView_Msg",@"你确定撤消此运单吗?")
                                                            delegate:self
                                                   cancelButtonTitle:LocalizedString(@"Common_Btn_Cancel", @"取消") otherButtonTitles:LocalizedString(@"Common_Btn_Sure", @"确定"), nil];
    v_Alert.tag = 88888;
    [v_Alert show];
    [v_Alert release];

}

#pragma mark - 运单评价
-(void)EvaluateShip
{
    ShipEvaluateViewController *v_Evaluate = [[[ShipEvaluateViewController alloc]init]autorelease];
    v_Evaluate.hidesBottomBarWhenPushed = YES;
    //v_Evaluate.b_RateState = b_RateState;
    v_Evaluate.str_ShipId= _str_ShipId;
    [self.navigationController pushViewController:v_Evaluate animated:YES];
}

#pragma mark - UiAlertDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 99999)
    {
        if(buttonIndex == 1)
        {
            [self RequestConfirmReceived];
        }
    }
    
    if(alertView.tag == 88888)
    {
        if(buttonIndex == 1)
        {
            [self RequestCancelShipOrder];
        }
    }

}
- (void)willPresentAlertView:(UIAlertView *)alertView
{
    UIImage *img = [UIImage imageNamed:@"bg_Alert_Normal"];
    alertView.frame = CGRectMake((MainScreenFrame_Width - 320.0f - img.size.width)/2, alertView.frame.origin.y, img.size.width, img.size.height);
}
#pragma mark - SkipurlClick
-(void)SkipurlClick
{
    NSURL *URL = [NSURL URLWithString:_str_ShipExpressUrl];
	SVWebViewController *webViewController = [[[SVWebViewController alloc] initWithURL:URL] autorelease];
    webViewController.availableActions = SVWebViewControllerAvailableActionsOpenInSafari | SVWebViewControllerAvailableActionsCopyLink ;
    CustomerNavagationBarController *registerViewController = [[[CustomerNavagationBarController alloc] initWithRootViewController:webViewController] autorelease];
	[self.navigationController presentModalViewController:registerViewController animated:YES];
}
#pragma mark - 延时方法
-(void)delNotification:(id)sender
{
    [self.view setUserInteractionEnabled:YES];
    if([isNewDisplayStateDelegate respondsToSelector:@selector(isDeleteShip)])
    {
        [isNewDisplayStateDelegate isDeleteShip];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
