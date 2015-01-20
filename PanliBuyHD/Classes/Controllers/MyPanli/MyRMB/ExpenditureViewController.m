//
//  ExpenditureViewController.m
//  PanliApp
//
//  Created by jason on 14-5-12.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "ExpenditureViewController.h"
#import "PageData.h"
#import "UserAccount.h"
#import "ExpenditureDetailViewController.h"
@interface ExpenditureViewController ()

@end

@implementation ExpenditureViewController
@synthesize marr_AllRecords = _marr_AllRecords;
@synthesize marr_ExpendRecords = _marr_ExpendRecords;
@synthesize marr_IncomeRecords = _marr_IncomeRecords;
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(req_Records);
    SAFE_RELEASE(rpt_Records);
    SAFE_RELEASE(tab_Expenditure);
    SAFE_RELEASE(_marr_AllRecords);
    SAFE_RELEASE(_marr_ExpendRecords);
    SAFE_RELEASE(_marr_IncomeRecords);
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    showFlag = 0;
    pageIndexAll = 1;
    pageIndexExpend = 1;
    pageIndexIncome = 1;
    
    //顶部目录按钮和下拉view
    btnNavOrder = [UIButton buttonWithType:UIButtonTypeCustom];
    btnNavOrder.frame = CGRectMake(15.0f, 0.0f, 125.0f, 44.0f);
    [btnNavOrder setTitle:LocalizedString(@"ExpenditureViewController_btnNavOrder",@"全部消费记录") forState:UIControlStateNormal];
    [btnNavOrder setTitleColor:PL_COLOR_NAVBAR_TITLE forState:UIControlStateNormal];
    [btnNavOrder addTarget:self action:@selector(filterViewAction) forControlEvents:UIControlEventTouchUpInside];
    imgFilterIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_userShare_menu_down"]];
    imgFilterIcon.frame = CGRectMake(120.0f, 18.0f, 11.0, 7.5f);
    [btnNavOrder addSubview:imgFilterIcon];
    [imgFilterIcon release];
    self.navigationItem.titleView = btnNavOrder;
    
    filterView = [[NavFilterView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Height, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT) itemArray:[NSArray arrayWithObjects:LocalizedString(@"ExpenditureViewController_itemArray_item1",@"全部消费记录"),
                   LocalizedString(@"ExpenditureViewController_itemArray_item2",@"收入"),
                   LocalizedString(@"ExpenditureViewController_itemArray_item3",@"支出"), nil] selectedIndex:0];
    
    filterView.delegate = self;
    filterView.hidden = YES;
    filterView.alpha = 0;
    [self.navigationController.view addSubview:filterView];
    [filterView release];
    
    tab_Expenditure = [[CustomTableViewController alloc] init];
    tab_Expenditure.tableStyle = UITableViewStylePlain;
    tab_Expenditure.loadingStyle = head_none;
    tab_Expenditure.needRefresh = NO;
    tab_Expenditure.view.backgroundColor = [PanliHelper colorWithHexString:@"#EFEFEF"];
    [tab_Expenditure setCustomTableViewDelegate:self];
    tab_Expenditure.view.frame = CGRectMake(0.0f, 0.0f, Right_SpliteView_Width, MainScreenFrame_Width);
    tab_Expenditure.tableView.frame = CGRectMake(0.0f, -2, Right_SpliteView_Width, MainScreenFrame_Width - 350.0f);
    tab_Expenditure.tableView.backgroundColor = [PanliHelper colorWithHexString:@"#ffffff"];
    tab_Expenditure.tableView.separatorColor = PL_COLOR_CLEAR;
    [PanliHelper setExtraCellLineHidden:tab_Expenditure.tableView];
     [self.view insertSubview:tab_Expenditure.view belowSubview:filterView];

   
    exceptionView = [[CustomerExceptionView alloc] initWithFrame:CGRectMake(Right_SpliteView_Width, 0.0f, Right_SpliteView_Width, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT)];
    [exceptionView setHidden:YES];
    [self.view insertSubview:exceptionView aboveSubview:tab_Expenditure.view];
    [exceptionView release];

//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(expenditureResponse:)
//                                                 name:RQNAME_USER_ACCOUNTRECORDS
//                                               object:nil];
    [tab_Expenditure requestData:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self checkLoginWithBlock:^{
        
    }];
    if(!filterView.hidden)
    {
        [self filterViewAction];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - request && response
- (void)customTableView:(CustomTableViewController *)customTableView sendRequset:(BOOL)isFirst
{
    [tab_Expenditure.view setUserInteractionEnabled:NO];
    exceptionView.hidden = YES;
    isFirstRequest = isFirst;
    req_Records = req_Records ? req_Records : [[AccountRecordsRequest alloc] init];
    rpt_Records = rpt_Records ? rpt_Records : [[DataRepeater alloc] initWithName:RQNAME_USER_ACCOUNTRECORDS];
    NSMutableDictionary *prams = [[NSMutableDictionary alloc] init];
    [prams setValue:[NSString stringWithFormat:@"%d",showFlag] forKey:RQ_USER_ACCOUNTRECORDS_PARM_TYPE];
    
    int pageIndex = 0;
    switch (showFlag)
    {
        case 0:
        {
            pageIndex = pageIndexAll;
            break;
        }
        case 1:
        {
            pageIndex = pageIndexIncome;
            break;
        }
        case 2:
        {
            pageIndex = pageIndexExpend;
            break;
        }
        default:
            break;
    }
    
    [prams setValue:[NSString stringWithFormat:@"%d",pageIndex] forKey:RQ_USER_ACCOUNTRECORDS_PARM_PAGEINDEX];
    [prams setValue:@"10" forKey:RQ_USER_ACCOUNTRECORDS_PARM_PAGESIZE];
    rpt_Records.networkRequest = req_Records;
    rpt_Records.notificationName = RQNAME_USER_ACCOUNTRECORDS;
    rpt_Records.requestModal = PullData;
    rpt_Records.requestParameters = prams;
    [prams release];
    rpt_Records.isAuth = YES;
    __unsafe_unretained __typeof(self) weakSelf = self;
    rpt_Records.compleBlock = ^(id repeater){
        [weakSelf expenditureResponse:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:rpt_Records];

}
- (void)expenditureResponse:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        PageData *mPageData = [repeater responseValue];
        if(isFirstRequest)
        {
            [tab_Expenditure hideLoadingView];
        }
        
        BOOL havaMore = NO;
        switch (showFlag)
        {
            case 0:
            {
                pageIndexAll ++;
                isFirstRequest ? self.marr_AllRecords = mPageData.list : [self.marr_AllRecords addObjectsFromArray:mPageData.list];
                havaMore = self.marr_AllRecords.count < mPageData.rowCount;
                pageCountAll = mPageData.rowCount;
                if(self.marr_AllRecords == nil || self.marr_AllRecords.count <= 0)
                {
                    exceptionView.image = [UIImage imageNamed:@"bg_myGroup_error"];
                    exceptionView.title = LocalizedString(@"ExpenditureViewController_exceptionView1",@"暂时没有消费记录");
                    [exceptionView setNeedsDisplay];
                    [exceptionView setHidden:NO];
                }
                break;
            }
            case 1:
            {
                pageIndexIncome ++;
                isFirstRequest ? self.marr_IncomeRecords = mPageData.list : [self.marr_IncomeRecords addObjectsFromArray:mPageData.list];
                havaMore = self.marr_IncomeRecords.count < mPageData.rowCount;
                pageCountIncome = mPageData.rowCount;
                if(self.marr_IncomeRecords == nil || self.marr_IncomeRecords.count <= 0)
                {
                    exceptionView.image = [UIImage imageNamed:@"bg_myGroup_error"];
                    exceptionView.title = LocalizedString(@"ExpenditureViewController_exceptionView2",@"暂时没有收入记录");
                    [exceptionView setNeedsDisplay];
                    [exceptionView setHidden:NO];
                }
                break;
            }
            case 2:
            {
                pageIndexExpend ++;
                isFirstRequest ? self.marr_ExpendRecords = mPageData.list : [self.marr_ExpendRecords addObjectsFromArray:mPageData.list];
                havaMore = self.marr_ExpendRecords.count < mPageData.rowCount;
                pageCountExpend = mPageData.rowCount;
                if(self.marr_ExpendRecords == nil || self.marr_ExpendRecords.count <= 0)
                {
                    exceptionView.image = [UIImage imageNamed:@"bg_myGroup_error"];
                    exceptionView.title = LocalizedString(@"ExpenditureViewController_exceptionView3",@"暂时没有支出记录");
                    [exceptionView setNeedsDisplay];
                    [exceptionView setHidden:NO];
                }
                break;
            }
        }
        [tab_Expenditure.tableView reloadData];
        //判断是否可以获取更多
        [tab_Expenditure doAfterRequestSuccess:isFirstRequest AndHavaMore:havaMore];
    }
    else
    {
        if (isFirstRequest)
        {
            [tab_Expenditure hideLoadingView];
        }
        [tab_Expenditure doAfterRequsetFailure:isFirstRequest errorInfo:repeater.errorInfo];
    }
    [tab_Expenditure.view setUserInteractionEnabled:YES];
}

#pragma mark - UITableView delegate && datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (showFlag)
    {
        case 0:
        {
           return self.marr_AllRecords.count;
        }
        case 1:
        {
            return self.marr_IncomeRecords.count;
        }
        case 2:
        {
            return self.marr_ExpendRecords.count;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.0f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str_Expend = @"ExpendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str_Expend];
    if(!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str_Expend] autorelease];
        //状态
        UILabel *lab_State = [[UILabel alloc] initWithFrame:CGRectMake(16.0f, 32.0f, 30.0f, 16.0f)];
        lab_State.tag = 6001;
        lab_State.backgroundColor = PL_COLOR_CLEAR;
        lab_State.font = DEFAULT_FONT(15.0f);
        lab_State.textColor = [PanliHelper colorWithHexString:@"#444444"];
        [cell.contentView addSubview:lab_State];
        [lab_State release];
        
        //金额
        UILabel *lab_Money = [[UILabel alloc] initWithFrame:CGRectMake(lab_State.frame.origin.x + 30.0f + 10.0f, 28.0f, 120.0f, 21.0f)];
        lab_Money.tag = 6002;
        lab_Money.backgroundColor = PL_COLOR_CLEAR;
        lab_Money.font = DEFAULT_FONT(20.0f);
        lab_Money.textAlignment = UITextAlignmentLeft;
        [cell.contentView addSubview:lab_Money];
        [lab_Money release];
        
        //余额
        UILabel *lab_balance = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width - 16.0f, 21.0f, cell.frame.size.width - 166.0f, 16.0f)];
        lab_balance.tag = 6003;
        lab_balance.backgroundColor = PL_COLOR_CLEAR;
        lab_balance.font = DEFAULT_FONT(15.0f);
        lab_balance.textColor = [PanliHelper colorWithHexString:@"#444444"];
        lab_balance.textAlignment = UITextAlignmentRight;
        [cell.contentView addSubview:lab_balance];
        [lab_balance release];
        
        //时间
        UILabel *lab_Date = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width - 16.0f, 44.0f, cell.frame.size.width - 166.0f, 16.0f)];
        lab_Date.tag = 6004;
        lab_Date.backgroundColor = PL_COLOR_CLEAR;
        lab_Date.font = DEFAULT_FONT(15.0f);
        lab_Date.textColor = [PanliHelper colorWithHexString:@"#acacac"];;
        lab_Date.textAlignment = UITextAlignmentRight;
        [cell.contentView addSubview:lab_Date];
        [lab_Date release];
        
        //线条
        UIView *line_Top = [[UIView alloc] initWithFrame:CGRectMake(0.0f,73.0f,Right_SpliteView_Width, 1.0f)];
        line_Top.backgroundColor = [PanliHelper colorWithHexString:@"#f4f4f4"];
        [cell.contentView addSubview:line_Top];
        [line_Top release];
        
        UIView *line_Bottom = [[UIView alloc] initWithFrame:CGRectMake(0.0f,74.0f,Right_SpliteView_Width, 1.0f)];
        line_Bottom.backgroundColor = [PanliHelper colorWithHexString:@"#dfdfdf"];
        [cell.contentView addSubview:line_Bottom];
        [line_Bottom release];
    }
    UserAccount *mUserAccount = nil;
    switch (showFlag)
    {
        case 0:
        {
            mUserAccount = [self.marr_AllRecords objectAtIndex:indexPath.row];
            break;
        }
        case 1:
        {
            mUserAccount = [self.marr_IncomeRecords objectAtIndex:indexPath.row];
            break;
        }
        case 2:
        {
            mUserAccount = [self.marr_ExpendRecords objectAtIndex:indexPath.row];
            break;
        }
        default:
            break;
    }
    
    UILabel *lab_State = (UILabel*)[cell.contentView viewWithTag:6001];
    UILabel *lab_Money = (UILabel*)[cell.contentView viewWithTag:6002];
    UILabel *lab_balance = (UILabel*)[cell.contentView viewWithTag:6003];
    UILabel *lab_Date = (UILabel*)[cell.contentView viewWithTag:6004];
    
    if(mUserAccount.type == 1)
    {
        
        lab_State.text = LocalizedString(@"ExpenditureViewController_labState1",@"收入");
        lab_Money.text = [NSString stringWithFormat:LocalizedString(@"ExpenditureViewController_lab_Money",@"%.2f元"),mUserAccount.amount];
        lab_Money.textColor = [PanliHelper colorWithHexString:@"#4ea700"];
    }
    else
    {
        lab_State.text = LocalizedString(@"ExpenditureViewController_labState2",@"支出");
        NSString *str_Money = [NSString stringWithFormat:LocalizedString(@"ExpenditureViewController_lab_Money",@"%.2f元"),mUserAccount.amount];
        str_Money = [str_Money stringByReplacingOccurrencesOfString:@"-" withString:@""];
        lab_Money.text = str_Money;
        lab_Money.textColor = [PanliHelper colorWithHexString:@"#fc0201"];
    }
    lab_balance.text = [NSString stringWithFormat:LocalizedString(@"ExpenditureViewController_labBalance",@"余额:￥%.2f"),mUserAccount.balance];
    lab_Date.text = [PanliHelper timestampToDateString:mUserAccount.tradeTime formatterString:@"yyyy-MM-dd"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UserAccount *mUserAccount = nil;
    switch (showFlag)
    {
        case 0:
        {
            mUserAccount = [self.marr_AllRecords objectAtIndex:indexPath.row];
            break;
        }
        case 1:
        {
            mUserAccount = [self.marr_IncomeRecords objectAtIndex:indexPath.row];
            break;
        }
        case 2:
        {
            mUserAccount = [self.marr_ExpendRecords objectAtIndex:indexPath.row];
            break;
        }
        default:
            break;
    }

    ExpenditureDetailViewController *detail = [[[ExpenditureDetailViewController alloc] init] autorelease];
    detail.hidesBottomBarWhenPushed = YES;
    detail.m_UserAccount = mUserAccount;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - filterView
- (void)filterSelectDone:(int)index isChange:(BOOL)changed
{
    [self filterViewAction];
    showFlag = index;
    exceptionView.hidden = YES;
    switch (index) {
        case 0:
        {
            [btnNavOrder setTitle:LocalizedString(@"ExpenditureViewController_btnNavOrder1",@"全部消费记录") forState:UIControlStateNormal];
            imgFilterIcon.frame = CGRectMake(120.0f, 18.0f, 11.0, 7.5f);
            if(self.marr_AllRecords == nil || self.marr_AllRecords.count <= 0)
            {
                [tab_Expenditure requestData:YES];
            }
            break;
        }
        case 1:
        {
            [btnNavOrder setTitle:LocalizedString(@"ExpenditureViewController_btnNavOrder2",@"收入") forState:UIControlStateNormal];
            imgFilterIcon.frame = CGRectMake(85.0f, 18.0f, 11.0, 7.5f);
            if(self.marr_IncomeRecords == nil || self.marr_IncomeRecords.count <= 0)
            {
                [tab_Expenditure requestData:YES];
            }
            break;
        }
        case 2:
        {
            [btnNavOrder setTitle:LocalizedString(@"ExpenditureViewController_btnNavOrder3",@"支出") forState:UIControlStateNormal];
            imgFilterIcon.frame = CGRectMake(85.0f, 18.0f, 11.0, 7.5f);
            if(self.marr_ExpendRecords == nil || self.marr_ExpendRecords.count <= 0)
            {
                [tab_Expenditure requestData:YES];
            }
            break;
        }
        default:
            break;
    }
    [tab_Expenditure.tableView reloadData];
    
    //判断是否有下一页
    BOOL havaMore = NO;
    switch (showFlag)
    {
        case 0:
        {
            havaMore = self.marr_AllRecords.count < pageCountAll;
            break;
        }
        case 1:
        {
            havaMore = self.marr_IncomeRecords.count < pageCountIncome;
            break;
        }
        case 2:
        {
            havaMore = self.marr_ExpendRecords.count < pageCountExpend;
            break;
        }
    }
    //判断是否可以获取更多
    [tab_Expenditure doAfterRequestSuccess:isFirstRequest AndHavaMore:havaMore];
}

- (void)filterViewAction
{
    self.navigationItem.titleView.userInteractionEnabled = NO;
    if (filterView.hidden)
    {
        [UIView animateWithDuration:0.4f animations:^{
            filterView.hidden = NO;
            imgFilterIcon.hidden = YES;
            filterView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            self.navigationItem.rightBarButtonItem.enabled = NO;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.4f animations:^{
            filterView.alpha = 0.0f;
            imgFilterIcon.hidden = NO;
        } completion:^(BOOL finished) {
            filterView.hidden = YES;
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }];
    }
    self.navigationItem.titleView.userInteractionEnabled = YES;
}
@end
