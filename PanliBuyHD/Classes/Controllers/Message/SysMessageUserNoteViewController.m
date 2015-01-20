//
//  SysMessageUserNoteViewController.m
//  PanliApp
//
//  Created by jason on 13-11-1.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "SysMessageUserNoteViewController.h"
#import "MessageTopic.h"
#import "MessageTopicCell.h"
#import "SysMsgTopic.h"
#import "SysMsgDetailViewController.h"
#import "SVWebViewController.h"
#import "CustomerNavagationBarController.h"

@interface SysMessageUserNoteViewController ()

@end

@implementation SysMessageUserNoteViewController

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(marr_SysMsgArray);
    SAFE_RELEASE(req_SysMsgRequest);
    SAFE_RELEASE(rpt_SysMsg);
    SAFE_RELEASE(tab_SysMsgTable);
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
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

- (void)viewDidLoad
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.backgroundColor = [PanliHelper colorWithHexString:@"#f4f4f4"];;
    //返回按钮
//    [self viewDidLoadWithBackButtom:YES];
    self.navigationItem.title = LocalizedString(@"SysMessageUserNoteViewController_Nav_Title", @"系统通知");
    
    //通知
    tab_SysMsgTable = [[CustomTableViewController alloc] init];
    tab_SysMsgTable.customTableViewDelegate = self;
    tab_SysMsgTable.loadingStyle = head_none;
    tab_SysMsgTable.view.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Width - 300, MainScreenFrame_Height - 20 - UI_NAVIGATION_BAR_HEIGHT - 72);
    tab_SysMsgTable.tableView.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Width - 300, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT - 72);
    tab_SysMsgTable.tableStyle = UITableViewStylePlain;
    tab_SysMsgTable.tableView.backgroundColor = [PanliHelper colorWithHexString:@"#f9f9f9"];
    [PanliHelper setExtraCellLineHidden:tab_SysMsgTable.tableView];
    [self.view addSubview:tab_SysMsgTable.tableView];
    
    //错误提示view
    sys_exceptionView = [[CustomerExceptionView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width - 300, MainScreenFrame_Height - 20 - UI_NAVIGATION_BAR_HEIGHT - 72)];
    [sys_exceptionView setHidden:YES];
    [self.view insertSubview:sys_exceptionView aboveSubview:tab_SysMsgTable.tableView];
    [sys_exceptionView release];
    
    UITapGestureRecognizer *sysExceptionTap = [[UITapGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(tapReload)];
    sysExceptionTap.cancelsTouchesInView = NO;
    [sys_exceptionView addGestureRecognizer:sysExceptionTap];
    [sysExceptionTap release];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(noticeResponse:)
//                                                 name:RQNAME_GETSYSMSG
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(urlClick:)
//                                                 name:@"SYS_MSG_CLICK_URL"
//                                               object:nil];
 
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    isFirstRequestNotice = YES;
    isFirstRequestAll = YES;
    [tab_SysMsgTable requestData:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    isFirstRequestNotice = NO;
    isFirstRequestAll = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - click url 
- (void)urlClick:(NSNotification*)sender
{
    NSArray *arr = sender.object;
    if(arr == nil || arr.count <= 0)
    {
        return;
    }
    int clickRow = [[arr objectAtIndex:0] intValue];
    int urlRow = [[arr objectAtIndex:1] intValue];
    SysMsgTopic *mSysMsgTopic = (SysMsgTopic*)[marr_SysMsgArray objectAtIndex:clickRow];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[mSysMsgTopic.links objectAtIndex:urlRow]]];
    SVWebViewController *webViewController = [[[SVWebViewController alloc] initWithURL:URL] autorelease];
    webViewController.availableActions = SVWebViewControllerAvailableActionsOpenInSafari | SVWebViewControllerAvailableActionsCopyLink ;
    CustomerNavagationBarController *detailViewController = [[[CustomerNavagationBarController alloc] initWithRootViewController:webViewController] autorelease];
    [self.navigationController presentModalViewController:detailViewController animated:YES];
}

#pragma mark - request and response
-(void)customTableView:(CustomTableViewController *)customTableView sendRequset:(BOOL)isFirst
{
    [self.view setUserInteractionEnabled:NO];
    [self.navigationItem.titleView setUserInteractionEnabled:NO];
    //第一次请求
    if (isFirstRequestAll)
    {
        //请求系统通知
        rpt_SysMsg = rpt_SysMsg ? rpt_SysMsg : [[DataRepeater alloc] initWithName:RQNAME_GETSYSMSG];
        req_SysMsgRequest = req_SysMsgRequest ? req_SysMsgRequest : [[GetSysMsgRequest alloc] init];
        NSMutableDictionary *params_notice = [[NSMutableDictionary alloc] init];
        [params_notice setValue:@"1" forKey:RQ_SYSTEMMESSAGE_PARAM_INDEX];
        rpt_SysMsg.requestParameters = params_notice;
        rpt_SysMsg.notificationName = RQNAME_GETSYSMSG;
        rpt_SysMsg.requestModal = PullData;
        rpt_SysMsg.networkRequest = req_SysMsgRequest;
        [params_notice release];
        
        rpt_SysMsg.isAuth = YES;
        __unsafe_unretained __typeof(self) weakSelf = self;
        rpt_SysMsg.compleBlock = ^(id repeater){
            [weakSelf noticeResponse:repeater];
        };
        [[DataRequestManager sharedInstance] sendRequest:rpt_SysMsg];
        
        isFirstRequestAll = NO;
        return;
    }
    //系统通知请求
    else
    {
        [sys_exceptionView setHidden:YES];
        isFirstRequestNotice = isFirst;
        //判断是否是首次加载或刷新操作
        rpt_SysMsg = rpt_SysMsg ? rpt_SysMsg : [[DataRepeater alloc] initWithName:RQNAME_GETSYSMSG];
        req_SysMsgRequest = req_SysMsgRequest ? req_SysMsgRequest : [[GetSysMsgRequest alloc] init];
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        
        if(isFirstRequestNotice)
        {
            [params setValue:@"1" forKey:RQ_SYSTEMMESSAGE_PARAM_INDEX];
        }
        else
        {
            [params setValue:[NSString stringWithFormat:@"%d",marr_SysMsgArray ? (int)marr_SysMsgArray.count + 1: 1] forKey:RQ_SYSTEMMESSAGE_PARAM_INDEX];
        }
        rpt_SysMsg.requestParameters = params;
        rpt_SysMsg.notificationName = RQNAME_GETSYSMSG;
        rpt_SysMsg.requestModal = PullData;
        rpt_SysMsg.networkRequest = req_SysMsgRequest;
        [params release];
        
        rpt_SysMsg.isAuth = YES;
        __unsafe_unretained __typeof(self) weakSelf = self;
        rpt_SysMsg.compleBlock = ^(id repeater){
            [weakSelf noticeResponse:repeater];
        };
        [[DataRequestManager sharedInstance] sendRequest:rpt_SysMsg];
    }
}

- (void)noticeResponse:(DataRepeater *)repeater
{
    if (repeater.isResponseSuccess)
    {
        //第一次请求或刷新请求
        if (isFirstRequestNotice)
        {
            if (marr_SysMsgArray)
            {
                SAFE_RELEASE(marr_SysMsgArray);
            }
            marr_SysMsgArray = [NSMutableArray new];
            
            [marr_SysMsgArray addObjectsFromArray:repeater.responseValue];
            [tab_SysMsgTable.tableView reloadData];
            [tab_SysMsgTable hideLoadingView];
            //如果无商品显示无商品view
            if(marr_SysMsgArray == nil || marr_SysMsgArray.count == 0)
            {
                sys_exceptionView.image = [UIImage imageNamed:@"icon_None_Message"];
                sys_exceptionView.title = LocalizedString(@"SysMessageUserNoteViewController_sysExceptionView_Title", @"暂时没有系统通知");
                sys_exceptionView.detail = LocalizedString(@"SysMessageUserNoteViewController_sysExceptionView_Detail", @"轻击刷新");
                [sys_exceptionView setNeedsDisplay];
                [sys_exceptionView setHidden:NO];
            }
        }
        else
        {
            [marr_SysMsgArray addObjectsFromArray:repeater.responseValue];
            [tab_SysMsgTable.tableView reloadData];
        }
        //判断是否可以获取更多
        BOOL havaMore = repeater.responseValue != nil && ((NSArray *)repeater.responseValue).count > 0 && ([marr_SysMsgArray count] % 10 == 0) && [marr_SysMsgArray count] >0;
        [tab_SysMsgTable doAfterRequestSuccess:isFirstRequestNotice AndHavaMore:havaMore];
    }
    else
    {
        if (isFirstRequestNotice)
        {
            [tab_SysMsgTable hideLoadingView];
        }
        [tab_SysMsgTable doAfterRequsetFailure:isFirstRequestNotice errorInfo:repeater.errorInfo];

    }
    [self.view setUserInteractionEnabled:YES];
    [self.navigationItem.titleView setUserInteractionEnabled:YES];
}


#pragma mark - tableview datasource and delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return marr_SysMsgArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"sysTopicCell";
    MessageTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil)
    {
        cell = [[[MessageTopicCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier: CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    SysMsgTopic * sysMsg = [marr_SysMsgArray objectAtIndex:indexPath.row];
    [cell SetData:sysMsg type:0 indexRow:(int)indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SysMsgTopic *mSysMsgTopic = [marr_SysMsgArray objectAtIndex:indexPath.row];
    CGSize singleLineSize = [mSysMsgTopic.content sizeWithFont:DEFAULT_FONT(14) constrainedToSize:CGSizeMake(MainScreenFrame_Width - 345.0f, 20.0f) lineBreakMode:NSLineBreakByCharWrapping];
    CGSize skuSize = [mSysMsgTopic.content sizeWithFont:DEFAULT_FONT(14) constrainedToSize:CGSizeMake(MainScreenFrame_Width - 345.0f, 500.0f) lineBreakMode:NSLineBreakByCharWrapping];
    if(mSysMsgTopic.links.count > 0)
    {
        if (mSysMsgTopic.links.count % 3 ==0)
        {
            return 25.0f * (mSysMsgTopic.links.count / 3) + skuSize.height - singleLineSize.height + 60.0f;
        }
        else
        {
            return 25.0f * (mSysMsgTopic.links.count / 3 + 1) + skuSize.height - singleLineSize.height + 60.0f;
        }
        
    }
    else
    {
        return skuSize.height - singleLineSize.height + 60.0f;
    }
    
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    SysMsgDetailViewController *sysMsgView = [[[SysMsgDetailViewController alloc]init]autorelease];
//    SysMsgTopic * sysMsg = (SysMsgTopic*)[marr_SysMsgArray objectAtIndex:indexPath.row];
//    sysMsgView.m_SysMsgTopic = sysMsg;
//    ((SysMsgTopic*)[marr_SysMsgArray objectAtIndex:indexPath.row]).isRead = YES;
//    [self.navigationController pushViewController:sysMsgView animated:YES];
//    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//}
#pragma mark - tap
- (void)tapReload
{
    sys_exceptionView.image = nil;
    sys_exceptionView.title = nil;
    sys_exceptionView.detail = nil;
    [sys_exceptionView setNeedsDisplay];
    [sys_exceptionView setHidden:YES];
    isFirstRequestNotice = YES;
    [tab_SysMsgTable requestData:YES];
}


@end
