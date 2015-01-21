//
//  MyCouponViewController.m
//  PanliBuyHD
//
//  Created by ZhaoFucheng on 14-10-22.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "MyCouponViewController.h"
#import "MyCouponCell.h"
#import "Coupon.h"
#import "ScoreExchangeViewController.h"

#define TAG_SCORE_EXCHANGE_VIEW 1016
@interface MyCouponViewController ()

@end

@implementation MyCouponViewController

- (void)viewWillAppear:(BOOL)animated
{
//    [self.tableView reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
       
    self.navigationItem.title = LocalizedString(@"MyCouponViewController_Nav_Title1",@"我的优惠券");
    self.view.backgroundColor = [PanliHelper colorWithHexString:@"#f4f4f4"];
    
    self.tableView.separatorColor = PL_COLOR_CLEAR;
    [PanliHelper setExtraCellLineHidden:self.tableView];
    [PanliHelper setExtraCellPixelExcursion:self.tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(couponListResponse:)
                                                 name:RQNAME_GETCOUPON_MYPANLI
                                               object:nil];
    
    exceptionView = [[CustomerExceptionView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width - 300, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT - 72)];
    [exceptionView setHidden:YES];
    [self.view insertSubview:exceptionView aboveSubview:self.tableView];
    
    UIButton *btn_goIntegral = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_goIntegral.frame = CGRectMake((MainScreenFrame_Width - 300 - 163.5) / 2,320.0f, 163.5f, 37.0f);
    [btn_goIntegral setImage:[UIImage imageNamed:@"btn_CouponHome_GoScore"] forState:UIControlStateNormal];
    [btn_goIntegral setImage:[UIImage imageNamed:@"btn_CouponHome_GoScore_on"] forState:UIControlStateHighlighted];
    [btn_goIntegral addTarget:self action:@selector(goIntegralClick) forControlEvents:UIControlEventTouchUpInside];
    [exceptionView addSubview:btn_goIntegral];
    
    [self requestCouponList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - btnClick
-(void)goIntegralClick
{
    [super checkLoginWithBlock:^{
        [self.tabBarController setSelectedIndex:4];
        ScoreExchangeViewController *IntegralHome = [[ScoreExchangeViewController alloc] init];
//        UINavigationController *nav = [self.tabBarController.viewControllers objectAtIndex:4];
        [self.navigationController pushViewController:IntegralHome animated:YES];
//        NSMutableArray *viewControllerArray = [[NSMutableArray alloc] initWithArray:nav.viewControllers];
//        for (int i = 1; i < [viewControllerArray count]; i++)
//        {
//            [viewControllerArray removeObjectAtIndex:i];
//            i--;
//        }
//        nav.viewControllers = viewControllerArray;
//        IntegralHome.hidesBottomBarWhenPushed = YES;
//        [nav pushViewController:IntegralHome animated:YES];
////        [self.navigationController popToRootViewControllerAnimated:YES];
////        [nav setNavigationBarHidden:NO];
    } andLoginTag:TAG_SCORE_EXCHANGE_VIEW];
}

/**
 *  用户登录成功之后，继续之前的操作
 */
- (void)userDidLogin:(NSNotification *)sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"%@LoginDoneNotification",[self class]] object:nil];
    int tag = [sender.object intValue];
    if (tag == TAG_SCORE_EXCHANGE_VIEW)
    {
        [self.tabBarController setSelectedIndex:4];
        ScoreExchangeViewController *IntegralHome = [[ScoreExchangeViewController alloc] init];
        [self.navigationController pushViewController:IntegralHome animated:YES];
    }
}

#pragma mark - request && response
- (void)requestCouponList
{
    [exceptionView setHidden:YES];
    [self showHUDIndicatorMessage:LocalizedString(@"MyCouponViewController_HUDIndMsg",@"正在加载...")];
    self.view.userInteractionEnabled = NO;
    req_Coupon = req_Coupon ? req_Coupon:[[GetCouponRequest alloc] init];
    rpt_Coupon = rpt_Coupon?rpt_Coupon:[[DataRepeater alloc]initWithName:RQNAME_GETCOUPON_MYPANLI];
    rpt_Coupon.notificationName = RQNAME_GETCOUPON_MYPANLI;
    rpt_Coupon.requestModal = PullData;
    rpt_Coupon.networkRequest = req_Coupon;
    
    rpt_Coupon.isAuth = YES;
    __weak __typeof(self) weakSelf = self;
    rpt_Coupon.compleBlock = ^(id repeater){
        [weakSelf couponListResponse:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:rpt_Coupon];
}
-(void)couponListResponse:(DataRepeater*)repeater
{
    self.view.userInteractionEnabled = YES;
    if(repeater.isResponseSuccess)
    {
        [self hideHUD];
        arr_Coupon = repeater.responseValue;
        if(arr_Coupon == nil || arr_Coupon.count <= 0)
        {
            exceptionView.img_icon.image = [UIImage imageNamed:@"bg_CouponHome_MainNone"];
            exceptionView.lab_title.text = LocalizedString(@"MyCouponViewController_exceptionView",@"您还没有优惠券");
            [exceptionView setNeedsDisplay];
            [exceptionView setHidden:NO];
        }
        else
        {
            [self reloadView];
        }
    }
    else
    {
        [self showHUDErrorMessage:repeater.errorInfo.message];
    }
}

- (void)reloadView
{
    NSArray *arr_Usable = [arr_Coupon filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.status in {1,6}"]];
    self.navigationItem.title = [NSString stringWithFormat:LocalizedString(@"MyCouponViewController_Nav_Title2",@"我的优惠券(%d)"),arr_Usable.count];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return  arr_Coupon.count/2 + arr_Coupon.count%2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier =@"CouponCellId";
    MyCouponCell *cell =(MyCouponCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = (MyCouponCell *)[[[NSBundle mainBundle] loadNibNamed:@"MyCouponCell" owner:self options:nil] lastObject];
        cell.backgroundColor = [PanliHelper colorWithHexString:@"#f4f4f4"];
    }
    
    NSArray *array = nil;
    if (arr_Coupon.count >= indexPath.row*2+2)
    {
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(indexPath.row*2, 2)];
        array = [arr_Coupon objectsAtIndexes:indexSet];
    }
    else
    {
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(indexPath.row*2, 1)];
        array = [arr_Coupon objectsAtIndexes:indexSet];
    }
    
    
    Coupon *leftCoupon = [array objectAtIndex:0];
    Coupon *rightCoupon = array.count > 1 ? [array objectAtIndex:1] : nil;
    
    [cell setDataWithLeft:leftCoupon andRight:rightCoupon];
    
    cell.leftView.tag=8000+indexPath.row*2;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellviewTaped:)];
    [cell.leftView addGestureRecognizer:tapRecognizer];
    if (rightCoupon != nil) {
        cell.rightView.tag=8000+indexPath.row*2+1;
        tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellviewTaped:)];
        [cell.rightView addGestureRecognizer:tapRecognizer];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

-(void)cellviewTaped:(UITapGestureRecognizer *)recognizer
{
	
    NSInteger tag=[recognizer view].tag-8000;
    
    Coupon *mCoupon = (Coupon*)[arr_Coupon objectAtIndex:tag];
    NSString *strMessage = [NSString stringWithFormat:LocalizedString(@"MyCouponViewController_strMessage",@"此优惠券编号为:%@,是否要复制?"),mCoupon.code];
    current_CouponCode = mCoupon.code;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:LocalizedString(@"MyCouponViewController_AlertView_Title",@"优惠券信息")
                                                        message:strMessage
                                                       delegate:self
                                              cancelButtonTitle:LocalizedString(@"Common_Btn_Cancel", @"取消")
                                              otherButtonTitles:LocalizedString(@"MyCouponViewController_AlertView_OthBtn",@"复制"), nil];
    [alertView show];

    
    
    
}



#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        //复制信息到粘贴板
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = current_CouponCode;
    }
}

@end
