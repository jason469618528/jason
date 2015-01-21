//
//  LoginViewController.m
//  PanliBuyHD
//
//  Created by jason on 14-6-18.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "LoginViewController.h"
#import "RSAManager.h"
#import "NSData+Base64.h"
#define VIEW_DEFAULT_WIDTH 450.0f
#define VIEW_DEFAULT_HEIGHT 541.0f

#define TAG_CANCEL 1001
#define TAG_LOGIN 1002
#define TAG_FACEBOOK 1003
#define TAG_REGISTER 1004
@interface LoginViewController ()

@end

@implementation LoginViewController

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
    self.view.backgroundColor = [PanliHelper colorWithHexString:@"#ebebeb"];
    //背景
    UIView *view_TopBG = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, VIEW_DEFAULT_WIDTH, 56.0f)];
    view_TopBG.backgroundColor = [PanliHelper colorWithHexString:@"#f6f6f6"];
    [self.view addSubview:view_TopBG];
    
    UILabel *lab_Title = [[UILabel alloc] initWithFrame:CGRectMake((VIEW_DEFAULT_WIDTH - 42.0f)/2, (56 - 19)/2, 42.0f, 20.0f)];
    lab_Title.backgroundColor = PL_COLOR_CLEAR;
    lab_Title.textColor = [PanliHelper colorWithHexString:@"#ff6700"];
    lab_Title.font = DEFAULT_FONT(19.0f);
    lab_Title.text = LocalizedString(@"LoginViewController_Nav_Title",@"登录");
    [view_TopBG addSubview:lab_Title];
    
    UIView *view_TopLive = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 56.0f, VIEW_DEFAULT_WIDTH, 1.5f)];
    view_TopLive.backgroundColor = [PanliHelper colorWithHexString:@"#cecece"];
    [self.view addSubview:view_TopLive];
    
    //取消
    UIButton *btn_Cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Cancel.frame = CGRectMake(VIEW_DEFAULT_WIDTH - 53.0f , (56 - 47.0f)/2, 53.0f, 47.0f);
    btn_Cancel.tag = TAG_CANCEL;
    [btn_Cancel setImage:[UIImage imageNamed:@"btn_padlogin_cancel"] forState:UIControlStateNormal];
    [btn_Cancel setImage:[UIImage imageNamed:@"btn_padlogin_cancel_on"] forState:UIControlStateHighlighted];
    [btn_Cancel addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn_Cancel];
    
    //用户名
    txt_UserName = [[UITextField alloc] initWithFrame:CGRectMake(43.0f, 78.0f, 365.0f, 50)];
    txt_UserName.font = DEFAULT_FONT(15);
    txt_UserName.textColor = PL_COLOR_GRAY;
    txt_UserName.backgroundColor = [PanliHelper colorWithHexString:@"#ffffff"];
    txt_UserName.placeholder = LocalizedString(@"LoginViewController_txtUserName",@"用户名");
    txt_UserName.delegate = self;
    txt_UserName.returnKeyType = UIReturnKeyNext;
    txt_UserName.clearButtonMode = YES;
    txt_UserName.keyboardAppearance = UIKeyboardAppearanceDefault;
    txt_UserName.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    txt_UserName.layer.cornerRadius = 6.0f;
    txt_UserName.layer.masksToBounds = YES;
    txt_UserName.layer.borderColor = [PanliHelper colorWithHexString:@"#cecece"].CGColor;
    txt_UserName.layer.borderWidth = 1.2f;
    //取缓存用户名
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefault objectForKey:@"userName"];
    if (![NSString isEmpty:userName])
    {
        txt_UserName.text = userName;
    }
    
    UIImageView *imageUser = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_padlogin_UserName"]];
    imageUser.frame = CGRectMake(15, 2, 22, 23);
    UIView *userLeftView = [[UIView alloc]init];
    [userLeftView addSubview:imageUser];
    
    txt_UserName.leftView = userLeftView;
    txt_UserName.leftView.frame = CGRectMake(0, 0, 45, 25);
    txt_UserName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txt_UserName.leftView.contentMode = UIControlContentVerticalAlignmentCenter;
    txt_UserName.leftViewMode = UITextFieldViewModeAlways;
    
    //密码
    txt_Password = [[UITextField alloc] initWithFrame:CGRectMake(43.0f, 148.0f, 365.0f, 50)];
    txt_Password.borderStyle = UITextBorderStyleNone;
    txt_Password.font = DEFAULT_FONT(15);
    txt_Password.textColor = PL_COLOR_GRAY;
    txt_Password.backgroundColor = [PanliHelper colorWithHexString:@"#ffffff"];
    txt_Password.placeholder = LocalizedString(@"LoginViewController_txtPassword",@"密码");
    txt_Password.delegate = self;
    txt_Password.returnKeyType = UIReturnKeyDone;
    txt_Password.secureTextEntry = YES;
    txt_Password.keyboardAppearance = UIKeyboardAppearanceDefault;
    txt_Password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    txt_Password.layer.cornerRadius = 6.0f;
    txt_Password.clearButtonMode = YES;
    txt_Password.layer.masksToBounds = YES;
    txt_Password.layer.borderColor = [PanliHelper colorWithHexString:@"#cecece"].CGColor;
    txt_Password.layer.borderWidth = 1.2f;
    
    UIImageView *imagePassword = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_padlogin_Password"]];
    imagePassword.frame = CGRectMake(15, 2, 22, 23);
    UIView *passwordLeftView = [[UIView alloc]init];
    [passwordLeftView addSubview:imagePassword];
    
    txt_Password.leftView = passwordLeftView;
    txt_Password.leftView.frame = CGRectMake(0, 0, 45, 25);
    txt_Password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txt_Password.leftView.contentMode = UIControlContentVerticalAlignmentCenter;
    txt_Password.leftViewMode = UITextFieldViewModeAlways;

    [self.view addSubview:txt_UserName];
    [self.view addSubview:txt_Password];
    
    //登录
    UIButton *btn_login = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_login.frame = CGRectMake(43.0f , 220.0f, 365.0f, 50.5f);
    btn_login.tag = TAG_LOGIN;
    [btn_login setImage:[UIImage imageNamed:@"btn_padlogin_login"] forState:UIControlStateNormal];
    [btn_login setImage:[UIImage imageNamed:@"btn_padlogin_login_on"] forState:UIControlStateHighlighted];
    [btn_login addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn_login];
    
    //其它登录提示
    UIImageView *img_Other = [[UIImageView alloc] initWithFrame:CGRectMake(43.0f, 310.0f, 365.0f, 3.5f)];
    img_Other.image = [UIImage imageNamed:@"icon_padlogin_live"];
    [self.view addSubview:img_Other];
    
    UILabel *lab_OtherText = [[UILabel alloc] initWithFrame:CGRectMake(145.f, -5.0f, 100.0f, 13.0f)];
    lab_OtherText.text = LocalizedString(@"LoginViewController_labFaceBook",@"其它登录方式");
    lab_OtherText.font = DEFAULT_FONT(12.0f);
    lab_OtherText.textColor = [PanliHelper colorWithHexString:@"#b4939f"];
    lab_OtherText.backgroundColor = PL_COLOR_CLEAR;
    [img_Other addSubview:lab_OtherText];
    
    //注册
    UIImageView *img_Bottom = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, VIEW_DEFAULT_HEIGHT - 73.0f - 75.0f, VIEW_DEFAULT_WIDTH + 1, 73.0f)];
    img_Bottom.image = [UIImage imageNamed:@"bg_padlogin_Bottom"];
    [self.view addSubview:img_Bottom];
    
    UIView *view_Bottom = [[UIView alloc] initWithFrame:CGRectMake(0.0f, VIEW_DEFAULT_HEIGHT - 75.0f, VIEW_DEFAULT_WIDTH + 1, 78.0f)];
    view_Bottom.backgroundColor = [PanliHelper colorWithHexString:@"#dfdfdf"];
    [self.view addSubview:view_Bottom];
    
    UIButton *btn_Register = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Register.frame = CGRectMake(43.0f , VIEW_DEFAULT_HEIGHT - 20.0f - 40.5f, 365.0f, 40.5f);
    btn_Register.tag = TAG_REGISTER;
    [btn_Register setImage:[UIImage imageNamed:@"btn_padlogin_register"] forState:UIControlStateNormal];
    [btn_Register setImage:[UIImage imageNamed:@"btn_padlogin_register_on"] forState:UIControlStateHighlighted];
    [btn_Register addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn_Register];

    //登录请求通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginResponse:)
                                                 name:RQNAME_USERLOGIN
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - login
- (void)loginClick
{
    [self.view endEditing:YES];
    NSString *str_username = [txt_UserName text];
    NSString *str_password = [txt_Password text];
    
    if ([NSString isEmpty:str_username] && [NSString isEmpty:str_username])
    {
        [self showHUDErrorMessage:LocalizedString(@"LoginViewController_HUDErrMsg1",@"请输入用户名和密码")];
        return;
    }
    else if ([NSString isEmpty:str_username])
    {
        
        [self showHUDErrorMessage:LocalizedString(@"LoginViewController_HUDErrMsg2",@"请输入用户名")];
        return;
    }
    else if ([NSString isEmpty:str_password])
    {
        
        [self showHUDErrorMessage:LocalizedString(@"LoginViewController_HUDErrMsg3",@"请输入密码")];
        return;
    }
    str_password = [str_password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSError *error = nil;
    NSString *encryptPw = [RSAManager encryptToString:str_password error:&error];
    if (error != nil)
    {
        [self showHUDErrorMessage:LocalizedString(@"LoginViewController_HUDErrMsg4",@"密码加密失败，请重试或反馈")];
        return;
    }
    
    [self showHUDIndicatorMessage:LocalizedString(@"LoginViewController_HUDIndMsg2",@"正在验证...")];
    //请求参数
    NSMutableDictionary *mDic_Params = [[NSMutableDictionary alloc] init];
    [mDic_Params setValue:str_username forKey:RQ_LOGIN_PARAM_USERNAME];
    [mDic_Params setValue:encryptPw forKey:RQ_LOGIN_PARAM_PASSWORD];
    [mDic_Params setValue:[NSUserDefaults getObjectForKey:@"deviceToken"] forKey:RQ_LOGIN_PARAM_DEVICETOKEN];
    
    req_LoginRequest = req_LoginRequest ? req_LoginRequest : [[LoginRequest alloc] init];
    rpt_Login = rpt_Login ? rpt_Login : [[DataRepeater alloc] initWithName:RQNAME_USERLOGIN];
    rpt_Login.requestParameters = mDic_Params;
    rpt_Login.notificationName = RQNAME_USERLOGIN;
    __weak LoginViewController *loginVC = self;
    rpt_Login.compleBlock = ^(id repeater)
    {
        [loginVC loginResponse:repeater];
    };
    rpt_Login.requestModal = PushData;
    rpt_Login.networkRequest = req_LoginRequest;
    [[DataRequestManager sharedInstance] sendRequest:rpt_Login];
}
/**
 *登录返回响应
 */
- (void)loginResponse:(DataRepeater *)repeater
{
    
    if (repeater.isResponseSuccess)
    {
        [self hideHUD];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NAME_LOGIN object:nil];
        [self.popOverController dismissPopoverAnimated:YES];
    }
    else
    {
        if (repeater.errorInfo.code == USER_UNACTIVE)
        {
            [self hideHUD];
            [self showHUDErrorMessage:LocalizedString(@"LoginViewController_HUDErrMsg5",@"账户未激活")];
//            ActiveViewController *activeViewController = [[[ActiveViewController alloc] init] autorelease];
//            activeViewController.emailSite = repeater.responseValue;
//            [self.navigationController pushViewController:activeViewController animated:YES];
        }
        else
        {
            [self showHUDErrorMessage:repeater.errorInfo.message];
        }
    }
}
#pragma mark - btnClick
- (void)loginBtnClick:(UIButton*)btn
{
    switch (btn.tag)
    {
        case TAG_CANCEL:
        {
            [self.popOverController dismissPopoverAnimated:YES];
            break;
        }
        case TAG_LOGIN:
        {
            [self loginClick];
            break;
        }
        case TAG_FACEBOOK:
        {
            break;
        }
        case TAG_REGISTER:
        {
            break;
        }
        default:
            break;
    }
}
#pragma mark - UITextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //点击了return
    if ([string isEqualToString:@"\n"])
    {
        if (textField.tag == 1000)
        {
            [textField resignFirstResponder];
            [txt_Password becomeFirstResponder];
        }
        else if (textField.tag == 1001)
        {
            [textField resignFirstResponder];
        }
        return NO;
    }
    //输入了空格
    if ([string isEqualToString:@" "])
    {
        return NO;
    }
    return YES;
}
@end
