//
//  MyGroupBuyViewController.m
//  PanliBuyHD
//
//  Created by ZhaoFucheng on 14-10-29.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "MyGroupBuyViewController.h"
#import "MyJoinCell.h"
#import "GetMyJoinGroupListRequest.h"
#import "CustomerExceptionView.h"
#import "MyJoinGroupBuy.h"
#import "MyJoinGroupBuyProduct.h"
#import "CustomTableViewController.h"
#import "DataRequestManager.h"
//#import "SearchProductDetailViewController.h"
#define MYJOINGUOUPBUY_PRODUCT_ARR(section) ((MyJoinGroupBuy*)[mArr_JoinGroupBuy objectAtIndex:section]).products

@interface MyGroupBuyViewController ()
{
    CustomTableViewController *tab_myJoinGroup;
    BOOL isFirstRequestAll;
    BOOL isJoinGroup;
    CustomerExceptionView *Join_exceptionView;
    GetMyJoinGroupListRequest *req_JoinGroupBuy;
    DataRepeater *rpt_JoinGroupBuy;
    int pageIndexJoin;
    NSMutableArray *mArr_JoinGroupBuy;
}

@end

@implementation MyGroupBuyViewController


- (void)viewDidLoad
{
    [super viewDidLoadWithBackButtom:YES];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.backgroundColor = [PanliHelper colorWithHexString:@"#f4f4f4"];
	self.navigationItem.title = LocalizedString(@"MyGroupBuyViewController_Nav_Title",@"我抱的团");
    self.view.backgroundColor= [PanliHelper colorWithHexString:@"#f6f6f6"];
    pageIndexJoin= 1;
    isFirstRequestAll = YES;
    isJoinGroup = YES;
    
    
    tab_myJoinGroup = [[CustomTableViewController alloc] init];
    tab_myJoinGroup.tableStyle = UITableViewStylePlain;
    tab_myJoinGroup.loadingStyle = head_none;
    tab_myJoinGroup.needRefresh = NO;
    tab_myJoinGroup.view.backgroundColor = [PanliHelper colorWithHexString:@"#EFEFEF"];
    [tab_myJoinGroup setCustomTableViewDelegate:self];
    tab_myJoinGroup.view.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Height, MainScreenFrame_Width);
    tab_myJoinGroup.tableView.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Width - 300, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT - 72);
    tab_myJoinGroup.tableView.backgroundColor = [PanliHelper colorWithHexString:@"#f2f2f2"];
    tab_myJoinGroup.tableView.separatorColor = [UIColor clearColor];
    [PanliHelper setExtraCellLineHidden:tab_myJoinGroup.tableView];
    [self.view addSubview:tab_myJoinGroup.view];
    
    //异常view
    Join_exceptionView = [[CustomerExceptionView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width - 300, MainScreenFrame_Height - 20 - UI_NAVIGATION_BAR_HEIGHT - 72)];
    [Join_exceptionView setHidden:YES];
    [self.view insertSubview:Join_exceptionView atIndex:1000];
    
    //请求我抱的团
    [tab_myJoinGroup requestData:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)customTableView:(CustomTableViewController *)customTableView sendRequset:(BOOL)isFirst
{
    [tab_myJoinGroup hideHeadLoadingView];
    
    [self.view setUserInteractionEnabled:NO];
    if(isFirstRequestAll)
    {
        //请求我抱的团
        [self showHUDIndicatorMessage:LocalizedString(@"MyGroupBuyViewController_HUDIndMsg",@"正在加载...")];
        
        req_JoinGroupBuy = req_JoinGroupBuy ? req_JoinGroupBuy : [[GetMyJoinGroupListRequest alloc] init];
        rpt_JoinGroupBuy = rpt_JoinGroupBuy ? rpt_JoinGroupBuy : [[DataRepeater alloc]initWithName:RQNAME_TUAN_MYBAOTUAN];
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setValue:[NSString stringWithFormat:@"%d",pageIndexJoin] forKey:RQ_MYJOINGROUP_PARM_PAGEINDEX];
        [params setValue:@"10" forKey:RQ_MYJOINGROUP_PARM_PAGECOUNT];
        
        rpt_JoinGroupBuy.isAuth = YES;
        __weak __typeof(self) weakSelf = self;
        rpt_JoinGroupBuy.compleBlock = ^(id repeater){
            [weakSelf JoinGroupBuyResponse:repeater];
        };
        rpt_JoinGroupBuy.requestModal = PullData;
        rpt_JoinGroupBuy.networkRequest = req_JoinGroupBuy;
        rpt_JoinGroupBuy.requestParameters = params;
        [[DataRequestManager sharedInstance] sendRequest:rpt_JoinGroupBuy];
        isFirstRequestAll = NO;
        return;
    }
    else
    {
        Join_exceptionView.hidden = YES;
        isJoinGroup = isFirst;
        req_JoinGroupBuy = req_JoinGroupBuy ? req_JoinGroupBuy : [[GetMyJoinGroupListRequest alloc] init];
        rpt_JoinGroupBuy = rpt_JoinGroupBuy ? rpt_JoinGroupBuy : [[DataRepeater alloc]initWithName:RQNAME_TUAN_MYBAOTUAN];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setValue:[NSString stringWithFormat:@"%d",pageIndexJoin] forKey:RQ_MYJOINGROUP_PARM_PAGEINDEX];
        [params setValue:@"10" forKey:RQ_MYJOINGROUP_PARM_PAGECOUNT];
        
        rpt_JoinGroupBuy.isAuth = YES;
        __weak __typeof(self) weakSelf = self;
        rpt_JoinGroupBuy.compleBlock = ^(id repeater){
            [weakSelf JoinGroupBuyResponse:repeater];
        };        rpt_JoinGroupBuy.requestModal = PullData;
        rpt_JoinGroupBuy.networkRequest = req_JoinGroupBuy;
        rpt_JoinGroupBuy.requestParameters = params;
        [[DataRequestManager sharedInstance] sendRequest:rpt_JoinGroupBuy];
    }
}
#pragma mark - Request && Response
-(void)JoinGroupBuyResponse:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        [self hideHUD];
        tab_myJoinGroup.tableView.separatorColor = [PanliHelper colorWithHexString:@"#e2e2e2"];
        //第一次请求或刷新请求
        if (isJoinGroup)
        {
            if(mArr_JoinGroupBuy)
            {
                SAFE_RELEASE(mArr_JoinGroupBuy);
            }
            mArr_JoinGroupBuy = [NSMutableArray new];
            [mArr_JoinGroupBuy addObjectsFromArray:repeater.responseValue];
            [tab_myJoinGroup.tableView reloadData];
            [tab_myJoinGroup hideLoadingView];
            //如果无商品显示无商品view
            if(mArr_JoinGroupBuy == nil || mArr_JoinGroupBuy.count == 0)
            {
                Join_exceptionView.image = [UIImage imageNamed:@"bg_myGroup_error"];
                Join_exceptionView.title = LocalizedString(@"MyGroupBuyViewController_JoinExceptionView",@"暂时没有抱的团");
                [Join_exceptionView setNeedsDisplay];
                [Join_exceptionView setHidden:NO];
            }
        }
        else
        {
            [mArr_JoinGroupBuy addObjectsFromArray:repeater.responseValue];
            [tab_myJoinGroup.tableView reloadData];
        }
        pageIndexJoin ++ ;
        //判断是否可以获取更多
        BOOL havaMore = repeater.responseValue != nil && ((NSArray *)repeater.responseValue).count > 0 && ([mArr_JoinGroupBuy count] % 10 == 0) && [mArr_JoinGroupBuy count] >0;
        [tab_myJoinGroup doAfterRequestSuccess:isJoinGroup AndHavaMore:havaMore];
    }
    else
    {
        [self hideHUD];
        if (isJoinGroup)
        {
            [tab_myJoinGroup hideLoadingView];
        }
        [tab_myJoinGroup doAfterRequsetFailure:isJoinGroup errorInfo:repeater.errorInfo];
    }
    [self.view setUserInteractionEnabled:YES];
}


#pragma mark - tableview datasource and delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == tab_myJoinGroup.tableView)
    {
        return mArr_JoinGroupBuy.count;
    }
    else
    {
        return 1;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return MYJOINGUOUPBUY_PRODUCT_ARR(section).count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == tab_myJoinGroup.tableView)
    {
        return 40;
    }
    else
    {
        return 0;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView = [[UIView alloc] init];
    MyJoinGroupBuy *m_MyJoin = [mArr_JoinGroupBuy objectAtIndex:section];
    //背景
    UIImageView *backgroundImage = [[UIImageView alloc]init];
    backgroundImage.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Height,40.0f);
    backgroundImage.image = [UIImage imageNamed:@"bg_Cart_CellMain"];
    [sectionHeaderView addSubview:backgroundImage];
    
    //店铺或单品标识图
    UIImageView *img_flag = [[UIImageView alloc] init];
    img_flag.frame = CGRectMake(10.0f, 9.0f, 39.0f,22.0f);
    if(m_MyJoin.groupType)
        img_flag.image = [UIImage imageNamed:@"icon_myGroup_shop"];
    else
        img_flag.image = [UIImage imageNamed:@"icon_myGroup_product"];
    [sectionHeaderView addSubview:img_flag];
    
    //ID
    UILabel *lab_id = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, 10.0f, 100, 20.0f)];
    lab_id.backgroundColor = PL_COLOR_CLEAR;
    lab_id.textColor = [PanliHelper colorWithHexString:@"#4f4f50"];
    lab_id.font = DEFAULT_FONT(16);
    lab_id.text = [NSString stringWithFormat:@"ID:%d",m_MyJoin.tuanId];
    [sectionHeaderView addSubview:lab_id];
    
    //店铺或商品名
    UILabel *lab_Title = [[UILabel alloc]initWithFrame:CGRectMake(140, 10.0f, 170, 20.0f)];
    lab_Title.backgroundColor = PL_COLOR_CLEAR;
    lab_Title.textColor = [PanliHelper colorWithHexString:@"#4f4f50"];
    lab_Title.font = DEFAULT_FONT(16);
    lab_Title.text = [NSString stringWithFormat:@"%@",m_MyJoin.groupName];
    [sectionHeaderView addSubview:lab_Title];
    
    return sectionHeaderView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyJoinGroupBuyProduct *m_GroupBuyProduct;
    NSString *str_SkuRemark;
    CGSize skuSize;
    CGSize singleSize;
    m_GroupBuyProduct = [MYJOINGUOUPBUY_PRODUCT_ARR(indexPath.section) objectAtIndex:indexPath.row];
    str_SkuRemark = [NSString stringWithFormat:LocalizedString(@"MyGroupBuyViewController_strSkuRemark",@"备注:%@"),m_GroupBuyProduct.skuRemark];
    skuSize = [str_SkuRemark sizeWithFont:DEFAULT_FONT(14) constrainedToSize:CGSizeMake(210.0f, 500.0f) lineBreakMode:NSLineBreakByCharWrapping];
    singleSize = [str_SkuRemark sizeWithFont:DEFAULT_FONT(14) constrainedToSize:CGSizeMake(210.0f, 20.0f) lineBreakMode:NSLineBreakByCharWrapping];
    return 100 + skuSize.height - singleSize.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"myJoinGroupCell";
    MyJoinCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = (MyJoinCell *)[[[NSBundle mainBundle] loadNibNamed:@"MyJoinCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    MyJoinGroupBuyProduct *m_GroupBuyProduct = [MYJOINGUOUPBUY_PRODUCT_ARR(indexPath.section) objectAtIndex:indexPath.row];
    [cell SetDataDisplay:m_GroupBuyProduct];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    MyJoinGroupBuyProduct *m_GroupBuyProduct = [MYJOINGUOUPBUY_PRODUCT_ARR(indexPath.section) objectAtIndex:indexPath.row];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    BaseProduct *mBaseProduct = [[BaseProduct alloc] init];
//    mBaseProduct.productName = m_GroupBuyProduct.productName;
//    mBaseProduct.productUrl = m_GroupBuyProduct.productUrl;
//    mBaseProduct.thumbnail = m_GroupBuyProduct.thumbnail;
//    mBaseProduct.price = m_GroupBuyProduct.price;
//    SearchProductDetailViewController *detailVC = [[[SearchProductDetailViewController alloc] init] autorelease];
//    detailVC.mBaseProduct = mBaseProduct;
//    [mBaseProduct release];
//    detailVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
