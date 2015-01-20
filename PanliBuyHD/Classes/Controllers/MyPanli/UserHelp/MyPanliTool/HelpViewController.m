//
//  HelpViewController.m
//  PanliBuyHD
//
//  Created by guo on 14-10-28.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "HelpViewController.h"
#import "DataRequestManager.h"
#import "GuideDetailViewController.h"
#import "HelpShowViewController.h"
#import "MoneyEstimateViewController.h"
#import "SVWebViewController.h"
#import "ScanCodeViewController.h"

#define FIRST_BOOK_TAG  1001
#define SECOND_BOOK_TAG 1002
#define THIRD_BOOK_TAG  1003

#define COST_TAG   1009
#define RATE_TAG   1010
#define FEED_TAG   1011
#define DETAIL_TAG 1012

#define CACHE_KEY_QUESTION  @"HELP_QUESTION"
#define CACHE_TIME_HELP_QUESTION 600

@interface HelpViewController ()

@end

@implementation HelpViewController

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
    // Do any additional setup after loading the view.
//    [super viewDidLoadWithBackButtom:YES];
    //LocalizedString(@"HelpViewController_Nav_Title",
    self.navigationItem.title = @"使用指南";
    
    float totalHeight = 0;
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f,0.0f, Right_SpliteView_Width,MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT)];
    _mainScrollView.backgroundColor = [PanliHelper colorWithHexString:@"#eeeeeb"];
    _mainScrollView.contentSize = CGSizeMake(320,0.0f);
    _mainScrollView.canCancelContentTouches = NO;
    _mainScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    _mainScrollView.clipsToBounds = NO;
    _mainScrollView.scrollEnabled = YES;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.bounces = YES;
    _mainScrollView.pagingEnabled = NO;
    _mainScrollView.contentOffset = CGPointMake(0, 0);
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    
    //顶部banner
    _guideScrollView = [[CustomerAutoRollScrollView alloc] initWithFrame:CGRectMake(25.0f, 10, Right_SpliteView_Width-50, 145.0*(Right_SpliteView_Width-50)/300.0f)];
    _guideScrollView.dataSource = self;
    [_mainScrollView addSubview:_guideScrollView];
    
    totalHeight = 145.0*(Right_SpliteView_Width-50)/300+10;
    
    //代购秘籍
    UIImageView *img_bookBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, totalHeight + 20, Right_SpliteView_Width, 174.0*Right_SpliteView_Width/320.0f)];
    img_bookBackground.image = [UIImage imageNamed:@"bg_help_book"];
    img_bookBackground.tag = 1004;
    [_mainScrollView addSubview:img_bookBackground];
    
    //代购秘籍分割线
    UIImageView *img_seprateLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(25.0f, 0.0f, Right_SpliteView_Width-50, 16.0f)];
    img_seprateLine1.image = [UIImage imageNamed:@"icon_help_book"];
    img_seprateLine1.tag = 1005;
    [img_bookBackground addSubview:img_seprateLine1];
    
    //代购秘籍1
    UIButton *btn_helpBuy = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_helpBuy.frame = CGRectMake(30.0f, totalHeight + 50, 188.0f, 106*188/82.0f);
    btn_helpBuy.tag = FIRST_BOOK_TAG;
    [btn_helpBuy setBackgroundImage:[UIImage imageNamed:@"btn_help_book1"] forState:UIControlStateNormal];
    [btn_helpBuy setBackgroundImage:[UIImage imageNamed:@"btn_help_book1_on"] forState:UIControlStateHighlighted];
    [btn_helpBuy addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_mainScrollView addSubview:btn_helpBuy];
    
    UILabel *lab_helpBuy = [[UILabel alloc] initWithFrame:CGRectMake(30.0, 106*188/82.0+80, 188.0f+5, 45.0f)];
    lab_helpBuy.tag = 1006;
    //LocalizedString(@"HelpViewController_labHelpBuy",
    lab_helpBuy.text = @"绝世代购秘籍";
    lab_helpBuy.textColor = [PanliHelper colorWithHexString:@"#898987"];
    lab_helpBuy.font = DEFAULT_FONT(18);
    lab_helpBuy.textAlignment = UITextAlignmentCenter;
    lab_helpBuy.backgroundColor = PL_COLOR_CLEAR;
    [img_bookBackground addSubview:lab_helpBuy];
    
    //代购秘籍2
    UIButton *btn_helpBuyTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_helpBuyTwo.frame = CGRectMake(30+188+39.5, totalHeight + 50, 188.0f, 106*188/82.0);
    btn_helpBuyTwo.tag = SECOND_BOOK_TAG;
    [btn_helpBuyTwo setBackgroundImage:[UIImage imageNamed:@"btn_help_book2"] forState:UIControlStateNormal];
    [btn_helpBuyTwo setBackgroundImage:[UIImage imageNamed:@"btn_help_book2_on"] forState:UIControlStateHighlighted];
    [btn_helpBuyTwo addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_mainScrollView addSubview:btn_helpBuyTwo];
    
    UILabel *lab_helpBuyTwo = [[UILabel alloc] initWithFrame:CGRectMake(30+188+39.5-5, 106*188/82.0+80, 188.0f+5, 45.0f)];
    //LocalizedString(@"HelpViewController_lab_helpBuyTwo",
    lab_helpBuyTwo.text = @"绝世代购秘籍2";
    lab_helpBuyTwo.tag = 1007;
    lab_helpBuyTwo.textColor = [PanliHelper colorWithHexString:@"#898987"];
    lab_helpBuyTwo.font = DEFAULT_FONT(18);
    lab_helpBuyTwo.textAlignment = UITextAlignmentCenter;
    lab_helpBuyTwo.backgroundColor = PL_COLOR_CLEAR;
    [img_bookBackground addSubview:lab_helpBuyTwo];
    
    //拼单潮人攻略
    UIButton *btn_joinBuy = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_joinBuy.frame = CGRectMake(30+(188+39.5)*2, totalHeight + 50, 188.0f, 106*188/82.0);
    btn_joinBuy.tag = THIRD_BOOK_TAG;
    [btn_joinBuy setBackgroundImage:[UIImage imageNamed:@"btn_help_book3"] forState:UIControlStateNormal];
    [btn_joinBuy setBackgroundImage:[UIImage imageNamed:@"btn_help_book3_on"] forState:UIControlStateHighlighted];
    [btn_joinBuy addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_mainScrollView addSubview:btn_joinBuy];
    
    UILabel *lab_joinBuy = [[UILabel alloc] initWithFrame:CGRectMake(30+(188+39.5)*2-5, 106*188/82.0+80, 188.0f+5, 45.0f)];
    //LocalizedString(@"HelpViewController_labJoinBuy",
    lab_joinBuy.text = @"拼单潮人攻略";
    lab_joinBuy.tag = 1008;
    lab_joinBuy.textColor = [PanliHelper colorWithHexString:@"#898987"];
    lab_joinBuy.font = DEFAULT_FONT(18);
    lab_joinBuy.textAlignment = UITextAlignmentCenter;
    lab_joinBuy.backgroundColor = PL_COLOR_CLEAR;
    [img_bookBackground addSubview:lab_joinBuy];
    
    totalHeight = totalHeight+50+188+180;
    
    //小工具分割线
    UIImageView *img_seprateLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(25.0f, totalHeight + 20, Right_SpliteView_Width-50, 16.0f)];
    img_seprateLine2.image = [UIImage imageNamed:@"icon_help_tool"];
    [_mainScrollView addSubview:img_seprateLine2];
    
    totalHeight += 33;
    
    //工具
    NSArray *arr_btnImg = @[ [UIImage imageNamed:@"btn_help_cost"],
                             [UIImage imageNamed:@"btn_help_rate"],
                             [UIImage imageNamed:@"btn_help_Scan"],
                             [UIImage imageNamed:@"btn_help_detail"]];
    
    NSArray *arr_btnOnImg = @[ [UIImage imageNamed:@"btn_help_cost_on"],
                               [UIImage imageNamed:@"btn_help_rate_on"],
                               [UIImage imageNamed:@"btn_help_Scan_on"],
                               [UIImage imageNamed:@"btn_help_detail_on"]];
    
    float subX = 62.0f;
    for (int i = 0; i < arr_btnImg.count; i++)
    {
        UIImage *img_normal = [arr_btnImg objectAtIndex:i];
        UIImage *img_highlight = [arr_btnOnImg objectAtIndex:i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:img_normal forState:UIControlStateNormal];
        [btn setBackgroundImage:img_highlight forState:UIControlStateHighlighted];
        [btn setTag:1009+i];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(subX, totalHeight + 20, 100.5, 100.5);
        [_mainScrollView addSubview:btn];
        subX += 152.5;
    }
    
    totalHeight += 115;
    
    _mainScrollView.contentSize = CGSizeMake(Right_SpliteView_Width, totalHeight+80);
    
    [self getGuideInfoRequest];
    
}
#pragma mark - CustomScrollViewDataSource
- (NSInteger)scrollView:(CustomerAutoRollScrollView *)csViewNumberOfPages
{
    return [self.guideBannerArray count];
}

- (UIView *)scrollView:(CustomerAutoRollScrollView *)csView viewAtIndex:(NSInteger)index
{
    GuideView *temp = [[GuideView alloc] initWithFrame:csView.bounds];
    [temp setGuideViewDelegate:self];
    [temp setGuideData:[self.guideBannerArray objectAtIndex:index]];
    return temp;
}
- (void)getGuideInfoRequest
{
    req_getGuideList = req_getGuideList ? req_getGuideList : [[GetGuideListRequest alloc] init];
    rpt_gGetGuideList = rpt_gGetGuideList ? rpt_gGetGuideList : [[DataRepeater alloc] initWithName:RQNAME_GETGUIDE];
    rpt_gGetGuideList.requestModal = PullData;
    rpt_gGetGuideList.cacheKey = CACHE_KEY_QUESTION;
    rpt_gGetGuideList.cacheValidTime = CACHE_TIME_HELP_QUESTION;
    rpt_gGetGuideList.saveCache = YES;
    rpt_gGetGuideList.networkRequest = req_getGuideList;
    __unsafe_unretained __typeof(self) weakSelf = self;
    rpt_gGetGuideList.compleBlock = ^(id repeater){
        [weakSelf getGuideInfoResponse:repeater];
    };
    [[DataRequestManager sharedInstance] sendRequest:rpt_gGetGuideList];
}
- (void)getGuideInfoResponse:(DataRepeater *)repeater
{
    if (repeater.isResponseSuccess)
    {
        NSPredicate *predicateDetail = [NSPredicate predicateWithFormat:@"SELF.type =0"];
        NSPredicate *predicateBanner = [NSPredicate predicateWithFormat:@"SELF.type =1"];
        NSMutableArray *responseArray = repeater.responseValue;
        self.guideDetailArray = [responseArray filteredArrayUsingPredicate:predicateDetail];
        self.guideBannerArray = [responseArray filteredArrayUsingPredicate:predicateBanner];
        [_guideScrollView reloadData];
        //判断没有问题后隐藏
        if(self.guideBannerArray == nil || self.guideBannerArray.count == 0)
        {
            [self getGuideError];
        }
    }
    else
    {
        //LocalizedString(@"HelpViewController_HUDErrMsg",
        [self showHUDErrorMessage:@"小指南问题获取失败"];
        [self getGuideError];
    }
}

#pragma mark - AdvertViewDelegate
- (void)goToGuideDetailView:(Guide *)guide
{
    GuideDetailViewController *guideDetailViewController = [[[GuideDetailViewController alloc] init] autorelease];
    guideDetailViewController.mGuide = guide;
    guideDetailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:guideDetailViewController animated:YES];
}

- (void)getGuideError
{
    for (UIView *view in self.view.subviews)
    {
        CGRect rect = view.frame;
        _guideScrollView.hidden = YES;
        if(view.tag > 1000 || view.tag < 1014)
        {
            [UIView animateWithDuration:0.5 animations:^{
                view.frame = CGRectOffset(rect, 0, -155);
            }];
        }
        _mainScrollView.contentSize = CGSizeMake(Right_SpliteView_Width, _mainScrollView.contentSize.height -155);
    }
}

- (void)btnClick:(UIButton *)sender
{
    switch (sender.tag)
    {
            //代购秘籍1
        case FIRST_BOOK_TAG:
        {
            HelpShowViewController *helpShowViewController = [[[HelpShowViewController alloc] init] autorelease];
            helpShowViewController.type = 1;
            NSLog(@"self.navigation========%@",self.navigationController);
            [self.navigationController presentModalViewController:helpShowViewController animated:YES];
            break;
        }
            //代购秘籍2
        case SECOND_BOOK_TAG:
        {
            HelpShowViewController *helpShowViewController = [[[HelpShowViewController alloc] init] autorelease];
            helpShowViewController.type = 2;
            [self.navigationController presentModalViewController:helpShowViewController animated:YES];
            break;
        }
            //拼单潮人攻略
        case THIRD_BOOK_TAG:
        {
            HelpShowViewController *helpShowViewController = [[[HelpShowViewController alloc] init] autorelease];
            helpShowViewController.type = 3;
            [self.navigationController presentModalViewController:helpShowViewController animated:YES];
            break;
        }
            //费用估算
        case COST_TAG:
        {
            MoneyEstimateViewController *moneyEstimateViewController = [[[MoneyEstimateViewController alloc] init] autorelease];
            [self.navigationController pushViewController:moneyEstimateViewController animated:YES];
            break;
        }
            //汇率查询
        case RATE_TAG:
        {
            SVWebViewController *webViewController = [[[SVWebViewController alloc] initWithAddress:@"http://qq.ip138.com/hl.asp"] autorelease];
            webViewController.title = LocalizedString(@"HelpViewController_webViewController1",@"汇率查询");
            
            //返回
            UIButton *btn_nav_back = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn_nav_back setImage:[UIImage imageNamed:@"btn_navbar_back"]forState:UIControlStateNormal];
            [btn_nav_back setImage:[UIImage imageNamed:@"btn_navbar_back_on"] forState:UIControlStateHighlighted];
            [btn_nav_back addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
            btn_nav_back.frame = CGRectMake(0.0f, 0.0f, 26.5f, 26.5f);
            btn_nav_back.imageEdgeInsets = IS_IOS7 ? UIEdgeInsetsMake(0, -13, 0, 0) : UIEdgeInsetsZero;
            btn_nav_back.tag = 1002;
            UIBarButtonItem * btn_Left = [[UIBarButtonItem alloc] initWithCustomView:btn_nav_back];
            webViewController.navigationItem.leftBarButtonItem = btn_Left;
            [btn_Left release];
            [self.navigationController pushViewController:webViewController animated:YES];
            break;
        }
            //扫一扫
        case FEED_TAG:
        {
            ScanCodeViewController *scanViewController = [[[ScanCodeViewController alloc] init] autorelease];
            [self.navigationController pushViewController:scanViewController animated:YES];
            break;
        }
            //详细帮助
        case DETAIL_TAG:
        {
            NSString *urlString = [BASE_URL stringByAppendingString:URL_LIVE800];
            urlString = [urlString stringByReplacingOccurrencesOfString:@"/API/" withString:@"/"];
            SVWebViewController *webViewController = [[[SVWebViewController alloc] initWithURL:[NSURL URLWithString:urlString]] autorelease];
            webViewController.title = LocalizedString(@"HelpViewController_webViewController2",@"在线客服");
            //返回
            UIButton *btn_nav_back = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn_nav_back setImage:[UIImage imageNamed:@"btn_navbar_back"]forState:UIControlStateNormal];
            [btn_nav_back setImage:[UIImage imageNamed:@"btn_navbar_back_on"] forState:UIControlStateHighlighted];
            [btn_nav_back addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
            btn_nav_back.frame = CGRectMake(0.0f, 0.0f, 26.5f, 26.5f);
            btn_nav_back.imageEdgeInsets = IS_IOS7 ? UIEdgeInsetsMake(0, -13, 0, 0) : UIEdgeInsetsZero;
            btn_nav_back.tag = 1002;
            UIBarButtonItem * btn_Left = [[UIBarButtonItem alloc] initWithCustomView:btn_nav_back];
            webViewController.navigationItem.leftBarButtonItem = btn_Left;
            [btn_Left release];
            [self.navigationController pushViewController:webViewController animated:YES];
            break;
        }
            
        default:
            break;
    }
}
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
