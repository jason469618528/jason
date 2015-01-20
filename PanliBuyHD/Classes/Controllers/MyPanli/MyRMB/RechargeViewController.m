//
//  RechargeViewController.m
//  PanliApp
//
//  Created by jason on 13-4-19.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "RechargeViewController.h"
#import "UserInfo.h"
#import "RechargeSuccessViewController.h"
#import "RechargeFaildViewController.h"
#import "CustomerNavagationBarController.h"
#define NUMBERS @".0123456789\n"

@interface RechargeViewController ()
{
    
}
@property(nonatomic, retain, readwrite) PayPalConfiguration *payPalConfig;
@end

@implementation RechargeViewController

@synthesize keyboardToolbar;
@synthesize shouldPayMoney;
#pragma mark - default

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
    [self viewDidLoadWithBackButtom:YES];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [PanliHelper colorWithHexString:@"#eeeeee"];
    //paypal配置
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = NO;
    _payPalConfig.languageOrLocale = @"cn";
    _payPalConfig.merchantName = @"Panli Paypal Store";
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    _payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionNone;

    int subY = 0;
    
    //底部支付View
    UIView *view_Bottom = [[UIView alloc]initWithFrame:CGRectMake(0.0, MainScreenFrame_Width - UI_NAVIGATION_BAR_HEIGHT - 100.0f-90 , MainScreenFrame_Width, 100.0f)];
    view_Bottom.backgroundColor = [PanliHelper colorWithHexString:@"#f8f8f8"];
    [[view_Bottom layer] setBorderWidth:1];
    [[view_Bottom layer] setBorderColor:[PanliHelper colorWithHexString:@"#cccccc"].CGColor];
    [self.view addSubview:view_Bottom];
    
    if(self.payTypeFlag == BalanceNotEnough || self.payTypeFlag == BalanceEnough)
    {
        self.navigationItem.title = LocalizedString(@"RechargeViewController_Nav_Title1",@"支付");
        //余额充足情况与余额不足情况
        UIView *view_Top = [[UIView alloc] initWithFrame:CGRectMake(10.0f, 12.0f, MainScreenFrame_Width - 20.0f, self.payTypeFlag == BalanceNotEnough ? 186.0f : 150.0f)];
        view_Top.backgroundColor = [PanliHelper colorWithHexString:@"#ffffff"];
        [[view_Top layer] setBorderWidth:1.0f];
        [[view_Top layer] setBorderColor:[PanliHelper colorWithHexString:@"#cacaca"].CGColor];
        [[view_Top layer] setCornerRadius:8.0f];
        [self.view addSubview:view_Top];
        
        UILabel *lab_PayMsg = [[UILabel alloc] initWithFrame:CGRectMake(118.0f, 12.0f, 200.0f, 18.0f)];
        lab_PayMsg.text = LocalizedString(@"RechargeViewController_labPayMsg",@"结算信息");
        lab_PayMsg.font = DEFAULT_FONT(17.0f);
        lab_PayMsg.textColor = [PanliHelper colorWithHexString:@"#444444"];
        lab_PayMsg.backgroundColor = PL_COLOR_CLEAR;
        [view_Top addSubview:lab_PayMsg];
        
        //线条
        UIView *view_LineTop = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 39.0f, view_Top.frame.size.width, 0.5)];
        view_LineTop.backgroundColor = [PanliHelper colorWithHexString:@"#cacaca"];
        [view_Top addSubview:view_LineTop];
        
        UIView *view_LineBottom = [[UIView alloc] initWithFrame:CGRectMake(00.0f, 39.5f, view_Top.frame.size.width, 0.5)];
        view_LineBottom.backgroundColor = [PanliHelper colorWithHexString:@"#e7e7e7"];
        [view_Top addSubview:view_LineBottom];
        
        subY += view_LineBottom.frame.origin.y + 10.0f + 1.6f;
        
        //应付金额
        UILabel *lab_PayMoney = [[UILabel alloc] initWithFrame:CGRectMake(18.0f, subY, 274.0f, 16.0f)];
        lab_PayMoney.text = [NSString stringWithFormat:LocalizedString(@"RechargeViewController_labPayMoney",@"应付总额 : ￥%.2f"),shouldPayMoney];
        lab_PayMoney.font = DEFAULT_FONT(15.0f);
        lab_PayMoney.textColor = [PanliHelper colorWithHexString:@"#666666"];
        lab_PayMoney.textAlignment = UITextAlignmentLeft;
        lab_PayMoney.backgroundColor = PL_COLOR_CLEAR;
        [view_Top addSubview:lab_PayMoney];
        
        subY += 15.0f + 10.0f; // 15 + 10
        
        if(self.payTypeFlag == BalanceEnough)
        {
            //虚线
            UIImageView *image_LineTop = [[UIImageView alloc] initWithFrame:CGRectMake(8.0f, subY, view_Top.frame.size.width - 16.0f, 2.0f)];
            image_LineTop.image = [UIImage imageNamed:@"bg_Message_ProductLine"];
            [view_Top addSubview:image_LineTop];
            
            subY += 12.0f; // 10 + 2
            
            UserInfo *mUserInfo = [GlobalObj getUserInfo];
            //余额
            lab_Balance = [[UILabel alloc] initWithFrame:CGRectMake(18.0f, subY, 274.0f, 16.0f)];
            lab_Balance.text = [NSString stringWithFormat:LocalizedString(@"RechargeViewController_labBalance",@"账户余额 : ￥%.2f"),mUserInfo.balance];
            lab_Balance.font = DEFAULT_FONT(15.0f);
            lab_Balance.textColor = [PanliHelper colorWithHexString:@"#666666"];
            lab_Balance.textAlignment = UITextAlignmentLeft;
            lab_Balance.backgroundColor = PL_COLOR_CLEAR;
            [view_Top addSubview:lab_Balance];
            
            subY += 15.0f + 20.0f; // 15 + 10
        }
        else
        {
            //虚线
            UIImageView *image_LineTop = [[UIImageView alloc] initWithFrame:CGRectMake(8.0f, subY, view_Top.frame.size.width - 16.0f, 2.0f)];
            image_LineTop.image = [UIImage imageNamed:@"bg_Message_ProductLine"];
            [view_Top addSubview:image_LineTop];
            
            subY += 12.0f; // 10 + 2
            
            UserInfo *mUserInfo = [GlobalObj getUserInfo];
            //余额
            lab_Balance = [[UILabel alloc] initWithFrame:CGRectMake(18.0f, subY, 274.0f, 16.0f)];
            lab_Balance.text = [NSString stringWithFormat:LocalizedString(@"RechargeViewController_labBalance",@"账户余额 : ￥%.2f"),mUserInfo.balance];
            lab_Balance.font = DEFAULT_FONT(15.0f);
            lab_Balance.textColor = [PanliHelper colorWithHexString:@"#666666"];
            lab_Balance.textAlignment = UITextAlignmentLeft;
            lab_Balance.backgroundColor = PL_COLOR_CLEAR;
            [view_Top addSubview:lab_Balance];
            
            subY += 15.0f + 10.0f; // 15 + 10
            
            //虚线
            UIImageView *image_LineBottom = [[UIImageView alloc] initWithFrame:CGRectMake(8.0f, subY, view_Top.frame.size.width - 16.0f, 2.0f)];
            image_LineBottom.image = [UIImage imageNamed:@"bg_Message_ProductLine"];
            [view_Top addSubview:image_LineBottom];
            
            subY += 12.0f; // 10 + 2
            
            //还需支付
            UILabel *lab_LittleMoneyTxt = [[UILabel alloc] initWithFrame:CGRectMake(18.0f, subY, 73.0f, 16.0f)];
            lab_LittleMoneyTxt.text = LocalizedString(@"RechargeViewController_labLittleMoneyTxt",@"还需支付 : ");
            lab_LittleMoneyTxt.font = DEFAULT_FONT(15.0f);
            lab_LittleMoneyTxt.textColor = [PanliHelper colorWithHexString:@"#666666"];
            lab_LittleMoneyTxt.textAlignment = UITextAlignmentLeft;
            lab_LittleMoneyTxt.backgroundColor = PL_COLOR_CLEAR;
            [view_Top addSubview:lab_LittleMoneyTxt];
            
            lab_LittleMoney = [[UILabel alloc] initWithFrame:CGRectMake(18.0f + 73.0f, subY, 200.0f, 16.0f)];
            lab_LittleMoney.text = [NSString stringWithFormat:@"%@",[PanliHelper getCurrencyStyle:shouldPayMoney - mUserInfo.balance]];
            lab_LittleMoney.font = DEFAULT_FONT(15.0f);
            lab_LittleMoney.textColor = [PanliHelper colorWithHexString:@"#ff3301"];
            lab_LittleMoney.textAlignment = UITextAlignmentLeft;
            lab_LittleMoney.backgroundColor = PL_COLOR_CLEAR;
            [view_Top addSubview:lab_LittleMoney];
            
            subY += 15.0f + 30.0f; //15.0f + 10.0f + 20.0f
        }
    }
    else
    {
        //充值 LocalizedString(@"RechargeViewController_Nav_Title2",
        self.navigationItem.title=LocalizedString(@"RechargeViewController_Nav_Title2",@"充值");
        
        subY += 24.0f;
        
        //输入充值金额text
        txt_InputMoney=[[UITextField alloc]initWithFrame:CGRectMake(13.0f+60, 24.0f, MainScreenFrame_Width - 26.0f-200, 45.0f)];
        [txt_InputMoney setBorderStyle:UITextBorderStyleNone];
        [txt_InputMoney setBackground:[UIImage imageNamed:@"bg_PaypalText"]];
        txt_InputMoney.font = DEFAULT_FONT(17.0f);
        txt_InputMoney.textColor = [PanliHelper colorWithHexString:@"#23bc1e"];
        txt_InputMoney.clearButtonMode = YES;
        
        UILabel * lab_Input = [[UILabel alloc]init];
        lab_Input.frame = CGRectMake(10.0f, 14.0f, 95.0f, 18.0f);
        //LocalizedString(@"RechargeViewController_labInput",
        lab_Input.text = LocalizedString(@"RechargeViewController_labInput",@"充值金额 ￥");
        lab_Input.font = DEFAULT_FONT(17.0f);
        lab_Input.textColor = [PanliHelper colorWithHexString:@"4d4d4d"];
        lab_Input.backgroundColor = PL_COLOR_CLEAR;
        
        UIView * bg_InputView = [[UIView alloc]init];
        [bg_InputView addSubview:lab_Input];
        txt_InputMoney.leftView = bg_InputView;
        
        txt_InputMoney.leftView.frame = CGRectMake(0.0f, 0.0f, 105.0f, 45.0f);
        txt_InputMoney.leftView.contentMode = UIControlContentVerticalAlignmentCenter;
        txt_InputMoney.leftViewMode = UITextFieldViewModeAlways;
        txt_InputMoney.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        txt_InputMoney.delegate = self;
        txt_InputMoney.keyboardType = UIKeyboardTypeDecimalPad;
        [txt_InputMoney addTarget:self action:@selector(UpdateRegeRest:) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:txt_InputMoney];
        
        subY += 65.0f;
        
        //添加完成
        if (self.keyboardToolbar == nil)
        {
            self.keyboardToolbar = [[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 38.0f)]autorelease];
            self.keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
            //LocalizedString(@"RechargeViewController_BarButtonItem_Title",
            UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:LocalizedString(@"RechargeViewController_BarButtonItem_Title", @"完成")
                                                                            style:UIBarButtonItemStyleDone
                                                                           target:self
                                                                           action:@selector(hideKeyboardToolbar:)];
            [self.keyboardToolbar setItems:[NSArray arrayWithObjects: doneBarItem, nil]];
        }
        txt_InputMoney.inputAccessoryView = self.keyboardToolbar;
        
        //设置手势
        UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleBackgroundTap:)];
        recognizer.cancelsTouchesInView = NO;
        [self.view addGestureRecognizer:recognizer];
        [recognizer release];

    }
    
    //支付方式
    UIView *view_PayMode = [[UIView alloc] initWithFrame:CGRectMake(0.0f, subY, MainScreenFrame_Width, 44.0f)];
    view_PayMode.backgroundColor = [PanliHelper colorWithHexString:@"#eeeeee"];
    [self.view addSubview:view_PayMode];
    [view_PayMode release];
    
    //icon
    UIImageView *icon_Mode = [[UIImageView alloc] initWithFrame:CGRectMake(13.0f+60, 13.0f, 18.0f, 15.0f)];
    icon_Mode.image = [UIImage imageNamed:@"icon_Paypal_State"];
    [view_PayMode addSubview:icon_Mode];
    [icon_Mode release];
    
    //支付方式
    UILabel *lab_PayMode = [[UILabel alloc] initWithFrame:CGRectMake(101.0f, 13.0f, 200.0f, 16.0f)];
//    LocalizedString(@"RechargeViewController_labPayMode", 
    lab_PayMode.text = LocalizedString(@"RechargeViewController_labPayMode", @"支付方式");
    lab_PayMode.font = DEFAULT_FONT(15.0f);
    lab_PayMode.textColor = [PanliHelper colorWithHexString:@"#6e6e6e"];
    lab_PayMode.textAlignment = UITextAlignmentLeft;
    lab_PayMode.backgroundColor = PL_COLOR_CLEAR;
    [view_PayMode addSubview:lab_PayMode];
    [lab_PayMode release];

    //线条
    UIView *view_LineTop = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, 1.0f)];
    view_LineTop.backgroundColor = [PanliHelper colorWithHexString:@"#bababa"];
    [view_PayMode addSubview:view_LineTop];
    [view_LineTop release];

    UIView *view_LineBottom = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 1.0f, MainScreenFrame_Width, 1.0f)];
    view_LineBottom.backgroundColor = [PanliHelper colorWithHexString:@"#fefffa"];
    [view_PayMode addSubview:view_LineBottom];
    [view_LineBottom release];
    
    //线条
    UIView *view_Bottom_LineTop = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 43.0f, MainScreenFrame_Width, 1.0f)];
    view_Bottom_LineTop.backgroundColor = [PanliHelper colorWithHexString:@"#bababa"];
    [view_PayMode addSubview:view_Bottom_LineTop];
    [view_Bottom_LineTop release];

    UIView *view_Bottom_LineBottom = [[UIView alloc] initWithFrame:CGRectMake(00.0f, 44.0f, MainScreenFrame_Width, 1.0f)];
    view_Bottom_LineBottom.backgroundColor = [PanliHelper colorWithHexString:@"#fefffa"];
    [view_PayMode addSubview:view_Bottom_LineBottom];
    [view_Bottom_LineBottom release];
    
    subY += 54.0f;
    
    if(self.payTypeFlag != BalanceEnough)
    {
        //paypal当前汇率 手续费
        UIImageView *icon_Paypal = [[UIImageView alloc] initWithFrame:CGRectMake(13.0f+60, subY, 55.0f, 55.0f)];
        icon_Paypal.image = [UIImage imageNamed:@"icon_Paypal_Logo"];
        [[icon_Paypal layer] setCornerRadius:8.0f];
        [self.view addSubview:icon_Paypal];
        [icon_Paypal release];
        
        lab_PayDetail = [[UILabel alloc]initWithFrame:CGRectMake(138.0f, subY + 10.0f, 220.0f, 35.0f)];
        lab_PayDetail.textColor = [PanliHelper colorWithHexString:@"#7c7f7e"];
        lab_PayDetail.backgroundColor = PL_COLOR_CLEAR;
        lab_PayDetail.font = DEFAULT_FONT(15);
        lab_PayDetail.numberOfLines = 2;
        [self.view addSubview:lab_PayDetail];
        [lab_PayDetail release];

        subY += 65.0f;
        
        //虚线
        UIImageView *image_LineBottom = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, subY, MainScreenFrame_Width - 20.0f, 2.0f)];
        image_LineBottom.image = [UIImage imageNamed:@"bg_Message_ProductLine"];
        [self.view addSubview:image_LineBottom];
        [image_LineBottom release];
        
        subY += 12.0f;
        
        UILabel * lab_PayMore = [[UILabel alloc]init];
        lab_PayMore.frame = CGRectMake(10.0f, subY, MainScreenFrame_Width - 20.0f, 14.0f);
        //LocalizedString(@"RechargeViewController_labPayMore",
        lab_PayMore.text = LocalizedString(@"RechargeViewController_labPayMore", @"更多支付方式陆续开通,目前可使用网页版进行。");
        lab_PayMore.textAlignment = UITextAlignmentCenter;
        lab_PayMore.font = DEFAULT_FONT(13.0f);
        lab_PayMore.textColor = [PanliHelper colorWithHexString:@"#a7a7a7"];
        lab_PayMore.backgroundColor = PL_COLOR_CLEAR;
        [self.view addSubview:lab_PayMore];
        [lab_PayMore release];
        
        //实际支付
        lab_DealMoney = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 15.0f, MainScreenFrame_Width - 20.0f, 20.0f)];
        lab_DealMoney.textAlignment = UITextAlignmentCenter;
        lab_DealMoney.font = DEFAULT_FONT(19.0f);
        lab_DealMoney.backgroundColor = PL_COLOR_CLEAR;
        [view_Bottom addSubview:lab_DealMoney];
        [lab_DealMoney release];
        
        btn_payPalTest = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_payPalTest.frame = CGRectMake(lab_DealMoney.center.x-302/2.0f, lab_DealMoney.frame.origin.y + lab_DealMoney.frame.size.height + 10.0f, 302.0f, 41.5f);
        [btn_payPalTest setImage:[UIImage imageNamed:@"btn_Palpal_pay"] forState:UIControlStateNormal];
        [btn_payPalTest setImage:[UIImage imageNamed:@"btn_Palpal_pay_on"] forState:UIControlStateHighlighted];
        [btn_payPalTest addTarget:self action:@selector(paypalClick) forControlEvents:UIControlEventTouchUpInside];
        [view_Bottom addSubview:btn_payPalTest];
        
        [self getRechargeInfoRequest];
    }
    else
    {
        //标识
        UIImageView * imageg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_IsPatch_on"]];
        imageg.frame=CGRectMake(20, subY + 10.0f, 25, 25);
        [self.view addSubview:imageg];
        [imageg release];

        lab_PayDetail = [[UILabel alloc]initWithFrame:CGRectMake(70.0f, subY + 6.0f, 220.0f, 35.0f)];
        //LocalizedString(@"RechargeViewController_labPayDetail",
        lab_PayDetail.text = LocalizedString(@"RechargeViewController_labPayDetail", @"Panli RMB账户余额支付");
        lab_PayDetail.textColor = [PanliHelper colorWithHexString:@"#7c7f7e"];
        lab_PayDetail.backgroundColor = PL_COLOR_CLEAR;
        lab_PayDetail.font = DEFAULT_FONT(15);
        [self.view addSubview:lab_PayDetail];
        [lab_PayDetail release];
        
        btn_payPalTest = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_payPalTest.frame = CGRectMake(7.0f, 29.25f, 304.0f, 41.5f);
        [btn_payPalTest setImage:[UIImage imageNamed:@"btn_CartPay_Recharge"] forState:UIControlStateNormal];
        [btn_payPalTest setImage:[UIImage imageNamed:@"btn_CartPay_Recharge_on"] forState:UIControlStateHighlighted];
        [btn_payPalTest addTarget:self action:@selector(shopingCartClick) forControlEvents:UIControlEventTouchUpInside];
        [view_Bottom addSubview:btn_payPalTest];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self checkLoginWithBlock:^{
        CustomerNavagationBarController *tomerNav = (CustomerNavagationBarController*)self.navigationController;
        tomerNav.canDragBack = NO;
        [PayPalMobile preconnectWithEnvironment:PAYPAL_ENVIRONMENT];
        
        if (self.payTypeFlag != BalanceEnough)
        {
            //获取充值信息请求
//            [[NSNotificationCenter defaultCenter] addObserver:self
//                                                     selector:@selector(getRechargeInfoResponse:)
//                                                         name:RQNAME_RECHARGEINFO
//                                                       object:nil];
//            //生成订单
//            [[NSNotificationCenter defaultCenter] addObserver:self
//                                                     selector:@selector(rechargeCreateResponse:)
//                                                         name:RQNAME_RECHARGEORDERCREATE
//                                                       object:nil];
//            //与服务器对账
//            [[NSNotificationCenter defaultCenter] addObserver:self
//                                                     selector:@selector(rechargeNotifyResponse:)
//                                                         name:RQNAME_PAYPALRECHARGENOTIFY
//                                                       object:nil];
        }
        
        if(self.rpt_DataRepeater && self.payTypeFlag != Recharge)
        {
            //支付请求
//            [[NSNotificationCenter defaultCenter] addObserver:self
//                                                     selector:@selector(PayResponse:)
//                                                         name:self.rpt_DataRepeater.notificationName
//                                                       object:nil];
        }
    }];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    CustomerNavagationBarController *tomerNav = (CustomerNavagationBarController*)self.navigationController;
    tomerNav.canDragBack = YES;
}
#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    
    if (completedPayment != nil)
    {
        NSDictionary *responseDic = [completedPayment.confirmation objectForKey:@"response"];
        if (responseDic != nil && [[responseDic objectForKey:@"state"] isEqualToString:@"approved"])
        {
            NSString *payId = [responseDic objectForKey:@"id"];
            [self rechargeNotifyRequestWithPayKey:payId];
        }
        else
        {
            [self showHUDErrorMessage:LocalizedString(@"RechargeViewController_HUDErrMsg1", @"Paypal充值失败")];
        }
    }
    else
    {
        [self showHUDErrorMessage:LocalizedString(@"RechargeViewController_HUDErrMsg1", @"Paypal充值失败")];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - shoppingCart Viewcontroller
- (void)PayResponse:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        [self hideHUD];
        [self performSelector:@selector(paySuccess) withObject:self afterDelay:1.0];
    }
    else
    {
        [self showHUDErrorMessage:repeater.errorInfo.message];
        [btn_payPalTest addTarget:self action:@selector(shopingCartClick) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)paySuccess
{
    self.successViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:self.successViewController animated:NO];
}

#pragma mark - paypalClick
- (void)paypalClick
{
    if(self.payTypeFlag != Recharge)
    {
        [self createRechargeOrderRequest];
        return;
    }
    else
    {
        //充值
        float userMoney = [txt_InputMoney.text floatValue];
        if(userMoney <= 0)
        {
            //LocalizedString(@"RechargeViewController_HUDErrMsg2",
            [self showHUDErrorMessage:LocalizedString(@"RechargeViewController_HUDErrMsg2", @"请输入正确充值金额...")];
            return;
        }
        [self createRechargeOrderRequest];
    }
}

#pragma mark - shoppingCart btnclick
- (void)shopingCartClick
{
    //LocalizedString(@"RechargeViewController_HUDIndMsg1",
    [self showHUDIndicatorMessage:LocalizedString(@"RechargeViewController_HUDIndMsg1", @"正在提交...")];
    //支付请求
    self.rpt_DataRepeater.isAuth = YES;
    __unsafe_unretained __typeof(self) weakSelf = self;
    self.rpt_DataRepeater.compleBlock = ^(id repeater){
        [weakSelf PayResponse:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:self.rpt_DataRepeater];

}

#pragma mark - 获取充值配置信息
-(void)getRechargeInfoRequest
{
    //开始发送网络请求
    //LocalizedString(@"RechargeViewController_HUDIndMsg2",
    [self showHUDIndicatorMessage:LocalizedString(@"RechargeViewController_HUDIndMsg2", @"正在同步国际汇率...")];
    req_RegeInfo = req_RegeInfo ? req_RegeInfo : [[RechargeInfoRequest alloc] init];
    rpt_RegeInfo = rpt_RegeInfo ? rpt_RegeInfo : [[DataRepeater alloc] initWithName:RQNAME_RECHARGEINFO];
    rpt_RegeInfo.notificationName = RQNAME_RECHARGEINFO;
    rpt_RegeInfo.requestModal = PullData;
    rpt_RegeInfo.networkRequest = req_RegeInfo;
    rpt_RegeInfo.isAuth = YES;
    __unsafe_unretained __typeof(self) weakSelf = self;
    rpt_RegeInfo.compleBlock = ^(id repeater){
        [weakSelf getRechargeInfoResponse:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:rpt_RegeInfo];
}

-(void)getRechargeInfoResponse:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        NSDictionary * dic_RegeInfo = repeater.responseValue;
        if(!dic_RegeInfo || [[dic_RegeInfo allKeys] count] == 0)
        {
            //LocalizedString(@"RechargeViewController_HUDErrMsg3",
            [self showHUDErrorMessage:LocalizedString(@"RechargeViewController_HUDErrMsg3", @"获取计算汇率失败!")];
            return;
        }
        [self hideHUD];
        
        //获取CallbackUrl
        str_CallbackUrl = [[dic_RegeInfo objectForKey:@"CallbackUrl"] retain];

        NSArray  *FeeRate = [dic_RegeInfo objectForKey:@"RechargeFee"];
        NSDictionary *rateDic = [FeeRate objectAtIndex:0];
        //充值状态
        rechargeType = [[rateDic objectForKey:@"RechargeType"] intValue];
        
        //美元汇率
        dollarRate=[[dic_RegeInfo objectForKey:@"USDRate"]floatValue];
        //损失率
        lossRate = [[rateDic objectForKey:@"FeeRate"] floatValue];
        //损失美金
        baseFee = [[rateDic objectForKey:@"BaseFee"] floatValue];

        //显示汇率与手续费
        NSString *str_lossRate = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithFloat:lossRate] numberStyle:NSNumberFormatterPercentStyle];
        NSString *str_baseFee = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithFloat:baseFee] numberStyle:NSNumberFormatterDecimalStyle];
        //LocalizedString(@"RechargeViewController_strMsg",
        NSString *str_Msg = [NSString stringWithFormat:LocalizedString(@"RechargeViewController_strMsg", @"当前汇率 美元:人民币元=1:%.2f手续费 :%@+$%@"),dollarRate,str_lossRate,str_baseFee];
        lab_PayDetail.text = str_Msg;
        
        if(self.payTypeFlag == BalanceNotEnough)
        {
            [self reloadMoney];
        }
    }
    else
    {
        if(repeater.errorInfo.code == 2)
        {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:LocalizedString(@"RechargeViewController_AlertView_Title1", @"panli提醒")
                                                          message:LocalizedString(@"RechargeViewController_AlertView_Msg1", @"服务器维护中，暂时无法充值")
                                                         delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            alert.tag=1111;
            [alert show];
            [alert release];
            
        }
        [self showHUDErrorMessage:LocalizedString(@"RechargeViewController_HUDErrMsg4", @"获取汇率失败,请稍候再试")];
        lab_PayDetail.text = LocalizedString(@"RechargeViewController_HUDErrMsg4", @"获取汇率失败,请稍候再试");
    }
}

- (void)reloadMoney
{
         UserInfo *mUserInfo = [GlobalObj getUserInfo];
         float litterMoney = shouldPayMoney - mUserInfo.balance;
        //计算人民币兑换美金
        float USAMoney = (litterMoney / dollarRate + baseFee)/(1-lossRate);
        //保留小数四舍五入
        float newMoney = (USAMoney*100+0.5)/100.0;
    //LocalizedString(@"RechargeViewController_strMoney",
        NSString *str_money = [NSString stringWithFormat:LocalizedString(@"RechargeViewController_strMoney", @"实际支付 : $%.2f"),newMoney];
    
        currentUSAMoney = newMoney;
    
        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0"))
        {
            //判断富文本颜色
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:str_money];
            [str addAttribute:NSForegroundColorAttributeName value:[PanliHelper colorWithHexString:@"#7f7f7f"] range:NSMakeRange(0,6)];
            [str addAttribute:NSForegroundColorAttributeName value:[PanliHelper colorWithHexString:@"#fc0200"] range:NSMakeRange(6,str_money.length - 6)];
            lab_DealMoney.attributedText = str;
            [str release];
        }
        else
        {
            lab_DealMoney.text = str_money;
        }
}

#pragma mark - 创建订单
-(void)createRechargeOrderRequest
{
    [self showHUDIndicatorMessage:LocalizedString(@"RechargeViewController_HUDIndMsg3", @"正在加载...")];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[NSString stringWithFormat:@"%.2f",currentUSAMoney] forKey:RQ_RECHARGEORDERCREATE_PARAM_AMOUNT];
    [params setValue:[NSString stringWithFormat:@"%d",rechargeType] forKey:RQ_RECHARGEORDERCREATE_PARAM_RECHARGETYPE];

    req_RegeCreate = req_RegeCreate ? req_RegeCreate : [[RechargeOrCreateRequest alloc] init];
    rpt_RegeCreate = rpt_RegeCreate ? rpt_RegeCreate : [[DataRepeater alloc]initWithName:RQNAME_RECHARGEORDERCREATE];
    rpt_RegeCreate.requestParameters = params;
    rpt_RegeCreate.notificationName = RQNAME_RECHARGEORDERCREATE;
    rpt_RegeCreate.requestModal = PushData;
    rpt_RegeCreate.networkRequest = req_RegeCreate;
    [params release];
    rpt_RegeCreate.isAuth = YES;
    __unsafe_unretained __typeof(self) weakSelf = self;
    rpt_RegeCreate.compleBlock = ^(id repeater){
        [weakSelf rechargeCreateResponse:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:rpt_RegeCreate];
}

-(void)rechargeCreateResponse:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        [self hideHUD];

        //服务器订单号
        NSString *orderNum = repeater.responseValue;
        
        PayPalItem *item = [PayPalItem itemWithName:LocalizedString(@"RechargeViewController_PayPalItem_Name", @"Panli充值")
                                        withQuantity:1
                                           withPrice:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.2f",currentUSAMoney]]
                                        withCurrency:@"USD"
                                             withSku:orderNum];

        NSArray *items = @[item];
        NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
        
        PayPalPayment *payment = [[[PayPalPayment alloc] init] autorelease];
        payment.amount = subtotal;
        payment.currencyCode = @"USD";
        UserInfo * userInfo = [GlobalObj getUserInfo];
        //LocalizedString(@"RechargeViewController_shortDescription",
        payment.shortDescription = [NSString stringWithFormat:LocalizedString(@"RechargeViewController_shortDescription", @"用户:%@,充值金额:$%.2f,充值流水号:%@"),userInfo.nickName,currentUSAMoney,orderNum];;
        payment.items = items;  // if not including multiple items, then leave payment.items as nil
        payment.paymentDetails = nil; // if not including payment details, then leave payment.paymentDetails as nil
        
        payment.bnCode = orderNum;
        if (!payment.processable) {
            // This particular payment will always be processable. If, for
            // example, the amount was negative or the shortDescription was
            // empty, this payment wouldn't be processable, and you'd want
            // to handle that here.
            //LocalizedString(@"RechargeViewController_HUDErrMsg5",
            [self showHUDErrorMessage:LocalizedString(@"RechargeViewController_HUDErrMsg5", @"Paypal充值组件加载失败,请重试...")];
            return;
        }
        
        PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                    configuration:self.payPalConfig
                                                                                                         delegate:self];
        [self presentViewController:paymentViewController animated:YES completion:nil];
        [paymentViewController release];
    }
    else
    {
        [self showHUDErrorMessage:repeater.errorInfo.message];

    }
}

#pragma mark - 与服务器对账
-(void)rechargeNotifyRequestWithPayKey:(NSString *)paykey
{
    //LocalizedString(@"RechargeViewController_HUDIndMsg4",
    [self showHUDIndicatorMessage:LocalizedString(@"RechargeViewController_HUDIndMsg4", @"正在与服务器对账...")];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:paykey forKey:RQ_PAYPALRECHARGENOTIFY_PARAM_PAYKEY];
    req_RegeNotify = req_RegeNotify ? req_RegeNotify : [[PaypalNotifyRequest alloc] init];
    rpt_RegeNotify = rpt_RegeNotify ? rpt_RegeNotify : [[DataRepeater alloc]initWithName:RQNAME_PAYPALRECHARGENOTIFY];
    rpt_RegeNotify.requestParameters = params;
    rpt_RegeNotify.notificationName = RQNAME_PAYPALRECHARGENOTIFY;
    rpt_RegeNotify.requestModal = PullData;
    rpt_RegeNotify.networkRequest = req_RegeNotify;
    [params release];
    rpt_RegeNotify.isAuth = YES;
    __unsafe_unretained __typeof(self) weakSelf = self;
    rpt_RegeNotify.compleBlock = ^(id repeater){
        [weakSelf rechargeNotifyResponse:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:rpt_RegeNotify];
}

-(void)rechargeNotifyResponse:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        if(self.payTypeFlag == Recharge)
        {
            RechargeSuccessViewController *rSuccess = [[[RechargeSuccessViewController alloc]init]autorelease];
            rSuccess.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:rSuccess animated:YES];
        }
        else
        {
            //LocalizedString(@"RechargeViewController_HUDIndMsg5",
            [self showHUDIndicatorMessage:LocalizedString(@"RechargeViewController_HUDIndMsg5", @"正在发送支付请求...")];
            //更新账户余额
            //LocalizedString(@"RechargeViewController_strMoneyTemp",
            NSString *str_MoneyTemp = [lab_DealMoney.text stringByReplacingOccurrencesOfString:LocalizedString(@"RechargeViewController_strMoneyTemp", @"实际支付 : $") withString:@""];
            UserInfo *mUserInfo = [GlobalObj getUserInfo];
            float UsaMoney = [str_MoneyTemp floatValue];
            float rmbMoney = UsaMoney * dollarRate - (UsaMoney * dollarRate * lossRate) - baseFee * dollarRate;
            mUserInfo.balance  += rmbMoney;
            [PanliHelper updataUserBalance:mUserInfo.balance];
            
            //刷新UI
            //LocalizedString(@"RechargeViewController_labBalance",
            lab_Balance.text = [NSString stringWithFormat:LocalizedString(@"RechargeViewController_labBalance", @"账户余额 : ￥%.2f"),mUserInfo.balance];
            lab_LittleMoney.text = [NSString stringWithFormat:@""];
            lab_DealMoney.text = @"";
            currentUSAMoney = 0;
            //支付请求
            
            self.rpt_DataRepeater.isAuth = YES;
            __unsafe_unretained __typeof(self) weakSelf = self;
            self.rpt_DataRepeater.compleBlock = ^(id repeater){
                [weakSelf PayResponse:repeater];
            };
            [[DataRequestManager sharedInstance] sendRequest:self.rpt_DataRepeater];
        }
        
    }
    else
    {
        RechargeFaildViewController *faildVC = [[[RechargeFaildViewController alloc]init]autorelease];
        faildVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:faildVC animated:YES];
    }
}

#pragma mark - UitextFieldDegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [txt_InputMoney resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if(textField == txt_InputMoney)
    {
        NSCharacterSet * cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString : @""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest)
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle :LocalizedString(@"RechargeViewController_AlertView_Title2", @"提示")
                                                            message :LocalizedString(@"RechargeViewController_AlertView_Msg", @"请输入数字!")
                                                            delegate:nil
                                                   cancelButtonTitle:LocalizedString(@"Common_Btn_Sure", @"确定")
                                                   otherButtonTitles:nil];
            [alert show];
            [alert release];
            return NO;
        }
    }
    //其他的类型不需要检测，直接写入
    return YES;
}

#pragma mark - 动态实际金额
-(void)UpdateRegeRest:(id)sender
{
    float checkvalue = [[txt_InputMoney text]floatValue];
    if(checkvalue == 0)
    {
        lab_DealMoney.text = @"";
        currentUSAMoney = 0;
        return;
    }
    if(![NSString isEmpty:txt_InputMoney.text])
    {
        float USAMoney = (checkvalue / dollarRate + baseFee)/(1-lossRate);
        //保留小数四舍五入
        float newMoney = (USAMoney*100+0.5)/100.0;
        //LocalizedString(@"RechargeViewController_strMoney",
        NSString *str_money = [NSString stringWithFormat:LocalizedString(@"RechargeViewController_strMoney", @"实际支付 : $%.2f"),newMoney];
        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0"))
        {
            //判断富文本颜色
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:str_money];
            [str addAttribute:NSForegroundColorAttributeName value:[PanliHelper colorWithHexString:@"#7f7f7f"] range:NSMakeRange(0,6)];
            [str addAttribute:NSForegroundColorAttributeName value:[PanliHelper colorWithHexString:@"#fc0200"] range:NSMakeRange(6,str_money.length - 6)];
            lab_DealMoney.attributedText = str;
            [str release];
        }
        else
        {
            lab_DealMoney.text = str_money;
        }
        currentUSAMoney = newMoney;
    }
    else
    {
        lab_DealMoney.text = @"";
        currentUSAMoney = 0;
    }
    
}

#pragma mark - Uialertview
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(alertView.tag==11)
    {
        if(buttonIndex==0)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark - hide
-(void)hideKeyboardToolbar:(UITapGestureRecognizer*)sender
{
    [txt_InputMoney resignFirstResponder];
}
-(void)handleBackgroundTap:(UITapGestureRecognizer*)send
{
    [txt_InputMoney resignFirstResponder];
}

@end
