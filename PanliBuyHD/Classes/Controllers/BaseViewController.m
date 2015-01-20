//
//  BaseViewController.m
//  PanliBuyHD
//
//  Created by Liubin on 14-6-16.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //国际化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:CHANGE_LANGUAGE_NOTIFICATION object:nil];
}

- (void)changeLanguage
{
    if (SYSTEM_VERSION_GREATER_THAN(@"6.0"))
    {
        // 非正在使用的视图
        if (![self.view window])
        {
            // 使再次进入时能够重新加载调用loadView,viewDidLoad
            [self viewDidUnload];
            self.view = nil;
        }
    }
}

/**
 * 功能描述: 重写viewdidload
 * 输入参数: backButton 是否需要左边返回按钮
 * 返 回 值: N/A
 */
- (void)viewDidLoadWithBackButtom:(BOOL)backButton
{
    [super viewDidLoad];
    self.HUD.yOffset = -50;
    self.view.backgroundColor = [PanliHelper colorWithHexString:@"#ebebeb"];
    [self setBarButtonItem:backButton];
}
- (void)setBarButtonItem:(BOOL)isBack
{
    //是否显示返回按钮
    if (isBack)
    {
        UIButton *btn_nav_back = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_nav_back.frame = CGRectMake(0.0f, 0.0f, 27.0f, 27.0f);
        btn_nav_back.tag = 999;
        [btn_nav_back setImage:[UIImage imageNamed:@"btn_navbar_back"]forState:UIControlStateNormal];
        [btn_nav_back setImage:[UIImage imageNamed:@"btn_navbar_back_on"] forState:UIControlStateHighlighted];
        btn_nav_back.imageEdgeInsets = IS_IOS7 ? UIEdgeInsetsMake(0, -13, 0, 0) : UIEdgeInsetsZero;
        [btn_nav_back addTarget:self action:@selector(barButtonItemClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * btn_Left = [[UIBarButtonItem alloc] initWithCustomView:btn_nav_back];
        self.navigationItem.leftBarButtonItem = btn_Left;
    }
    else
    {
        [self.navigationItem setHidesBackButton:YES];
    }
}
/**
 * 功能描述: 导航按钮事件
 * 输入参数: 按钮
 * 返 回 值: N/A
 */
- (void)barButtonItemClick:(UIButton *)btn
{
    if (btn.tag == 999)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (HelpBuySourceState)resuleIsHelpBuySourceType:(NSString*)strSource
{
    if([strSource isEqualToString:@"taobao"])
    {
        return taobao;
    }
    else if ([strSource isEqualToString:@"jd"])
    {
        return jd;
    }
    else if ([strSource isEqualToString:@"dangdang"])
    {
        return dangdang;
    }
    else if ([strSource isEqualToString:@"yixun"])
    {
        return yixun;
    }
    else if ([strSource isEqualToString:@"amazon"])
    {
        return amazon;
    }
    else if ([strSource isEqualToString:@"paipai"])
    {
        return paipai;
    }
    else if ([strSource isEqualToString:@"vancl"])
    {
        return vancl;
    }
    else if ([strSource isEqualToString:@"vip"])
    {
        return vip;
    }
    else
    {
        return taobao;
    }
}

/**
 * 功能描述: 判断是否登录
 * 输入参数: N/A
 * 返 回 值: N/A
 */
- (void) checkLoginWithBlock:(void(^)(void))complete
{
    UserInfo *userInfo = [GlobalObj getUserInfo];
    if (userInfo != nil)
    {
        complete();
    }
    else
    {
        //清空用户信息
        [GlobalObj setUserInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NAME_POP_LOGIN object:nil];
    }
}

/**
 * 功能描述: 判断是否登录
 * 输入参数: N/A
 * 返 回 值: N/A
 */
- (void) checkLoginWithBlock:(void(^)(void))complete andLoginTag:(int)tag
{
    UserInfo *userInfo = [GlobalObj getUserInfo];
    if (userInfo != nil)
    {
        complete();
    }
    else
    {
        //清空用户信息
        [GlobalObj setUserInfo:nil];
//        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        //购物车和关注界面未登录返回首页
//        if ([self isMemberOfClass:[ShoppingCartViewController class]] || [self isMemberOfClass:[FavoriteViewController class]] )
//        {
//            loginViewController.isBackToHome = YES;
//        }
//        else
//        {
//            loginViewController.isBackToHome = NO;
//        }
//        if (tag > 0)
//        {
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogin:) name:[NSString stringWithFormat:@"%@LoginDoneNotification",[self class]] object:nil];
//            loginViewController.notificationName = [NSString stringWithFormat:@"%@LoginDoneNotification",[self class]];
//            loginViewController.loginTag = tag;
//        }
//        CustomerNavagationBarController *navLogin = [[[CustomerNavagationBarController alloc] initWithRootViewController:loginViewController] autorelease];
//        [self.navigationController presentModalViewController:navLogin animated:NO];
    }
}

/**
 * 功能描述: 根据运单状态判断展示类型
 * 输入参数: status 运单状态
 * 返 回 值: 运单展示类型枚举
 */
- (ShipDisState)getShipStateWithStatus:(int)status
{
    
    if(status == ShipUnhandled)
    {  //未处理
        return WCLWay;
    }
    else if( status == OrderReceived  || status ==Deliverying || status ==ShipProcessing)
    {//处理中
        return CLCWay;
    }
    else if (status == IncorrectInfo || status == ChuguanPackageReturned || status == WeichuguanPackageReturned || status == RedeliveredFreely || status == Redeliverd || status == RedeliverdDually || status == PackageReturnedDually || status == Untransportable)
    {//待确认
        return DCLWay;
    }
    else if (status == Deliverd )
    {
        return YFHWay;
    }
    else if (status == Received )
    {
        return YSHWay;
    }
    else if (status == Canceled || status == Audited || status == StateError)
    {
        return shipCanceled;
    }
    else
    {
        return CLCWay;
    }
    
}

@end
