//
//  AboutViewController.m
//  PanliBuyHD
//
//  Created by guo on 14-10-29.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.backgroundColor = PL_COLOR_CLEAR;
    
    [self viewDidLoadWithBackButtom:YES];
    
    self.navigationItem.title = LocalizedString(@"AboutViewController_Nav_Title",@"关于软件");
    
    self.view.backgroundColor = [PanliHelper colorWithHexString:@"#f2f2f2"];
    
    UIImageView * bg_Logo=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_More_Logo"]];
    bg_Logo.frame=CGRectMake(280, 100, 201,201.5);
    [self.view addSubview:bg_Logo];
    
    UILabel *lab_Title = [[UILabel alloc]initWithFrame:CGRectMake(280, 320, 150, 30)];
    lab_Title.text = LocalizedString(@"AboutViewController_labTitle",@"Panli代购-移动版");
    lab_Title.backgroundColor = PL_COLOR_CLEAR;
    lab_Title.textColor = PL_COLOR_GRAY;
    lab_Title.font = DEFAULT_FONT(18);
    [self.view addSubview:lab_Title];
    
    //版本
    UILabel *lab_Version = [[UILabel alloc]initWithFrame:CGRectMake(260, 360, 150, 30)];
    lab_Version.text = LocalizedString(@"AboutViewController_labVersion",@"版本:");
    lab_Version.backgroundColor = PL_COLOR_CLEAR;
    lab_Version.textColor = PL_COLOR_GRAY;
    lab_Version.font = DEFAULT_FONT(18);
    [self.view addSubview:lab_Version];
    
    UILabel *lab_VersionNum = [[UILabel alloc]initWithFrame:CGRectMake(350, 360, 150, 30)];
    lab_VersionNum.text = [@"V" stringByAppendingString:[PanliHelper getVersion]];
    lab_VersionNum.backgroundColor = PL_COLOR_CLEAR;
    lab_VersionNum.textColor = [UIColor orangeColor];
    lab_VersionNum.font = DEFAULT_FONT(15);
    [self.view addSubview:lab_VersionNum];
    
    //官网
    UILabel *lab_Url = [[UILabel alloc]initWithFrame:CGRectMake(260, 400, 150, 30)];
    lab_Url.text = LocalizedString(@"AboutViewController_labUrl",@"官网:");
    lab_Url.backgroundColor = PL_COLOR_CLEAR;
    lab_Url.textColor = PL_COLOR_GRAY;
    lab_Url.font = DEFAULT_FONT(18);
    [self.view addSubview:lab_Url];
    
    UILabel *lab_UrlStr = [[UILabel alloc]initWithFrame:CGRectMake(350, 400, 150, 30)];
    lab_UrlStr.text = @"www.panli.com";
    lab_UrlStr.backgroundColor = PL_COLOR_CLEAR;
    lab_UrlStr.textColor = [UIColor orangeColor];
    lab_UrlStr.font = DEFAULT_FONT(18);
    [self.view addSubview:lab_UrlStr];
    
    //客服
    UILabel *lab_Service = [[UILabel alloc]initWithFrame:CGRectMake(260, 440, 150, 30)];
    lab_Service.text = LocalizedString(@"AboutViewController_labService",@"客服:");
    lab_Service.backgroundColor = PL_COLOR_CLEAR;
    lab_Service.textColor = PL_COLOR_CLEAR;
    lab_Service.font = DEFAULT_FONT(18);
    [self.view addSubview:lab_Service];
    
    UILabel *lab_ServiceStr = [[UILabel alloc]initWithFrame:CGRectMake(350, 440, 150, 30)];
    lab_ServiceStr.text = @"service@panli.com";
    lab_ServiceStr.backgroundColor = PL_COLOR_CLEAR;
    lab_ServiceStr.textColor = [UIColor orangeColor];
    lab_ServiceStr.font = DEFAULT_FONT(18);
    [self.view addSubview:lab_ServiceStr];
}

#pragma mark - ButtonClick
//- (void)VersionDetailClick
//{
//    GuideViewController *vGuide = [[[GuideViewController alloc]init]autorelease];
//    vGuide.fromPageType = 1;
//    [self.navigationController presentModalViewController:vGuide animated:YES];
//}

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
