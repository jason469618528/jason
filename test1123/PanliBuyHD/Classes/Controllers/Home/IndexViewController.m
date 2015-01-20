//
//  IndexViewController.m
//  PanliBuyHD
//
//  Created by Liubin on 14-6-16.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "IndexViewController.h"
#import "LoginViewController.h"
#import "HelpBuyProductDetail.h"
#import "UserInfo.h"
#import "IndexViewCell.h"
#define DEFAULT_LIVE_COLOR [PanliHelper colorWithHexString:@"#cecece"]
#define INDEX_CELL_HEIGHT 60.0f
@interface IndexViewController ()
@end

@implementation IndexViewController
#pragma mark - Default
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"逛街";
    self.tab_Category.backgroundColor = [PanliHelper colorWithHexString:@"#f1f1f1"];
    [PanliHelper setExtraCellPixelExcursion:_tab_Category];
    [PanliHelper setExtraCellLineHidden:_tab_Category];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 151.0f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *shoppingHome = @"IndexView";
    IndexViewCell *homecell = (IndexViewCell*)[tableView dequeueReusableCellWithIdentifier:shoppingHome];
    if(homecell == nil)
    {
        homecell= (IndexViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"IndexViewCell" owner:self options:nil] lastObject];
        homecell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [homecell reloadView:@[@"1",@"2",@"3"]];
    return homecell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //ios 8去左边20像素
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}


@end
