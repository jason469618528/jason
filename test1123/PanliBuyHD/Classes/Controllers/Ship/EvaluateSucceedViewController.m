//
//  EvaluateSucceedViewController.m
//  PanliApp
//
//  Created by jason on 13-5-2.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "EvaluateSucceedViewController.h"
#import "ShipListViewController.h"

@interface EvaluateSucceedViewController ()

@end

@implementation EvaluateSucceedViewController


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
//    [self viewDidLoadWithBackButtom:NO];
    
    self.navigationItem.title = LocalizedString(@"EvaluateSucceedViewController_Nav_Title", @"运单评价成功");
    
    UIImageView * bg_Main=[[UIImageView alloc]initWithImage: IS_568H ? [UIImage imageNamed:@"bg_ShipRate_Main_h568@2x.png"]:[UIImage imageNamed:@"bg_ShipRate_Main@2x.png"]];
                           
    bg_Main.frame=CGRectMake(0, 0, 320,IS_568H?507: 417);
    [self.view addSubview:bg_Main];
    [bg_Main release];

    UIImageView * imageg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_IsPatch_on"]];
    imageg.frame=CGRectMake(70, 30, 25, 25);
    [self.view addSubview:imageg];
    [imageg release];
    
    UILabel * textlist = [[UILabel alloc]initWithFrame:CGRectMake(100, 35, 320, 20)];
    textlist.text = LocalizedString(@"EvaluateSucceedViewController_textlist",@"运单评价成功!");
    textlist.backgroundColor = PL_COLOR_CLEAR;
    textlist.font = DEFAULT_FONT(18);
    textlist.textColor = [PanliHelper colorWithHexString:@"#5d910e"];
    [self.view addSubview:textlist];
    [textlist release];
    
    UILabel * displaytext = [[UILabel alloc]initWithFrame:CGRectMake(40, 70, 250, 50)];
    displaytext.text = LocalizedString(@"EvaluateSucceedViewController_displaytext",@"感谢您的评价,额外赠送您100积分!愿我们的服务能让您享更多!");
    displaytext.textColor = [PanliHelper colorWithHexString:@"#5c5c5c"];
    displaytext.font = DEFAULT_FONT(15);
    displaytext.numberOfLines = 2;
    displaytext.backgroundColor = PL_COLOR_CLEAR;
    [self.view addSubview:displaytext];
    [displaytext release];
    
    UIButton * btn_Home=[UIButton buttonWithType:UIButtonTypeCustom];
    btn_Home.frame=CGRectMake(30, 150, 260, 45);
    [btn_Home setImage:[UIImage imageNamed:@"btn_ShipRate_GoShipHome"] forState:UIControlStateNormal];
    [btn_Home setImage:[UIImage imageNamed:@"btn_ShipRate_GoShipHome_on"] forState:UIControlStateHighlighted];
    [btn_Home addTarget:self action:@selector(BackClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_Home];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navSubmitSuccess = (CustomerNavagationBarController*)self.navigationController;
//    self.navSubmitSuccess.canDragBack = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navSubmitSuccess.canDragBack = YES;
}
#pragma mark - 返回 
-(void)BackClick
{
    for(int i = 0; i< self.navigationController.viewControllers.count;i++)
    {
        if( [[self.navigationController.viewControllers objectAtIndex:i]  isKindOfClass:[ShipListViewController class]])
        {
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:i] animated:YES];
        }
    }
}
@end
