//
//  LoginViewController.h
//  PanliBuyHD
//
//  Created by jason on 14-6-18.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginRequest.h"

@interface LoginViewController : BaseViewController<UITextFieldDelegate>
{
    UITextField *txt_UserName;
    UITextField *txt_Password;
    LoginRequest *req_LoginRequest;
    DataRepeater *rpt_Login;
}
@property (nonatomic, strong) UIPopoverController * popOverController;
@end
