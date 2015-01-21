//
//  RegistViewController.m
//  PanliApp
//
//  Created by Liubin on 13-7-16.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "RegistViewController.h"
#import "RegistResponseViewController.h"
#import "DataRequestManager.h"

typedef enum
{
    Editing = 0,
    Checking = 1,
    CheckSuccess = 2,
    CheckError = 3,
    ShowPwd = 4,
    HidePwd = 5
    
} textStatus;

#define FRAME_LEFTVIEW      CGRectMake(0.0f, 0.0f, 8.0f, 48.0f)
#define FRAME_RIGHTVIEW     CGRectMake(260.0f, 0.0f, 30.0f, 48.0f)
#define FRAME_RIGHTSUBVIEW  CGRectMake(0.0f, 12.0f, 25.0f, 25.0f)

#define ANIMOTIONTIME 4.0



@implementation RegistViewController

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_str_Email);
    SAFE_RELEASE(_str_EmailWarning);
    SAFE_RELEASE(_str_UserName);
    SAFE_RELEASE(_str_UserNameWarning);
    SAFE_RELEASE(_str_PasswordWarning);
    SAFE_RELEASE(req_CheckEmailRequest);
    SAFE_RELEASE(rpt_CheckEmail);
    SAFE_RELEASE(req_CheckUserNameRequest);
    SAFE_RELEASE(rpt_CheckUserName);
    SAFE_RELEASE(req_RegisterRequest);
    SAFE_RELEASE(rpt_Register);
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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController setNavigationBarHidden:NO];
    //LocalizedString(@"RegistViewController_Nav_Title",
	self.navigationItem.title = LocalizedString(@"RegistViewController_Nav_Title",@"注册Panli会员");
    self.view.backgroundColor = [PanliHelper colorWithHexString:@"#ededed"];
    
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 20.0f, 320, 320 - UI_NAVIGATION_BAR_HEIGHT)];
    mainScrollView.contentSize = CGSizeMake(MainScreenFrame_Width, 320 - UI_NAVIGATION_BAR_HEIGHT + 50);
    mainScrollView.backgroundColor = PL_COLOR_CLEAR;
    mainScrollView.scrollEnabled = NO;
    [self.view addSubview:mainScrollView];
    [mainScrollView release];

    txt_Email = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 20.0f, 320.0f, 50.0f)];
    txt_Email.borderStyle = UITextBorderStyleNone;
    txt_Email.backgroundColor = PL_COLOR_WHITE;
    txt_Email.font = DEFAULT_FONT(15);
    txt_Email.textColor = PL_COLOR_BLACK;
    txt_Email.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //LocalizedString(@"RegistViewController_txtEmail",
    txt_Email.placeholder = LocalizedString(@"RegistViewController_txtEmail",@"请填写常用邮箱");
    txt_Email.delegate = self;
    txt_Email.keyboardType = UIKeyboardTypeEmailAddress;
    txt_Email.returnKeyType = UIReturnKeyNext;
    txt_Email.keyboardAppearance = UIKeyboardAppearanceDefault;
    txt_Email.autocapitalizationType = UITextAutocapitalizationTypeNone;
    txt_Email.clearButtonMode = UITextFieldViewModeWhileEditing;
    txt_Email.leftView = [[[UIView alloc] init] autorelease];
    txt_Email.leftView.frame = FRAME_LEFTVIEW;
    txt_Email.leftView.contentMode = UIControlContentVerticalAlignmentCenter;
    txt_Email.leftViewMode = UITextFieldViewModeAlways;
    [mainScrollView addSubview:txt_Email];
    [txt_Email release];
    
    UIView *emailLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 0.5f)];
    emailLine.backgroundColor = [PanliHelper colorWithHexString:@"#c8c8cb"];
    [txt_Email addSubview:emailLine];
    [emailLine release];

    //用户名
    txt_UserName = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 68.0f, 320.0f, 50.0f)];
    txt_UserName.borderStyle = UITextBorderStyleNone;
    txt_UserName.backgroundColor = PL_COLOR_WHITE;
    txt_UserName.font = DEFAULT_FONT(15);
    txt_UserName.textColor = PL_COLOR_GRAY;
    txt_UserName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //LocalizedString(@"RegistViewController_txtUserName",
    txt_UserName.placeholder = LocalizedString(@"RegistViewController_txtUserName",@"请填写您的用户名");
    txt_UserName.delegate = self;
    txt_UserName.returnKeyType = UIReturnKeyNext;
    txt_UserName.keyboardAppearance = UIKeyboardAppearanceDefault;
    txt_UserName.autocapitalizationType = UITextAutocapitalizationTypeNone;
    txt_UserName.clearButtonMode = UITextFieldViewModeWhileEditing;
    txt_UserName.leftView = [[[UIView alloc] init] autorelease];
    txt_UserName.leftView.frame = FRAME_LEFTVIEW;
    txt_UserName.leftView.contentMode = UIControlContentVerticalAlignmentCenter;
    txt_UserName.leftViewMode = UITextFieldViewModeAlways;
    [mainScrollView addSubview:txt_UserName];
    [txt_UserName release];
    
    UIView *nameLine = [[UIView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 310.0f, 0.5f)];
    nameLine.backgroundColor = [PanliHelper colorWithHexString:@"#c8c8cb"];
    [txt_UserName addSubview:nameLine];
    [nameLine release];
    
    //密码
    txt_Password = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 116.0f, 320.0f, 50.0f)];
    txt_Password.borderStyle = UITextBorderStyleNone;
    txt_Password.backgroundColor = PL_COLOR_WHITE;
    txt_Password.font = DEFAULT_FONT(15);
    txt_Password.textColor = PL_COLOR_GRAY;
    txt_Password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //LocalizedString(@"RegistViewController_txtPassword",
    txt_Password.placeholder = LocalizedString(@"RegistViewController_txtPassword",@"密码为6-20个字母或数字组成");
    txt_Password.delegate = self;
    txt_Password.returnKeyType = UIReturnKeyDone;
    txt_Password.keyboardAppearance = UIKeyboardAppearanceDefault;
    txt_Password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    txt_Password.leftView = [[[UIView alloc] init] autorelease];
    txt_Password.leftView.frame = FRAME_LEFTVIEW;
    txt_Password.leftView.contentMode = UIControlContentVerticalAlignmentCenter;
    txt_Password.leftViewMode = UITextFieldViewModeAlways;
    [self setRightView:txt_Password status:HidePwd];
    [mainScrollView addSubview:txt_Password];
    [txt_Password release];
    
    UIView *pwdLineTop = [[UIView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 310.0f, 0.5f)];
    pwdLineTop.backgroundColor = [PanliHelper colorWithHexString:@"#c8c8cb"];
    [txt_Password addSubview:pwdLineTop];
    [pwdLineTop release];
    
    UIView *pwdLineBottom = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 49.5f, 320.0f, 0.5f)];
    pwdLineBottom.backgroundColor = [PanliHelper colorWithHexString:@"#c8c8cb"];
    [txt_Password addSubview:pwdLineBottom];
    [pwdLineBottom release];
    
    //按钮
    UIButton *btn_Reg = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_Reg setFrame:CGRectMake(10.0f, 200.0f, 300.0f, 45.0f)];
    [btn_Reg setImage:[UIImage imageNamed:@"btn_regist_submit"] forState:UIControlStateNormal];
    [btn_Reg setImage:[UIImage imageNamed:@"btn_regist_submit_on"] forState:UIControlStateHighlighted];
    [btn_Reg addTarget:self action:@selector(regiterClick) forControlEvents:UIControlEventTouchUpInside];
    [mainScrollView addSubview:btn_Reg];
    
    //为view添加tap手势响应（隐藏键盘）
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:gestureRecognizer];
    [gestureRecognizer release];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)regiterClick
{
    [self.view endEditing:YES];
    if ([NSString isEmpty:txt_Email.text])
    {
        //LocalizedString(@"RegistViewController_HUDErrMsg1"
        [self showHUDErrorMessage:LocalizedString(@"RegistViewController_HUDErrMsg1",@"请填写您的常用邮箱")];
        
        return;
    }
    else if ([NSString isEmpty:txt_UserName.text])
    {
        //LocalizedString(@"RegistViewController_HUDErrMsg2",
        [self showHUDErrorMessage:LocalizedString(@"RegistViewController_HUDErrMsg2",@"请填写用户名")];
        return;
    }
    else if ([NSString isEmpty:txt_Password.text])
    {
        //LocalizedString(@"RegistViewController_HUDErrMsg3",
        [self showHUDErrorMessage:LocalizedString(@"RegistViewController_HUDErrMsg3",@"请输入密码")];
        return;
    }
    else if (![self.str_EmailWarning isEqualToString:@"success"])
    {
        [self showHUDErrorMessage:self.str_EmailWarning];
        return;
    }
    else if (![self.str_UserNameWarning isEqualToString:@"success"])
    {
        [self showHUDErrorMessage:self.str_UserNameWarning];
        return;
    }
    
    //密码合法性check
    NSString *regex = @"^[A-Za-z0-9]{6,20}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [predicate evaluateWithObject:txt_Password.text];
    
    if (!isMatch)
    {
        //LocalizedString(@"RegistViewController_HUDErrMsg4",
        [self showHUDErrorMessage:LocalizedString(@"RegistViewController_HUDErrMsg4",@"密码必须为6-20位的数字或字母")];
        return;
    }

    [self registerRequest];
}

#pragma mark - request and response
/**
 *验证邮箱
 */
- (void)emailCheckRequest
{
    txt_Email.userInteractionEnabled = NO;
    //请求参数
    NSMutableDictionary *mDic_Params = [[NSMutableDictionary alloc] init];
    [mDic_Params setValue:txt_Email.text forKey:RQ_REGISTER_PARM_EMAIL];
    [mDic_Params setValue:@"e" forKey:RQ_REGISTER_PARM_WHICHONE];
    
    req_CheckEmailRequest = req_CheckEmailRequest ? req_CheckEmailRequest : [[RegisterRequest alloc] init];
    rpt_CheckEmail = rpt_CheckEmail ? rpt_CheckEmail : [[DataRepeater alloc] initWithName:RQNAME_REGISTER_CHECKEMAIL]; 
    rpt_CheckEmail.requestParameters = mDic_Params;
    __block RegistViewController *registerView = self;
    rpt_CheckEmail.compleBlock = ^(id repeater){
        [registerView emailCheckResponse:repeater];
    };
    rpt_CheckEmail.requestModal = PushData;
    rpt_CheckEmail.networkRequest = req_CheckEmailRequest;
    [mDic_Params release];
    [[DataRequestManager sharedInstance] sendRequest:rpt_CheckEmail];
}

- (void)emailCheckResponse:(DataRepeater *)repeater
{
    if (repeater.isResponseSuccess)
    {
        self.str_EmailWarning = @"success";
        [self setRightView:txt_Email status:CheckSuccess];
    }
    else
    {
        self.str_EmailWarning = repeater.errorInfo.message;
        [self setRightView:txt_Email status:CheckError];
    }
    txt_Email.userInteractionEnabled = YES;
}

/**
 *验证用户名
 */
- (void)userNameCheckRequest
{
    txt_UserName.userInteractionEnabled = NO;
    //请求参数
    NSMutableDictionary *mDic_Params = [[NSMutableDictionary alloc] init];
    [mDic_Params setValue:txt_UserName.text forKey:RQ_REGISTER_PARM_USERNAME];
    [mDic_Params setValue:@"u" forKey:RQ_REGISTER_PARM_WHICHONE];
    
    req_CheckUserNameRequest = req_CheckUserNameRequest ? req_CheckUserNameRequest : [[RegisterRequest alloc] init];
    rpt_CheckUserName = rpt_CheckUserName ? rpt_CheckUserName : [[DataRepeater alloc] initWithName:RQNAME_REGISTER_CHECKUSERNAME];
    rpt_CheckUserName.requestParameters = mDic_Params;
    __block RegistViewController *registerView = self;
    rpt_CheckUserName.compleBlock = ^(id repeater){
        [registerView userNameCheckResponse:repeater];
    };
    rpt_CheckUserName.requestModal = PushData;
    rpt_CheckUserName.networkRequest = req_CheckUserNameRequest;
    [mDic_Params release];
    [[DataRequestManager sharedInstance] sendRequest:rpt_CheckUserName];
}

- (void)userNameCheckResponse:(DataRepeater *)repeater
{
    if (repeater.isResponseSuccess)
    {
        self.str_UserNameWarning = @"success";
        [self setRightView:txt_UserName status:CheckSuccess];
    }
    else
    {
        self.str_UserNameWarning = repeater.errorInfo.message;
        [self setRightView:txt_UserName status:CheckError];
    }
    txt_UserName.userInteractionEnabled = YES;
}

/**
 *注册
 */
- (void)registerRequest
{
    self.navigationItem.rightBarButtonItem.enabled = NO;
    //LocalizedString(@"RegistViewController_HUDIndMsg",
    [self showHUDIndicatorMessage:LocalizedString(@"RegistViewController_HUDIndMsg",@"正在提交...")];
    //请求参数
    NSMutableDictionary *mDic_Params = [[NSMutableDictionary alloc] init];
    [mDic_Params setValue:txt_Email.text forKey:RQ_REGISTER_PARM_EMAIL];
    [mDic_Params setValue:txt_UserName.text forKey:RQ_REGISTER_PARM_USERNAME];
    [mDic_Params setValue:txt_Password.text forKey:RQ_REGISTER_PARM_PASSWORD];
    
    req_RegisterRequest = req_RegisterRequest ? req_RegisterRequest : [[RegisterRequest alloc] init];
    rpt_Register = rpt_Register ? rpt_Register : [[DataRepeater alloc] initWithName:RQNAME_REGISTER];
    rpt_Register.requestParameters = mDic_Params;
    __block RegistViewController *registerView = self;
    rpt_Register.compleBlock = ^(id repeater){
        [registerView registerResponse:repeater];
    };
    rpt_Register.requestModal = PushData;
    rpt_Register.networkRequest = req_RegisterRequest;
    [mDic_Params release];
    [[DataRequestManager sharedInstance] sendRequest:rpt_Register];
}

- (void)registerResponse:(DataRepeater *)repeater
{
    if (repeater.isResponseSuccess)
    {
        [self hideHUD];
        RegistResponseViewController *registResponseViewController = [[[RegistResponseViewController alloc] init] autorelease];
        registResponseViewController.responseType = 0;
        registResponseViewController.emailSite = repeater.responseValue;
        [self.navigationController pushViewController:registResponseViewController animated:YES];
    }
    else
    {
        [self showHUDErrorMessage:repeater.errorInfo.message];
    }
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

#pragma mark - UITextFiled delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == txt_Email)
    {
        [self setRightView:txt_Email status:Editing];
    }
    else if (textField == txt_UserName)
    {
        [self setRightView:txt_UserName status:Editing];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //邮箱
    if (textField == txt_Email)
    {
        if (![NSString isEmpty:txt_Email.text] && ![self.str_Email isEqualToString:txt_Email.text])
        {
            [self setRightView:txt_Email status:Checking];
        }
        else if (![NSString isEmpty:txt_Email.text] && [self.str_Email isEqualToString:txt_Email.text])
        {
            if (![self.str_EmailWarning isEqualToString:@"success"])
            {
                [self setRightView:txt_Email status:CheckError];
            }
            else
            {
                [self setRightView:txt_Email status:CheckSuccess];
            }
        }
        else
        {
            [self setRightView:txt_Email status:Editing];
        }
        self.str_Email = txt_Email.text;
    }
    //用户名
    else if (textField == txt_UserName)
    {
        if (![NSString isEmpty:txt_UserName.text] && ![self.str_UserName isEqualToString:txt_UserName.text])
        {
            [self setRightView:txt_UserName status:Checking];
        }
        else if (![NSString isEmpty:txt_UserName.text] && [self.str_UserName isEqualToString:txt_UserName.text])
        {
            if (![self.str_UserNameWarning isEqualToString:@"success"])
            {
                [self setRightView:txt_UserName status:CheckError];
            }
            else
            {
                [self setRightView:txt_UserName status:CheckSuccess];
            }
        }
        else
        {
            [self setRightView:txt_UserName status:Editing];
        }
        self.str_UserName = txt_UserName.text;
    }
    //密码
    else if (textField == txt_Password)
    {
        NSString *pwd = txt_Password.text;
        
        NSString *regex = @"^[A-Za-z0-9]{6,20}$";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [predicate evaluateWithObject:pwd];
        
        if (!isMatch)
        {
            //LocalizedString(@"RegistViewController_strPasswordWarning",
            self.str_PasswordWarning = LocalizedString(@"RegistViewController_strPasswordWarning",@"密码必须为6-20位的数字或字母");
            CMPopTipView *warningView = [[[CMPopTipView alloc] initWithMessage:self.str_PasswordWarning] autorelease];
            warningView.backgroundColor = [UIColor blackColor];
            warningView.textColor = [UIColor whiteColor];
            warningView.animation = arc4random() % 2;
            warningView.dismissTapAnywhere = YES;
            [warningView autoDismissAnimated:YES atTimeInterval:3.0];
            [warningView presentPointingAtView:txt_Password.rightView inView:self.view animated:YES];
        }
        else
        {
            self.str_PasswordWarning = nil;
        }
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //点击了return
    if ([string isEqualToString:@"\n"])
    {
        if (textField == txt_Email)
        {
            [textField resignFirstResponder];
            [txt_UserName becomeFirstResponder];
        }
        else if (textField == txt_UserName)
        {
            [textField resignFirstResponder];
            [txt_Password becomeFirstResponder];
        }
        else
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

- (void)hideKeyboard
{
    [self.view endEditing:YES];
}

- (void)setRightView:(UITextField *)textField status:(textStatus)status
{
    switch (status)
    {
        case Editing:
        {
            textField.rightView = nil;
            break;
        }
        case Checking:
        {
            UIView *rightView = [[UIView alloc] init];
            UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            activityIndicatorView.frame = FRAME_RIGHTSUBVIEW;
            [activityIndicatorView startAnimating];
            [rightView addSubview:activityIndicatorView];
            textField.rightView = rightView;
            textField.rightView.frame = FRAME_RIGHTVIEW;
            textField.rightView.contentMode = UIControlContentVerticalAlignmentCenter;
            textField.rightViewMode = UITextFieldViewModeAlways;
            [rightView release];
            [activityIndicatorView release];
            if (textField == txt_Email)
            {
                [self performSelector:@selector(emailCheckRequest) withObject:nil afterDelay:1.0f];
            }
            else
            {
                [self performSelector:@selector(userNameCheckRequest) withObject:nil afterDelay:1.0f];
            }
            break;
        }
        case CheckSuccess:
        {
            UIView *rightView = [[UIView alloc] init];
            UIImageView *imageSuccess = [[UIImageView alloc]init];
            imageSuccess.image = [UIImage imageNamed:@"icon_regist_checkSuccess"];
            imageSuccess.frame = FRAME_RIGHTSUBVIEW;
            [rightView addSubview:imageSuccess];
            textField.rightView = rightView;
            textField.rightView.frame = FRAME_RIGHTVIEW;
            textField.rightView.contentMode = UIControlContentVerticalAlignmentCenter;
            textField.rightViewMode = UITextFieldViewModeAlways;
            [rightView release];
            [imageSuccess release];
            break;
        }
        case CheckError:
        {
            UIView *rightView = [[UIView alloc] init];
            UIButton *btn_warning = [UIButton buttonWithType:UIButtonTypeCustom];
            if (textField == txt_Email)
            {
                btn_warning.tag = 1001;
            }
            else if (textField == txt_UserName)
            {
                btn_warning.tag = 1002;
            }
            btn_warning.frame = FRAME_RIGHTSUBVIEW;
            [btn_warning setBackgroundImage:[UIImage imageNamed:@"icon_regist_checkError"] forState:UIControlStateNormal];
            [btn_warning addTarget:self action:@selector(showWarningMessage:) forControlEvents:UIControlEventTouchUpInside];
            [rightView addSubview:btn_warning];
            textField.rightView = rightView;
            textField.rightView.frame = FRAME_RIGHTVIEW;
            textField.rightView.contentMode = UIControlContentVerticalAlignmentCenter;
            textField.rightViewMode = UITextFieldViewModeAlways;
            [rightView release];
            break;
        }
        case ShowPwd:
        {
            txt_Password.secureTextEntry = NO;
            UIView *rightView = [[UIView alloc] init];
            UIButton *btn_pwd = [UIButton buttonWithType:UIButtonTypeCustom];
            btn_pwd.frame = CGRectMake(0.0f, 9.0f, 50.0f, 30.0f);
            btn_pwd.tag = 999;
            [btn_pwd setBackgroundImage:[UIImage imageNamed:@"btn_regist_hidePwd"] forState:UIControlStateNormal];
            [btn_pwd setBackgroundImage:[UIImage imageNamed:@"btn_regist_hidePwd_on"] forState:UIControlStateHighlighted];
            [btn_pwd addTarget:self action:@selector(changePwdStatus:) forControlEvents:UIControlEventTouchUpInside];
            [rightView addSubview:btn_pwd];
            txt_Password.rightView = rightView;
            txt_Password.rightView.frame = CGRectMake(235.0f, 0.0f, 55.0f, 48.0f);
            txt_Password.rightView.contentMode = UIControlContentVerticalAlignmentCenter;
            txt_Password.rightViewMode = UITextFieldViewModeAlways;
            [rightView release];
            break;
        }
        case HidePwd:
        {
            txt_Password.secureTextEntry = YES;
            UIView *rightView = [[UIView alloc] init];
            UIButton *btn_pwd = [UIButton buttonWithType:UIButtonTypeCustom];
            btn_pwd.frame = CGRectMake(0.0f, 9.0f, 50.0f, 30.0f);
            btn_pwd.tag = 9999;
            [btn_pwd setBackgroundImage:[UIImage imageNamed:@"btn_regist_showPwd"] forState:UIControlStateNormal];
            [btn_pwd setBackgroundImage:[UIImage imageNamed:@"btn_regist_showPwd_on"] forState:UIControlStateHighlighted];
            [btn_pwd addTarget:self action:@selector(changePwdStatus:) forControlEvents:UIControlEventTouchUpInside];
            [rightView addSubview:btn_pwd];
            txt_Password.rightView = rightView;
            txt_Password.rightView.frame = CGRectMake(235.0f, 0.0f, 55.0f, 48.0f);
            txt_Password.rightView.contentMode = UIControlContentVerticalAlignmentCenter;
            txt_Password.rightViewMode = UITextFieldViewModeAlways;
            [rightView release];
            break;
        }
    }
}

/**
 * 功能描述: 弹出警告
 * 输入参数: N/A
 * 返 回 值: N/A
 */
- (void)showWarningMessage:(UIButton *)button
{
    NSString *message;
    if (button.tag == 1001)
    {
        message = self.str_EmailWarning;
    }
    else
    {
        message = self.str_UserNameWarning;
    }
    
    CMPopTipView *warningView = [[[CMPopTipView alloc] initWithMessage:message] autorelease];
    warningView.backgroundColor = PL_COLOR_BLACK;
    warningView.textColor = [UIColor whiteColor];
    //popTipView.disableTapToDismiss = YES;
    //popTipView.preferredPointDirection = PointDirectionUp;
    warningView.animation = arc4random() % 2;
    warningView.dismissTapAnywhere = YES;
    [warningView autoDismissAnimated:YES atTimeInterval:3.0];
    [warningView presentPointingAtView:button inView:self.view animated:YES];
    
    if (button.tag == 1001)
    {
        [txt_Email becomeFirstResponder];
    }
    else
    {
        [txt_UserName becomeFirstResponder];
    }
}

- (void)changePwdStatus:(UIButton *)button
{
    if (button.tag == 999)
    {
        [self setRightView:txt_Password status:HidePwd];
    }
    else
    {
        [self setRightView:txt_Password status:ShowPwd];
    }
}

#pragma mark - keyboard event
- (void)keyboardDidShow
{
    mainScrollView.scrollEnabled = YES;
}

- (void)keyboardDidHide
{
    [mainScrollView setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
    mainScrollView.scrollEnabled = NO;
}

@end


