//
//  MessageDetailViewController.m
//  PanliApp
//
//  Created by Liubin on 13-4-18.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "Message.h"
#import "MessageDetailCell.h"
#import "UserInfo.h"
#import "SVWebViewController.h"
#import "MsgProductDetailViewController.h"
#import "ShipDetailViewController.h"
#import "CustomerNavagationBarController.h"

static int DataIndex = 1;//数据起点
static int pageIndex = 1;//当前页码
static int pageSize = 10;//页尺寸
#define TOP_BG_HIDE 60.0f
@interface MessageDetailViewController ()

@end

@implementation MessageDetailViewController
@synthesize str_messageTopic = _str_messageTopic;
@synthesize str_objectId = _str_objectId;
@synthesize messageType = _messageType;
@synthesize messageTopicId = _messageTopicId;
@synthesize str_Image = _str_Image;
@synthesize messageGetDetailId = _messageGetDetailId;
#pragma mark - default
- (void)dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    
    SAFE_RELEASE(tab_MessageTable);
    SAFE_RELEASE(req_MessageDetailRequest);
    SAFE_RELEASE(req_SendMsgByTopicIdRequest);
    SAFE_RELEASE(req_MessageObjectcsRequest);
    SAFE_RELEASE(req_SendMsgByObjectIdRequest);
    SAFE_RELEASE(mArr_messageArray);
    SAFE_RELEASE(_str_messageTopic);
    SAFE_RELEASE(_str_objectId);
    SAFE_RELEASE(dataRepeater);
    SAFE_RELEASE(_str_Image);
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
//    [super viewDidLoadWithBackButtom:YES];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = LocalizedString(@"MessageDetailViewController_Nav_Title",@"短信详情");
    self.view.backgroundColor = [PanliHelper colorWithHexString:@"#f9f9f9"];
    //底部留言view
    view_BottomMessageView = [[MessageDetailBottomView alloc] initWithFrame:CGRectMake(0, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT - 328 - 40, MainScreenFrame_Width - 65,40)];
     [self.view addSubview:view_BottomMessageView];
    [view_BottomMessageView release];
    
    //短信列表
    tab_MessageTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width - 65, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT - 328 - 40.0f) style:UITableViewStylePlain];
    tab_MessageTable.backgroundColor = [PanliHelper colorWithHexString:@"#f9f9f9"];
    tab_MessageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    tab_MessageTable.delegate = self;
    tab_MessageTable.dataSource = self;
    [PanliHelper setExtraCellLineHidden:tab_MessageTable];
    [PanliHelper setExtraCellPixelExcursion:tab_MessageTable];
    [self.view insertSubview:tab_MessageTable belowSubview:view_BottomMessageView];
    
    UIButton *btn_input = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_input setBackgroundImage:nil forState:UIControlStateNormal];
    [btn_input setFrame:CGRectMake(0, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT - 328 - 40, MainScreenFrame_Width - 65,40)];
    [btn_input addTarget:self action:@selector(showMessageView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_input];
    
    //商品详情 及运单详情 topheadView
    [self reloadTopHead];
    
    //弹出回复消息view
    view_PopMessageView = [[MessagePopView alloc] initWithFrame:CGRectMake(0, MainScreenFrame_Width - 20 - UI_NAVIGATION_BAR_HEIGHT - 72, MainScreenFrame_Width - 65, 120)];
     [view_PopMessageView.btn_PopButton addTarget:self action:@selector(sendMessageRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:view_PopMessageView];
    [view_PopMessageView release];
    
    
    //下拉刷新View
    _headView = [[CustomLoadingView alloc] initWithFrame:CGRectMake(0, -70, MainScreenFrame_Width - 65, 80) andType:foot_none andKey:nil imageDown:[UIImage imageNamed:@"icon_myPanli_RefreshDown"] imageUp:[UIImage imageNamed:@"icon_myPanli_RefreshUP"]];
    [tab_MessageTable addSubview:_headView];
    [_headView release];

    //添加手势
    UITapGestureRecognizer *hideMessageTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMessageView)];
    [hideMessageTap setNumberOfTapsRequired:1];
    [hideMessageTap setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:hideMessageTap];
    [hideMessageTap release];
    
          
    //发送数据请求
    [self sendRequset:YES isShow:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    
//    //注册获取消息详细通知
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(getMessageResponse:)
//                                                 name:RQNAME_USERMESSAGEDETAIL
//                                               object:nil];
//    
//    //注册发送消息通知
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(sendMessageResponse:)
//                                                 name:RQNAME_SENDMESSAGEBYTOPICID
//                                               object:nil];
//    
//    //文本超链接
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(MessageUrlClick:)
//                                                 name:@"MESSAGECLICKURL"
//                                               object:nil];
    
    // 键盘高度变化通知
    if (SYSTEM_VERSION_GREATER_THAN(@"5.0") )
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHeightChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    }
    
    
    //键盘隐藏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];


}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadTopHead
{
    UIButton *btn_Click = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Click.frame = CGRectMake(0, 0, MainScreenFrame_Width - 65, 90.0f);
    btn_Click.backgroundColor = PL_COLOR_CLEAR;
    [btn_Click addTarget:self action:@selector(goDetailClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_Click];
    tab_MessageTable.tableHeaderView = btn_Click;
    //背景图
    UIImageView *topBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MainScreenFrame_Width - 65.0f, 90.0f)];
    [topBackground setImage:[PanliHelper getImageFileByName:@"bg_msgDetail_topic@2x.png"]];
    [btn_Click addSubview:topBackground];
    [topBackground release];
    
    //商品图片
    CustomUIImageView *img_icon = [[CustomUIImageView alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 70.0f, 70.0f)];
    [btn_Click addSubview:img_icon];
    [img_icon release];
    
    //关于
    UILabel *lab_Topic = [[UILabel alloc] initWithFrame:CGRectMake(85.0f, 12.0f, MainScreenFrame_Width-110 - 65, 15.0f)];
    lab_Topic.backgroundColor = PL_COLOR_CLEAR;
    lab_Topic.textColor = [PanliHelper colorWithHexString:@"#5d9083"];
    [btn_Click addSubview:lab_Topic];
    [lab_Topic release];
    
    //商品名
    UILabel *lab_ProductName = [[UILabel alloc] initWithFrame:CGRectMake(85.0f, 20.0f, MainScreenFrame_Width-110 - 65, 70.0f)];
    lab_ProductName.backgroundColor = PL_COLOR_CLEAR;
    lab_ProductName.numberOfLines = 2;
    lab_ProductName.textColor = [PanliHelper colorWithHexString:@"#5d9083"];
    [btn_Click addSubview:lab_ProductName];
    [lab_ProductName release];

    UIImage *img_Arrow = [UIImage imageNamed:@"icon_msgDetail_arrow"];
    UIImageView *img_arrow = [[UIImageView alloc] init];
    img_arrow.image = img_Arrow;
    img_arrow.frame = CGRectMake(MainScreenFrame_Width - 110.0f, (90.0f - img_Arrow.size.height)/2, img_Arrow.size.width, img_Arrow.size.height);
    [btn_Click addSubview:img_arrow];
    [img_arrow release];
    //判断商品短信与运单短信
    if (_messageType == OrderMessage)
    {
        img_icon.layer.cornerRadius = 5.0f;
        img_icon.layer.masksToBounds = YES;
        img_icon.layer.borderColor = [PanliHelper colorWithHexString:@"#82BEBF"].CGColor;
        img_icon.layer.borderWidth = 1.5f;

        [img_icon setCustomImageWithURL:[NSURL URLWithString:_str_Image]
                       placeholderImage:[UIImage imageNamed:@"icon_product"]];
        
        NSString *list = _str_messageTopic;
        NSArray *listItems = [list componentsSeparatedByString:@":"];
        lab_Topic.text = [NSString stringWithFormat:@"%@",[listItems objectAtIndex:0]];
        lab_ProductName.text = [NSString stringWithFormat:@"%@",[listItems objectAtIndex:1]];
    }
    else
    {
        img_icon.image = [UIImage imageNamed:@"icon_msgDetail_ship"];
        
        lab_Topic.frame = CGRectMake(85.0f, 12.0f, MainScreenFrame_Width-110 - 65, 70.0f);
        lab_Topic.numberOfLines = 2;
        lab_Topic.text = [NSString stringWithFormat:@"%@",_str_messageTopic];
    }
}

- (void)showMessageView
{
    [view_PopMessageView.txt_InputView becomeFirstResponder];
}

- (void)hideMessageView
{
    [view_PopMessageView.txt_InputView resignFirstResponder];
}

#pragma mark - request and response
-(void)sendRequset:(BOOL)isFirst isShow:(BOOL)isShow
{
    _isFirst = isFirst;
    if(isShow)
    {
        [self showLoadingView];
    }
    //判断第一次加载
    if (_isFirst)
    {
        pageIndex = 1;
        pageSize = 10;
    }
    //计算从那一条数据开始获取
    DataIndex = pageSize * (pageIndex - 1) + 1;
    [self.view setUserInteractionEnabled:NO];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];    
    //数据转发器
    if (dataRepeater)
    {
        [dataRepeater release];
        dataRepeater = nil;
    }
    dataRepeater = [[DataRepeater alloc] initWithName:RQNAME_USERMESSAGEDETAIL];
    dataRepeater.notificationName = RQNAME_USERMESSAGEDETAIL;
    dataRepeater.requestModal = PullData;
    //通过短信主题ID获取短信
    if (_messageTopicId)
    {
        req_MessageDetailRequest = req_MessageDetailRequest ? req_MessageDetailRequest : [[MessageDetailRequest alloc] init];
        NSNumber *num_topicId = [[NSNumber alloc] initWithInt:self.messageTopicId];
        [params setValue:num_topicId forKey:RQ_MESSAGEDETAIL_PARAM_TOPICID];
        [params setValue:[NSString stringWithFormat:@"%d", DataIndex] forKey:RQ_MESSAGEDETAIL_PARAM_INDEX];
        [params setValue:[NSString stringWithFormat:@"%d", pageSize] forKey:RQ_MESSAGEDETAIL_PARAM_COUNT];
        
        dataRepeater.requestParameters = params;
        dataRepeater.networkRequest = req_MessageDetailRequest;
        [num_topicId release];
        
    }
    //通过objId发送短信
    else
    {
        req_MessageObjectcsRequest = req_MessageObjectcsRequest ? req_MessageObjectcsRequest : [[MessageObjectcsRequest alloc] init];
        [params setValue:_str_objectId forKey:RQ_MESSAGEBYOBJECTID_PARAM_OBJECTID];
        [params setValue:[[[NSNumber alloc] initWithInt:_messageType] autorelease] forKey:RQ_MESSAGEBYOBJECTID_PARAM_OBJECTTYPE];
        [params setValue:[NSString stringWithFormat:@"%d", DataIndex]  forKey:RQ_MESSAGEBYOBJECTID_PARAM_INDEX];
        [params setValue:[NSString stringWithFormat:@"%d", pageSize] forKey:RQ_MESSAGEBYOBJECTID_PARAM_PAGESIZE];
        
        dataRepeater.requestParameters = params;
        dataRepeater.networkRequest = req_MessageObjectcsRequest;
    }
    [params release];
    
    dataRepeater.isAuth = YES;
    __unsafe_unretained __typeof(self) weakSelf = self;
    dataRepeater.compleBlock = ^(id repeater){
        [weakSelf getMessageResponse:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:dataRepeater];
    
}

- (void)getMessageResponse:(DataRepeater *)repeater
{
    [self hideLoadingView];
    
    if (repeater.isResponseSuccess)
    {
        BOOL havaMore;
        if (_isFirst)
        {
            if (mArr_messageArray)
            {
                SAFE_RELEASE(mArr_messageArray);
            }            
            mArr_messageArray = [NSMutableArray new];
            [mArr_messageArray addObjectsFromArray:repeater.responseValue];            
            [tab_MessageTable reloadData];
            if(mArr_messageArray.count > 0)
            {
                [tab_MessageTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[mArr_messageArray count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }
        }
        else
        {
            [mArr_messageArray addObjectsFromArray:repeater.responseValue];
            [tab_MessageTable reloadData];
        }
        pageIndex++;
        //判断是否可以获取更多
        havaMore = repeater.responseValue != nil && ((NSArray *)repeater.responseValue).count > 0 && ([mArr_messageArray count] % pageSize == 0) && [mArr_messageArray count] >0;
        if(!havaMore)
        {
            [self hideHeadLoadingView:YES];
        }
        else
        {
            [self hideHeadLoadingView:NO];
        }
    }
    else
    {        
        ErrorInfo* errorInfo = repeater.errorInfo;
        [self showHUDErrorMessage:errorInfo.message];
    }
    [self.view setUserInteractionEnabled:YES];
}

/**
 *发送消息请求
 */
- (void)sendMessageRequest
{
    str_MessageTemp = view_PopMessageView.txt_InputView.text;
    if ([NSString isEmpty:str_MessageTemp])
    {
        [self showHUDErrorMessage:LocalizedString(@"MessageDetailViewController_HUDErrMsg",@"请输入短信内容")];
        return;
    }
    [self.view endEditing:YES];
    [self showHUDIndicatorMessage:LocalizedString(@"MessageDetailViewController_HUDIndMsg",@"正在提交...")];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];    
    //数据转发器
    if (dataRepeater)
    {
        [dataRepeater release];
        dataRepeater = nil;
    }
    dataRepeater = [[DataRepeater alloc] initWithName:RQNAME_SENDMESSAGEBYTOPICID];
    dataRepeater.notificationName = RQNAME_SENDMESSAGEBYTOPICID;
    dataRepeater.requestModal = PushData;
    if (_messageTopicId)
    {
        if (!req_SendMsgByTopicIdRequest)
        {
            req_SendMsgByTopicIdRequest = [[SendMsgByTopicIdRequest alloc] init];
        }
        [params setValue:[NSString stringWithFormat:@"%d",_messageTopicId] forKey:RQ_SENDMESSAGEBYTOPIDID_PARAM_TOPICID];
        [params setValue:str_MessageTemp forKey:RQ_SENDMESSAGEBYTOPIDID_PARAM_CONTENT];                        
        dataRepeater.requestParameters = params;        
        dataRepeater.networkRequest = req_SendMsgByTopicIdRequest;
    }
    else
    {
        if (!req_SendMsgByObjectIdRequest)
        {
            req_SendMsgByObjectIdRequest = [[SendMsgByObjectIdRequest alloc] init];
        }
        [params setValue:_str_objectId forKey:RQ_SENDMESSAGEBYOBJECTID_PARAM_OBJECTID];
        NSString *str_Type;
        switch (_messageType)
        {
            case OrderMessage:
                str_Type = @"Product";
                break;
            case ShipMessage:
                str_Type = @"Shipment";
                break;
            case PackageMessage:
                str_Type = @"Parcel";
                break;                
            default:
                break;
        }
        [params setValue:str_Type forKey:RQ_SENDMESSAGEBYOBJECTID_PARAM_OBJECTTYPE];
        [params setValue:str_MessageTemp forKey:RQ_SENDMESSAGEBYOBJECTID_PARAM_CONTENT];
        dataRepeater.requestParameters = params;
        dataRepeater.networkRequest = req_SendMsgByObjectIdRequest;
    }
    [params release];
    
    dataRepeater.isAuth = YES;
    __unsafe_unretained __typeof(self) weakSelf = self;
    dataRepeater.compleBlock = ^(id repeater){
        [weakSelf sendMessageResponse:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:dataRepeater];
}

- (void)sendMessageResponse:(DataRepeater *)repeater
{
    if (repeater.isResponseSuccess)
    {
        [self showHUDSuccessMessage:LocalizedString(@"MessageDetailViewController_HUDSucMsg",@"发送成功")];
        [self sendRequset:YES isShow:NO];
    }
    else
    {
        [self showHUDErrorMessage:repeater.errorInfo.message];
    }
}

#pragma mark - CustomTableViewController Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mArr_messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"messageCell";
    MessageDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[[MessageDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [PanliHelper colorWithHexString:@"#f9f9f9"];
    }
    Message *message = [mArr_messageArray objectAtIndex:mArr_messageArray.count - indexPath.row - 1];
    [cell setMessageData:message];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat defaultHeight = 40.0f;
    Message *message = [mArr_messageArray objectAtIndex:mArr_messageArray.count - indexPath.row - 1];
    CGSize size = [message.content sizeWithFont:DEFAULT_FONT(15)
                              constrainedToSize:CGSizeMake(MainScreenFrame_Width - 82, 700.0f)
                                  lineBreakMode:NSLineBreakByCharWrapping];
    if (indexPath.row == mArr_messageArray.count -1)
    {
        return defaultHeight +size.height + 10.0f + 2.0f + 15;

    }
    else
    {
        return defaultHeight +size.height + 10.0f + 2.0f;

    }
}

- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
   
    Message *message = [mArr_messageArray objectAtIndex:mArr_messageArray.count - indexPath.row - 1];
    if (message.isOwn)
    {
        cell.backgroundColor = [PanliHelper colorWithHexString:@"#ebebed"];
    }
}



#pragma mark - keyboard event
- (void)keyboardHeightChange:(NSNotification *)notification
{
    //记录最后一次键盘高度
    static CGFloat lastKeyboardHeight = UI_KAYBOARD_HEIGHT;
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
   //本次键盘高度与上次键盘高度差值
    CGFloat distanceToMove = kbSize.width - lastKeyboardHeight;
    lastKeyboardHeight = kbSize.width;
    CGRect rect = view_PopMessageView.frame;

    //留言窗口第一次弹出
    if (rect.origin.y == MainScreenFrame_Width - 20 - UI_NAVIGATION_BAR_HEIGHT - 72)
    {
        [UIView animateWithDuration:0.25 animations:^{
            view_PopMessageView.frame = CGRectOffset(rect, 0.0, -rect.size.height - kbSize.width);
        }completion:^(BOOL finished){}];
    }
    else
    {
        [UIView animateWithDuration:0.25 animations:^{
            view_PopMessageView.frame = CGRectOffset(rect, 0, -distanceToMove);
        } completion:^(BOOL finished) {}];
    }
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;        
    CGRect rect = view_PopMessageView.frame;        
    if (rect.origin.y == MainScreenFrame_Width - 20 - UI_NAVIGATION_BAR_HEIGHT - 72)
    {
        [UIView animateWithDuration:0.25 animations:^{
            
            view_PopMessageView.frame = CGRectOffset(rect, 0.0, -rect.size.height - kbSize.height);
            
        }completion:^(BOOL finished){}];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{    
    CGRect f = view_PopMessageView.frame;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        view_PopMessageView.frame = CGRectOffset(view_PopMessageView.frame, 0.0, f.size.height + 216);
    }completion:^(BOOL finished){
                         
        view_PopMessageView.frame = CGRectMake(0, MainScreenFrame_Width - 20 - UI_NAVIGATION_BAR_HEIGHT - 72, MainScreenFrame_Width - 65, 120);
        [view_PopMessageView.txt_InputView setText:@""];

        }];
}

#pragma mark - click
- (void)goDetailClick
{
    if(_messageType == OrderMessage)
    {
        MsgProductDetailViewController *vProductDetail = [[[MsgProductDetailViewController alloc]init]autorelease];
        vProductDetail.str_ProductId = [NSString stringWithFormat:@"%@",_messageGetDetailId];
        [self.navigationController pushViewController:vProductDetail animated:YES];
    }
    else
    {
        //ShipOrder *ShipData=[mArr_ShipDetail objectAtIndex:indexPath.row];
        ShipDetailViewController *v_WayBill = [[[ShipDetailViewController alloc]init]autorelease];
        v_WayBill.str_ShipId = _str_objectId;
        // v_WayBill.superStatus = 3;
        //v_WayBill.str_ShipExpressUrl = ShipData.expressUrl;
        //v_WayBill.str_ShipExpressNo = ShipData.packageCode;
        v_WayBill.navigationItem.rightBarButtonItem = nil;
        [self.navigationController pushViewController:v_WayBill animated:YES];
    }
}

#pragma mark - 文本超链接
-(void)MessageUrlClick:(NSNotification*)sender
{
    NSNotification *sen = sender.object;
    NSURL *URL = [NSURL URLWithString:sen.object];
	SVWebViewController *webViewController = [[[SVWebViewController alloc] initWithURL:URL] autorelease];
    webViewController.availableActions = SVWebViewControllerAvailableActionsOpenInSafari | SVWebViewControllerAvailableActionsCopyLink ;
    CustomerNavagationBarController *registerViewController = [[[CustomerNavagationBarController alloc] initWithRootViewController:webViewController] autorelease];
	[self.navigationController presentModalViewController:registerViewController animated:YES];
}

#pragma mark - UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //100默认高
    if(!_refreshing)
    {
        if (scrollView.contentOffset.y > -20)
        {
            [_headView changeState:Normal];
            _requestType = no_Request;
        }
        else if (scrollView.contentOffset.y <= -20)
        {
            [_headView changeState:Pulling];
            _requestType = refresh_Request;
        }
        else if (scrollView.contentOffset.y > 0)
        {
            _requestType = no_Request;
        }
    }
    
    if (scrollView.contentOffset.y <= -TOP_BG_HIDE)
    {
        [tab_MessageTable setContentOffset:CGPointMake(0, -TOP_BG_HIDE)];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerat
{
    if(!_refreshing)
    {
        if(_requestType == refresh_Request)
        {
            [self sendRequset:NO isShow:NO];
        }
    }
}
#pragma mark - loadingView
/**
 *显示正在加载
 */
- (void)showLoadingView
{
    _refreshing = YES;
    [_headView changeState:Loading];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [tab_MessageTable setContentInset:UIEdgeInsetsMake(TOP_BG_HIDE, 0, 0, 0)];
    [tab_MessageTable setContentOffset:CGPointMake(0, -TOP_BG_HIDE)];
    [UIView commitAnimations];
}

/**
 *隐藏刷新view
 */
- (void)hideLoadingView
{
    _refreshing = NO;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [tab_MessageTable setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    //    [mainTableView setContentOffset:CGPointMake(0, 0)];
    [UIView commitAnimations];
}
/**
 *隐藏headview
 */
- (void)hideHeadLoadingView:(BOOL)isRequest
{
    _refreshing = isRequest;
    _headView.hidden = isRequest;
}
@end
