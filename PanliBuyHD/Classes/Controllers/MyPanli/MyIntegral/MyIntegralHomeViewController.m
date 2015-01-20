//
//  MyIntegralHomeViewController.m
//  PanliBuyHD
//
//  Created by guo on 14-10-23.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "MyIntegralHomeViewController.h"
#import "IntegralListViewController.h"
#import "ScoreExchangeViewController.h"
#import "UserInfo.h"

@interface MyIntegralHomeViewController ()

@end

@implementation MyIntegralHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [self checkLoginWithBlock:^{
        //获取用户信息
        UserInfo * dic_User = [GlobalObj getUserInfo];
        
        lab_UserBalance.text = [NSString stringWithFormat:LocalizedString(@"IntegralHomeViewController_labUserBalance",@"当前积分:%d"), dic_User.integration];
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super viewDidLoadWithBackButtom:YES];
    self.navigationController.navigationBar.backgroundColor = [PanliHelper colorWithHexString:@"#f4f4f4"];;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = LocalizedString(@"IntegralHomeViewController_Nav_Title",@"我的积分");
    self.view.backgroundColor = [PanliHelper colorWithHexString:@"#e9ecec"];
    //top背景
    UIImageView* img_Top = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_Score_Top"]];
    img_Top.frame = CGRectMake(210, 0, 320, 128.0f);
    [self.view addSubview:img_Top];
    
    //当前积分
    lab_UserBalance = [[UILabel alloc]initWithFrame:CGRectMake(15.0f+210, 40.0f, 320 - 30.0f, 21.0f)];
    lab_UserBalance.backgroundColor = PL_COLOR_CLEAR;
    lab_UserBalance.textColor = [PanliHelper colorWithHexString:@"#fdfffd"];
    lab_UserBalance.font = DEFAULT_FONT(20);
    lab_UserBalance.textAlignment = UITextAlignmentLeft;
    [self.view addSubview:lab_UserBalance];
    
    //积分兑换优惠券
    UIButton* btn_Exchange = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_Exchange setFrame:CGRectMake(15.0f+210, 150.0f, 288.0f, 52.0f)];
    btn_Exchange.tag = 1001;
    [btn_Exchange setImage:[UIImage imageNamed:@"btn_Score_Exchange"] forState:UIControlStateNormal];
    [btn_Exchange setImage:[UIImage imageNamed:@"btn_Score_Exchange_on"] forState:UIControlStateHighlighted];
    [btn_Exchange addTarget:self action:@selector(scoreClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_Exchange];
    
    UIButton* btn_Detail = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_Detail setFrame:CGRectMake(15.0f+210, 222.0f, 288.0f, 52.0f)];
    btn_Detail.tag = 1002;
    [btn_Detail setImage:[UIImage imageNamed:@"btn_Score_Detail"] forState:UIControlStateNormal];
    [btn_Detail setImage:[UIImage imageNamed:@"btn_Score_Detail_on"] forState:UIControlStateHighlighted];
    [btn_Detail addTarget:self action:@selector(scoreClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_Detail];
    
    //背景图片
    UIImageView *img_Bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_Score_Bottom"]];
    img_Bg.frame = CGRectMake((MainScreenFrame_Width - 129.0f)/2, btn_Detail.frame.origin.y + 52.0f + ( IS_568H ? 65.0f : 10.0f), 129.0f, 124.0f);
    [self.view addSubview:img_Bg];
}

- (void)scoreClick:(UIButton *)sender
{
    if(sender.tag == 1001)
    {
        [self checkLoginWithBlock:^{
            ScoreExchangeViewController *exchange = [[ScoreExchangeViewController alloc] init];
            exchange.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:exchange animated:YES];
        }];
    }
    else
    {
        [self checkLoginWithBlock:^{
            IntegralListViewController *integralList = [[IntegralListViewController alloc] init];
            integralList.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:integralList animated:YES];
        }];
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
