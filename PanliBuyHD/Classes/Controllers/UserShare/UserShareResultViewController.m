//
//  UserShareResultViewController.m
//  PanliApp
//
//  Created by Liubin on 13-12-16.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "UserShareResultViewController.h"

@interface UserShareResultViewController ()

@end

@implementation UserShareResultViewController

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
    [super viewDidLoadWithBackButtom:NO];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [PanliHelper colorWithHexString:@"#eeedf2"];
    
//    if(IS_IOS7)
//    {
//        UIView *navBackgroundImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 20)];
//        navBackgroundImageView.backgroundColor = [PanliHelper colorWithHexString:@"#f7f7f7"];
//        [self.view addSubview:navBackgroundImageView];
//        [navBackgroundImageView release];
//    }
    
    UIImageView *img_flagIcon = [[UIImageView alloc] initWithFrame:CGRectMake(((MainScreenFrame_Height - 300) - 200.0f) / 2, 60.0f, 21.5f, 21.5f)];
    [self.view addSubview:img_flagIcon];
    img_flagIcon.image = [UIImage imageNamed:@"icon_joinBuy_success"];
    [img_flagIcon release];
    
    UILabel *lab_title = [[UILabel alloc] initWithFrame:CGRectMake(((MainScreenFrame_Height - 300) - 200.0f) / 2 + 25, 60.0f, 200.0f, 21.5)];
    lab_title.backgroundColor = PL_COLOR_CLEAR;
    lab_title.font = DEFAULT_FONT(22);
    lab_title.textAlignment = UITextAlignmentLeft;
    lab_title.text = LocalizedString(@"UserShareResultViewController_labTitle",@"分享商品成功!");
    lab_title.textColor = [PanliHelper colorWithHexString:@"#5c910f"];
    [self.view addSubview:lab_title];
    [lab_title release];
    
    UIImageView *img_flagBackground = [[UIImageView alloc] init];
    img_flagBackground.image = [UIImage imageNamed:@"bg_joinBuy_success"];
    img_flagBackground.frame = CGRectMake(((MainScreenFrame_Height - 300) - 184.0f) / 2, 120.0f, 184.0f, 168.0f);
    [self.view addSubview:img_flagBackground];
    [img_flagBackground release];
    
    UIButton *btn_continueBuy = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_continueBuy.frame = CGRectMake(((MainScreenFrame_Height - 300) - 210.0f) / 2, 300.0f, 210.0f, 34.0f);
    [btn_continueBuy setBackgroundImage:[UIImage imageNamed:@"btn_userShare_continu"] forState:UIControlStateNormal];
    [btn_continueBuy setBackgroundImage:[UIImage imageNamed:@"btn_userShare_continu_on"] forState:UIControlStateHighlighted];
    [btn_continueBuy addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_continueBuy];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)btnClick:(UIButton *)btn
{
    NSArray *VCtrlArray = self.navigationController.viewControllers;
    [self.navigationController popToViewController:[VCtrlArray objectAtIndex:1] animated:YES];
}

@end
