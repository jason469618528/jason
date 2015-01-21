//
//  UserToolHomeViewController.m
//  PanliApp
//
//  Created by jason on 14-4-4.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "UserToolHomeViewController.h"
#import "LoginViewController.h"
#import "MyPanliHomeViewController.h"
#import "CustomerNavagationBarController.h"
#import "PushNotificationViewController.h"
#import "HelpViewController.h"
#import "SelectAddressViewController.h"
#import "ChangePasswordViewController.h"
#import "UserInfo.h"
#import "ActiveViewController.h"
#import "AboutViewController.h"
#import "InternationalViewController.h"

#define TAG_PUSH_NOTIF      1022
#define TAG_SELECT_ADDRESS  1023
#define TAG_FEED_BACK       1024
#define TAG_CHANGE_PASSWORD 1025

@interface UserToolHomeViewController ()

@end

@implementation UserToolHomeViewController

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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = LocalizedString(@"UserToolHomeViewController_Nav_Title",@"更多");
    [self.navigationController setNavigationBarHidden:NO];
    //init tableview
    tab_Main = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, MainScreenFrame_Width - 20 - 72) style:UITableViewStylePlain];
    tab_Main.delegate = self;
    tab_Main.dataSource = self;
    tab_Main.backgroundColor = [PanliHelper colorWithHexString:@"#f0f0f0"];
    tab_Main.separatorColor = PL_COLOR_CLEAR;
    tab_Main.showsHorizontalScrollIndicator = NO;
    tab_Main.showsVerticalScrollIndicator = NO;
    [PanliHelper setExtraCellPixelExcursion:tab_Main];
    [PanliHelper setExtraCellLineHidden:tab_Main];
    [self.view addSubview:tab_Main];
    
    //footer add button
    UIView *view_Footer = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 84.0f)];
    btn_logout = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_logout setFrame:CGRectMake(17.5f, 0.0f , 286.5f, 43.5f)];
    [btn_logout setImage:[UIImage imageNamed:@"btn_UH_Logout"]forState:UIControlStateNormal];
    [btn_logout setImage:[UIImage imageNamed:@"btn_UH_Logout_on"]forState:UIControlStateHighlighted];
    [btn_logout addTarget:self action:@selector(logoutClick)forControlEvents:UIControlEventTouchUpInside];
    [view_Footer addSubview:btn_logout];
    tab_Main.tableFooterView = view_Footer;
    
    // init data
    NSArray *arr_Tool = [NSArray arrayWithObjects:LocalizedString(@"UserToolHomeViewController_arrTool_item1",@"消息设置"),
                         LocalizedString(@"UserToolHomeViewController_arrTool_item2",@"收货地址薄"),
                         LocalizedString(@"UserToolHomeViewController_arrTool_item3",@"修改登录密码"),
                         LocalizedString(@"UserToolHomeViewController_arrTool_item4",@"多语言"), nil];
    NSArray *arr_Hint = [NSArray arrayWithObjects:LocalizedString(@"UserToolHomeViewController_arrHint_item1",@"使用指南"),
                         LocalizedString(@"UserToolHomeViewController_arrHint_item2",@"意见反馈"),
                         LocalizedString(@"UserToolHomeViewController_arrHint_item3",@"为我们打分鼓励"),
                         LocalizedString(@"UserToolHomeViewController_arrHint_item4",@"关于 Panli App"),
                         LocalizedString(@"UserToolHomeViewController_arrHint_item5",@"检查更新"), nil];
    
    arr_Data = [[NSArray alloc] initWithObjects:arr_Tool,arr_Hint, nil];
    
    NSArray *arr_ImgTop = [NSArray arrayWithObjects:[UIImage imageNamed:@"icon_UH_Notification"],[UIImage imageNamed:@"icon_UH_Address"],[UIImage imageNamed:@"icon_UH_ChangePassWord"],[UIImage imageNamed:@"icon_UH_Notification"], nil];
    NSArray *arr_ImgBom = [NSArray arrayWithObjects:[UIImage imageNamed:@"icon_UH_UserGuide"],
                           [UIImage imageNamed:@"icon_UH_FeedBack"],
                           [UIImage imageNamed:@"icon_UH_Grade"],
                           [UIImage imageNamed:@"icon_UH_About"],
                           [UIImage imageNamed:@"icon_UH_Check"], nil];
    
    arr_Image = [[NSArray alloc] initWithObjects:arr_ImgTop,arr_ImgBom, nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //注销按钮
    UserInfo *userInfo = [GlobalObj getUserInfo];
    if (userInfo != nil)
    {
        btn_logout.hidden = NO;
        
    }
    else
    {
        btn_logout.hidden = YES;
    }
    
    //国际化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:CHANGE_LANGUAGE_NOTIFICATION object:nil];
}

- (void)changeLanguage
{
//    [self.navigationController popToRootViewControllerAnimated:YES];
    [tab_Main reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableview Delegate && dataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section)
    {
        return 5;
    }
    else
    {
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.0f;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view_Footer = [[UIView alloc] init];
    view_Footer.backgroundColor = PL_COLOR_CLEAR;
    
    if(!section)
    {
        UIView *view_BomLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 19.5f, MainScreenFrame_Width, 0.5)];
        view_BomLine.backgroundColor = [PanliHelper colorWithHexString:@"#c8c8c8"];
        [view_Footer addSubview:view_BomLine];
    }
    return view_Footer;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = PL_COLOR_WHITE;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCell = @"toolCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
        //icon
        UIImageView *icon_Flag = [[UIImageView alloc] init];
        icon_Flag.tag = indexPath.row + 1000;
        [cell addSubview:icon_Flag];
        
        //更新label
        UILabel *lab_update = [[UILabel alloc] initWithFrame:CGRectMake(175.0f, 22.0f, 130.0f, 12.0f)];
        lab_update.tag = 9999;
        lab_update.font = DEFAULT_FONT(12.0f);
        lab_update.backgroundColor = PL_COLOR_CLEAR;
        lab_update.textAlignment = NSTextAlignmentRight;
        [cell addSubview:lab_update];
        
        //线条
        UIView *view_Line = [[UIView alloc] initWithFrame:CGRectMake(36.0f, 49.5f, MainScreenFrame_Width - 36.0f, 0.5f)];
        view_Line.tag = 8888;
        view_Line.backgroundColor = [PanliHelper colorWithHexString:@"#c8c8c8"];
        [cell addSubview:view_Line];
        
        //底部线条
        UIView *view_BomLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 49.5f, MainScreenFrame_Width, 0.5)];
        view_BomLine.tag = 7777;
        view_BomLine.backgroundColor = [PanliHelper colorWithHexString:@"#c8c8c8"];
        [cell addSubview:view_BomLine];
    }
    UILabel *lab_update = (UILabel*)[cell viewWithTag:9999];
    //icon
    UIImageView *icon_Flag = (UIImageView*)[cell viewWithTag:indexPath.row + 1000];
    UIImage *image = [[arr_Image objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    icon_Flag.image = image;
    icon_Flag.frame = CGRectMake(17.5f, 17.5f, image.size.width, image.size.height);
    //底部线条
    UIView *view_BomLine = (UIView*)[cell viewWithTag:7777];
    if(indexPath.section == 0)
    {
        view_BomLine.hidden = (4-1 != indexPath.row) ? YES : NO;
    }
    else if(indexPath.section == 1)
    {
        view_BomLine.hidden = (5-1 != indexPath.row) ? YES : NO;
    }
    
    if(indexPath.row == 4)
    {
        if([GlobalObj isLastVersion])
        {
            lab_update.text = [NSString stringWithFormat:@"V%@%@",[PanliHelper getVersion] ,LocalizedString(@"UserToolHomeViewController_labUpdate1",@"已是最新版本")];
            lab_update.textColor = [PanliHelper colorWithHexString:@"#afafaf"];
        }
        else
        {
            lab_update.text = LocalizedString(@"UserToolHomeViewController_labUpdate2",@"检测到新版本,点击更新");
            lab_update.textColor = [PanliHelper colorWithHexString:@"#fe6600"];
        }
        cell.accessoryView = nil;
    }
    else
    {
        lab_update.text = nil;
        UIImageView *img_arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_UH_Allow"]];
        img_arrow.frame = CGRectMake(0.0f, 0.0f, 7.0f, 11.0f);
        cell.accessoryView = img_arrow;
    }
    
    NSArray *arr_List = [arr_Data objectAtIndex:indexPath.section];
    cell.textLabel.text = [arr_List objectAtIndex:indexPath.row];
    //线条
    UIView *view_Line = (UIView*)[cell viewWithTag:8888];
    view_Line.hidden = (arr_List.count-1 == indexPath.row) ? YES : NO;
    
    cell.textLabel.font = DEFAULT_FONT(15);
    cell.textLabel.textColor = [PanliHelper colorWithHexString:@"#444444"];
    cell.indentationLevel = 4;
    //点击背景颜色
    UIView *view_hightBackground = [[UIView alloc] init];
    view_hightBackground.backgroundColor = [PanliHelper colorWithHexString:@"#f2f2f2"];
    cell.selectedBackgroundView = view_hightBackground;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPanliHomeViewController *homeViewController = (MyPanliHomeViewController *)self.parentViewController.parentViewController;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row)
    {
        case 0:
        {
            //消息设置 与 使用指南
            if(!indexPath.section)
            {
                //消息设置
                [super checkLoginWithBlock:^{
                    CustomerNavagationBarController *nav_PushNotification = [[CustomerNavagationBarController alloc] initWithRootViewController:[[PushNotificationViewController alloc] init]];
                    homeViewController.viewControllers = [NSArray arrayWithObjects:self.navigationController,nav_PushNotification, nil];
                } andLoginTag:TAG_PUSH_NOTIF];
                
            }
            else
            {
                //使用指南
                CustomerNavagationBarController *nav_Help = [[CustomerNavagationBarController alloc] initWithRootViewController:[[HelpViewController alloc] init]];
                homeViewController.viewControllers = [NSArray arrayWithObjects:self.navigationController,nav_Help, nil];
            }
            break;
        }
        case 1:
        {
            //收货地址薄 与 意见反馈
            if(!indexPath.section)
            {
                [super checkLoginWithBlock:^{
                    SelectAddressViewController *selectAddressView = [[SelectAddressViewController alloc] init];
                    selectAddressView.viewType = 1;
                    CustomerNavagationBarController *nav_SelectAddress = [[CustomerNavagationBarController alloc] initWithRootViewController:selectAddressView];
                    homeViewController.viewControllers = [NSArray arrayWithObjects:self.navigationController,nav_SelectAddress, nil];
                } andLoginTag:TAG_SELECT_ADDRESS];
            }
            else
            {
                //意见反馈
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
//                else if (userInfo != nil && userInfo.isApproved)
//                {
//                    ActiveViewController *activeViewController = [[ActiveViewController alloc] init];
//                    [self.navigationController presentModalViewController:activeViewController animated:NO];
//                }
                else
                {
                    FeedBackViewController *feedBack = [[FeedBackViewController alloc] init];
                    CustomerNavagationBarController *nav_FeedBack = [[CustomerNavagationBarController alloc] initWithRootViewController:feedBack];
                    feedBack.delegate = self;
                    homeViewController.viewControllers = [NSArray arrayWithObjects:self.navigationController,nav_FeedBack, nil];
                }
            }
            break;
        }
        case 2:
        {
            //修改登录密码 与 打分
            if(!indexPath.section)
            {
                [super checkLoginWithBlock:^{
                    CustomerNavagationBarController *nav_ChangePassword = [[CustomerNavagationBarController alloc] initWithRootViewController:[[ChangePasswordViewController alloc] init]];
                    homeViewController.viewControllers = [NSArray arrayWithObjects:self.navigationController,nav_ChangePassword, nil];
                } andLoginTag:TAG_CHANGE_PASSWORD];
            }
            else
            {
                NSURL * url=[NSURL URLWithString:@"https://itunes.apple.com/us/app/panli-dai-gou/id590216292?ls=1&mt=8"];
                [[ UIApplication sharedApplication ] openURL: url ];
            }
            break;
        }
        case 3:
        {
            //多语言 与 关于APP
            if (!indexPath.section)
            {
                
                CustomerNavagationBarController *nav_International = [[CustomerNavagationBarController alloc] initWithRootViewController:[[InternationalViewController alloc] init]];
                homeViewController.viewControllers = [NSArray arrayWithObjects:self.navigationController,nav_International, nil];
            }
            else
            {
                CustomerNavagationBarController *nav_About = [[CustomerNavagationBarController alloc] initWithRootViewController:[[AboutViewController alloc] init]];
                homeViewController.viewControllers = [NSArray arrayWithObjects:self.navigationController,nav_About, nil];
            }
            break;
        }
        case 4:
        {
            if([GlobalObj isLastVersion])
            {
                [self showHUDMessage:LocalizedString(@"UserToolHomeViewController_HUDMsg",@"已是最新版本")];
            }
            else
            {
                NSURL * url=[NSURL URLWithString:@"https://itunes.apple.com/us/app/panli-dai-gou/id590216292?ls=1&mt=8"];
                [[ UIApplication sharedApplication ] openURL: url ];
            }
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
    switch (tag)
    {
        case TAG_PUSH_NOTIF:
        {
                        break;
        }
        case TAG_SELECT_ADDRESS:
        {
                        break;
        }
        case TAG_FEED_BACK:
        {
            
            break;
        }
        case TAG_CHANGE_PASSWORD:
        {
            
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - feedBackSuccessDelegate
- (void)feedBackSuccess
{
    [self showHUDSuccessMessage:LocalizedString(@"UserToolHomeViewController_HUDSucMsg",@"您的反馈已经收录!")];
}

#pragma mark - UserLogout
-(void)logoutClick
{
    if([GlobalObj getUserInfo])
    {
        UIAlertView *logoutAlertView = [[UIAlertView alloc]initWithTitle:LocalizedString(@"UserToolHomeViewController_AlertView_Title",@"Panli提示")
                                                                 message:LocalizedString(@"UserToolHomeViewController_AlertView_Msg",@"是否注销当前账号?")
                                                                delegate:self
                                                       cancelButtonTitle:LocalizedString(@"UserToolHomeViewController_AlertView_CanBtn",@"否")
                                                       otherButtonTitles:LocalizedString(@"UserToolHomeViewController_AlertView_OthBtn",@"是"),nil];
        [logoutAlertView setTag:8000];
        [logoutAlertView show];
    }
}
#pragma mark - UIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 8000 && buttonIndex == 1)
    {
        [self showHUDSuccessMessage:LocalizedString(@"UserToolHomeViewController_HUDSucMsg2",@"退出当前账号成功")];
        [self.HUD showAnimated:YES whileExecutingBlock:^{
            [GlobalObj setUserInfo:nil];
            btn_logout.hidden = YES;
            sleep(1.8);
        } completionBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];

        return;
    }
}
@end
