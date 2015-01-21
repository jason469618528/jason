//
//  RechargeFaildViewController.m
//  PanliApp
//
//  Created by Liubin on 14-8-22.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "RechargeFaildViewController.h"
#import "CustomerNavagationBarController.h"
@interface RechargeFaildViewController ()

@end

@implementation RechargeFaildViewController

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
    [super viewDidLoadWithBackButtom:NO];
    self.navigationItem.title = LocalizedString(@"RechargeFaildViewController_Nav_Title",@"提示");
    
    NSString *str_Message = LocalizedString(@"RechargeFaildViewController_strMessage",@"正在处理中,记得保持关注哦!\n\n若有疑问,请发送邮件至service@panli.com\n\n我们会尽快与您取得联系。");
    CGSize sizeMessage = [str_Message sizeWithFont:DEFAULT_FONT(14.0f) constrainedToSize:CGSizeMake(280.0f, 120.0f) lineBreakMode:NSLineBreakByCharWrapping];
    
    UILabel * lab_Message = [[UILabel alloc]initWithFrame:CGRectMake(35.0f, 50.0f, 280.0f, sizeMessage.height)];
    lab_Message.text = str_Message;
    lab_Message.numberOfLines = 0;
    lab_Message.backgroundColor = PL_COLOR_CLEAR;
    lab_Message.font = DEFAULT_FONT(14.0f);
    lab_Message.textColor = [PanliHelper colorWithHexString:@"#4e4e50"];
    [self.view addSubview:lab_Message];
    [lab_Message release];
    
    UIButton *btn_back = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_back.frame = CGRectMake(30.0f, lab_Message.frame.origin.y + lab_Message.frame.size.height + 30.0f, 260.0f, 50.0f);
    btn_back.layer.cornerRadius = 6.0f;
    btn_back.layer.masksToBounds = YES;
    btn_back.backgroundColor = [PanliHelper colorWithHexString:@"#23bd00"];
    [btn_back setTitle:LocalizedString(@"RechargeFaildViewController_btnBack",@"返回MyPanli") forState:UIControlStateNormal];
    [btn_back setTitleColor:PL_COLOR_WHITE forState:UIControlStateNormal];
    [btn_back addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_back];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CustomerNavagationBarController *tomerNav = (CustomerNavagationBarController*)self.navigationController;
    tomerNav.canDragBack = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    CustomerNavagationBarController *tomerNav = (CustomerNavagationBarController*)self.navigationController;
    tomerNav.canDragBack = YES;
}


- (void)backClick
{
    if (self.tabBarController.selectedIndex == 4)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
        self.tabBarController.selectedIndex = 4;
    }
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
