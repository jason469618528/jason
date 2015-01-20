//
//  IntegralListViewController.m
//  PanliBuyHD
//
//  Created by guo on 14-10-23.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "IntegralListViewController.h"
#import "PageData.h"
#import "UserScore.h"

@interface IntegralListViewController ()

@end

@implementation IntegralListViewController
@synthesize marr_AllRecords = _marr_AllRecords;
@synthesize marr_ExpendRecords = _marr_ExpendRecords;
@synthesize marr_IncomeRecords = _marr_IncomeRecords;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(!filterView.hidden)
    {
        [self filterViewAction];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super viewDidLoadWithBackButtom:YES];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    showFlag = 0;
    pageIndexScoreAll = 1;
    pageIndexScoreExpend = 1;
    pageIndexScoreIncome = 1;
    
    //顶部目录按钮和下拉view
    btnNavOrder = [UIButton buttonWithType:UIButtonTypeCustom];
    btnNavOrder.frame = CGRectMake(0.0f, 0.0f, 125.0f, 44.0f);
    //LocalizedString(@"IntegralListViewController_btnNavOrder1",
    [btnNavOrder setTitle:LocalizedString(@"IntegralListViewController_btnNavOrder1",@"全部积分记录") forState:UIControlStateNormal];
    [btnNavOrder setTitleColor:PL_COLOR_NAVBAR_TITLE forState:UIControlStateNormal];
    [btnNavOrder addTarget:self action:@selector(filterViewAction) forControlEvents:UIControlEventTouchUpInside];
    imgFilterIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_userShare_menu_down"]];
    imgFilterIcon.frame = CGRectMake(120.0f, 18.0f, 11.0, 7.5f);
    [btnNavOrder addSubview:imgFilterIcon];
    self.navigationItem.titleView = btnNavOrder;
    
    filterView = [[NavFilterView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Height, MainScreenFrame_Width - UI_NAVIGATION_BAR_HEIGHT)
                                            itemArray:[NSArray arrayWithObjects:LocalizedString(@"IntegralListViewController_itemArray_item1",@"全部积分记录"),
                                                       LocalizedString(@"IntegralListViewController_itemArray_item2",@"获得积分"),
                                                       LocalizedString(@"IntegralListViewController_itemArray_item3",@"消耗积分"), nil] selectedIndex:0];
    filterView.delegate = self;
    filterView.hidden = YES;
    filterView.alpha = 0;
    [self.navigationController.view addSubview:filterView];
    
    tab_ScoreRecords = [[CustomTableViewController alloc] init];
    tab_ScoreRecords.tableStyle = UITableViewStylePlain;
    tab_ScoreRecords.loadingStyle = head_none;
    tab_ScoreRecords.needRefresh = NO;
    tab_ScoreRecords.view.backgroundColor = [PanliHelper colorWithHexString:@"#EFEFEF"];
    [tab_ScoreRecords setCustomTableViewDelegate:self];
    tab_ScoreRecords.view.frame = CGRectMake(0.0f, 0.0f, Right_SpliteView_Width, MainScreenFrame_Width);
    tab_ScoreRecords.tableView.frame = CGRectMake(0.0f, -2, Right_SpliteView_Width, MainScreenFrame_Width - UI_NAVIGATION_BAR_HEIGHT);
    tab_ScoreRecords.tableView.backgroundColor = [PanliHelper colorWithHexString:@"#ffffff"];
    tab_ScoreRecords.tableView.separatorColor = PL_COLOR_CLEAR;
    [PanliHelper setExtraCellLineHidden:tab_ScoreRecords.tableView];
    [self.view insertSubview:tab_ScoreRecords.view belowSubview:filterView];
    
    
    exceptionView_Score = [[CustomerExceptionView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, Right_SpliteView_Width, MainScreenFrame_Width - UI_NAVIGATION_BAR_HEIGHT)];
    [exceptionView_Score setHidden:YES];
    [self.view insertSubview:exceptionView_Score aboveSubview:tab_ScoreRecords.view];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(scoreRecordsResponse:)
//                                                 name:RQNAME_USER_SCORERECORDS
//                                               object:nil];
    [tab_ScoreRecords requestData:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self checkLoginWithBlock:^{
        
    }];
}

#pragma mark - CustomTableView_Request && Response
- (void)customTableView:(CustomTableViewController *)customTableView sendRequset:(BOOL)isFirst
{
    [tab_ScoreRecords.view setUserInteractionEnabled:NO];
    exceptionView_Score.hidden = YES;
    isFirstRequest = isFirst;
    req_ScoreRecords = req_ScoreRecords ? req_ScoreRecords : [[ScoreRecordsRequest alloc] init];
    rpt_ScoreRecords = rpt_ScoreRecords ? rpt_ScoreRecords : [[DataRepeater alloc] initWithName:RQNAME_USER_SCORERECORDS];
    NSMutableDictionary *prams = [[NSMutableDictionary alloc] init];
    [prams setValue:[NSString stringWithFormat:@"%d",showFlag] forKey:RQ_USER_SCORERECORDS_PARM_TYPE];
    
    //页码
    int pageIndex = 0;
    switch (showFlag)
    {
        case 0:
        {
            pageIndex = pageIndexScoreAll;
            break;
        }
        case 1:
        {
            pageIndex = pageIndexScoreIncome;
            break;
        }
        case 2:
        {
            pageIndex = pageIndexScoreExpend;
            break;
        }
            
        default:
            break;
    }
    [prams setValue:[NSString stringWithFormat:@"%d",pageIndex] forKey:RQ_USER_SCORERECORDS_PARM_PAGEINDEX];
    
    [prams setValue:@"10" forKey:RQ_USER_SCORERECORDS_PARM_PAGESIZE];
    rpt_ScoreRecords.networkRequest = req_ScoreRecords;
    rpt_ScoreRecords.notificationName = RQNAME_USER_SCORERECORDS;
    rpt_ScoreRecords.requestModal = PullData;
    rpt_ScoreRecords.requestParameters = prams;
    
    rpt_ScoreRecords.isAuth = YES;
    __weak __typeof(self) weakSelf = self;
    rpt_ScoreRecords.compleBlock = ^(id repeater){
        [weakSelf scoreRecordsResponse:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:rpt_ScoreRecords];
    
}
- (void)scoreRecordsResponse:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        PageData *mPageData = [repeater responseValue];
        if(isFirstRequest)
        {
            [tab_ScoreRecords hideLoadingView];
        }
        BOOL havaMore = NO;
        switch (showFlag)
        {
            case 0:
            {
                pageIndexScoreAll ++;
                isFirstRequest ? self.marr_AllRecords = mPageData.list : [self.marr_AllRecords addObjectsFromArray:mPageData.list];
                havaMore = self.marr_AllRecords.count < mPageData.rowCount;
                pageCountScoreAll = mPageData.rowCount;
                if(self.marr_AllRecords == nil || self.marr_AllRecords.count <= 0)
                {
                    exceptionView_Score.image = [UIImage imageNamed:@"bg_myGroup_error"];
                    //LocalizedString(@"IntegralListViewController_exceptionViewScore1",
                    exceptionView_Score.title = LocalizedString(@"IntegralListViewController_exceptionViewScore1",@"暂时没有消费记录");
                    [exceptionView_Score setNeedsDisplay];
                    [exceptionView_Score setHidden:NO];
                }
                break;
            }
            case 1:
            {
                pageIndexScoreIncome ++;
                isFirstRequest ? self.marr_IncomeRecords = mPageData.list : [self.marr_IncomeRecords addObjectsFromArray:mPageData.list];
                havaMore = self.marr_IncomeRecords.count < mPageData.rowCount;
                pageCountScoreIncome = mPageData.rowCount;
                if(self.marr_IncomeRecords == nil || self.marr_IncomeRecords.count <= 0)
                {
                    exceptionView_Score.image = [UIImage imageNamed:@"bg_myGroup_error"];
                    //LocalizedString(@"IntegralListViewController_exceptionViewScore2",
                    exceptionView_Score.title = LocalizedString(@"IntegralListViewController_exceptionViewScore2",@"暂时没有收入记录");
                    [exceptionView_Score setNeedsDisplay];
                    [exceptionView_Score setHidden:NO];
                }
                break;
            }
            case 2:
            {
                pageIndexScoreExpend ++;
                isFirstRequest ? self.marr_ExpendRecords = mPageData.list : [self.marr_ExpendRecords addObjectsFromArray:mPageData.list];
                havaMore = self.marr_ExpendRecords.count < mPageData.rowCount;
                pageCountScoreExpend = mPageData.rowCount;
                if(self.marr_ExpendRecords == nil || self.marr_ExpendRecords.count <= 0)
                {
                    exceptionView_Score.image = [UIImage imageNamed:@"bg_myGroup_error"];
                    //LocalizedString(@"IntegralListViewController_exceptionViewScore3",
                    exceptionView_Score.title = LocalizedString(@"IntegralListViewController_exceptionViewScore3",@"暂时没有支出记录");
                    [exceptionView_Score setNeedsDisplay];
                    [exceptionView_Score setHidden:NO];
                }
                break;
            }
        }
        [tab_ScoreRecords.tableView reloadData];
        //判断是否可以获取更多
        [tab_ScoreRecords doAfterRequestSuccess:isFirstRequest AndHavaMore:havaMore];
    }
    else
    {
        if (isFirstRequest)
        {
            [tab_ScoreRecords hideLoadingView];
        }
        
        [tab_ScoreRecords doAfterRequsetFailure:isFirstRequest errorInfo:repeater.errorInfo];
        
    }
    [tab_ScoreRecords.view setUserInteractionEnabled:YES];
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
    UserScore *mUserScore = nil;
    switch (showFlag)
    {
        case 0:
        {
            mUserScore = [self.marr_AllRecords objectAtIndex:indexPath.row];
            break;
        }
        case 1:
        {
            mUserScore = [self.marr_IncomeRecords objectAtIndex:indexPath.row];
            break;
        }
        case 2:
        {
            mUserScore = [self.marr_ExpendRecords objectAtIndex:indexPath.row];
            break;
        }
        default:
            break;
    }
    
    NSString *str_Explain = mUserScore.description;
    CGSize size_Explain = [str_Explain sizeWithFont:DEFAULT_FONT(15.0f)
                                  constrainedToSize:CGSizeMake(MainScreenFrame_Height - 34.0f, 500.0f)
                                      lineBreakMode:NSLineBreakByCharWrapping];
    if(size_Explain.height >= 30)
    {
        return 75.0f + size_Explain.height;
    }
    else
    {
        return 75.0f;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str_Expend = @"ExpendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str_Expend];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str_Expend];
        //金额
        UILabel *lab_Money = [[UILabel alloc] initWithFrame:CGRectMake(17.0f, 15.0f, 145.0f, 21.0f)];
        lab_Money.tag = 6001;
        lab_Money.backgroundColor = PL_COLOR_CLEAR;
        lab_Money.font = DEFAULT_FONT(20.0f);
        lab_Money.textAlignment = UITextAlignmentLeft;
        [cell.contentView addSubview:lab_Money];
        
        //时间
        UILabel *lab_Date = [[UILabel alloc] initWithFrame:CGRectMake(150.0f, 15.0f, cell.frame.size.width - 170.0f, 16.0f)];
        lab_Date.tag = 6002;
        lab_Date.backgroundColor = PL_COLOR_CLEAR;
        lab_Date.font = DEFAULT_FONT(15.0f);
        lab_Date.textColor = [PanliHelper colorWithHexString:@"#acacac"];
        lab_Date.textAlignment = UITextAlignmentRight;
        [cell.contentView addSubview:lab_Date];
        
        //说明
        UILabel *lab_Explain = [[UILabel alloc] initWithFrame:CGRectMake(17.0f, 46.0f, Right_SpliteView_Width - 34.0f, 16.0f)];
        lab_Explain.tag = 6003;
        lab_Explain.backgroundColor = PL_COLOR_CLEAR;
        lab_Explain.font = DEFAULT_FONT(15.0f);
        lab_Explain.textColor = [PanliHelper colorWithHexString:@"#444444"];
        lab_Explain.textAlignment = UITextAlignmentLeft;
        lab_Explain.numberOfLines = 0;
        [cell.contentView addSubview:lab_Explain];
        
        //线条
        UIView *line_Top = [[UIView alloc] initWithFrame:CGRectMake(0.0f,73.0f,Right_SpliteView_Width,1.0f)];
        line_Top.backgroundColor = [PanliHelper colorWithHexString:@"#f4f4f4"];
        line_Top.tag = 6005;
        [cell.contentView addSubview:line_Top];
        
        UIView *line_Bottom = [[UIView alloc] initWithFrame:CGRectMake(0.0f,74.0f,Right_SpliteView_Width,1.0f)];
        line_Bottom.backgroundColor = [PanliHelper colorWithHexString:@"#dfdfdf"];
        line_Bottom.tag = 6006;
        [cell.contentView addSubview:line_Bottom];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UserScore *mUserScore = nil;
    switch (showFlag)
    {
        case 0:
        {
            mUserScore = [self.marr_AllRecords objectAtIndex:indexPath.row];
            break;
        }
        case 1:
        {
            mUserScore = [self.marr_IncomeRecords objectAtIndex:indexPath.row];
            break;
        }
        case 2:
        {
            mUserScore = [self.marr_ExpendRecords objectAtIndex:indexPath.row];
            break;
        }
        default:
            break;
    }
    
    UILabel *lab_Money = (UILabel*)[cell.contentView viewWithTag:6001];
    UILabel *lab_Date = (UILabel*)[cell.contentView viewWithTag:6002];
    UILabel *lab_Explain = (UILabel*)[cell.contentView viewWithTag:6003];
    
    if(mUserScore.type == 1)
    {
        lab_Money.textColor = [PanliHelper colorWithHexString:@"#4ea700"];
        lab_Money.text = [NSString stringWithFormat:@"+%d",mUserScore.score];
    }
    else
    {
        lab_Money.textColor = [PanliHelper colorWithHexString:@"#fc0201"];
        lab_Money.text = [NSString stringWithFormat:@"-%d",abs(mUserScore.score)];
    }
    
    NSString *str_Explain = mUserScore.description;
    CGSize size_Explain = [str_Explain sizeWithFont:DEFAULT_FONT(15.0f)
                                  constrainedToSize:CGSizeMake(Right_SpliteView_Width - 34.0f, 500.0f)
                                      lineBreakMode:NSLineBreakByCharWrapping];
    lab_Explain.frame = CGRectMake(17.0f, 46.0f, size_Explain.width, size_Explain.height);
    //判断线条位置
    UIView *line_Top = (UIView*)[cell.contentView viewWithTag:6005];
    UIView *line_Bottom = (UIView*)[cell.contentView viewWithTag:6006];
    if(size_Explain.height >= 30)
    {
        line_Top.frame = CGRectMake(0.0f, 46.0f + size_Explain.height + 15.0f - 4, Right_SpliteView_Width, 1.0f);
    }
    else
    {
        line_Top.frame = CGRectMake(0.0f, 73.0f, 320.0f, 1.0f);
    }
    line_Bottom.frame = CGRectMake(0.0f, line_Top.frame.origin.y + 1.0f, Right_SpliteView_Width, 1.0f);
    lab_Explain.text = str_Explain;
    lab_Date.text = [PanliHelper timestampToDateString:mUserScore.tradeTime formatterString:@"yyyy-MM-dd hh:mm:ss"];
    return cell;
}

#pragma mark - filterView delegate displayState
- (void)filterSelectDone:(int)index isChange:(BOOL)changed
{
    [self filterViewAction];
    showFlag = index;
    exceptionView_Score.hidden = YES;
    switch (index) {
        case 0:
        {
            //LocalizedString(@"IntegralListViewController_btnNavOrder1",
            [btnNavOrder setTitle:LocalizedString(@"IntegralListViewController_btnNavOrder1",@"全部积分记录") forState:UIControlStateNormal];
            imgFilterIcon.frame = CGRectMake(120.0f, 18.0f, 11.0, 7.5f);
            if(self.marr_AllRecords == nil || self.marr_AllRecords.count <= 0)
            {
                [tab_ScoreRecords requestData:YES];
            }
            
            break;
        }
        case 1:
        {
            //LocalizedString(@"IntegralListViewController_btnNavOrder2",
            [btnNavOrder setTitle:LocalizedString(@"IntegralListViewController_btnNavOrder2",@"获得积分") forState:UIControlStateNormal];
            imgFilterIcon.frame = CGRectMake(100.0f, 18.0f, 11.0, 7.5f);
            if(self.marr_IncomeRecords == nil || self.marr_IncomeRecords.count <= 0)
            {
                [tab_ScoreRecords requestData:YES];
            }
            break;
        }
        case 2:
        {
            //LocalizedString(@"IntegralListViewController_btnNavOrder3",
            [btnNavOrder setTitle:LocalizedString(@"IntegralListViewController_btnNavOrder3",@"消耗积分") forState:UIControlStateNormal];
            imgFilterIcon.frame = CGRectMake(100.0f, 18.0f, 11.0, 7.5f);
            if(self.marr_ExpendRecords == nil || self.marr_ExpendRecords.count <= 0)
            {
                [tab_ScoreRecords requestData:YES];
            }
            break;
        }
        default:
            break;
    }
    [tab_ScoreRecords.tableView reloadData];
    //判断是否有下一页
    BOOL havaMore = NO;
    switch (showFlag)
    {
        case 0:
        {
            havaMore = self.marr_AllRecords.count < pageCountScoreAll;
            break;
        }
        case 1:
        {
            havaMore = self.marr_IncomeRecords.count < pageCountScoreIncome;
            break;
        }
        case 2:
        {
            havaMore = self.marr_ExpendRecords.count < pageCountScoreExpend;
            break;
        }
    }
    //判断是否可以获取更多
    [tab_ScoreRecords doAfterRequestSuccess:isFirstRequest AndHavaMore:havaMore];
}

- (void)filterViewAction
{
    self.navigationItem.titleView.userInteractionEnabled = NO;
    if (filterView.hidden)
    {
        [UIView animateWithDuration:0.4f animations:^{
            filterView.hidden = NO;
            filterView.alpha = 1.0f;
            imgFilterIcon.hidden = YES;
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
