//
//  ExpenditureDetailViewController.m
//  PanliApp
//
//  Created by jason on 14-5-22.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "ExpenditureDetailViewController.h"

@interface ExpenditureDetailViewController ()

@end

@implementation ExpenditureDetailViewController
@synthesize m_UserAccount = _m_UserAccount;
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_m_UserAccount);
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

- (void)viewWillAppear:(BOOL)animated
{
    [self checkLoginWithBlock:^{
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoadWithBackButtom:YES];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = LocalizedString(@"ExpenditureDetailViewController_Nav_Title",@"收支详情");
    //背景图片
    UIImageView* img_Bg = [[UIImageView alloc]initWithImage:[PanliHelper getImageFileByName:@"bg_RMB_detail_Main@2x.png"]];
    img_Bg.frame = CGRectMake(210.0f, 0.0f, 320, 300.0f);
    [self.view addSubview:img_Bg];
    [img_Bg release];
    
    //状态
    UILabel *lab_StateTXT = [[UILabel alloc] initWithFrame:CGRectMake(15.0f*15, 15.0f, 30.0f, 16.0f)];
    lab_StateTXT.backgroundColor = PL_COLOR_CLEAR;
    lab_StateTXT.font = DEFAULT_FONT(15.0f);
    lab_StateTXT.textColor = [PanliHelper colorWithHexString:@"#999999"];
    [self.view addSubview:lab_StateTXT];
    [lab_StateTXT release];
    
    //金额
    UILabel *lab_Money = [[UILabel alloc] initWithFrame:CGRectMake(60.0f+210.0f, 40.0f, 232.0f, 21.0f)];
    lab_Money.backgroundColor = PL_COLOR_CLEAR;
    lab_Money.font = DEFAULT_FONT(20.0f);
    lab_Money.textAlignment = UITextAlignmentRight;
    [self.view addSubview:lab_Money];
    [lab_Money release];
    
    if(_m_UserAccount.type == 1)
    {
        lab_StateTXT.text = LocalizedString(@"ExpenditureDetailViewController_labStateTXT1",@"收入");
        lab_Money.text = [NSString stringWithFormat:LocalizedString(@"ExpenditureDetailViewController_labMoney",@"%.2f元"),_m_UserAccount.amount];
        lab_Money.textColor = [PanliHelper colorWithHexString:@"#4ea700"];
    }
    else
    {
        lab_StateTXT.text = LocalizedString(@"ExpenditureDetailViewController_labStateTXT2",@"支出");
        NSString *str_Money = [NSString stringWithFormat:LocalizedString(@"ExpenditureDetailViewController_labMoney",@"%.2f元"),_m_UserAccount.amount];
        str_Money = [str_Money stringByReplacingOccurrencesOfString:@"-" withString:@""];
        lab_Money.text = str_Money;
        lab_Money.textColor = [PanliHelper colorWithHexString:@"#fc0201"];
    }
    
    //余额
    UILabel *lab_balance = [[UILabel alloc] initWithFrame:CGRectMake(60.0f+210, 80.0f, 232.0f, 16.0f)];
    lab_balance.backgroundColor = PL_COLOR_CLEAR;
    lab_balance.font = DEFAULT_FONT(15.0f);
    lab_balance.textColor = [PanliHelper colorWithHexString:@"#323232"];
    lab_balance.text = [NSString stringWithFormat:LocalizedString(@"ExpenditureDetailViewController_labBalance",@"余额:￥%.2f"),_m_UserAccount.balance];
    lab_balance.textAlignment = UITextAlignmentRight;
    [self.view addSubview:lab_balance];
    [lab_balance release];
    
    //时间
    UILabel *lab_Date = [[UILabel alloc] initWithFrame:CGRectMake(73.0f+210,121.0f, Right_SpliteView_Width - 73.0f - 23.0f, 16.0f)];
    lab_Date.backgroundColor = PL_COLOR_CLEAR;
    lab_Date.font = DEFAULT_FONT(15.0f);
    lab_Date.textColor = [PanliHelper colorWithHexString:@"#676767"];
    lab_Date.text = [PanliHelper timestampToDateString:_m_UserAccount.tradeTime formatterString:@"yyyy-MM-dd HH:mm:ss"];
    lab_Date.textAlignment = UITextAlignmentLeft;
    [self.view addSubview:lab_Date];
    [lab_Date release];
    
    //摘要
    CGSize size_Detail = [_m_UserAccount.description sizeWithFont:DEFAULT_FONT(15.0f) constrainedToSize:CGSizeMake(232.0f, 200.0f) lineBreakMode:NSLineBreakByCharWrapping];
    UILabel *lab_Detail = [[UILabel alloc] initWithFrame:CGRectMake(73.0f+210,150.0f, 232.0f, size_Detail.height)];
    lab_Detail.backgroundColor = PL_COLOR_CLEAR;
    lab_Detail.font = DEFAULT_FONT(15.0f);
    lab_Detail.numberOfLines = 0;
    lab_Detail.textColor = [PanliHelper colorWithHexString:@"#676767"];
    lab_Detail.text = _m_UserAccount.description;
    lab_Detail.textAlignment = UITextAlignmentLeft;
    [self.view addSubview:lab_Detail];
    [lab_Detail release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
