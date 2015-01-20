//
//  MyPanliRMBViewController.m
//  PanliBuyHD
//
//  Created by guo on 14-10-21.
//  Copyright (c) 2014年 Panli. All rights reserved.
//
#define TAG_RECHARGE     1017
#define TAG_EXPENDITURE  1018

#import "MyPanliRMBViewController.h"
#import "CustomUIImageView.h"
#import "UserInfo.h"
#import "RechargeViewController.h"
#import "ExpenditureViewController.h"

@interface MyPanliRMBViewController ()

@end

@implementation MyPanliRMBViewController

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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationController.navigationBar.backgroundColor = [PanliHelper colorWithHexString:@"#e9ecec"];
    self.view.backgroundColor = [PanliHelper colorWithHexString:@"#e9ecec"];
    self.navigationItem.title = LocalizedString(@"MyPanliRMBViewController_Nav_Title",@"Panli RMB账户");
    
    //获取用户信息
    UserInfo * dic_User = [GlobalObj getUserInfo];
    
    //用户头像
    CustomUIImageView *img_User_Head = [[CustomUIImageView alloc] initWithFrame:CGRectMake(17.0f+(MainScreenFrame_Height-320*1.2)/2, 28.0f, 75*1.2, 75*1.2)];
    UserInfo *userInfo = [GlobalObj getUserInfo];
    [img_User_Head setCustomImageWithURL:[NSURL URLWithString:userInfo.avatarUrl]
                        placeholderImage:[UIImage imageNamed:@"icon_myPanli_avatar_default"]];
    [self.view addSubview:img_User_Head];
    
    //top背景
    UIImageView* img_Top = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_RMB_Top"]];
    img_Top.frame = CGRectMake((MainScreenFrame_Height-320*1.2)/2, 0, 320*1.2, 126.0f*1.2);
    [self.view addSubview:img_Top];
    
    //用户余额
    UILabel* lab_UserBalance = [[UILabel alloc]initWithFrame:CGRectMake(110+195,40.0f+10.0f, 200, 18.0f)];
    lab_UserBalance.text = [NSString stringWithFormat:LocalizedString(@"MyPanliRMBViewController_labUserBalance",@"账户余额:%@"), [PanliHelper getCurrencyStyle:dic_User.balance]];
    lab_UserBalance.backgroundColor = PL_COLOR_CLEAR;
    lab_UserBalance.textColor = [PanliHelper colorWithHexString:@"#454444"];
    lab_UserBalance.font = DEFAULT_FONT(17);
    lab_UserBalance.textAlignment = UITextAlignmentLeft;
    [self.view addSubview:lab_UserBalance];
    
    //线条
    UIView *line_Top = [[UIView alloc] initWithFrame:CGRectMake((MainScreenFrame_Height-320*1.2)/2,126.0f*1.2,320*1.2, 1.0f)];
    line_Top.backgroundColor = [PanliHelper colorWithHexString:@"#d2d2d2"];
    [self.view addSubview:line_Top];
    
    UIView *line_Bottom = [[UIView alloc] initWithFrame:CGRectMake((MainScreenFrame_Height-320*1.2)/2,126.0f*1.2+1,320*1.2, 1.0f)];
    line_Bottom.backgroundColor = [PanliHelper colorWithHexString:@"#fdfdfd"];
    [self.view addSubview:line_Bottom];
    
    //充值button
    UIButton* btn_Pay = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_Pay setFrame:CGRectMake((MainScreenFrame_Height-288.0f*1.2)/2, 126.0f*1.2+2+20, 288.0f*1.2, 52.0f)];
    btn_Pay.tag = 1001;
    [btn_Pay setImage:[UIImage imageNamed:@"btn_RMB_Recharge"] forState:UIControlStateNormal];
    [btn_Pay setImage:[UIImage imageNamed:@"btn_RMB_Recharge_on"] forState:UIControlStateHighlighted];
    [btn_Pay addTarget:self action:@selector(payAndExpenseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_Pay];
    
    //消费记录(支出)
    UIButton* btn_Expenditrue = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_Expenditrue setFrame:CGRectMake((MainScreenFrame_Height-288.0f*1.2)/2, 126.0f*1.2+2+20+52+20, 288.0f*1.2, 52.0f)];
    btn_Expenditrue.tag = 1002;
    [btn_Expenditrue setImage:[UIImage imageNamed:@"btn_RMB_Expenditure"] forState:UIControlStateNormal];
    [btn_Expenditrue setImage:[UIImage imageNamed:@"btn_RMB_Expenditure_on"] forState:UIControlStateHighlighted];
    [btn_Expenditrue addTarget:self action:@selector(payAndExpenseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_Expenditrue];
    
    //背景图片
    UIImageView* img_Bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_RMB_Bottom"]];
    img_Bg.frame = CGRectMake((MainScreenFrame_Height - 108.0f)/2, btn_Expenditrue.frame.origin.y + 52.0f + ( IS_568H ? 60.0f : 10.0f), 108.0f, 117.0f);
    [self.view addSubview:img_Bg];
}

- (void)payAndExpenseBtnClick:(UIButton *)sender
{
    if(sender.tag == 1001)
    {
        //充值
        [super checkLoginWithBlock:^{
            RechargeViewController * reChargeView = [[RechargeViewController alloc]init];
            reChargeView.hidesBottomBarWhenPushed = YES;
            reChargeView.payTypeFlag = Recharge;
            reChargeView.rpt_DataRepeater = nil;
            [self.navigationController pushViewController:reChargeView animated:YES];
        } ];
        
    }
    else
    {
        //消费记录
        [super checkLoginWithBlock:^{
            ExpenditureViewController *expenditure = [[ExpenditureViewController alloc]init];
            expenditure.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:expenditure animated:YES];
        } ];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
