//
//  SysMsgDetailViewController.m
//  PanliApp
//
//  Created by jason on 13-4-19.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "SysMsgDetailViewController.h"
#import "SVWebViewController.h"
#import "CustomerNavagationBarController.h"

@interface SysMsgDetailViewController ()

@end

@implementation SysMsgDetailViewController
@synthesize m_SysMsgTopic = _m_SysMsgTopic;
#pragma mark - default

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(req_SysMIsRead);
    SAFE_RELEASE(data_SysMIsRead);
    SAFE_RELEASE(_m_SysMsgTopic);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
          [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTweetNotification:) name:IFTweetLabelURLNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    //返回按钮
//    [self viewDidLoadWithBackButtom:YES];
    
    self.view.backgroundColor = [PanliHelper colorWithHexString:@"#E5E5E5"];
    
    self.navigationItem.title = LocalizedString(@"SysMsgDetailViewController_Nav_Title", @"短信详情");
    
    UIView *contentView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenFrame_Width, MainScreenFrame_Height)] autorelease];
	[contentView setBackgroundColor:[UIColor orangeColor]]; 
    
    //main背景
    UIImageView * bg_main = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_Main"]];
    bg_main.frame = CGRectMake(0, 0, MainScreenFrame_Width, MainScreenFrame_Height);
    [self.view addSubview:bg_main];
    [bg_main release];
    
    //list背景
    UIImageView * bg_List = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_msgDetail_sysMain"]];
    bg_List.frame = CGRectMake(10, 10, MainScreenFrame_Width-20, MainScreenFrame_Height-120);
    [self.view addSubview:bg_List];
    [bg_List release];
        
    //dots 背景
    UIImageView * icon_Dots = [[UIImageView alloc]initWithFrame:CGRectMake(20, 60, 280, 3)];
    icon_Dots.image = [UIImage imageNamed:@"bg_msgDetail_dotLine"];
    [self.view  addSubview:icon_Dots];
    [icon_Dots release];
    
    //显示标题
    UILabel *lab_SysTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 280, 60)];
    lab_SysTitle.text = _m_SysMsgTopic.title;
    lab_SysTitle.textColor = [UIColor blackColor];
    lab_SysTitle.backgroundColor = PL_COLOR_CLEAR;
    lab_SysTitle.numberOfLines = 3;
    [self.view addSubview:lab_SysTitle];
    [lab_SysTitle release];
    
    //显示内容
    CGSize size_Data = [_m_SysMsgTopic.content sizeWithFont:DEFAULT_FONT(15) constrainedToSize:CGSizeMake(245, MainScreenFrame_Height-130)];
    IFTweetLabel *lab_DisData = [[IFTweetLabel alloc] initWithFrame:CGRectMake(40, 70, size_Data.width,size_Data.height)];
    lab_DisData.text=[NSString stringWithFormat:@"  %@" ,_m_SysMsgTopic.content ];
    lab_DisData.font=DEFAULT_FONT(15);
	[lab_DisData setNumberOfLines:0];
    [lab_DisData setLinksEnabled:YES];
	[self.view addSubview:lab_DisData];
    [lab_DisData release];
    
    
    DLOG(@"%ld",_m_SysMsgTopic.links.count);

    for (int i = 0; i < _m_SysMsgTopic.linkLabels.count; i++)
    {
        NSString *str_links = [_m_SysMsgTopic.linkLabels objectAtIndex:i];
        CGSize size_Links = [str_links sizeWithFont:DEFAULT_FONT(15.0f) constrainedToSize:CGSizeMake(245, 500.0f) lineBreakMode:NSLineBreakByCharWrapping];
        
        UIButton *btn_ClickUrl = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_ClickUrl.titleLabel.font = DEFAULT_FONT(15.0f);
        btn_ClickUrl.layer.borderColor = [PanliHelper colorWithHexString:@"#e9e9e9"].CGColor;
        btn_ClickUrl.layer.cornerRadius = 10.0f;
        btn_ClickUrl.layer.masksToBounds = YES;
        btn_ClickUrl.layer.borderWidth = 1.0f;
        [btn_ClickUrl setBackgroundColor:[PanliHelper colorWithHexString:@"#e9e9e9"]];
        [btn_ClickUrl setTitle:str_links forState:UIControlStateNormal];
        [btn_ClickUrl setTitleColor:[PanliHelper colorWithHexString:@"#018ca6"] forState:UIControlStateNormal];
        [btn_ClickUrl setTitleColor:PL_COLOR_RED forState:UIControlStateHighlighted];
        btn_ClickUrl.tag = i;
        btn_ClickUrl.frame = CGRectMake(40.0f, lab_DisData.frame.size.height + lab_DisData.frame.origin.y + 10.0f + i * size_Links.height + i * 10, size_Links.width + 5, size_Links.height + 5);
        [btn_ClickUrl addTarget:self action:@selector(urlClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn_ClickUrl];
    }
    //系统短信isRead只读
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(SysMsgIsRead:)
//                                                 name:RQNAME_SETSYSMESSAGEISREAD
//                                               object:nil];
    [self MsgIsReadRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)urlClick:(UIButton*)btn
{
    NSInteger tag = btn.tag;
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[_m_SysMsgTopic.links objectAtIndex:tag]]];
    SVWebViewController *webViewController = [[[SVWebViewController alloc] initWithURL:URL] autorelease];
    webViewController.availableActions = SVWebViewControllerAvailableActionsOpenInSafari | SVWebViewControllerAvailableActionsCopyLink ;
    webViewController.type = -1;
    CustomerNavagationBarController *detailViewController = [[[CustomerNavagationBarController alloc] initWithRootViewController:webViewController] autorelease];
    [self.navigationController presentModalViewController:detailViewController animated:YES];
}

#pragma mark - 设置系统短信is read
- (void)MsgIsReadRequest
{
    req_SysMIsRead = req_SysMIsRead ? req_SysMIsRead : [[SetSysMsgIsReadRequest alloc] init];
    //开始发送网络请求
     NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[NSString stringWithFormat:@"%d",_m_SysMsgTopic.topicId] forKey:RQ_SYSMESSAGEISREAD_PARAM_TOPICID];
    
    data_SysMIsRead = data_SysMIsRead ? data_SysMIsRead : [[DataRepeater alloc]initWithName:RQNAME_SETSYSMESSAGEISREAD];
    data_SysMIsRead.requestParameters = params;
    data_SysMIsRead.notificationName = RQNAME_SETSYSMESSAGEISREAD;
    data_SysMIsRead.requestModal = PushData;
    data_SysMIsRead.networkRequest = req_SysMIsRead;
    [params release];
    
    data_SysMIsRead.isAuth = YES;
    __unsafe_unretained __typeof(self) weakSelf = self;
    data_SysMIsRead.compleBlock = ^(id repeater){
        [weakSelf SysMsgIsRead:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:data_SysMIsRead];
}

-(void)SysMsgIsRead:(DataRepeater * )repeater
{
    // NSString *str_Result = repeater.responseValue;
    if(repeater.isResponseSuccess)
    {
//        NSLog(@"短信\"%@\"设为已读成功",[NSString stringWithFormat:@"%d",_m_SysMsgTopic.topicId]);
    }
}

#pragma mark - IFWlabel
- (void)handleTweetNotification:(NSNotification *)notification
{
    // NSURL * url=[NSURL URLWithString: notification.object];
    // [[ UIApplication sharedApplication ] openURL: url ];
    DLOG(@"%@",notification.object);
    
}


@end
