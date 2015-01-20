//
//  RegistResponseViewController.m
//  PanliApp
//
//  Created by Liubin on 13-7-18.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "RegistResponseViewController.h"
#import "ActiveViewController.h"
#import "SVWebViewController.h"

#define ACTIVE_TAG 1001
#define INDEX_TAG  1002
#define LOGIN_TAG  1003

@implementation RegistResponseViewController

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_emailSite);
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
//    [super viewDidLoadWithBackButtom:NO];
    self.navigationItem.title = LocalizedString(@"RegistResponseViewController_Nav_Title",@"注册Panli会员");
    
    //背景图
    UIImageView *backgroundView = [[UIImageView alloc] init];
    backgroundView.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT);
    [self.view addSubview:backgroundView];
    [backgroundView release];
    
    UILabel *lab_mainTitle = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 150.0f, 320.0f, 20.0f)];
    lab_mainTitle.backgroundColor = PL_COLOR_CLEAR;
    lab_mainTitle.font = DEFAULT_BOLD_FONT(18);
    lab_mainTitle.textAlignment = UITextAlignmentCenter;
    lab_mainTitle.textColor = [PanliHelper colorWithHexString:@"#5D900F"];
    [backgroundView addSubview:lab_mainTitle];
    [lab_mainTitle release];
    
    UILabel *lab_subTitleOne = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 180.0f, 320.0f, 20.0f)];
    lab_subTitleOne.backgroundColor = PL_COLOR_CLEAR;
    lab_subTitleOne.font = DEFAULT_FONT(14);
    lab_subTitleOne.textAlignment = UITextAlignmentCenter;
    lab_subTitleOne.textColor = [PanliHelper colorWithHexString:@"#8E8E8E"];
    [backgroundView addSubview:lab_subTitleOne];
    [lab_subTitleOne release];
    
    UILabel *lab_subTitleTwo = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 210.0f, 320.0f, 20.0f)];
    lab_subTitleTwo.backgroundColor = PL_COLOR_CLEAR;
    lab_subTitleTwo.font = DEFAULT_FONT(14);
    lab_subTitleTwo.textAlignment = UITextAlignmentCenter;
    lab_subTitleTwo.textColor = [PanliHelper colorWithHexString:@"#8E8E8E"];
    [backgroundView addSubview:lab_subTitleTwo];
    [lab_subTitleTwo release];
    
    UIButton *btn_Operate = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Operate.frame = CGRectMake(42.0f, 250.0f, 237.0f, 43.0f);
    [btn_Operate addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_Operate];
    
    switch (self.responseType)
    {
            //注册成功
        case 0:
        {
            UIButton *btn_nav_home = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn_nav_home setImage:[UIImage imageNamed:@"btn_navbar_backHome"] forState:UIControlStateNormal];
            [btn_nav_home setImage:[UIImage imageNamed:@"btn_navbar_backHome_on"] forState:UIControlStateHighlighted];
            [btn_nav_home addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            btn_nav_home.frame = CGRectMake(0.0f, 0.0f, 27.0f, 27.0);
            btn_nav_home.imageEdgeInsets = IS_IOS7 ? UIEdgeInsetsMake(0, -13, 0, 0) : UIEdgeInsetsZero;
            btn_nav_home.titleLabel.font = DEFAULT_FONT(15);
            btn_nav_home.tag = INDEX_TAG;
            UIBarButtonItem *btn_left = [[UIBarButtonItem alloc] initWithCustomView:btn_nav_home];
            self.navigationItem.leftBarButtonItem = btn_left;
            [btn_left release];

            
            if (IS_568H)
            {
                backgroundView.image = [UIImage imageNamed:@"bg_regist_success_h568@2x.png"];
            }
            else
            {
                backgroundView.image = [UIImage imageNamed:@"bg_regist_success@2x.png"];
            }
            
            lab_mainTitle.textColor = [PanliHelper colorWithHexString:@"#5D900F"];
            lab_mainTitle.text = LocalizedString(@"RegistResponseViewController_labMainTitle1",@"恭喜您,提交注册信息成功!");

            lab_subTitleOne.text = LocalizedString(@"RegistResponseViewController_labSubTitleOne1",@"请前往您的注册邮箱查收激活邮件,");

            lab_subTitleTwo.text = LocalizedString(@"RegistResponseViewController_labSubTitleTwo1",@"激活账户可享受完整的Panli服务.");
            
            btn_Operate.tag = ACTIVE_TAG;
            [btn_Operate setBackgroundImage:[UIImage imageNamed:@"btn_regist_active"] forState:UIControlStateNormal];
            [btn_Operate setBackgroundImage:[UIImage imageNamed:@"btn_regist_active_on"] forState:UIControlStateHighlighted];
            break;
        }
         
            //激活成功
        case 1:
        {
            if (IS_568H)
            {
                backgroundView.image =  [UIImage imageNamed:@"bg_regist_success_h568@2x.png"];
            }
            else
            {
                backgroundView.image = [UIImage imageNamed:@"bg_regist_success@2x.png"];
            }

            lab_mainTitle.textColor = [PanliHelper colorWithHexString:@"#5D900F"];
            lab_mainTitle.text = LocalizedString(@"RegistResponseViewController_labMainTitle2",@"恭喜您激活成功!");
            
            lab_subTitleOne.text = LocalizedString(@"RegistResponseViewController_labSubTitleOne2",@"欢迎加入Panli大家庭,");
            
            lab_subTitleTwo.text = LocalizedString(@"RegistResponseViewController_labSubTitleTwo2",@"现在您可以体验Panli的完整服务.");
            
            btn_Operate.tag = INDEX_TAG;
            [btn_Operate setBackgroundImage:[UIImage imageNamed:@"btn_regist_backHome"] forState:UIControlStateNormal];
            [btn_Operate setBackgroundImage:[UIImage imageNamed:@"btn_regist_backHome_on"] forState:UIControlStateHighlighted];
            break;
        }
            
            //激活失败
        case 2:
        {            
            if (IS_568H)
            {
                backgroundView.image = [UIImage imageNamed:@"bg_regist_fail_h568@2x.png"];
            }
            else
            {
                backgroundView.image = [UIImage imageNamed:@"bg_regist_fail@2x.png"];
            }
            
            lab_mainTitle.textColor = [PanliHelper colorWithHexString:@"#B12E02"];
            lab_mainTitle.text = LocalizedString(@"RegistResponseViewController_labMainTitle3",@"很抱歉,账户激活失败!");
            
            lab_subTitleOne.text = LocalizedString(@"RegistResponseViewController_labSubTitleOne3",@"您的账户激活链接可能失效了,");
            
            lab_subTitleTwo.text = LocalizedString(@"RegistResponseViewController_labSubTitleTwo3",@"请重新登录,我们将给您再次发送激活邮件.");
            
            btn_Operate.tag = LOGIN_TAG;
            [btn_Operate setBackgroundImage:[UIImage imageNamed:@"btn_regist_relogin"] forState:UIControlStateNormal];
            [btn_Operate setBackgroundImage:[UIImage imageNamed:@"btn_regist_relogin_on"] forState:UIControlStateHighlighted];
            break;
        }
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonClick:(UIButton *)button
{
    switch (button.tag)
    {
        case ACTIVE_TAG:
        {
            SVWebViewController *webViewController = [[[SVWebViewController alloc] initWithAddress:self.emailSite] autorelease];
            webViewController.title = LocalizedString(@"RegistResponseViewController_webViewController",@"激活Panli账户");
            
            UIButton *btn_nav_home = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn_nav_home setImage:[UIImage imageNamed:@"btn_navbar_backHome"] forState:UIControlStateNormal];
            [btn_nav_home setImage:[UIImage imageNamed:@"btn_navbar_backHome_on"] forState:UIControlStateHighlighted];
            [btn_nav_home addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            btn_nav_home.frame = CGRectMake(0.0f, 0.0f, 27.0f, 27.0f);
            btn_nav_home.imageEdgeInsets = IS_IOS7 ? UIEdgeInsetsMake(0, -13, 0, 0) : UIEdgeInsetsZero;
            btn_nav_home.titleLabel.font = DEFAULT_FONT(15);
            btn_nav_home.tag = INDEX_TAG;
            UIBarButtonItem *btn_left = [[UIBarButtonItem alloc] initWithCustomView:btn_nav_home];
            webViewController.navigationItem.leftBarButtonItem = btn_left;
            [btn_left release];
            [self.navigationController pushViewController:webViewController animated:YES];
            break;
        }
            
        case INDEX_TAG:
        {
//            [self dismissModalViewControllerAnimated:YES];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"TRANS_TO_HOMEPAGE" object:nil];
            [self dismissModalViewControllerAnimated:YES];
            if(self.tabBarController)
            {
                self.tabBarController.selectedIndex = 0;
            }
            break;
        }
            
        case LOGIN_TAG:
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        }
            
        default:
            break;
    }
}

@end
