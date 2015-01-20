//
//  RegistViewController.h
//  PanliApp
//
//  Created by Liubin on 13-7-16.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

/**************************************************
 * 内容描述: 用户注册
 * 创 建 人: 刘彬
 * 创建日期: 2013-07-16
 **************************************************/
#import <UIKit/UIKit.h>
#import "RegisterRequest.h"
#import "DataRepeater.h"
#import "CMPopTipView.h"
#import "BaseViewController.h"


/**************************************************
 * 内容描述: 注册
 * 创 建 人: 刘彬
 * 创建日期: 2013-07-16
 **************************************************/
@interface RegistViewController : BaseViewController<UITextFieldDelegate>
{
    UIScrollView *mainScrollView;
    UITextField *txt_Email;
    UITextField *txt_UserName;
    UITextField *txt_Password;
    
    DataRepeater *rpt_CheckEmail;
    RegisterRequest *req_CheckEmailRequest;
    
    DataRepeater *rpt_CheckUserName;
    RegisterRequest *req_CheckUserNameRequest;
    
    DataRepeater *rpt_Register;
    RegisterRequest *req_RegisterRequest;
}

@property (nonatomic, retain) NSString *str_Email;
@property (nonatomic, retain) NSString *str_EmailWarning;

@property (nonatomic, retain) NSString *str_UserName;
@property (nonatomic, retain) NSString *str_UserNameWarning;

@property (nonatomic, retain) NSString *str_PasswordWarning;

@end
