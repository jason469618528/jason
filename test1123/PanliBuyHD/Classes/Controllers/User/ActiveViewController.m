//
//  ActiveViewController.m
//  PanliApp
//
//  Created by Liubin on 13-7-19.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ActiveViewController.h"
#import "SVWebViewController.h"

@interface ActiveViewController ()

@end

@implementation ActiveViewController

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
    
    self.navigationItem.title = LocalizedString(@"ActiveViewController_Nav_Title",@"激活Panli账户");
    
    //返回按钮
    UIButton *btn_nav_back = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_nav_back setImage:[UIImage imageNamed:@"btn_navbar_back"]forState:UIControlStateNormal];
    [btn_nav_back setImage:[UIImage imageNamed:@"btn_navbar_back_on"] forState:UIControlStateHighlighted];
    [btn_nav_back addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    btn_nav_back.frame = CGRectMake(0.0f, 0.0f, 26.5f, 26.5f);
    btn_nav_back.imageEdgeInsets = IS_IOS7 ? UIEdgeInsetsMake(0, -13, 0, 0) : UIEdgeInsetsZero;
    btn_nav_back.tag = 1001;
    UIBarButtonItem * btn_Left = [[UIBarButtonItem alloc] initWithCustomView:btn_nav_back];
    self.navigationItem.leftBarButtonItem = btn_Left;
    [btn_Left release];

    UIImageView *backgroundView = [[UIImageView alloc] init];
    backgroundView.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT);
    if (IS_568H)
    {
        backgroundView.image = [UIImage imageNamed:@"bg_regist_fail_h568@2x.png"];
    }
    else
    {
        backgroundView.image = [UIImage imageNamed:@"bg_regist_fail@2x.png"];
    }
    [self.view addSubview:backgroundView];
    [backgroundView release];
    
    UILabel *lab_firstLine = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 150.0f, 320.0f, 20.0f)];
    lab_firstLine.backgroundColor = PL_COLOR_CLEAR;
    lab_firstLine.font = DEFAULT_BOLD_FONT(18);
    lab_firstLine.textAlignment = UITextAlignmentCenter;
    lab_firstLine.textColor = [PanliHelper colorWithHexString:@"#B12E02"];
    lab_firstLine.text = LocalizedString(@"ActiveViewController_labfirstLine",@"您的Panli账户未激活!");
    [backgroundView addSubview:lab_firstLine];
    [lab_firstLine release];
    
    UILabel *lab_secondLine = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 180.0f, 320.0f, 20.0f)];
    lab_secondLine.backgroundColor = PL_COLOR_CLEAR;
    lab_secondLine.font = DEFAULT_FONT(14);
    lab_secondLine.textAlignment = UITextAlignmentCenter;
    lab_secondLine.textColor = [PanliHelper colorWithHexString:@"#8E8E8E"];
    lab_secondLine.text = LocalizedString(@"ActiveViewController_labSecondLine",@"请前往您的注册邮箱查收激活邮件");
    [backgroundView addSubview:lab_secondLine];
    [lab_secondLine release];
    
    UILabel *lab_thirdLine = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 210.0f, 320.0f, 20.0f)];
    lab_thirdLine.backgroundColor = PL_COLOR_CLEAR;
    lab_thirdLine.font = DEFAULT_FONT(14);
    lab_thirdLine.textAlignment = UITextAlignmentCenter;
    lab_thirdLine.textColor = [PanliHelper colorWithHexString:@"#8E8E8E"];
    lab_thirdLine.text = LocalizedString(@"ActiveViewController_labThirdLine",@"激活账户可享受完整的Panli服务");
    [backgroundView addSubview:lab_thirdLine];
    [lab_thirdLine release];
    
    UIButton *btn_avtive = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_avtive.tag = 1002;
    btn_avtive.frame = CGRectMake(42.0f, 250.0f, 237.0f, 43.0f);
    [btn_avtive setImage:[UIImage imageNamed:@"btn_regist_checkEmail"] forState:UIControlStateNormal];
    [btn_avtive setImage:[UIImage imageNamed:@"btn_regist_checkEmail_on"] forState:UIControlStateHighlighted];
    [btn_avtive addTarget:self action:@selector(checkEmail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_avtive];
    
    UILabel *lab_fourthLine = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 330.0f, 320.0f, 20.0f)];
    lab_fourthLine.backgroundColor = PL_COLOR_CLEAR;
    lab_fourthLine.font = DEFAULT_FONT(14);
    lab_fourthLine.textAlignment = UITextAlignmentCenter;
    lab_fourthLine.textColor = [PanliHelper colorWithHexString:@"#8E8E8E"];
    lab_fourthLine.text = LocalizedString(@"ActiveViewController_labFourthLine",@"若需帮助请发送邮件至service@panli.com");
    [backgroundView addSubview:lab_fourthLine];
    [lab_fourthLine release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backClick
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)backClick:(UIButton *)btn
{
    switch (btn.tag)
    {
        case 1001:
            [self.navigationController dismissModalViewControllerAnimated:YES];
            break;
        case 1002:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        default:
            break;
    }

}

- (void)checkEmail
{
    SVWebViewController *webViewController = [[[SVWebViewController alloc] initWithAddress:self.emailSite] autorelease];
    webViewController.title = LocalizedString(@"ActiveViewController_WebView_Title",@"注册Panli账户");
    
    //返回
    UIButton *btn_nav_back = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_nav_back setImage:[UIImage imageNamed:@"btn_navbar_back"]forState:UIControlStateNormal];
    [btn_nav_back setImage:[UIImage imageNamed:@"btn_navbar_back_on"] forState:UIControlStateHighlighted];
    [btn_nav_back addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    btn_nav_back.frame = CGRectMake(0.0f, 0.0f, 26.5f, 26.5f);
    btn_nav_back.imageEdgeInsets = IS_IOS7 ? UIEdgeInsetsMake(0, -13, 0, 0) : UIEdgeInsetsZero;
    btn_nav_back.tag = 1002;
    UIBarButtonItem * btn_Left = [[UIBarButtonItem alloc] initWithCustomView:btn_nav_back];
    webViewController.navigationItem.leftBarButtonItem = btn_Left;
    [btn_Left release];
    [self.navigationController pushViewController:webViewController animated:YES];
}
@end
