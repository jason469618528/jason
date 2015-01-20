//
//  RechargeSuccessViewController.m
//  PanliApp
//
//  Created by jason on 13-6-3.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "RechargeSuccessViewController.h"
#import "CustomerNavagationBarController.h"
@interface RechargeSuccessViewController ()

@end

@implementation RechargeSuccessViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    [super dealloc];
}
- (void)viewDidLoad
{
    [self viewDidLoadWithBackButtom:YES];
    
    self.navigationItem.title = LocalizedString(@"RechargeSuccessViewController_Nav_Title",@"充值成功");
    self.view.backgroundColor = [PanliHelper colorWithHexString:@"#ededed"];
    
    UIImageView * imageg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_IsPatch_on"]];
    imageg.frame=CGRectMake(30, 40, 25, 25);
    [self.view addSubview:imageg];
    [imageg release];
    
    
    UILabel * lab_Title = [[UILabel alloc]initWithFrame:CGRectMake(65, 42, 320, 20)];
    lab_Title.text = LocalizedString(@"RechargeSuccessViewController_labTitle",@"恭喜您,成功提交充值信息!");
    lab_Title.backgroundColor = PL_COLOR_CLEAR;
    lab_Title.font = DEFAULT_FONT(20);
    lab_Title.textColor = [PanliHelper colorWithHexString:@"#5d910e"];
    [self.view addSubview:lab_Title];
    [lab_Title release];
    NSString *str_Message = LocalizedString(@"RechargeSuccessViewController_strMessage",@"充值金额会在30分钟内到账,请耐心等待。\n\n若有疑问,请发送邮件至service@panli.com\n\n我们会尽快与您取得联系。");
    CGSize sizeMessage = [str_Message sizeWithFont:DEFAULT_FONT(14.0f) constrainedToSize:CGSizeMake(280.0f, 120.0f) lineBreakMode:NSLineBreakByCharWrapping];
    
    UILabel * lab_Message = [[UILabel alloc]initWithFrame:CGRectMake(35.0f, 80.0f, 280.0f, sizeMessage.height)];
    lab_Message.text = str_Message;
    lab_Message.numberOfLines = 0;
    lab_Message.backgroundColor = PL_COLOR_CLEAR;
    lab_Message.font = DEFAULT_FONT(14.0f);
    lab_Message.textColor = [PanliHelper colorWithHexString:@"#4e4e50"];
    [self.view addSubview:lab_Message];
    [lab_Message release];
}
//super
- (void)barButtonItemClick:(UIButton *)btn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
