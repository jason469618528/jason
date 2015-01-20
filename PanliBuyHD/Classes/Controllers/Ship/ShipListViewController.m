//
//  ShipDetailViewController.m
//  PanliApp
//
//  Created by jason on 13-4-23.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShipListViewController.h"
#import "ShipOrder.h"
#import "ShipListCell.h"
#import "ExpressInfo.h"
#import "SVWebViewController.h"
#import "MessageDetailViewController.h"
#import "UserInfo.h"
#define TABLEVIEW_HEIGHT MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT

@interface ShipListViewController ()
@end

@implementation ShipListViewController
@synthesize ShipState = _ShipState;
@synthesize mArr_AllShip = _mArr_AllShip;
#pragma mark - default
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_mArr_AllShip);
    SAFE_RELEASE(req_AllShip);
    SAFE_RELEASE(rpt_AllShip);
    tab_AllShipList.delegate = nil;
    tab_AllShipList.dataSource = nil;
    SAFE_RELEASE(_shipUnReadMessages);
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

- (void)viewDidLoad
{
    //返回按钮
//    [self viewDidLoadWithBackButtom:YES];
    self.navigationItem.title = LocalizedString(@"ShipListViewController_Nav_Title",@"我的运单");
    tab_AllShipList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenFrame_Width - LEFT_SPLITEVIEW_WIDTH, MainScreenFrame_Height - TOOLBAR_WIDTH)];
    tab_AllShipList.dataSource = self;
    tab_AllShipList.delegate = self;
    tab_AllShipList.separatorColor = [PanliHelper colorWithHexString:@"#c8d5dc"];
    tab_AllShipList.backgroundColor = [PanliHelper colorWithHexString:@"#eeeeeb"];
    [PanliHelper setExtraCellLineHidden:tab_AllShipList];
    [self.view addSubview:tab_AllShipList];
    [tab_AllShipList release];
    
    AllShip_exceptionView = [[CustomerExceptionView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width-300, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT - 28)];
    [AllShip_exceptionView setHidden:YES];
    [self.view insertSubview:AllShip_exceptionView aboveSubview:tab_AllShipList];
    
    
    [AllShip_exceptionView release];
//    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(SendMessages:)
                                                 name:@"SHIPSLIST_SENDMESSAGE"
                                               object:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self checkLoginWithBlock:^{
        //请求
        [self RequestAllShip];
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.mArr_AllShip)
    {
        [tab_AllShipList reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - sendmessage
- (void)SendMessages:(NSNotification*)sender
{
    ShipOrder* mShipOrderTemp = (ShipOrder*)sender.object;
    MessageDetailViewController *v_MsgDetail = [[[MessageDetailViewController alloc]init]autorelease];
    v_MsgDetail.str_objectId = mShipOrderTemp.orderId;
    v_MsgDetail.messageType = ShipMessage;
    v_MsgDetail.str_messageTopic = [NSString stringWithFormat:LocalizedString(@"ShipListViewController_vMsgDetail",@"关于运单(%@)的短信"),mShipOrderTemp.orderId];
    [self.navigationController pushViewController:v_MsgDetail animated:YES];
    
    //判断是否已读
    NSArray *arr_TempAllShip = [self.mArr_AllShip filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.orderId = %@",mShipOrderTemp.orderId]];
    
    if (arr_TempAllShip != nil && arr_TempAllShip.count > 0)
    {
        ((ShipOrder*)[arr_TempAllShip objectAtIndex:0]).haveUnreadMessage = NO;
    }
    [tab_AllShipList reloadData];
 }

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isAllShipMore)
    {
        return self.mArr_AllShip.count + 1;
    }
    else
    {
        return self.mArr_AllShip.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 77.5;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == self.mArr_AllShip.count)
    {
        static NSString * string = @"AllShipMoreCell";
        UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:string];
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string]autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = PL_COLOR_CLEAR;
        }
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
        cell.indentationLevel = 12;
        cell.textLabel.textColor=PL_COLOR_GRAY;
        cell.textLabel.text = LocalizedString(@"ShipListViewController_cell_textLabel",@"读取更多...");
        return cell;
    }
        static NSString *cellIdentifier = @"AllShipCell";
        ShipListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[[ShipListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    
        ShipOrder *m_ShipOrder = ((ShipOrder*)[self.mArr_AllShip objectAtIndex:indexPath.row]);
        [cell Setdata:m_ShipOrder state:[super getShipStateWithStatus:m_ShipOrder.status]];
        
        UIImage *arrow = [UIImage imageNamed:@"icon_right_arrow"];
        UIImageView *img_arrow = [[UIImageView alloc] initWithImage:arrow];
        img_arrow.frame = CGRectMake(0, 0, arrow.size.width, arrow.size.height);
        cell.accessoryView = img_arrow;
        [img_arrow release];
        return cell;
 }

#pragma mark - UITableViewDegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
      if(indexPath.row == self.mArr_AllShip.count)
    {
        UITableViewCell *loadMoreCell=[tableView cellForRowAtIndexPath:indexPath];
        loadMoreCell.textLabel.text=LocalizedString(@"ShipListViewController_loadMoreCell",@"正在读取...");
        loadMoreCell.textLabel.textColor=PL_COLOR_GRAY;
        [self performSelectorInBackground:@selector(RequestAllShip) withObject:nil];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    else
    {
        ShipOrder *ShipData=[self.mArr_AllShip objectAtIndex:indexPath.row];
        ShipDetailViewController *v_WayBill = [[ShipDetailViewController alloc]init];
        v_WayBill.isNewDisplayStateDelegate = self;
        v_WayBill.str_ShipId = ShipData.orderId;
        v_WayBill.str_ShipExpressUrl = ShipData.expressUrl;
        v_WayBill.str_ShipExpressNo = ShipData.packageCode;
        v_WayBill.mShipOrder = ShipData;
        v_WayBill.arr_OrderObject = self.mArr_AllShip;
        [self.navigationController pushViewController:v_WayBill animated:YES];
        [v_WayBill release];
    }
}
#pragma mark - productDetail isNewMessageFlag
- (void)isShipNewDisplayState
{
    //刷新tableview
    if(tab_AllShipList)
    {
        [tab_AllShipList reloadData];
    }
}

- (void)isDeleteShip
{
    //如果无商品显示无商品view
    if(self.mArr_AllShip == nil || self.mArr_AllShip.count <= 0)
    {
        
        AllShip_exceptionView.img_icon.image = [UIImage imageNamed:@"bg_ShipNone_Main"];
        AllShip_exceptionView.lab_title.text = LocalizedString(@"ShipListViewController_AllShipExceptionView",@"亲,暂时没有运单喔!");
        [AllShip_exceptionView setHidden:NO];
        [AllShip_exceptionView setNeedsDisplay];
    }
}

#pragma mark - Request and Response
-(void)RequestAllShip
{
    [self showHUDIndicatorMessage:LocalizedString(@"ShipListViewController_HUDIndMsg",@"正在加载...")];
    req_AllShip = req_AllShip ? req_AllShip : [[ShipOrdersRequest alloc]init];
    rpt_AllShip = rpt_AllShip ? rpt_AllShip : [[DataRepeater alloc]initWithName:RQNAME_USERSHIPORDERSALLSHIP];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSString *str_ShipTemp=[NSString stringWithFormat:@"%d",(int)[self.mArr_AllShip count]];
    [params setValue:str_ShipTemp forKey:RQ_SHIPORDERS_PARAM_INDEX];
    [params setValue:@"10" forKey:RQ_SHIPORDERS_PARAM_COUNT];
    
    rpt_AllShip.requestParameters = params;
    rpt_AllShip.notificationName = RQNAME_USERSHIPORDERSALLSHIP;
    rpt_AllShip.requestModal = PullData;
    rpt_AllShip.networkRequest = req_AllShip;
    [params release];
    rpt_AllShip.isAuth = YES;
    __unsafe_unretained __typeof(self) weakSelf = self;
    rpt_AllShip.compleBlock = ^(id repeater){
        [weakSelf GetAllShip:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:rpt_AllShip];
}

-(void)GetAllShip:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        [self hideHUD];
        
        if(isAllShipMore)
        {
            [self.mArr_AllShip addObjectsFromArray:repeater.responseValue];
        }
        else
        {
            self.mArr_AllShip = repeater.responseValue;
            //如果无商品显示无商品view
            if(self.mArr_AllShip == nil || self.mArr_AllShip.count == 0)
            {
                AllShip_exceptionView.img_icon.image = [UIImage imageNamed:@"bg_ShipNone_Main"];
                AllShip_exceptionView.lab_title.text = LocalizedString(@"ShipListViewController_AllShipExceptionView",@"亲,暂时没有运单喔!");
                [AllShip_exceptionView setHidden:NO];
                [AllShip_exceptionView setNeedsDisplay];
            }
        }
        //判断是否有新短信
        for(NSString *productObjIds in self.shipUnReadMessages.shipObjIds)
        {
            for(ShipOrder *ship in self.mArr_AllShip)
            {
                if([ship.orderId isEqualToString:productObjIds])
                {
                    ship.haveUnreadMessage = YES;
                }
            }
        }
        isAllShipMore = repeater.responseValue != nil && ((NSArray *)repeater.responseValue).count > 0 && (self.mArr_AllShip.count % 10 == 0) ;
        [tab_AllShipList reloadData];
    }
    else
    {
        ErrorInfo* errorInfo = repeater.errorInfo;
        if (errorInfo.code == NETWORK_ERROR)
        {
            AllShip_exceptionView.img_icon.image = [UIImage imageNamed:@"icon_None_NetWork"];
            AllShip_exceptionView.lab_title.text = LocalizedString(@"ShipListViewController_AllShipExceptionView2",@"网络不给力");
            [AllShip_exceptionView setHidden:NO];
            [AllShip_exceptionView setNeedsDisplay];
        }
        else
        {
            [self showHUDErrorMessage:errorInfo.message];
        }

    }
}

#pragma mark - Orientation Change
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        [tab_AllShipList setFrame:CGRectMake(0, 0, MainScreenFrame_Width, MainScreenFrame_Height - TOOLBAR_WIDTH)];
    }
    else if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [tab_AllShipList setFrame:CGRectMake(0, 0, MainScreenFrame_Width - LEFT_SPLITEVIEW_WIDTH, MainScreenFrame_Height  - TOOLBAR_WIDTH)];
    }
}
@end
