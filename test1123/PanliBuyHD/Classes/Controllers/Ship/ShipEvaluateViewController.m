//
//  ShipEvaluateViewController.m
//  PanliApp
//
//  Created by jason on 13-5-2.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShipEvaluateViewController.h"
#import "EvaluateSucceedViewController.h"
#import "ShipReview.h"

enum Rage
{
    Server=1,
    Speed=2,
    Sh=3,
    All=4,
}RageState;

@interface ShipEvaluateViewController ()

@end

@implementation ShipEvaluateViewController



@synthesize str_Image;

@synthesize str_ScoreCount;
//@synthesize b_RateState;
@synthesize str_ShipId;
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(r_Server);
    SAFE_RELEASE(r_Speed);
    SAFE_RELEASE(r_Sh);
    SAFE_RELEASE(r_All);
    SAFE_RELEASE(str_Image);
    SAFE_RELEASE(str_ScoreCount);
    SAFE_RELEASE(str_ShipId);
    SAFE_RELEASE(containerView);
    SAFE_RELEASE(req_GetRate);
    SAFE_RELEASE(data_GetRate);
    SAFE_RELEASE(req_Rate);
    SAFE_RELEASE(data_Repeater);
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
//    [self viewDidLoadWithBackButtom:YES];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenFrame_Width, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT)];
    [self.view addSubview:containerView];
    
    UIImageView * bg_Main=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_ShipRate_Main_h568@2x.png"]];
    bg_Main.frame=CGRectMake(0, 0, MainScreenFrame_Width,MainScreenFrame_Width - 20 - UI_NAVIGATION_BAR_HEIGHT - 72);
    [containerView addSubview:bg_Main];
    [bg_Main release];
    
    UIImageView * bg_Top = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_ShipRate_Top"]];
    bg_Top.frame = CGRectMake(0, 0, MainScreenFrame_Width - 65, 70);
    [containerView addSubview:bg_Top];
    [bg_Top release];
    
    UIImageView *icon_True = [[UIImageView alloc]initWithImage:[UIImage imageNamed:str_Image]];
    icon_True.frame = CGRectMake(15, 15, 25, 25);
    [containerView addSubview:icon_True];
    [icon_True release];

    
    UILabel *lab_Service = [[UILabel alloc]initWithFrame:CGRectMake((MainScreenFrame_Width - 65 - 320) / 2, 92, 70, 16)];
    lab_Service.text = LocalizedString(@"ShipEvaluateViewController_labService",@"客服效率:");
    lab_Service.textColor = PL_COLOR_GRAY;
    lab_Service.backgroundColor = PL_COLOR_CLEAR;
    lab_Service.font = DEFAULT_FONT(16);
    [containerView addSubview:lab_Service];
    [lab_Service release];
    
    UILabel *lab_Speed = [[UILabel alloc]initWithFrame:CGRectMake((MainScreenFrame_Width - 65 - 320) / 2, 122, 70, 16)];
    lab_Speed.text = LocalizedString(@"ShipEvaluateViewController_labSpeed",@"配送速度:");
    lab_Speed.textColor = PL_COLOR_GRAY;
    lab_Speed.backgroundColor = PL_COLOR_CLEAR;
    lab_Speed.font = DEFAULT_FONT(16);
    [containerView addSubview:lab_Speed];
    [lab_Speed release];
    
    UILabel * lab_Sh = [[UILabel alloc]initWithFrame:CGRectMake((MainScreenFrame_Width - 65 - 320) / 2, 152, 70, 16)];
    lab_Sh.text = LocalizedString(@"ShipEvaluateViewController_labSh",@"商品验货:");
    lab_Sh.textColor = PL_COLOR_GRAY;
    lab_Sh.backgroundColor = PL_COLOR_CLEAR;
    lab_Sh.font = DEFAULT_FONT(16);
    [containerView addSubview:lab_Sh];
    [lab_Sh release];
    
    UILabel * lab_All = [[UILabel alloc]initWithFrame:CGRectMake((MainScreenFrame_Width - 65 - 320) / 2, 182, 70, 16)];
    lab_All.text = LocalizedString(@"ShipEvaluateViewController_labAll",@"整体情况:");
    lab_All.textColor = PL_COLOR_GRAY;
    lab_All.backgroundColor = PL_COLOR_CLEAR;
    lab_All.font = DEFAULT_FONT(16);
    [containerView addSubview:lab_All];
    [lab_All release];
    
    text_RateText = [[UITextView alloc]initWithFrame:CGRectMake((MainScreenFrame_Width - 65 - 400) / 2 ,210, 400, 70)];
    text_RateText.delegate = self;
    text_RateText.returnKeyType = UIReturnKeyDone;
	text_RateText.font = DEFAULT_FONT(15);
    text_RateText.layer.borderColor = [PanliHelper colorWithHexString:@"#9dbfc8"].CGColor;
    text_RateText.layer.borderWidth =1.0;
    text_RateText.layer.cornerRadius =5.0;
    [containerView addSubview:text_RateText];
    
    
    UILabel *lab_Title = [[UILabel alloc]init];
    
    if(str_ScoreCount)
    {
        lab_Title.frame = CGRectMake((MainScreenFrame_Width - 65 - 320) / 2, 45, 320, 20);
        
        UILabel *  textlist = [[UILabel alloc]initWithFrame:CGRectMake(50, 20, 320, 20)];
        textlist.text = [NSString stringWithFormat:LocalizedString(@"ShipEvaluateViewController_textlist",@"恭喜您获取%@积分奖励!"),str_ScoreCount];
        textlist.backgroundColor = PL_COLOR_CLEAR;
        textlist.font = DEFAULT_FONT(18);
        textlist.textColor = [PanliHelper colorWithHexString:@"#5d910e"];
        [containerView addSubview:textlist];
        [textlist release];

    }
    else
    {
        lab_Title.frame = CGRectMake((MainScreenFrame_Width - 65 - 320) / 2, 30, 320, 20);
    }
    lab_Title.text = LocalizedString(@"ShipEvaluateViewController_labTitle",@"您的评价是我们前进的动力,请对本次服务进行评价!");
    lab_Title.textColor = [PanliHelper colorWithHexString:@"#5c5c5c"];
    lab_Title.font = DEFAULT_FONT(12);
    lab_Title.backgroundColor = PL_COLOR_CLEAR;
    [containerView addSubview:lab_Title];
    [lab_Title release];

    
    r_Server=[[RatingView alloc]initWithFrame:CGRectMake((MainScreenFrame_Width - 65 - 320) / 2 + 85, 88, 150, 10)];
    [r_Server setImagesDeselected:@"icon_ShipRate_star_none" partlySelected:@"icon_ShipDetail_star" fullSelected:@"icon_ShipDetail_star" andDelegate:self state:Server];
    [containerView addSubview: r_Server];
    
    
    r_Speed=[[RatingView alloc]initWithFrame:CGRectMake((MainScreenFrame_Width - 65 - 320) / 2 + 85, 118, 150, 10)];
    [r_Speed setImagesDeselected:@"icon_ShipRate_star_none" partlySelected:@"icon_ShipDetail_star" fullSelected:@"icon_ShipDetail_star" andDelegate:self state:Speed];
    [containerView addSubview: r_Speed];
    
    r_Sh=[[RatingView alloc]initWithFrame:CGRectMake((MainScreenFrame_Width - 65 - 320) / 2 + 85, 148, 150, 10)];
    [r_Sh setImagesDeselected:@"icon_ShipRate_star_none" partlySelected:@"icon_ShipDetail_star" fullSelected:@"icon_ShipDetail_star" andDelegate:self state:Sh];
    [containerView addSubview: r_Sh];
    
    
    r_All=[[RatingView alloc]initWithFrame:CGRectMake((MainScreenFrame_Width - 65 - 320) / 2 + 85, 178, 150, 10)];
    [r_All setImagesDeselected:@"icon_ShipRate_star_none" partlySelected:@"icon_ShipDetail_star" fullSelected:@"icon_ShipDetail_star" andDelegate:self state:All];
    [containerView addSubview: r_All];

    self.navigationItem.title = LocalizedString(@"ShipEvaluateViewController_Nav_Title",@"运单评价");
    UIButton *btn_operate = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_operate setImage:[UIImage imageNamed:@"btn_navbar_confirm"]forState:UIControlStateNormal];
    [btn_operate setImage:[UIImage imageNamed:@"btn_navbar_confirm_on"] forState:UIControlStateHighlighted];
    [btn_operate addTarget:self action:@selector(rightButtonClick)forControlEvents:UIControlEventTouchUpInside];
    btn_operate.frame = CGRectMake(0, 0, 50.5, 26.5);
    btn_operate.imageEdgeInsets = IS_IOS7 ? UIEdgeInsetsMake(0, 0, 0, -13) : UIEdgeInsetsZero;
    UIBarButtonItem *rightbutton = [[UIBarButtonItem alloc] initWithCustomView:btn_operate];
    self.navigationItem.rightBarButtonItem = rightbutton;
    [rightbutton release];
    [r_Server displayRating:0];
    [r_Speed displayRating:0];
    [r_Sh displayRating:0];
    [r_All displayRating:0];

    //通知
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(rateRequest:)
//                                                 name:RQNAME_SHIPRATE
//                                               object:nil];
    
    text_RateText.text = LocalizedString(@"ShipEvaluateViewController_textRateText",@"若对Panli有其它意见，请在此留言");
    //手势
    UITapGestureRecognizer * recognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GestrueRecognizerCanncel:)];
    recognizer.cancelsTouchesInView=NO;
    [self.view addGestureRecognizer:recognizer];
    [recognizer release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -  星星的委托方法
-(void)ratingChanged:(float)newRating inid:(NSString *)sender
{
    int count=[sender intValue];
    switch (count) {
        case 1:
        {
            ServerNum = newRating;
            break;
        }
        case 2:
        {
            SpeedNum = newRating;
            break;
        }
        case 3:
        {
            ShNum = newRating;
            break;
        }
        case 4:
        {
            AllNum = newRating;
            break;
        }
            
        default:
            break;
    }
    
}

#pragma mark - 评价请求
-(void)RequestRate
{
    [self.view setUserInteractionEnabled:NO];
    req_Rate = req_Rate ? req_Rate : [[RateRequest alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:str_ShipId forKey:RQ_RATE_PARAM_SHIPID];
    NSString *str_Server = [NSString stringWithFormat:@"%d",ServerNum];
    NSString *str_Speed = [NSString stringWithFormat:@"%d",SpeedNum];
    NSString *str_Sh = [NSString stringWithFormat:@"%d",ShNum];
    NSString *str_All = [NSString stringWithFormat:@"%d",AllNum];
    
    [params setValue:str_Server forKey:RQ_RATE_PARAM_CUSTOMERRATE];
    [params setValue:str_Speed forKey:RQ_RATE_PARAM_DELIVERYRATE];
    [params setValue:str_Sh forKey:RQ_RATE_PARAM_RECEIVERATE];
    [params setValue:str_All forKey:RQ_RATE_PARAM_GENERALRATE];
    [params setValue:[text_RateText.text isEqualToString:LocalizedString(@"ShipEvaluateViewController_textRateText",@"若对Panli有其它意见，请在此留言")] ? @"" : text_RateText.text forKey:RQ_RATE_PARAM_ADVICE];
    
    data_Repeater = data_Repeater ? data_Repeater : [[DataRepeater alloc]initWithName:RQNAME_SHIPRATE];
    data_Repeater.requestParameters = params;
    data_Repeater.notificationName = RQNAME_SHIPRATE;
    data_Repeater.requestModal = PushData;
    data_Repeater.networkRequest = req_Rate;
    [params release];
    
    data_Repeater.isAuth = YES;
    __unsafe_unretained __typeof(self) weakSelf = self;
    data_Repeater.compleBlock = ^(id repeater){
        [weakSelf rateRequest:data_Repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:data_Repeater];
}

-(void)rateRequest:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        EvaluateSucceedViewController *v_Succceed = [[[EvaluateSucceedViewController alloc]init]autorelease];
        v_Succceed.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:v_Succceed animated:YES];
    }
    else
    {
        [self showHUDErrorMessage:repeater.errorInfo.message];
    }
    [self.view setUserInteractionEnabled:YES];
}


#pragma mark - 获取运单评价
-(void)GetShipRateRequest
{
    [self.view setUserInteractionEnabled:NO];
    req_GetRate = req_GetRate ? req_GetRate : [[GetReviewRequest alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:str_ShipId forKey:RQ_REVIEW_PARAM_SHIPID];
    
    data_GetRate = data_GetRate ? data_GetRate : [[DataRepeater alloc]initWithName:RQNAME_SHIPREVIEW];
    data_GetRate.requestParameters = params;
    data_GetRate.notificationName = RQNAME_SHIPREVIEW;
    data_GetRate.requestModal = PushData;
    data_GetRate.networkRequest = req_GetRate;
    [params release];
    
    data_GetRate.isAuth = YES;
    __unsafe_unretained __typeof(self) weakSelf = self;
    data_GetRate.compleBlock = ^(id repeater){
        [weakSelf GetRateRequest:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:data_GetRate];
}

-(void)GetRateRequest:(DataRepeater*)repeater
{
    if(repeater.isResponseSuccess)
    {
        ShipReview *m_Review = repeater.responseValue;
        int server = [m_Review.customerRate intValue];
        int speed =  [m_Review.deliveryRate intValue];
        int sh = [m_Review.receiveRate intValue];
        int all = [m_Review.generalRate intValue];
        
        text_RateText.text = m_Review.content;
        
        [r_Server displayRating:server];
        [r_Speed displayRating:speed];
        [r_Sh displayRating:sh];
        [r_All displayRating:all];
    }
    else
    {
        [self showHUDErrorMessage:repeater.errorInfo.message];
    }
    [self.view setUserInteractionEnabled:YES];
}

#pragma mark - RightClick
-(void)rightButtonClick
{
    if(ServerNum == 0 || SpeedNum == 0 || ShNum == 0 || AllNum == 0)
   {
       [self showHUDErrorMessage:LocalizedString(@"ShipEvaluateViewController_HUDErrMsg",@"请为服务评分")];
   }
   else
   {
        [self RequestRate];
   }   
}

#pragma mark - 手势
-(void)GestrueRecognizerCanncel:(UITapGestureRecognizer*)sender
{
    [text_RateText resignFirstResponder];
}
#pragma mark - UitextViewDegatele
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
   // if(b_RateState)
   // {
        
  //  }
   // else
  //  {
        if([text_RateText.text isEqualToString:LocalizedString(@"ShipEvaluateViewController_textRateText",@"若对Panli有其它意见，请在此留言")])
        {
            
            text_RateText.text = nil;
        }

  //  }
//    CGRect frame = textView.frame;
//    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
//    
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    
//    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
//    if(offset > 0)
//        self.view.frame = CGRectMake(0.0f, -offset-100, self.view.frame.size.width, self.view.frame.size.height);
//    [UIView commitAnimations];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    
    //if(b_RateState)
   // {
        
   // }
    //else
    //{
        if([text_RateText.text isEqualToString:@""])
        {
            
            text_RateText.text = LocalizedString(@"ShipEvaluateViewController_textRateText",@"若对Panli有其它意见，请在此留言");
        }
        
    //}

//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    
//    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
//    self.view.frame = CGRectMake(0.0f,IS_IOS7 ?64.0f:0.0f, self.view.frame.size.width, self.view.frame.size.height);
//    [UIView commitAnimations];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [text_RateText resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
