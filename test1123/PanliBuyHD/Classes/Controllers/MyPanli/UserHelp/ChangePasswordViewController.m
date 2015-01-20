//
//  ChangePasswordViewController.m
//  PanliBuyHD
//
//  Created by ZhaoFucheng on 14-10-29.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "RSAManager.h"
#import "DataRequestManager.h"
#import "CMPopTipView.h"

#define FRAME_LEFTVIEW      CGRectMake(0.0f, 0.0f, 8.0f, 37.0f)
#define FRAME_RIGHTVIEW     CGRectMake(260.0f, 0.0f, 30.0f, 48.0f)
#define FRAME_RIGHTSUBVIEW  CGRectMake(0.0f, 12.0f, 25.0f, 25.0f)

typedef enum
{
    Editing = 0,
    Checking = 1,
    CheckSuccess = 2,
    CheckError = 3,
} textStatus;

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

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
    
    self.navigationItem.title = LocalizedString(@"ChangePasswordViewController_Nav_Title",@"修改登录密码");
    self.view.backgroundColor = [PanliHelper colorWithHexString:@"#f2f2f2"];
    
    self.lab_CurrentPassword.text = LocalizedString(@"ChangePasswordViewController_labCurrentPassword",@"当前密码:");
    
    self.txt_CurrentPassword.layer.cornerRadius = 6.0f;
    self.txt_CurrentPassword.layer.masksToBounds = YES;
    self.txt_CurrentPassword.layer.borderColor = [PanliHelper colorWithHexString:@"#cecece"].CGColor;
    self.txt_CurrentPassword.layer.borderWidth = 1.2f;
    
    self.txt_CurrentPassword.leftView = [[UIView alloc] init];
    self.txt_CurrentPassword.leftView.frame = FRAME_LEFTVIEW;
    self.txt_CurrentPassword.leftView.contentMode = UIControlContentVerticalAlignmentCenter;
    self.txt_CurrentPassword.leftViewMode = UITextFieldViewModeAlways;
    
    self.lab_NewPassword.text = LocalizedString(@"ChangePasswordViewController_labNewPassword",@"新密码:");
    
    self.txt_NewPassword.layer.cornerRadius = 6.0f;
    self.txt_NewPassword.layer.masksToBounds = YES;
    self.txt_NewPassword.layer.borderColor = [PanliHelper colorWithHexString:@"#cecece"].CGColor;
    self.txt_NewPassword.layer.borderWidth = 1.2f;
    
    self.txt_NewPassword.leftView = [[UIView alloc] init];
    self.txt_NewPassword.leftView.frame = FRAME_LEFTVIEW;
    self.txt_NewPassword.leftView.contentMode = UIControlContentVerticalAlignmentCenter;
    self.txt_NewPassword.leftViewMode = UITextFieldViewModeAlways;
    
    self.lab_explain.text = LocalizedString(@"ChangePasswordViewController_labExplain",@"密码由6-20位大小写英文字母、数字组成");
    
    self.lab_IsDisplay.text = LocalizedString(@"ChangePasswordViewController_labIsDisplay",@"显示密码");
    
    //点击屏幕隐藏键盘
    UITapGestureRecognizer *gestureRecongizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    gestureRecongizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:gestureRecongizer];
    
    isDisPasswordFlag = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - hidekeyboard
- (void)hideKeyboard:(UITapGestureRecognizer*)gestureRecongizer
{
    [self.txt_CurrentPassword resignFirstResponder];
    [self.txt_NewPassword resignFirstResponder];
}

- (IBAction)submitClick:(UIButton *)sender {
    NSString *str_current = [self.txt_CurrentPassword text];
    NSString *str_new = [self.txt_NewPassword text];
    
    if ([NSString isEmpty:str_current] && [NSString isEmpty:str_new])
    {
        [self showHUDErrorMessage:LocalizedString(@"ChangePasswordViewController_HUDErrMsg1",@"请输入用当前密码和新密码")];
        return;
    }
    else if ([NSString isEmpty:str_current])
    {
        
        [self showHUDErrorMessage:LocalizedString(@"ChangePasswordViewController_HUDErrMsg2",@"请输入当前密码")];
        return;
    }
    else if ([NSString isEmpty:str_new])
    {
        
        [self showHUDErrorMessage:LocalizedString(@"ChangePasswordViewController_HUDErrMsg3",@"请输入新密码")];
        return;
    }
    
    if([str_current isEqualToString:str_new])
    {
        [self showHUDErrorMessage:LocalizedString(@"ChangePasswordViewController_HUDErrMsg4",@"当前密码与新密码相同，请修改")];
        return;
    }
    
    
    //当前密码加密
    str_current = [str_current stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSError *error_current = nil;
    NSString *encrypt_CurrentPw = [RSAManager encryptToString:str_current error:&error_current];
    if (error_current != nil)
    {
        [self showHUDErrorMessage:LocalizedString(@"ChangePasswordViewController_HUDErrMsg5",@"密码加密失败，请重试或反馈")];
        return;
    }
    //新密码加密
    str_new = [str_new stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSError *error_new = nil;
    NSString *encrypt_NewPw = [RSAManager encryptToString:str_new error:&error_new];
    if (error_new != nil)
    {
        [self showHUDErrorMessage:LocalizedString(@"ChangePasswordViewController_HUDErrMsg6",@"密码加密失败，请重试或反馈")];
        return;
    }
    self.view.userInteractionEnabled = NO;
    [self showHUDIndicatorMessage:LocalizedString(@"ChangePasswordViewController_HUDIndMsg",@"正在验证密码...")];
    req_ModifyPW = req_ModifyPW ? req_ModifyPW : [[ModifyPasswordRequest alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    [params setValue:encrypt_CurrentPw forKey:RQ_USER_MODIFYPASSWORD_PARM_OLDPASSWORD];
    [params setValue:encrypt_NewPw forKey:RQ_USER_MODIFYPASSWORD_PARM_NEWPASSWORD];
    
    rpt_ModifyPW = rpt_ModifyPW ? rpt_ModifyPW : [[DataRepeater alloc]initWithName:RQNAME_USER_MODIFYPASSWORD];
    rpt_ModifyPW.isAuth = YES;
    rpt_ModifyPW.requestModal = PushData;
    rpt_ModifyPW.requestParameters = params;
    rpt_ModifyPW.networkRequest = req_ModifyPW;
    __weak __typeof(self) weakSelf = self;
    rpt_ModifyPW.compleBlock = ^(id repeater){
        [weakSelf modifyPasswordResponse:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:rpt_ModifyPW];
}

#pragma mark - response
- (void)modifyPasswordResponse:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        [self showHUDSuccessMessage:LocalizedString(@"ChangePasswordViewController_HUDSucMsg",@"修改密码成功!")];
        [self.HUD showAnimated:YES whileExecutingBlock:^{
            sleep(1.8);
        } completionBlock:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    }
    else
    {
        [self showHUDErrorMessage:repeater.errorInfo.message];
    }
    self.view.userInteractionEnabled = YES;
}

- (void)setRightView:(UITextField *)textField status:(textStatus)status
{
    switch (status)
    {
        case Editing:
        {
            textField.rightView = nil;
            self.btn_Submit.enabled = NO;
            break;
        }
        case Checking:
        {
            //            UIView *rightView = [[UIView alloc] init];
            //            UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            //            activityIndicatorView.frame = FRAME_RIGHTSUBVIEW;
            //            [activityIndicatorView startAnimating];
            //            [rightView addSubview:activityIndicatorView];
            //            textField.rightView = rightView;
            //            textField.rightView.frame = FRAME_RIGHTVIEW;
            //            textField.rightView.contentMode = UIControlContentVerticalAlignmentCenter;
            //            textField.rightViewMode = UITextFieldViewModeAlways;
            //            [rightView release];
            //            [activityIndicatorView release];
            
            if (textField == self.txt_CurrentPassword)
            {
                self.str_CurrentPWWarning = @"success";
                [self setRightView:self.txt_CurrentPassword status:CheckSuccess];
                //                [self performSelector:@selector(emailCheckRequest) withObject:nil afterDelay:1.0f];
            }
            else
            {
                self.str_NewPWWarning = @"success";
                [self setRightView:self.txt_NewPassword status:CheckSuccess];
                //                [self performSelector:@selector(userNameCheckRequest) withObject:nil afterDelay:1.0f];
            }
            break;
        }
        case CheckSuccess:
        {
            if (textField == self.txt_NewPassword)
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
            }
            else
            {
                textField.rightView = nil;
            }
            break;
        }
        case CheckError:
        {
            
            UIButton *btn_warning = [UIButton buttonWithType:UIButtonTypeCustom];
            if (textField == self.txt_CurrentPassword)
            {
                btn_warning.tag = 1001;
                textField.rightView = nil;
            }
            else if (textField == self.txt_NewPassword)
            {
                UIView *rightView = [[UIView alloc] init];
                btn_warning.frame = FRAME_RIGHTSUBVIEW;
                [btn_warning setBackgroundImage:[UIImage imageNamed:@"icon_regist_checkError"] forState:UIControlStateNormal];
                [btn_warning addTarget:self action:@selector(showWarningMessage:) forControlEvents:UIControlEventTouchUpInside];
                [rightView addSubview:btn_warning];
                textField.rightView = rightView;
                textField.rightView.frame = FRAME_RIGHTVIEW;
                textField.rightView.contentMode = UIControlContentVerticalAlignmentCenter;
                textField.rightViewMode = UITextFieldViewModeAlways;
                
                btn_warning.tag = 1002;
                self.btn_Submit.enabled = NO;
            }
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
        message = self.str_CurrentPWWarning;
    }
    else
    {
        message = self.str_NewPWWarning;
    }
    
    CMPopTipView *warningView = [[CMPopTipView alloc] initWithMessage:message];
    warningView.backgroundColor = [UIColor blackColor];
    warningView.textColor = [UIColor whiteColor];
    //popTipView.disableTapToDismiss = YES;
    //popTipView.preferredPointDirection = PointDirectionUp;
    warningView.animation = arc4random() % 2;
    warningView.dismissTapAnywhere = YES;
    [warningView autoDismissAnimated:YES atTimeInterval:3.0];
    [warningView presentPointingAtView:button inView:self.view animated:YES];
    
    if (button.tag == 1001)
    {
        [self.txt_CurrentPassword becomeFirstResponder];
    }
    else
    {
        [self.txt_NewPassword becomeFirstResponder];
    }
}

#pragma mark - UITexField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.txt_CurrentPassword)
    {
        [self setRightView:self.txt_CurrentPassword status:Editing];
    }
    else if (textField == self.txt_NewPassword)
    {
        [self setRightView:self.txt_NewPassword status:Editing];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.txt_CurrentPassword)
    {
        //        if([NSString isEmpty:txt_CurrentPassword.text])
        //        {
        //            self.str_CurrentPWWarning = @"当前密码为空";
        //            [self setRightView:txt_CurrentPassword status:CheckError];
        //            return;
        //        }
        //        NSString *pwd = txt_CurrentPassword.text;
        //        NSString *regex = @"^[A-Za-z0-9]{6,20}$";
        //        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        //        BOOL isMatch = [predicate evaluateWithObject:pwd];
        //        if (!isMatch)
        //        {
        //            self.str_CurrentPWWarning = @"当前密码格式错误";
        //            [self setRightView:txt_CurrentPassword status:CheckError];
        //        }
        //        else
        //        {
        //            if (![NSString isEmpty:txt_CurrentPassword.text] && ![self.str_CurrentPW isEqualToString:txt_CurrentPassword.text])
        //            {
        //                [self setRightView:txt_CurrentPassword status:Checking];
        //            }
        //            else if (![NSString isEmpty:txt_CurrentPassword.text] && [self.str_CurrentPW isEqualToString:txt_CurrentPassword.text])
        //            {
        //                if (![self.str_CurrentPWWarning isEqualToString:@"success"])
        //                {
        //                    [self setRightView:txt_CurrentPassword status:CheckError];
        //                }
        //                else
        //                {
        //                    [self setRightView:txt_CurrentPassword status:CheckSuccess];
        //                }
        //            }
        //            else
        //            {
        //                [self setRightView:txt_CurrentPassword status:Editing];
        //            }
        //        }
        self.str_CurrentPW = self.txt_CurrentPassword.text;
    }
    else
    {
        if([NSString isEmpty:self.txt_NewPassword.text])
        {
            self.str_NewPWWarning = LocalizedString(@"ChangePasswordViewController_strNewPWWarning1",@"新密码为空");
            [self setRightView:self.txt_NewPassword status:CheckError];
            return;
        }
        NSString *pwd = self.txt_NewPassword.text;
        NSString *regex = @"^[A-Za-z0-9]{6,20}$";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [predicate evaluateWithObject:pwd];
        if (!isMatch)
        {
            self.str_NewPWWarning = LocalizedString(@"ChangePasswordViewController_strNewPWWarning2",@"新密码格式错误");
            [self setRightView:self.txt_NewPassword status:CheckError];
        }
        else
        {
            if (![NSString isEmpty:self.txt_NewPassword.text] && ![self.str_NewPW isEqualToString:self.txt_NewPassword.text])
            {
                [self setRightView:self.txt_NewPassword status:Checking];
            }
            else if (![NSString isEmpty:self.txt_NewPassword.text] && [self.str_NewPW isEqualToString:self.txt_NewPassword.text])
            {
                if (![self.str_NewPWWarning isEqualToString:@"success"])
                {
                    [self setRightView:self.txt_NewPassword status:CheckError];
                }
                else
                {
                    [self setRightView:self.txt_NewPassword status:CheckSuccess];
                }
            }
            else
            {
                [self setRightView:self.txt_NewPassword status:Editing];
            }
        }
        self.str_NewPW = self.txt_NewPassword.text;
    }
    
    if ([self.str_NewPWWarning isEqualToString:@"success"])
    {
        self.btn_Submit.enabled = YES;
    }
    else
    {
        self.btn_Submit.enabled = NO;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //点击了return
    if ([string isEqualToString:@"\n"])
    {
        if (textField == self.txt_CurrentPassword)
        {
            [textField resignFirstResponder];
            [self.txt_NewPassword becomeFirstResponder];
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

- (IBAction)isDisplayPassword:(UIButton *)sender {
    if(isDisPasswordFlag)
    {
        [sender setImage:[UIImage imageNamed:@"btn_UH_IsDisplayPassword"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"btn_UH_IsDisplayPassword_on"] forState:UIControlStateHighlighted];
        self.txt_NewPassword.secureTextEntry = YES;
        self.txt_CurrentPassword.secureTextEntry = YES;
        isDisPasswordFlag = NO;
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"btn_UH_IsDisplayPassword_on"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"btn_UH_IsDisplayPassword"] forState:UIControlStateHighlighted];
        self.txt_NewPassword.secureTextEntry = NO;
        self.txt_CurrentPassword.secureTextEntry = NO;
        isDisPasswordFlag = YES;
    }
}
@end
