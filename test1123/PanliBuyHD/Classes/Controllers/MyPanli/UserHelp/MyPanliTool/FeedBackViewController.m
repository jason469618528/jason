//
//  FeedBackViewController.m
//  PanliBuyHD
//
//  Created by guo on 14-10-29.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "FeedBackViewController.h"
#import "DataRequestManager.h"

@interface FeedBackViewController ()

@end

@implementation FeedBackViewController
@synthesize delegate = _delegate;

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
    
    [self viewDidLoadWithBackButtom:NO];
    self.navigationController.navigationBar.backgroundColor = PL_COLOR_WHITE;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendButton addTarget:self action:@selector(SendMessageClick) forControlEvents:UIControlEventTouchUpInside];
    sendButton.frame = CGRectMake(260, 0, 52, 28);
    sendButton.imageEdgeInsets = IS_IOS7 ? UIEdgeInsetsMake(0, 0, 0, -13) : UIEdgeInsetsZero;
    [sendButton setImage:[UIImage imageNamed:@"btn_navbar_send"] forState:UIControlStateNormal];
    [sendButton setImage:[UIImage imageNamed:@"btn_navbar_send_on"] forState:UIControlStateHighlighted];
    _rightbutton = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    self.navigationItem.rightBarButtonItem = _rightbutton;
    
    self.navigationItem.title = LocalizedString(@"FeedBackViewController_Nav_Title",@"意见反馈");
    
    //背景
    UIImageView * bgimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Right_SpliteView_Width, MainScreenFrame_Width - UI_NAVIGATION_BAR_HEIGHT)];
    bgimage.image = [PanliHelper getImageFileByName:@"bg_FeedBack_Main@2x.png"];
    [self.view addSubview:bgimage];
    
    //textview (IS_568H?27:17)
    _txt_FeedBack = [[GCPlaceholderTextView alloc]initWithFrame:CGRectMake(25, 50, 500, 500)];
    _txt_FeedBack.font = DEFAULT_FONT(15);
    _txt_FeedBack.delegate = self;
    _txt_FeedBack.backgroundColor = PL_COLOR_CLEAR;
    _txt_FeedBack.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _txt_FeedBack.scrollEnabled=YES;
    _txt_FeedBack.returnKeyType = UIReturnKeyDone;
    _txt_FeedBack.placeholder = LocalizedString(@"FeedBackViewController_txtFeedBack",@"您的建议,就是我们前进的动力!");
    [self.view addSubview:_txt_FeedBack];
}

- (void)SendMessageClick
{
    if(![NSString isEmpty:_txt_FeedBack.text])
    {
        [self SendFeedBack];
    }
    else
    {
        [self showHUDErrorMessage:LocalizedString(@"FeedBackViewController_HUDErrMsg",@"请输入内容")];
    }
}
#pragma mark - UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [_txt_FeedBack resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)SendFeedBack
{
    [_rightbutton setEnabled:NO];
    [self showHUDIndicatorMessage:LocalizedString(@"FeedBackViewController_HUDIndMsg",@"正在提交...")];
    req_SendFeedBack = req_SendFeedBack ? req_SendFeedBack : [[SendFeedBackRequest alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    //手机系统版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    //手机型号
    NSString* phoneModel = [[UIDevice currentDevice] model];
    
    [params setValue:[NSString stringWithFormat:@"%@(%@,%@,iOS%@,%@)",_txt_FeedBack.text,[PanliHelper getVersion],phoneModel,phoneVersion, [self newtworkType]] forKey:RQ_ADDFEEDBACK_PARAM_CONTENT];
    
    data_SendFeedBack = data_SendFeedBack ? data_SendFeedBack : [[DataRepeater alloc]initWithName:RQNAME_ADDFEEDBACK];
    
    __weak FeedBackViewController *feedBackVC = self;
    data_SendFeedBack.compleBlock = ^(id repeater){
        [feedBackVC SendFeedBack:repeater];
    };
    data_SendFeedBack.isAuth = YES;
    data_SendFeedBack.requestModal = PushData;
    data_SendFeedBack.requestParameters = params;
    data_SendFeedBack.networkRequest = req_SendFeedBack;
    [[DataRequestManager sharedInstance] sendRequest:data_SendFeedBack];
}
-(void)SendFeedBack:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        [self.navigationController popViewControllerAnimated:YES];
        [_delegate feedBackSuccess];
    }
    else
    {
        [self showHUDErrorMessage:repeater.errorInfo.message];
    }
    [_rightbutton setEnabled:YES];
}

/**
 *获取网络状态
 */
- (NSString*)newtworkType
{
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKey:@"statusBar"] valueForKey:@"foregroundView"]subviews];
    NSNumber *dataNetworkItemView = nil;
    
    for (id subview in subviews)
    {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]])
        {
            dataNetworkItemView = subview;
            break;
        }
    }
    switch ([[dataNetworkItemView valueForKey:@"dataNetworkType"]integerValue])
    {
        case 0:
        {
            return  @"No wifi or cellular";
            break;
        }
        case 1:
        {
            return @"2G";
            break;
        }
        case 2:
        {
            return @"3G";
            break;
        }
        case 3:
        {
            return @"4G";
            break;
        }
        case 4:
        {
            return @"LTE";
            break;
        }
        case 5:
        {
            return @"Wifi";
            break;
        }
        default:
        {
            return @"";
            break;
        }
    }
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
