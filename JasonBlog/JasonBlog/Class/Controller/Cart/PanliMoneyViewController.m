//
//  PanliMoneyViewController.m
//  JasonBlog
//
//  Created by jason on 15/6/8.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import "PanliMoneyViewController.h"
#import "PanliMoneyCell.h"

#define TAG_BTNALL 2000
#define TAG_BTNEARNING 2001
#define TAG_BTNEXPEND 2002

#define BTN_SelectColor [UIColor redColor]
#define BTN_unSelectColor [UIColor yellowColor]

@interface PanliMoneyViewController ()

@property (strong, nonatomic) IBOutlet UIView *view_Bottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view_Bottomheight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view_TopHeight;
/**
 *有快过期的时候显示的文字
 */
@property (weak, nonatomic) IBOutlet UIButton *btn_TopOverdue;

@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;

@end

@implementation PanliMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //rightButtonItem
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"使用规则" style:UIBarButtonItemStyleDone target:self action:@selector(panliMoneyOther)];
    [rightBarItem setTintColor:[UIColor redColor]];
    [rightBarItem setTitleTextAttributes:@{NSFontAttributeName:DEFAULT_STHeitiSC_Light_FONT(16.5f)} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    _mainScrollView.contentSize = CGSizeMake(MainScreenFrame_Width*3,0);

//    //是否有快过期的番币
//    self.view_TopHeight.constant = 113.5;
//    self.btn_TopOverdue.hidden = NO;

    tab_MainView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT - self.view_TopHeight.constant) style:UITableViewStylePlain];
    tab_MainView.delegate = self;
    tab_MainView.dataSource = self;
    [self.mainScrollView addSubview:tab_MainView];
    
    tab_MainView.rowHeight = 75.0f;
    [tab_MainView reloadData];
    //init titleView
    [self getNavgationTitleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getNavgationTitleView
{
    //navbarTitleView
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 170.0f, UI_NAVIGATION_BAR_HEIGHT)];
    
    UIButton *btn_All = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_All.tag = TAG_BTNALL;
    btn_All.frame = CGRectMake(0.0f, 0.0f, 50.0f, 44.0f);
    btn_All.titleLabel.font = DEFAULT_STHeitiSC_Light_FONT(18.0f);
    [btn_All setTitle:@"全部" forState:UIControlStateNormal];
    [btn_All setTitleColor:BTN_SelectColor forState:UIControlStateNormal];
    [btn_All addTarget:self action:@selector(panliMoneyClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:btn_All];
    
    UIButton *btn_Earning = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Earning.tag = TAG_BTNEARNING;
    btn_Earning.frame = CGRectMake(50.0f + 5.0f, 0.0f, 50.0f, 44.0f);
    btn_Earning.titleLabel.font = DEFAULT_STHeitiSC_Light_FONT(18.0f);
    [btn_Earning setTitle:@"收入" forState:UIControlStateNormal];
    [btn_Earning setTitleColor:BTN_unSelectColor forState:UIControlStateNormal];
    [btn_Earning addTarget:self action:@selector(panliMoneyClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:btn_Earning];
    
    UIButton *btn_Expend = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Expend.tag = TAG_BTNEXPEND;
    btn_Expend.frame = CGRectMake(100.0f + 10.0f, 0.0f, 50.0f, 44.0f);
    btn_Expend.titleLabel.font = DEFAULT_STHeitiSC_Light_FONT(18.0f);
    [btn_Expend setTitle:@"支出" forState:UIControlStateNormal];
    [btn_Expend setTitleColor:BTN_unSelectColor forState:UIControlStateNormal];
    [btn_Expend addTarget:self action:@selector(panliMoneyClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:btn_Expend];
    
    self.navigationItem.titleView = titleView;
}

#pragma mark - SELF UIButtonClick Method
- (void)panliMoneyClick:(UIButton*)btn
{
    [self panliClick:btn.tag - 2000];
}

- (void)panliClick:(NSInteger)btnTag
{
    //更改按钮的选中状态
    for(UIView *subView in self.navigationItem.titleView.subviews)
    {
        if([subView isMemberOfClass:[UIButton class]])
        {
            UIButton *btnTitle = (UIButton*)subView;
            [btnTitle setTitleColor:btnTitle.tag == btnTag + 2000 ? BTN_SelectColor : BTN_unSelectColor forState:UIControlStateNormal];
        }
    }
    
    [_mainScrollView setContentOffset:CGPointMake(btnTag * MainScreenFrame_Width, 0) animated:YES];
}

- (void)panliMoneyOther
{
    NSLog(@"使用规则");
    if(self.view_Bottom)
    {
        [_view_Bottom removeFromSuperview];
    }
    [UIView animateWithDuration:5 animations:^{
        self.view_Bottomheight.constant = 162.0f;
    }];
    
    [self.navigationController.view addSubview:_view_Bottom];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCell = @"PanliMoneyCell";
    PanliMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:strCell owner:self options:nil] firstObject];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",(int)indexPath.row);
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int indexCount = _mainScrollView.contentOffset.x/MainScreenFrame_Width;
    [self panliClick:indexCount];
}


- (IBAction)btn_ClearMessage:(id)sender
{
    [_view_Bottom removeFromSuperview];
}
@end
