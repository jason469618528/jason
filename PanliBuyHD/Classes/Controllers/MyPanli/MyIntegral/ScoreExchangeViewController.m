//
//  ScoreExchangeViewController.m
//  PanliBuyHD
//
//  Created by guo on 14-10-23.
//  Copyright (c) 2014年 Panli. All rights reserved.
//
#define CREASE_HEIGHT 180.0f

#import "ScoreExchangeViewController.h"
#import "UserInfo.h"

@interface ScoreExchangeViewController ()

@end

@implementation ScoreExchangeViewController

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
    [super viewDidLoadWithBackButtom:YES];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.backgroundColor = [PanliHelper colorWithHexString:@"#f4f4f4"];
    //LocalizedString(@"ScoreExchangeViewController_Nav_Title",
    self.navigationItem.title = LocalizedString(@"ScoreExchangeViewController_Nav_Title",@"积分兑换优惠券");
    
    //获取当前积分
    UserInfo *mUserInfo = [GlobalObj getUserInfo];
    currentScore = mUserInfo.integration;
    
    arr_ImageMain = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"bg_ScoreExchange_Five"],
                     [UIImage imageNamed:@"bg_ScoreExchange_Ten"],
                     [UIImage imageNamed:@"bg_ScoreExchange_Twenty"],
                     [UIImage imageNamed:@"bg_ScoreExchange_Fifty"],nil];
    
    tab_Main = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, Right_SpliteView_Width, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    tab_Main.backgroundColor = [PanliHelper colorWithHexString:@"#f4f4f4"];
    tab_Main.delegate = self;
    tab_Main.dataSource = self;
    tab_Main.separatorColor = PL_COLOR_CLEAR;
    [PanliHelper setExtraCellLineHidden:tab_Main];
    [PanliHelper setExtraCellPixelExcursion:tab_Main];
    [self.view addSubview:tab_Main];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(scoreExchangeResponse:)
//                                                 name:RQNAME_USER_SCOREEXCHANGE
//                                               object:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_ImageMain.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str_Expend = @"ExpendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str_Expend];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str_Expend];
        
        //背景图片
        UIImageView *img_Bg = [[UIImageView alloc]initWithFrame:CGRectMake(11.0f+CREASE_HEIGHT, 11.25f, 200.5f, 95.5f)];
        img_Bg.tag = 5001;
        [cell.contentView addSubview:img_Bg];
        
        //需消耗
        UILabel *lab_Ex = [[UILabel alloc] initWithFrame:CGRectMake(213.0f+CREASE_HEIGHT, 28.0f, 94.0f, 12.0f)];
        lab_Ex.tag = 5002;
        lab_Ex.backgroundColor = PL_COLOR_CLEAR;
        lab_Ex.font = DEFAULT_FONT(11.0f);
        lab_Ex.textColor = [PanliHelper colorWithHexString:@"#828282"];
        lab_Ex.textAlignment = UITextAlignmentRight;
        [cell.contentView addSubview:lab_Ex];
        
        //兑换button
        UIButton *btn_Exchange = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_Exchange.tag = indexPath.row + 5003;
        btn_Exchange.frame = CGRectMake(223.0f+CREASE_HEIGHT, 62.5f, 86.0f, 31.0f);
        [cell.contentView addSubview:btn_Exchange];
        
        //线条
        UIView *line_Top = [[UIView alloc] initWithFrame:CGRectMake(0.0f+CREASE_HEIGHT,118.0f,320.0f, 1.0f)];
        line_Top.backgroundColor = [PanliHelper colorWithHexString:@"#c8c8c8"];
        [cell.contentView addSubview:line_Top];
        
        UIView *line_Bottom = [[UIView alloc] initWithFrame:CGRectMake(0.0f+CREASE_HEIGHT,119.0f,320.0f, 1.0f)];
        line_Bottom.backgroundColor = [PanliHelper colorWithHexString:@"#ffffff"];
        [cell.contentView addSubview:line_Bottom];
        
        cell.backgroundColor = [PanliHelper colorWithHexString:@"#f4f4f4"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //背景图片
    UIImageView *img_Bg = (UIImageView*)[cell.contentView viewWithTag:5001];
    img_Bg.image = [arr_ImageMain objectAtIndex:indexPath.row];
    
    //需消耗
    UILabel *lab_Ex = (UILabel*)[cell.contentView viewWithTag:5002];
    //LocalizedString(@"ScoreExchangeViewController_labEx",
    lab_Ex.text = [NSString stringWithFormat:LocalizedString(@"ScoreExchangeViewController_labEx",@"需消耗 : %d积分"),((int)indexPath.row + 1) * 500 + (indexPath.row == 2 ? 500 : 0) + (indexPath.row == 3 ? 3000 : 0)];
    
    //兑换button
    UIButton *btn_Exchange = (UIButton*)[cell.contentView viewWithTag:5003 + indexPath.row];
    NSInteger index = btn_Exchange.tag - 5003;
    if(currentScore >= 5000)
    {
        [btn_Exchange setImage:[UIImage imageNamed:@"btn_ScoreExchange_Click"] forState:UIControlStateNormal];
        [btn_Exchange setImage:[UIImage imageNamed:@"btn_ScoreExchange_Click_on"] forState:UIControlStateHighlighted];
        [btn_Exchange addTarget:self action:@selector(exchangeClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn_Exchange setUserInteractionEnabled:YES];
    }
    else if(currentScore >= 2000)
    {
        if(index == 0 || index == 1 ||  index == 2 )
        {
            [btn_Exchange setImage:[UIImage imageNamed:@"btn_ScoreExchange_Click"] forState:UIControlStateNormal];
            [btn_Exchange setImage:[UIImage imageNamed:@"btn_ScoreExchange_Click_on"] forState:UIControlStateHighlighted];
            [btn_Exchange addTarget:self action:@selector(exchangeClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn_Exchange setUserInteractionEnabled:YES];
        }
        else
        {
            [btn_Exchange setImage:[UIImage imageNamed:@"btn_ScoreExchange_NOClick"] forState:UIControlStateNormal];
            [btn_Exchange setUserInteractionEnabled:NO];
        }
    }
    else if(currentScore >= 1000)
    {
        if(index == 0 || index == 1)
        {
            [btn_Exchange setImage:[UIImage imageNamed:@"btn_ScoreExchange_Click"] forState:UIControlStateNormal];
            [btn_Exchange setImage:[UIImage imageNamed:@"btn_ScoreExchange_Click_on"] forState:UIControlStateHighlighted];
            [btn_Exchange addTarget:self action:@selector(exchangeClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn_Exchange setUserInteractionEnabled:YES];
        }
        else
        {
            [btn_Exchange setImage:[UIImage imageNamed:@"btn_ScoreExchange_NOClick"] forState:UIControlStateNormal];
            [btn_Exchange setUserInteractionEnabled:NO];
        }
        
    }
    else if(currentScore >= 500)
    {
        if(index == 0)
        {
            [btn_Exchange setImage:[UIImage imageNamed:@"btn_ScoreExchange_Click"] forState:UIControlStateNormal];
            [btn_Exchange setImage:[UIImage imageNamed:@"btn_ScoreExchange_Click_on"] forState:UIControlStateHighlighted];
            [btn_Exchange addTarget:self action:@selector(exchangeClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn_Exchange setUserInteractionEnabled:YES];
        }
        else
        {
            [btn_Exchange setImage:[UIImage imageNamed:@"btn_ScoreExchange_NOClick"] forState:UIControlStateNormal];
            [btn_Exchange setUserInteractionEnabled:NO];
        }
    }
    else
    {
        [btn_Exchange setImage:[UIImage imageNamed:@"btn_ScoreExchange_NOClick"] forState:UIControlStateNormal];
        [btn_Exchange setUserInteractionEnabled:NO];
    }
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
}

- (void)exchangeClick:(UIButton*)btn
{
    int index = (int)btn.tag - 5003;
    
    currentIndex = index +1;
    
    int score = 0;
    int scoreMoney = 0;
    switch (index) {
        case 0:
        {
            score = 500;
            scoreMoney = 5;
            break;
        }
        case 1:
        {
            score = 1000;
            scoreMoney = 10;
            break;
        }
        case 2:
        {
            score = 2000;
            scoreMoney = 20;
            break;
        }
        case 3:
        {
            score = 5000;
            scoreMoney = 50;
            break;
        }
        default:
            break;
    }
    currentScoreCount = score;
    
    NSString *str_Message = [NSString stringWithFormat:LocalizedString(@"ScoreExchangeViewController_strMessage",@"使用%d积分换取这张%d元优惠券吗?"),score,scoreMoney];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:LocalizedString(@"ScoreExchangeViewController_AlertView_Title",@"积分兑换优惠券")
                                                        message:str_Message delegate:self
                                              cancelButtonTitle:LocalizedString(@"ScoreExchangeViewController_AlertView_CanBtn",@"不用")
                                              otherButtonTitles:LocalizedString(@"ScoreExchangeViewController_AlertView_OthBtn",@"兑换"), nil];
    [alertView show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [self scoreExchangeRequest:currentIndex];
    }
}

#pragma mark - request && response
- (void)scoreExchangeRequest:(int)type
{
    self.view.userInteractionEnabled = NO;
    //LocalizedString(@"ScoreExchangeViewController_HUDIndMsg",
    [self showHUDIndicatorMessage:LocalizedString(@"ScoreExchangeViewController_HUDIndMsg",@"正在加载...")];
    req_Exchange = req_Exchange ? req_Exchange : [[ScoreExchangeRequest alloc] init];
    rpt_Exchange = rpt_Exchange ? rpt_Exchange : [[DataRepeater alloc] initWithName:RQNAME_USER_SCORERECORDS];
    
    NSMutableDictionary *prams = [[NSMutableDictionary alloc] init];
    [prams setValue:[NSString stringWithFormat:@"%d",type] forKey:RQ_USER_SCOREEXCHANGE_PARM_TYPE];
    
    rpt_Exchange.networkRequest = req_Exchange;
    rpt_Exchange.notificationName = RQNAME_USER_SCOREEXCHANGE;
    rpt_Exchange.requestModal = PullData;
    rpt_Exchange.requestParameters = prams;
    rpt_Exchange.isAuth = YES;
    __weak __typeof(self) weakSelf = self;
    rpt_Exchange.compleBlock = ^(id repeater){
        [weakSelf scoreExchangeResponse:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:rpt_Exchange];
}
- (void)scoreExchangeResponse:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        //LocalizedString(@"ScoreExchangeViewController_HUDSucMsg",
        [self showHUDSuccessMessage:LocalizedString(@"ScoreExchangeViewController_HUDSucMsg",@"兑换成功")];
        //更新用户积分
        UserInfo *mUserInfo = [GlobalObj getUserInfo];
        if(mUserInfo)
        {
            mUserInfo.integration = currentScore - currentScoreCount;
            [GlobalObj setUserInfo:mUserInfo];
        }
        currentScore -= currentScoreCount;
        [tab_Main reloadData];
    }
    else
    {
        [self showHUDErrorMessage:repeater.errorInfo.message];
    }
    self.view.userInteractionEnabled = YES;
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
