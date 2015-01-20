//
//  RootViewController.m
//  PanliBuyHD
//
//  Created by Liubin on 14-6-16.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "RootViewController.h"
#import "JJTabBarControllerLib.h"
#import "CustomerNavagationBarController.h"
#import "UserInfo.h"
#import "LoginViewController.h"
#import "IndexViewController.h"
#import "ShoppingcartHomeViewController.h"
#import "OrderHomeViewController.h"
#import "FavoriteHomeViewController.h"
#import "MyPanliHomeViewController.h"

@interface RootViewController ()<JJTabBarControllerDelegate>

@property (nonatomic,strong) JJTabBarController *tabBarController;

@property (nonatomic,strong) JJTabBarView *tabBarView;

@property (nonatomic,strong) UIPopoverController *popOver;

@end

@implementation RootViewController

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
    

    _tabBarView = [[JJTabBarView alloc] initWithFrame:CGRectMake(0, 0, TOOLBAR_WIDTH,UI_SCREEN_HEIGHT)];
    _tabBarView.backgroundImage = [UIImage imageNamed:@"bg_tabbar"];
    _tabBarView.autoResizeChilds = NO;
    
    //首页
    CustomerNavagationBarController *nav_index = [[CustomerNavagationBarController alloc] initWithRootViewController:[[IndexViewController alloc] initWithNibName:nil bundle:nil]];
    nav_index.jjTabBarButton = [self getTabbarButton:0];
    
    //购物车
    CustomerNavagationBarController *nav_shoppingcart = [[CustomerNavagationBarController alloc] initWithRootViewController:[[ShoppingcartHomeViewController alloc] initWithNibName:nil bundle:nil]];
    nav_shoppingcart.jjTabBarButton = [self getTabbarButton:1];
    
    //送货车
    CustomerNavagationBarController *nav_order = [[CustomerNavagationBarController alloc] initWithRootViewController:[[OrderHomeViewController alloc] initWithNibName:nil bundle:nil]];
    nav_order.jjTabBarButton = [self getTabbarButton:2];
    
    //收藏夹
    CustomerNavagationBarController *nav_favorite = [[CustomerNavagationBarController alloc] initWithRootViewController:[[FavoriteHomeViewController alloc] initWithNibName:nil bundle:nil]];
    nav_favorite.jjTabBarButton = [self getTabbarButton:3];
    
    //MyPanli
    MyPanliHomeViewController *nav_MyPanli = [[MyPanliHomeViewController alloc] initWithNibName:nil bundle:nil];
    nav_MyPanli.jjTabBarButton = [self getTabbarButton:4];
    
    _tabBarController = [[JJTabBarController alloc] initWithTabBar:_tabBarView andDockPosition:JJTabBarDockLeft];
    _tabBarController.delegate = self;
    _tabBarController.tabBarChilds = @[nav_index,nav_shoppingcart,nav_order,nav_favorite,nav_MyPanli];
    _tabBarController.selectedTabBarIndex = 0;
    [self addChildViewController:_tabBarController];
    [self.view addSubview:_tabBarController.view];
    [_tabBarController didMoveToParentViewController:self];
    
//    UserInfo *mUserInfo = [GlobalObj getUserInfo];
//    //用户已登录
//    if (mUserInfo)
//    {
//        [self userDidOnline];
//    }
//    //用户未登录
//    else
//    {
//        [self userDidOffline];
//    }
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidOnline) name:NOTIFICATION_NAME_LOGIN object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidOffline) name:NOTIFICATION_NAME_LOGOUT object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginButtonOnClick) name:NOTIFICATION_NAME_POP_LOGIN object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)getTabbarButton:(NSInteger)index
{
    // 未选中状态item
    NSArray *unSelectedImageArray = @[[UIImage imageNamed:@"btn_tabbar_home"],
                                      
                                      [UIImage imageNamed:@"btn_tabbar_shoppingcart"],
                                      
                                      [UIImage imageNamed:@"btn_tabbar_order"],
                                      
                                      [UIImage imageNamed:@"btn_tabbar_favorite"],
                                      
                                      [UIImage imageNamed:@"btn_tabbar_myPanli"]];
    // 选中状态item
    NSArray *selectedImageArray = @[[UIImage imageNamed:@"btn_tabbar_home_on"],
                                    
                                    [UIImage imageNamed:@"btn_tabbar_shoppingcart_on"],
                                    
                                    [UIImage imageNamed:@"btn_tabbar_order_on"],
                                    
                                    [UIImage imageNamed:@"btn_tabbar_favorite_on"],
                                    
                                    [UIImage imageNamed:@"btn_tabbar_myPanli_on"]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0.0f,TOOLBAR_WIDTH * index,TOOLBAR_WIDTH,TOOLBAR_WIDTH)];
    [button setBackgroundImage:[unSelectedImageArray objectAtIndex:index] forState:UIControlStateNormal];
    [button setBackgroundImage:[selectedImageArray objectAtIndex:index] forState:UIControlStateHighlighted];
    [button setAdjustsImageWhenHighlighted:NO];
    [button addBlockSelectionAction:^(UIButton *button, JJButtonEventType type) {
        [button setBackgroundImage:[selectedImageArray objectAtIndex:index] forState:UIControlStateNormal];
        [button setBackgroundImage:[unSelectedImageArray objectAtIndex:index] forState:UIControlStateHighlighted];
    } forEvent:JJButtonEventTouchUpInside];
    
    [button addBlockSelectionAction:^(UIButton *button, JJButtonEventType type) {
        [button setBackgroundImage:[unSelectedImageArray objectAtIndex:index] forState:UIControlStateNormal];
        [button setBackgroundImage:[selectedImageArray objectAtIndex:index] forState:UIControlStateHighlighted];
    } forEvent:JJButtonEventDeselect];
    
    [button addBlockSelectionAction:^(UIButton *button, JJButtonEventType type) {
        [button setBackgroundImage:[selectedImageArray objectAtIndex:index] forState:UIControlStateNormal];
        [button setBackgroundImage:[unSelectedImageArray objectAtIndex:index] forState:UIControlStateHighlighted];
    } forEvent:JJButtonEventSelect];
    return button;

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)userDidOnline
{
    if ([_tabBarView viewWithTag:99] != nil)
    {
        UIView *v = [_tabBarView viewWithTag:99];
        [v removeFromSuperview];
    }
    if ([_tabBarView viewWithTag:100] != nil)
    {
        UIView *v = [_tabBarView viewWithTag:100];
        [v removeFromSuperview];
    }
    UserInfo *mUserInfo = [GlobalObj getUserInfo];
    UIButton *btn_user = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_user.frame = CGRectMake(MainScreenFrame_Width - 155, 0.0f, 130.0f, TOOLBAR_WIDTH);
    btn_user.backgroundColor = PL_COLOR_CLEAR;
    btn_user.tag = 100;
    [btn_user addTarget:self action:@selector(userButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    CGSize nickNameSize = [mUserInfo.nickName sizeWithFont:DEFAULT_BOLD_FONT(15) constrainedToSize:CGSizeMake(btn_user.frame.size.width - 11 - 10, 20.0f) lineBreakMode:NSLineBreakByCharWrapping];
    UILabel *lab_nickNmae = [[UILabel alloc] initWithFrame:CGRectMake(btn_user.frame.size.width - nickNameSize.width, 45.0f, nickNameSize.width, 20.0f)];
    lab_nickNmae.backgroundColor = PL_COLOR_CLEAR;
    lab_nickNmae.textColor = [PanliHelper colorWithHexString:@"#ff6700"];
    lab_nickNmae.textAlignment = UITextAlignmentRight;
    lab_nickNmae.font = DEFAULT_BOLD_FONT(15.0f);
    lab_nickNmae.text = mUserInfo.nickName;
    [btn_user addSubview:lab_nickNmae];
    
    UIImageView *img_online = [[UIImageView alloc] initWithFrame:CGRectMake(btn_user.frame.size.width - nickNameSize.width - 15, 49.0f, 11.0f, 13.0f)];
    img_online.image = [UIImage imageNamed:@"icon_tabbar_online"];
    [btn_user addSubview:img_online];
    
    [_tabBarView addSubview:btn_user];
}

- (void)userDidOffline
{
    if ([_tabBarView viewWithTag:99] != nil)
    {
        UIView *v = [_tabBarView viewWithTag:99];
        [v removeFromSuperview];
    }
    if ([_tabBarView viewWithTag:100] != nil)
    {
        UIView *v = [_tabBarView viewWithTag:100];
        [v removeFromSuperview];
    }
    UIButton *btn_user = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_user.frame = CGRectMake(MainScreenFrame_Width - 155, 0.0f, 130.0f, TOOLBAR_WIDTH);
    btn_user.backgroundColor = PL_COLOR_CLEAR;
    btn_user.tag = 99;
    [btn_user addTarget:self action:@selector(loginButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    CGSize textSize = [LocalizedString(@"RootViewController_labLogin",@"登录") sizeWithFont:DEFAULT_BOLD_FONT(15) constrainedToSize:CGSizeMake(btn_user.frame.size.width - 11 - 10, 20.0f) lineBreakMode:NSLineBreakByCharWrapping];
    
    UILabel *lab_login = [[UILabel alloc] initWithFrame:CGRectMake(btn_user.frame.size.width - textSize.width, 45.0f, textSize.width, 20.0f)];
    lab_login.backgroundColor = PL_COLOR_CLEAR;
    lab_login.textColor = [PanliHelper colorWithHexString:@"#ff6700"];
    lab_login.textAlignment = UITextAlignmentRight;
    lab_login.font = DEFAULT_BOLD_FONT(15.0f);
    lab_login.text = LocalizedString(@"RootViewController_labLogin",@"登录");
    [btn_user addSubview:lab_login];
    
    UIImageView *img_offline = [[UIImageView alloc] initWithFrame:CGRectMake(btn_user.frame.size.width - textSize.width - 15, 49.0f, 11.0f, 13.0f)];
    img_offline.image = [UIImage imageNamed:@"icon_tabbar_offline"];
    [btn_user addSubview:img_offline];
    
    [_tabBarView addSubview:btn_user];
}
//弹出登陆框
- (void)loginButtonOnClick
{
    LoginViewController *login = [[LoginViewController alloc] init];
    self.popOver = [[UIPopoverController alloc] initWithContentViewController:login];
    login.popOverController = self.popOver;
    login.popOverController.delegate = self;
    NSArray *interactionViews = [NSArray arrayWithObjects:[self view], nil];
    [login.popOverController setPassthroughViews:interactionViews];
    
    self.popOver.popoverContentSize = CGSizeMake(450.0f, 541.0f);
    [self.popOver presentPopoverFromRect:CGRectMake(284.5f, 120.0f, 450.0f, 541.0f) inView:self.view permittedArrowDirections:0 animated:YES];
}
#pragma mark - UIPopoverControllerDelegate
//- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
//{
//    NSLog(@"--=-==ShouldDismissPopover消失=-=-=");
//    return YES;
//}
//- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
//{
//    NSLog(@"--=-==DidDismissPopover消失=-=-=");
//}

- (void)userButtonOnClick
{
    [GlobalObj setUserInfo:nil];
    [self userDidOffline];
}

@end
