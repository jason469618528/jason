//
//  MessageUserNoteViewController.m
//  PanliApp
//
//  Created by jason on 13-11-1.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "MessageUserNoteViewController.h"
#import "MessageTopic.h"
#import "MessageTopicCell.h"
#import "MessageDetailViewController.h"

@interface MessageUserNoteViewController ()

@end

@implementation MessageUserNoteViewController

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
    SAFE_RELEASE(marr_MessageArray);
    SAFE_RELEASE(req_MessageRequest);
    SAFE_RELEASE(rpt_Message);
    SAFE_RELEASE(tab_MessageTable);
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [super dealloc];
}
- (void)viewDidLoad
{
    //返回按钮
    [self viewDidLoadWithBackButtom:YES];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = LocalizedString(@"MessageUserNoteViewController_Nav_Title",@"短信箱");
    //短信
    tab_MessageTable = [[CustomTableViewController alloc] init];
    tab_MessageTable.customTableViewDelegate = self;
    tab_MessageTable.loadingStyle = head_none;
    tab_MessageTable.view.frame = CGRectMake(0.0f, 50.0f, 320, MainScreenFrame_Width);
    tab_MessageTable.tableView.frame = CGRectMake(0.0f, 50.0f, 320, MainScreenFrame_Width - UI_NAVIGATION_BAR_HEIGHT);
    tab_MessageTable.tableStyle = UITableViewStylePlain;
    tab_MessageTable.tableView.backgroundColor = [PanliHelper colorWithHexString:@"#E5E5E5"];
    [PanliHelper setExtraCellLineHidden:tab_MessageTable.tableView];
    [PanliHelper setExtraCellPixelExcursion:tab_MessageTable.tableView];
    [self.view addSubview:tab_MessageTable.tableView];
    
    //错误提示view
    msg_exceptionView = [[CustomerExceptionView alloc] initWithFrame:CGRectMake(0.0f, 50.0f, 320, 320 - UI_NAVIGATION_BAR_HEIGHT)];
    [msg_exceptionView setHidden:YES];
    [self.view insertSubview:msg_exceptionView aboveSubview:tab_MessageTable.tableView];
    [msg_exceptionView release];
//    msg_exceptionView.backgroundColor = [UIColor redColor];
    UITapGestureRecognizer *msgExceptionTap = [[UITapGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(tapReload)];
    msgExceptionTap.cancelsTouchesInView = NO;
    [msg_exceptionView addGestureRecognizer:msgExceptionTap];
    [msgExceptionTap release];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(messageResponse:)
//                                                 name:RQNAME_USERMESSAGETOPICS
//                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    isFirstRequestAll = YES;
    isFirstRequestMessage = YES;
    [tab_MessageTable requestData:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    isFirstRequestAll = NO;
    isFirstRequestMessage = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - request and response
-(void)customTableView:(CustomTableViewController *)customTableView sendRequset:(BOOL)isFirst
{
    [self.view setUserInteractionEnabled:NO];
    [self.navigationItem.titleView setUserInteractionEnabled:NO];
    //第一次请求
    if (isFirstRequestAll)
    {
        //请求咨询短信
        rpt_Message = rpt_Message ? rpt_Message : [[DataRepeater alloc] initWithName:RQNAME_USERMESSAGETOPICS];
        req_MessageRequest = req_MessageRequest ? req_MessageRequest : [[MessageTopicCsRequest alloc] init];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setValue:@"1" forKey:RQ_USERMESSAGETOPICCS_PARAM_INDEX];
        rpt_Message.notificationName = RQNAME_USERMESSAGETOPICS;
        rpt_Message.requestModal = PullData;
        rpt_Message.networkRequest = req_MessageRequest;
        rpt_Message.requestParameters = params;
        [params release];
        
        isFirstRequestAll = NO;
        rpt_Message.isAuth = YES;
        __unsafe_unretained __typeof(self) weakSelf = self;
        rpt_Message.compleBlock = ^(id repeater){
            [weakSelf messageResponse:repeater];
        };
        [[DataRequestManager sharedInstance] sendRequest:rpt_Message];
        return;
    }
    //咨询短信请求
    else
    {
        [msg_exceptionView setHidden:YES];
        isFirstRequestMessage = isFirst;
        //判断是否是首次加载或刷新操作
        rpt_Message = rpt_Message ? rpt_Message : [[DataRepeater alloc] initWithName:RQNAME_USERMESSAGETOPICS];
        req_MessageRequest = req_MessageRequest ? req_MessageRequest : [[MessageTopicCsRequest alloc] init];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        if(isFirstRequestMessage)
        {
            [params setValue:@"1" forKey:RQ_USERMESSAGETOPICCS_PARAM_INDEX];
        }
        else
        {
            [params setValue:[NSString stringWithFormat:@"%d",marr_MessageArray ? marr_MessageArray.count + 1 : 1] forKey:RQ_USERMESSAGETOPICCS_PARAM_INDEX];
        }
        rpt_Message.notificationName = RQNAME_USERMESSAGETOPICS;
        rpt_Message.requestModal = PullData;
        rpt_Message.networkRequest = req_MessageRequest;
        rpt_Message.requestParameters = params;
        [params release];
        
        rpt_Message.isAuth = YES;
        __unsafe_unretained __typeof(self) weakSelf = self;
        rpt_Message.compleBlock = ^(id repeater){
            [weakSelf messageResponse:repeater];
        };
        [[DataRequestManager sharedInstance] sendRequest:rpt_Message];
    }
}

- (void)messageResponse:(DataRepeater *)repeater
{
    if (repeater.isResponseSuccess)
    {
        //第一次请求或刷新请求
        if (isFirstRequestMessage)
        {
            if (marr_MessageArray)
            {
                SAFE_RELEASE(marr_MessageArray);
            }
            marr_MessageArray = [NSMutableArray new];
            
            [marr_MessageArray addObjectsFromArray:repeater.responseValue];
            [tab_MessageTable.tableView reloadData];
            [tab_MessageTable hideLoadingView];
            //如果无商品显示无商品view
            if(marr_MessageArray == nil || marr_MessageArray.count == 0)
            {
                msg_exceptionView.image = [UIImage imageNamed:@"icon_None_Message"];
                msg_exceptionView.title = LocalizedString(@"MessageUserNoteViewController_msgExceptionView_Title",@"暂时没有短信");
                msg_exceptionView.detail = LocalizedString(@"MessageUserNoteViewController_msgExceptionView_Detail",@"短信箱");
                [msg_exceptionView setNeedsDisplay];
                [msg_exceptionView setHidden:NO];
            }
        }
        else
        {
            [marr_MessageArray addObjectsFromArray:repeater.responseValue];
            [tab_MessageTable.tableView reloadData];
        }
        //判断是否可以获取更多
        BOOL havaMore = repeater.responseValue != nil && ((NSArray *)repeater.responseValue).count > 0 && ([marr_MessageArray count] % 10 == 0) && [marr_MessageArray count] >0;
        [tab_MessageTable doAfterRequestSuccess:isFirstRequestMessage AndHavaMore:havaMore];
        
    }
    else
    {
        if (isFirstRequestMessage)
        {
            [tab_MessageTable hideLoadingView];
        }
        [tab_MessageTable doAfterRequsetFailure:isFirstRequestMessage errorInfo:repeater.errorInfo];
    }
    [self.view setUserInteractionEnabled:YES];
    [self.navigationItem.titleView setUserInteractionEnabled:YES];
}

#pragma mark - tableview datasource and delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  marr_MessageArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"messageTopicCell";
    MessageTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil)
    {
        cell = [[[MessageTopicCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier: CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    MessageTopic *messageTopic = [marr_MessageArray objectAtIndex:indexPath.row];
    [cell SetData:messageTopic type:1 indexRow:(int)indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageDetailViewController *messageDetail = [[[MessageDetailViewController alloc] init] autorelease];
    MessageTopic *topic = (MessageTopic *)[marr_MessageArray objectAtIndex:indexPath.row];
    messageDetail.messageTopicId = topic.topicId;
    messageDetail.str_messageTopic = topic.title;
    messageDetail.str_objectId = topic.objId;
    messageDetail.messageType = topic.objType;
    messageDetail.str_Image = topic.image;
    messageDetail.messageGetDetailId = topic.objId;
    ((MessageTopic *)[marr_MessageArray objectAtIndex:indexPath.row]).isRead = YES;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.navigationController pushViewController:messageDetail animated:YES];
}
#pragma mark - tap
- (void)tapReload
{
    msg_exceptionView.image = nil;
    msg_exceptionView.title = nil;
    msg_exceptionView.detail = nil;
    [msg_exceptionView setNeedsDisplay];
    [msg_exceptionView setHidden:YES];
    isFirstRequestMessage = YES;
    [tab_MessageTable requestData:YES];
}


@end
