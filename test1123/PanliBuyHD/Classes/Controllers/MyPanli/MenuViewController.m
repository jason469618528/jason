//
//  MainViewController.m
//  PanliBuyHD
//
//  Created by ZhaoFucheng on 14-10-17.
//  Copyright (c) 2014年 Panli. All rights reserved.
//
#define TAG_TOOL  1000
#define TAG_USER_HEAD 1001
#define TAG_MESSAGE 1002
#define TAG_REGISTER 1003
#define TAG_LOGININ  1004

#define TAG_ORDERS 1005
#define TAG_SHIPS  1006
#define TAG_RMB    1007
#define TAG_COUPON 1008
#define TAG_INTEGRAL 1009
#define TAG_SYS_MESSAGE 1010
#define TAG_MYGROUP 1011
#define TAG_USERSHARE 1012

#define MYPANLI_MESSAGE @"MyPanliMessage"
#define MYPANLI_ORDER @"MyPanliOrder"
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

#define TOP_BG_HIDE 60.0f

#import "MenuViewController.h"
#import "MyPanliHomeViewController.h"
#import "OrderHomeViewController.h"
#import "ShipListViewController.h"
#import "CustomerNavagationBarController.h"
#import "MenuTableViewCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "UserInfo.h"
#import "MyPanliRMBViewController.h"
#import "MyIntegralHomeViewController.h"
#import "MyCouponViewController.h"
#import "SysMessageUserNoteViewController.h"
#import "UserShareHomeViewController.h"
#import "UserToolHomeViewController.h"
#import "RegistViewController.h"
#import "MyGroupBuyViewController.h"
@interface MenuViewController ()

@end

@implementation MenuViewController
@synthesize btn_User_Head = _btn_User_Head;

- (id)init
{
    self = [super init];
    if (self)
    {
        //注册 推送 获得未读短消息的通知，在 appDelegate RemoteNotification中Post
        /* 
         [[NSNotificationCenter defaultCenter] addObserver:self
         selector:@selector(getUserUnreadMessageResponse:)
         name:RQNAME_GETUSERUNREADMESSAGES
         object:nil];
         
         [[NSNotificationCenter defaultCenter] addObserver:self
         selector:@selector(refreshUnreadMessage)
         name:@"REFRESHUNREADMESSAGE"
         object:nil];
         */
        
        [self refreshUnreadMessage];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //cell数据源
    NSArray *arr_Order = @[LocalizedString(@"MenuViewController_arrOrder_item1", @"运单")];
    NSArray *arr_Rmb = @[LocalizedString(@"MenuViewController_arrRmb_item1", @"Panli RMB账户"),
                         LocalizedString(@"MenuViewController_arrRmb_item2", @"优惠券"),
                         LocalizedString(@"MenuViewController_arrRmb_item3", @"积分")];
    NSArray *arr_Message = @[LocalizedString(@"MenuViewController_arrMessage_item1", @"通知"),
                             LocalizedString(@"MenuViewController_arrMessage_item2", @"我抱的团"),
                             LocalizedString(@"MenuViewController_arrMessage_item3", @"宝贝分享")];
    NSArray *arr_Debug = @[LocalizedString(@"MenuViewController_arrDebug_item1", @"环境配置")];
    arr_CellTitle = [[NSArray alloc]initWithObjects:arr_Order,arr_Rmb,arr_Message,arr_Debug, nil];
    
    //图片数据源
    NSArray *arr_imageOrder = @[@"icon_mypanli_Ship"];
    NSArray *arr_imageRmb = @[@"icon_mypanli_MyRMB",@"icon_mypanli_Coupon",@"icon_mypanli_Integral"];
    NSArray *arr_imageMessage = @[@"icon_mypanli_SysMsg",@"icon_myPanli_GroupBuy",@"icon_mypanli_Share"];
    NSArray *arr_imageDebug = @[@"icon_mypanli_SysMsg"];
    arr_Image = [[NSArray alloc]initWithObjects:arr_imageOrder,arr_imageRmb,arr_imageMessage,arr_imageDebug, nil];
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.view.backgroundColor = [PanliHelper colorWithHexString:@"#f7f7f7"];
    
    //默认 自动调到第一行
    
    [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    UserInfo *userInfo = [GlobalObj getUserInfo];
    if (userInfo != nil)
    {
        [self hideHeadLoadingView:NO];
        //登录状态
        [self showHaveLoginedState:userInfo];
        
        [self shipOrderRequest];
        [self refreshRequest:NO];
        [self getUserUnreadMessageRequest];
    }
    else
    {
        [self hideHeadLoadingView:YES];
        //未登录状态
        [self showHaveOffLineView];
        
    }
}
//登录状态的视图
- (void)showHaveLoginedState:(UserInfo *)info
{
    btn_Register.hidden = YES;
    btn_login.hidden = YES;
    btn_UpdataAvatar.hidden = NO;
    _btn_User_Head.hidden = NO;
    img_TopBg.image = [PanliHelper getImageFileByName:@"bg_myPanli_main@2x.png"];
    lab_UserName.frame = CGRectMake(130.0f, 79.0f, self.tableView.frame.size.width - 130.0f, 25.0f);
    [_btn_User_Head setBackgroundImageWithURL:[NSURL URLWithString:info.avatarUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_myPanli_avatar_default"]];
    lab_UserName.text = info.nickName;
}
//未登陆状态的视图
- (void)showHaveOffLineView
{
    btn_Register.hidden = NO;
    btn_login.hidden = NO;
    btn_UpdataAvatar.hidden = YES;
    _btn_User_Head.hidden = YES;
    lab_UserName.frame = CGRectMake(106.0f, 60.0f, self.tableView.frame.size.width - 130.0f, 25.0f);
    lab_UserName.text = LocalizedString(@"MenuViewController_labUserName", @"欢迎来到Panli");
    img_TopBg.image = [PanliHelper getImageFileByName:@"bg_myPanli_main_none@2x.png"];
    //隐藏数字
    UIImageView* icon_num  = (UIImageView *)[self.view viewWithTag:3001];
    if (icon_num)
    {
        icon_num.hidden = YES;
    }
    //刷新tableview
    if(self.tableView)
    {
        [self.tableView reloadData];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
//    NSLog(@"self.tabel.frame.size.with ===== %f",self.tableView.frame.size.width);
//    NSLog(@"self.view.frame.size.with ===== %f",self.view.frame.size.width);

    //tableview footerView
    UIView *view_Footer = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 20.0f)];
    view_Footer.backgroundColor = PL_COLOR_CLEAR;
    UIView *view_TopLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 0.5)];
    view_TopLine.backgroundColor = [PanliHelper colorWithHexString:@"#c8c8c8"];
    [view_Footer addSubview:view_TopLine];
    self.tableView.tableFooterView = view_Footer;
    
    self.navigationItem.title = @"MyPanli";

    //tableview headView
    UIView *view_Head = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 146.0f)];
    view_Head.backgroundColor = PL_COLOR_CLEAR;
    self.tableView.tableHeaderView = view_Head;

    //用户头像
    _btn_User_Head = [[UIButton alloc] initWithFrame:CGRectMake(37.5f, 49.0f, 75.0f, 75.0f)];
    _btn_User_Head.tag = TAG_USER_HEAD;
    [_btn_User_Head addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [btn_User_Head setImageWithURL:[NSURL URLWithString:@"http://pic.baike.soso.com/p/20101218/bki-20101218151416-1212512781.jpg"] placeholderImage:nil];
    [view_Head addSubview:_btn_User_Head];
    
    //用户背景
    img_TopBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_myPanli_main"]];
    img_TopBg.frame = CGRectMake(0.0f, -TOP_BG_HIDE, self.tableView.frame.size.width, 206.0f);
    [view_Head addSubview:img_TopBg];
    
    //下拉刷新View
    _headView = [[CustomLoadingView alloc] initWithFrame:CGRectMake(0, -55, self.tableView.frame.size.width, 80) andType:head_none andKey:nil imageDown:[UIImage imageNamed:@"icon_myPanli_RefreshDown"] imageUp:[UIImage imageNamed:@"icon_myPanli_RefreshUP"]];
    [self.tableView addSubview:_headView];
    
    //上传照片
    btn_UpdataAvatar = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_UpdataAvatar.tag = TAG_USER_HEAD;
    [btn_UpdataAvatar setImage:[UIImage imageNamed:@"btn_mypanli_UpAvatar"]forState:UIControlStateNormal];
    [btn_UpdataAvatar addTarget:self action:@selector(btnClick:)forControlEvents:UIControlEventTouchUpInside];
    [btn_UpdataAvatar setFrame:CGRectMake(96.0f, 109.5f, 17.0f, 18.5f)];
    [view_Head addSubview:btn_UpdataAvatar];
    
    //用户名
    lab_UserName = [[UILabel alloc]initWithFrame:CGRectMake(130.0f, 79.0f, self.tableView.frame.size.width - 130.0f, 20.0f)];
    lab_UserName.backgroundColor = PL_COLOR_CLEAR;
    lab_UserName.textColor = PL_COLOR_WHITE;
    lab_UserName.font = DEFAULT_FONT(20);
    lab_UserName.textAlignment = UITextAlignmentLeft;
    [view_Head addSubview:lab_UserName];
    
    //短信按钮
    UIButton * btn_Message = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Message.tag = TAG_MESSAGE;
    [btn_Message setImage:[UIImage imageNamed:@"btn_mypanli_Message"]forState:UIControlStateNormal];
    [btn_Message setImage:[UIImage imageNamed:@"btn_mypanli_Message_on"]forState:UIControlStateHighlighted];
    [btn_Message addTarget:self action:@selector(btnClick:)forControlEvents:UIControlEventTouchUpInside];
    [btn_Message setFrame:CGRectMake(0.0f, 0.0f, 58.5f, 57.5f)];
    [self.tableView addSubview:btn_Message];
    
    //工具按钮
    UIButton * btn_Tool = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Tool.tag = TAG_TOOL;
    [btn_Tool setImage:[UIImage imageNamed:@"btn_myPanli_SetTool"]forState:UIControlStateNormal];
    [btn_Tool setImage:[UIImage imageNamed:@"btn_myPanli_SetTool_on"]forState:UIControlStateHighlighted];
    [btn_Tool addTarget:self action:@selector(btnClick:)forControlEvents:UIControlEventTouchUpInside];
    [btn_Tool setFrame:CGRectMake(self.tableView.frame.size.width - 69.5f, 0.0f, 69.5f, 65.0f)];
    [self.tableView addSubview:btn_Tool];
    
    //短信显示数字
    UIImageView* icon_Test  = [[UIImageView alloc]initWithFrame:CGRectMake(30.0f, 10.0f, 12.0f, 12.0f)];
    icon_Test.image = [UIImage imageNamed:@"bg_myPanli_smallBadge"];
    icon_Test.tag = 3001;
    [self.tableView addSubview:icon_Test];
    
    UILabel* lab_Test = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 20.0f, 11.0f)];
    lab_Test.tag = 2001;
    lab_Test.font = DEFAULT_FONT(11.0f);
    lab_Test.backgroundColor = PL_COLOR_CLEAR;
    lab_Test.textColor = [PanliHelper colorWithHexString:@"#eeeeef"];
    [icon_Test addSubview:lab_Test];
    
//    if(IS_IOS7)
//    {
//        UIView *navBackgroundImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 20)];
//        navBackgroundImageView.backgroundColor = [PanliHelper colorWithHexString:@"#f7f7f7"];
//        [self.view addSubview:navBackgroundImageView];
//    }
    
    //注册按钮
    btn_Register = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Register.tag = TAG_REGISTER;
    [btn_Register setFrame:CGRectMake(0.0f, 106.5f, 160.5f, 42.0f)];
    [btn_Register setImage:[UIImage imageNamed:@"btn_myPanli_Register"]forState:UIControlStateNormal];
    [btn_Register setImage:[UIImage imageNamed:@"btn_myPanli_Register_on"]forState:UIControlStateHighlighted];
    [btn_Register addTarget:self action:@selector(btnClick:)forControlEvents:UIControlEventTouchUpInside];
    [view_Head addSubview:btn_Register];
    
    //登录按钮
    btn_login = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_login.tag = TAG_LOGININ;
    [btn_login setFrame:CGRectMake(160.5f, 106.5f, 159.5f, 42.0f)];
    [btn_login setImage:[UIImage imageNamed:@"btn_myPanli_Login"]forState:UIControlStateNormal];
    [btn_login setImage:[UIImage imageNamed:@"btn_myPanli_Login_on"]forState:UIControlStateHighlighted];
    [btn_login addTarget:self action:@selector(btnClick:)forControlEvents:UIControlEventTouchUpInside];
    [view_Head addSubview:btn_login];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(getShipOrderDataResponse:)
//                                                 name:@"shipOrder"
//                                               object:nil];
    
}

- (void)btnClick:(UIButton *)sender
{
    switch (sender.tag)
    {
        //上传用户头像
        case TAG_USER_HEAD:
        {
            UIActionSheet *chooseUserHeadImage = [[UIActionSheet alloc] initWithTitle:LocalizedString(@"MenuViewController_ActionSheet_Title", @"选择头像来源")
                                                                             delegate:self
                                                                    cancelButtonTitle:LocalizedString(@"Common_Btn_Cancel", @"取消")
                                                               destructiveButtonTitle:LocalizedString(@"MenuViewController_ActionSheet_OthBtn1",@"从相册中选取美照")
                                                                    otherButtonTitles:LocalizedString(@"MenuViewController_ActionSheet_OthBtn2",@"立即拍摄美照"), nil];
            chooseUserHeadImage.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
            [chooseUserHeadImage showInView:self.view];
            break;
        }
        //工具(设置)
        case TAG_TOOL:
        {
            UserToolHomeViewController *userTool = [[UserToolHomeViewController alloc] init];
            [self.navigationController pushViewController:userTool animated:YES];
            break;
        }
        //短信息
        case TAG_MESSAGE:
        {
            UserInfo *userInfo = [GlobalObj getUserInfo];
            if (userInfo == nil)
            {
                //清空用户信息
                [GlobalObj setUserInfo:nil];
                LoginViewController *login = [[LoginViewController alloc] init];
                self.popOver = [[UIPopoverController alloc] initWithContentViewController:login];
                login.popOverController = self.popOver;
                self.popOver.popoverContentSize = CGSizeMake(450.0f, 541.0f);
                [self.popOver presentPopoverFromRect:CGRectMake(284.5f, 90.0f, 450.0f, 541.0f) inView:self.view permittedArrowDirections:0 animated:YES];
            }
            else if (userInfo != nil && userInfo.isApproved)
            {
                ActiveViewController *activeViewController = [[ActiveViewController alloc] init];
                [self.navigationController presentModalViewController:activeViewController animated:NO];
            }
            else
            {
                MessageUserNoteViewController *messageList = [[MessageUserNoteViewController alloc] init];
                [self.navigationController pushViewController:messageList animated:YES];
            }
            
            break;
        }
        //注册
        case TAG_REGISTER:
        {
            RegistViewController *registViewController = [[RegistViewController alloc] init];
            [self.navigationController pushViewController:registViewController animated:YES];
            break;
        }
        //登陆
        case TAG_LOGININ:
        {
            LoginViewController *login = [[LoginViewController alloc] init];
            self.popOver = [[UIPopoverController alloc] initWithContentViewController:login];
            login.popOverController = self.popOver;
            self.popOver.popoverContentSize = CGSizeMake(450.0f, 541.0f);
            [self.popOver presentPopoverFromRect:CGRectMake(284.5f, 120.0f, 450.0f, 541.0f) inView:self.view permittedArrowDirections:0 animated:YES];
            break;
        }
            
        default:
            break;
    }
    
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        //从相册中选取没照
        case 0:
        {
            if ([self isPhotoLibraryAvailable])
            {
//                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//                imagePicker.delegate = self;
//                [self presentViewController:imagePicker animated:YES completion:^{
//                    NSLog(@"图片选取");
//                }];
            }
            break;
        }
        //立即拍摄没照
        case 1:
        {
            if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos])
            {
                UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                controller.sourceType = UIImagePickerControllerSourceTypeCamera;
                if ([self isFrontCameraAvailable])
                {
                    controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
                }
                controller.delegate = self;
                [self presentViewController:controller animated:YES completion:^{
                    NSLog(@"前置摄像头");
                }];
            }
            break;
        }
            
        default:
            break;
    }
}

- (void)refreshUnreadMessage
{
    if ([GlobalObj getUserInfo] != nil)
    {
        [self getUserUnreadMessageRequest];
    }
}

#pragma mark - Ship_Request_Data && Response_Notification
//请求运单
- (void)shipOrderRequest
{
    req_AllShip = req_AllShip ? req_AllShip : [[ShipOrdersRequest alloc]init];
    rpt_AllShip = rpt_AllShip ? rpt_AllShip : [[DataRepeater alloc] initWithName:RQNAME_USERSHIPORDERSALLSHIP];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@"1" forKey:RQ_SHIPORDERS_PARAM_INDEX];
    [params setValue:@"20" forKey:RQ_SHIPORDERS_PARAM_COUNT];
    rpt_AllShip.requestParameters = params;
    rpt_AllShip.notificationName = @"shipOrder";
    rpt_AllShip.requestModal = PullData;
    rpt_AllShip.networkRequest = req_AllShip;
    
    rpt_AllShip.isAuth = YES;
    __weak  __typeof(self) weakSelf = self;
    rpt_AllShip.compleBlock = ^(id repeater){
        [weakSelf getShipOrderDataResponse:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:rpt_AllShip];
    
}

- (void)getShipOrderDataResponse:(DataRepeater *)repeater
{
    if(repeater.isResponseSuccess)
    {
        NSMutableArray *shipList = repeater.responseValue;
        NSMutableArray *lastShipList = [GlobalObj getLastShipList];
        for(ShipOrder *item in shipList)
        {
            for (ShipOrder *ship in lastShipList)
            {
                //相同运单且状态未改变
                if ([item.orderId isEqualToString:ship.orderId] && item.status == ship.status)
                {
                    item.haveRead = ship.haveRead;
                }
                //相同运单且状态改变
                if ([item.orderId isEqualToString:ship.orderId] && item.status != ship.status)
                {
                    item.haveRead = NO;
                }
            }
        }
        [GlobalObj setLastShipList:shipList];
        [self.tableView reloadData];
    }
}
#pragma mark - Refresh_Request_UserInfo && Get_Data_Response
-(void)refreshRequest:(BOOL)isShow
{
    UserInfo *info = [GlobalObj getUserInfo];
    if (info != nil)
    {
        if(isShow)
        {
            [self showLoadingView];
        }
        //谈化数字
        
        int icon_tag = 3001;
        UIImageView* icon_Test  = (UIImageView *)[self.view viewWithTag:icon_tag];
        icon_Test.alpha = 0.0;
        
        req_UserInfo = req_UserInfo ? req_UserInfo : [[GetUserInfoRequest alloc]init];
        rpt_UserInfo = rpt_UserInfo ? rpt_UserInfo : [[DataRepeater alloc]initWithName:RQNAME_USERINFOS];
        
        NSMutableDictionary *mDic_Params = [[NSMutableDictionary alloc] init];
        [mDic_Params setValue:@"true" forKey:RQ_USERINFOS_PARAM_USERINFO];
        [mDic_Params setValue:@"true" forKey:RQ_USERINFOS_PARAM_MESSAGENO];
        [mDic_Params setValue:@"true" forKey:RQ_USERINFOS_PARAM_SYSMESSNO];
        [mDic_Params setValue:@"true" forKey:RQ_USERINFOS_PARAM_ORDERNO];
        [mDic_Params setValue:@"true" forKey:RQ_USERINFOS_PARAM_SHIPNO];
        
        rpt_UserInfo.notificationName = RQNAME_USERINFOS;
        __weak MenuViewController *menuViewController = self;
        req_UserInfo.getUserInfoData = ^(id repeater)
        {
            [menuViewController getUserInfoData:repeater];
        };
        rpt_UserInfo.requestModal = PullData;
        rpt_UserInfo.networkRequest = req_UserInfo;
        rpt_UserInfo.requestParameters = mDic_Params;
        
        rpt_UserInfo.isAuth = YES;
        [[DataRequestManager sharedInstance] sendRequest:rpt_UserInfo];
        
        [self performSelector:@selector(hideLoadingView) withObject:self afterDelay:1.0];
    }
    else
    {
        [self showHaveOffLineView];
        LoginViewController *login = [[LoginViewController alloc] init];
        self.popOver = [[UIPopoverController alloc] initWithContentViewController:login];
        login.popOverController = self.popOver;
        self.popOver.popoverContentSize = CGSizeMake(450.0f, 541.0f);
        [self.popOver presentPopoverFromRect:CGRectMake(284.5f, 120.0f, 450.0f, 541.0f) inView:self.view permittedArrowDirections:0 animated:YES];
    }
    
}

- (void)getUserInfoData:(DataRepeater *)repeater
{
    if (req_UserInfo != nil)
    {
        if (repeater.isResponseSuccess)
        {
            //最新用户信息
            UserInfo *newUserInfo = (UserInfo *)repeater.responseValue;
            if (![NSString isEmpty:newUserInfo.avatarUrl])
            {
                [self.btn_User_Head setBackgroundImageWithURL:[NSURL URLWithString:newUserInfo.avatarUrl] forState:UIControlStateNormal];
            }
            else
            {
                [self.btn_User_Head setBackgroundImageWithURL:nil forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_myPanli_avatar_default"]];
            }
            [self.tableView reloadData];
        }
        else
        {
            [self showHUDErrorMessage:LocalizedString(@"MenuViewController_HUDErrMsg", @"刷新用户信息失败")];
        }
        [self hideLoadingView];
    }
    
}

#pragma mark - Get_User_Unread_Messages_Request && Response
- (void)getUserUnreadMessageRequest
{
    req_UnreadMessage = req_UnreadMessage ? req_UnreadMessage : [[GetUserUnReadMessages alloc] init];
    rpt_UnreadMessage = rpt_UnreadMessage ? rpt_UnreadMessage : [[DataRepeater alloc] initWithName:RQNAME_GETUSERUNREADMESSAGES];
    
    rpt_UnreadMessage.notificationName = RQNAME_GETUSERUNREADMESSAGES;
    __weak MenuViewController *menuVC = self;
    rpt_UnreadMessage.compleBlock = ^(id repeater)
    {
        [menuVC getUserUnreadMessageResponse:repeater];
    };
    rpt_UnreadMessage.requestModal = PullData;
    rpt_UnreadMessage.networkRequest = req_UnreadMessage;
    [[DataRequestManager sharedInstance] sendRequest:rpt_UnreadMessage];
}
- (void)getUserUnreadMessageResponse:(DataRepeater *)repeater
{
    if(repeater.isResponseSuccess)
    {
        self.mUserUnReadMessages = repeater.responseValue;
        //mypanli小红点
        if (self.mUserUnReadMessages.customerMsgCount > 0)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:TABBAR_NEW_NOTIFICATION object:[NSNumber numberWithInt:4]];
        }
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:TABBAR_NONE_NOTIFICATION object:[NSNumber numberWithInt:4]];
        }
        
        //重新计算短信数字和背景
        UILabel *lab_num = (UILabel *)[self.view viewWithTag:2001];
        UIImageView* icon_num  = (UIImageView *)[self.view viewWithTag:3001];
        
        int numberValue = [[NSString stringWithFormat:@"%d",self.mUserUnReadMessages.customerMsgCount] intValue];
        
        //淡出动画
        [UIView beginAnimations:@"HideArrow" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDuration:1];
        icon_num.alpha = 1;
        [UIView commitAnimations];
        
        if(numberValue >= 1 && numberValue < 10)
        {
            icon_num.hidden = NO;
            UIImage *img = [UIImage imageNamed:@"bg_myPanli_smallBadge"];
            icon_num.image = img;
            lab_num.frame = CGRectMake(2.8f, 1.2f, 20.0f, 11.0f);
            lab_num.text = [NSString stringWithFormat:@"%d",numberValue];
            icon_num.frame = CGRectMake(icon_num.frame.origin.x, icon_num.frame.origin.y, 12.0f, 12.0f);
        }
        else if(numberValue >= 10 && numberValue < 100)
        {
            icon_num.hidden = NO;
            UIImage *img = [UIImage imageNamed:@"bg_myPanli_middleBadge"];
            icon_num.image = img;
            lab_num.frame = CGRectMake(1.5f, 0.5f, 20.0f, 11.0f);
            lab_num.text = [NSString stringWithFormat:@"%d",numberValue];
            icon_num.frame = CGRectMake(icon_num.frame.origin.x, icon_num.frame.origin.y, 16.0f, 12.0f);
        }
        else if(numberValue >= 100)
        {
            icon_num.hidden = NO;
            UIImage *img = [UIImage imageNamed:@"bg_myPanli_bigBadge"];
            icon_num.image = img;
            lab_num.text = @"99+";
            lab_num.frame = CGRectMake(3.5f, 0.5f, 30.0f, 11.0f);
            icon_num.frame = CGRectMake(icon_num.frame.origin.x, icon_num.frame.origin.y, 24.0f, 12.0f);
        }
        else
        {
            icon_num.hidden = YES;
        }
        [self.tableView reloadData];
    }
}
#pragma mark - uploadAvatar request && response
- (void)uploadAvatarRequest:(NSString*)filePath
{
//    req_UpAvatar = req_UpAvatar ? req_UpAvatar : [[UploadAvatarRequest alloc]init];
//    rpt_UpAvatar = rpt_UpAvatar ? rpt_UpAvatar : [[DataRepeater alloc]initWithName:RQNAME_USER_UPLOADAVATAR];
//    
//    NSMutableDictionary *mDic_Params = [[NSMutableDictionary alloc] init];
//    [mDic_Params setValue:filePath forKey:RQ_USER_UPLOADAVATAR_PARM_PICFILE];
//    
//    rpt_UpAvatar.compleBlock = ^(id repeater){
//        [self uploadAvatarResponse:repeater];
//    };
//    rpt_UpAvatar.isAuth = YES;
//    rpt_UpAvatar.requestModal = PushData;
//    rpt_UpAvatar.networkRequest = req_UpAvatar;
//    rpt_UpAvatar.requestParameters = mDic_Params;
//    [mDic_Params release];
//    [[DataRequestManager sharedInstance] sendRequest:rpt_UpAvatar];
}

- (void)uploadAvatarResponse:(DataRepeater*)repeater
{
//    if(repeater.isResponseSuccess)
//    {
//        [self hideHUD];
//        //获取用户信息
//        UserInfo *user = [GlobalObj getUserInfo];
//        if (![NSString isEmpty:user.avatarUrl])
//        {
//            [btn_User_Head setCustomImageWithURL:[NSURL URLWithString:user.avatarUrl] forState:UIControlStateNormal];
//        }
//        else
//        {
//            [btn_User_Head setImage:[UIImage imageNamed:@"icon_myPanli_avatar_default"] forState:UIControlStateNormal];
//        }
//        [self refreshRequest:NO];
//    }
//    else
//    {
//        [self showHUDErrorMessage:LocalizedString(@"MyPanliViewController_HUDErrMsg2",@"上传头像失败,请重试")];
//    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 1;
            break;
        }
        case 1:
        {
            return 3;
            break;
        }
        case 2:
        {
            return 3;
            break;
        }
        case 3:
        {
            return 1;
            break;
        }
        default:
        {
            return 0;
            break;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuTableView";
    
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"MenuTableViewCell" owner:nil options:nil];
        for (id obj in nibs)
        {
            if ([obj isKindOfClass:[MenuTableViewCell class]])
            {
                cell = (MenuTableViewCell *)obj;
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
            }
            break;
        }
    }
    cell.separatorInset = UIEdgeInsetsMake(0, 44, 0, 0);
    NSString *str_Title = [[arr_CellTitle objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSString *str_Image = [[arr_Image objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    //判断最后一个cell线条
    NSArray *arr = [arr_CellTitle objectAtIndex:indexPath.section];
    BOOL isShowLine = (indexPath.row != (arr.count - 1));
    
    [cell initWithData:str_Title imageString:str_Image iRow:indexPath tabBottomLine:isShowLine systemMessageCount:0];
    cell.backgroundColor = [PanliHelper colorWithHexString:@"#ffffff"];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#ifndef DEBUG_FLAG
    return 4;
#else
    return 3;
#endif
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPanliHomeViewController *homeViewController = (MyPanliHomeViewController *)self.parentViewController.parentViewController;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section)
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    //运单
                    CustomerNavagationBarController *nav_ShipList = [[CustomerNavagationBarController alloc] initWithRootViewController:[[ShipListViewController alloc] init]];
                    homeViewController.viewControllers = [NSArray arrayWithObjects:self.navigationController,nav_ShipList, nil];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 1:
        {
            switch (indexPath.row)
            {
                //Panli RMB账户
                case 0:
                {
                    CustomerNavagationBarController *nav_MyPanliRMB = [[CustomerNavagationBarController alloc] initWithRootViewController:[[MyPanliRMBViewController alloc] init]];
                    homeViewController.viewControllers = [NSArray arrayWithObjects:self.navigationController,nav_MyPanliRMB, nil];
                    break;
                }
                //优惠券
                case 1:
                {
                    CustomerNavagationBarController *nav_MyCoupon = [[CustomerNavagationBarController alloc] initWithRootViewController:[[MyCouponViewController alloc] init]];
                    homeViewController.viewControllers = [NSArray arrayWithObjects:self.navigationController,nav_MyCoupon, nil];
                    break;
                }
                //积分
                case 2:
                {
                    CustomerNavagationBarController *nav_MyIntegral = [[CustomerNavagationBarController alloc] initWithRootViewController:[[MyIntegralHomeViewController alloc] init]];
                    homeViewController.viewControllers = [NSArray arrayWithObjects:self.navigationController,nav_MyIntegral, nil];
                    break;
                }
                    
                default:
                    break;
            }
            break;
        }
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //通知
                    CustomerNavagationBarController *nav_SysMessage = [[CustomerNavagationBarController alloc] initWithRootViewController:[[SysMessageUserNoteViewController alloc] init]];
                    homeViewController.viewControllers = [NSArray arrayWithObjects:self.navigationController,nav_SysMessage, nil];
                    break;
                }
                case 1:
                {
                    //我抱的团
                    CustomerNavagationBarController *nav_MyGroupBuy = [[CustomerNavagationBarController alloc] initWithRootViewController:[[MyGroupBuyViewController alloc] init]];
                    homeViewController.viewControllers = [NSArray arrayWithObjects:self.navigationController,nav_MyGroupBuy, nil];
                    break;
                }
                case 2:
                {
                    //宝贝分享
                    CustomerNavagationBarController *nav_UserShare = [[CustomerNavagationBarController alloc] initWithRootViewController:[[UserShareHomeViewController alloc] init]];
                    homeViewController.viewControllers = [NSArray arrayWithObjects:self.navigationController,nav_UserShare, nil];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 3:
        {
            
            break;
        }
        default:
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view_Header = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 20.0f)];
    view_Header.backgroundColor = [PanliHelper colorWithHexString:@"#eeeeee"];
    
    UIView *view_TopLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 0.5)];
    view_TopLine.backgroundColor = [PanliHelper colorWithHexString:@"#c8c8c8"];
    [view_Header addSubview:view_TopLine];
    
    UIView *view_BomLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 19.5f, self.tableView.frame.size.width, 0.5)];
    view_BomLine.backgroundColor = [PanliHelper colorWithHexString:@"#c8c8c8"];
    [view_Header addSubview:view_BomLine];
    
    return view_Header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section)
    {
        return 20.0f;
    }
    return 0.0f;
}

#pragma mark - UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //100默认高
    if(!_refreshing)
    {
        if (scrollView.contentOffset.y > -20)
        {
            [_headView changeState:Normal];
            _requestType = no_Request;
        }
        else if (scrollView.contentOffset.y <= -20)
        {
            [_headView changeState:Pulling];
            _requestType = refresh_Request;
        }
        else if (scrollView.contentOffset.y > 0)
        {
            _requestType = no_Request;
        }
    }
    
    if (scrollView.contentOffset.y <= -TOP_BG_HIDE)
    {
        [self.tableView setContentOffset:CGPointMake(0, -TOP_BG_HIDE)];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerat
{
    UserInfo *info = [GlobalObj getUserInfo];
    if(!_refreshing)
    {
        if(_requestType == refresh_Request)
        {
            [self refreshRequest:YES];
            [self refreshUnreadMessage];
        }
    }
    else if(info != nil)
    {
        [self showHaveLoginedState:info];
    }
    else if(info == nil)
    {
        [self showHaveOffLineView];
    }
}
#pragma mark - 相册是否可用
- (BOOL)isPhotoLibraryAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"didFinishPickingMediaWithInfo:");
    UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self dismissModalViewControllerAnimated:YES];
    
    if (portraitImg != nil)
    {
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        VPImageCropperViewController *VPImageVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 115.0f, 320, self.view.frame.size.height) limitScaleRatio:3.0];
        VPImageVC.delegate = self;
        [self.navigationController pushViewController:VPImageVC animated:YES];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark Image_Scale_Utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < 320) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = 320;
        btWidth = sourceImage.size.width * (320 / sourceImage.size.height);
    } else {
        btWidth = 320;
        btHeight = sourceImage.size.height * (320 / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
        {
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
        }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark - VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage
{
    //压缩图片
    NSData *imageData = UIImageJPEGRepresentation(editedImage,1.5);
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    timeSp = [timeSp stringByAppendingString:@".jpeg"];
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:timeSp];
    [imageData writeToFile:filePath atomically:YES];
    [self uploadAvatarRequest:filePath];
    
    [cropperViewController.navigationController popViewControllerAnimated:YES];
}
- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController
{
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
    [cropperViewController.navigationController popViewControllerAnimated:YES];
}
/**
 * 相机是否可用
 */
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

/**
 * 后摄像头是否可用
 */
- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

/**
 * 前摄像头是否可用
 */
- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}
/**
 * 拍照功能是否可用
 */
- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}
/**
 * 是否可选择视频
 */
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

/**
 * 是否可选择照片
 */
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark - Loading_View
/**
 *隐藏headview
 */
- (void)hideHeadLoadingView:(BOOL)isRequest
{
    _refreshing = isRequest;
    _headView.hidden = isRequest;
}

/**
 *隐藏刷新view
 */
- (void)hideLoadingView
{
    _refreshing = NO;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    //    [mainTableView setContentOffset:CGPointMake(0, 0)];
    [UIView commitAnimations];
}

/**
 *显示正在加载
 */
- (void)showLoadingView
{
    _refreshing = YES;
    [_headView changeState:Loading];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [self.tableView setContentInset:UIEdgeInsetsMake(TOP_BG_HIDE, 0, 0, 0)];
    [self.tableView setContentOffset:CGPointMake(0, -TOP_BG_HIDE)];
    [UIView commitAnimations];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
