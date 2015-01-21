//
//  ChangePasswordViewController.h
//  PanliBuyHD
//
//  Created by ZhaoFucheng on 14-10-29.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "BaseViewController.h"
#import "ModifyPasswordRequest.h"

@interface ChangePasswordViewController : BaseViewController
{
    ModifyPasswordRequest *req_ModifyPW;
    DataRepeater *rpt_ModifyPW;
    BOOL isDisPasswordFlag;
}
@property (weak, nonatomic) IBOutlet UITextField *txt_CurrentPassword;
@property (weak, nonatomic) IBOutlet UITextField *txt_NewPassword;
@property (weak, nonatomic) IBOutlet UIButton *btn_Submit;
- (IBAction)submitClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *lab_CurrentPassword;
@property (weak, nonatomic) IBOutlet UILabel *lab_NewPassword;
@property (weak, nonatomic) IBOutlet UILabel *lab_explain;

@property (nonatomic, retain) NSString *str_CurrentPW;
@property (nonatomic, retain) NSString *str_CurrentPWWarning;

@property (nonatomic, retain) NSString *str_NewPW;
@property (nonatomic, retain) NSString *str_NewPWWarning;
- (IBAction)isDisplayPassword:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *lab_IsDisplay;

@end
