//
//  CartHomeViewController.m
//  JasonBlog
//
//  Created by jason on 15-5-4.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import "CartHomeViewController.h"
#import "CategoryView.h"
#import "PanliMoneyViewController.h"
@interface CartHomeViewController ()
{
    dispatch_source_t timer;
    CategoryView *categoryView;
}
@end

@implementation CartHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.tab_Main.editing = YES;
    
    UIBarButtonItem *bar_Left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(categoryClick:)];
    self.navigationItem.leftBarButtonItem = bar_Left;
    
    UIBarButtonItem *bar_Right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(categoryClick:)];
    self.navigationItem.rightBarButtonItem = bar_Right;
    
    //搜索条
//    UITextField
    UISearchBar *bar_searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(60.0f, 0.0f, MainScreenFrame_Width - 120.0f, 44.0f)];
    bar_searchBar.backgroundColor = [UIColor clearColor];
    bar_searchBar.tintColor = J_COLOR_GRAY;
    bar_searchBar.placeholder = @"搜索商品";
    
    UITextField *searchBarTextField = [bar_searchBar valueForKey:@"_searchField"];
    searchBarTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [searchBarTextField addTarget:self action:@selector(updateTest) forControlEvents:UIControlEventEditingChanged];
    
    bar_searchBar.layer.borderColor = [UIColor redColor].CGColor;
    bar_searchBar.layer.borderWidth = 1.0f;
    bar_searchBar.layer.cornerRadius = 20.0f;
    bar_searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    bar_searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    self.navigationItem.titleView = bar_searchBar;
    
    timeArr = @[@"2016-12-12 19:23:20"];

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    
    __weak typeof(self) weSelf = self;
    dispatch_source_set_event_handler(timer, ^{
        [weSelf calTime];
    });
    dispatch_resume(timer);

}

- (void)updateTest
{
    NSLog(@"asf");
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

//    if (_timer == nil) {
//        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(calTime) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
//    }
    
   }

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    if(_timer)
//    {
//        _timer = nil;//关闭定时器，
//    }
}

//定时器刷新倒计时
-(void)calTime
{
    NSArray  *cells = _tab_Main.visibleCells; //取出屏幕可见cell
    for (UITableViewCell *cell in cells) {
        cell.textLabel.text = [self getTimeStr:timeArr[cell.tag]];
    }
    [_tab_Main reloadData];
}

//返回倒计时
-(NSString *)getTimeStr:(NSString *)fireStr
{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* fireDate = [formater dateFromString:fireStr];
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *d = [calendar components:unitFlags fromDate:today toDate:fireDate options:0];//计算时间差
    long hour = [d day] *24 + [d hour];
    NSString *seconds;
    NSString *minutes;
    NSString *hours;
    if([d second]<10)
        seconds = [NSString stringWithFormat:@"0%ld",[d second]];
    else
        seconds = [NSString stringWithFormat:@"%ld",[d second]];
    if([d minute]<10)
        minutes = [NSString stringWithFormat:@"0%ld",[d minute]];
    else
        minutes = [NSString stringWithFormat:@"%ld",[d minute]];
    if(hour < 10)
        hours = [NSString stringWithFormat:@"0%ld", hour];
    else
        hours = [NSString stringWithFormat:@"%ld",hour];
    return [NSString stringWithFormat:@"            倒计时%@:%@:%@", hours, minutes,seconds];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)categoryClick:(UIBarButtonItem*)barItem
{
    if(barItem == self.navigationItem.leftBarButtonItem)
    {
        NSLog(@"分类");
        if(categoryView)
        {
            [categoryView removeFromSuperview];
            categoryView = nil;
        }
        else
        {
            categoryView = [[CategoryView alloc] initWithFrame:CGRectMake(0.0f, 50.0f, MainScreenFrame_Width, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT - UI_TAB_BAR_HEIGHT - 50.0f)];
            [self.view addSubview:categoryView];
        }
    }
    else
    {
        NSLog(@"购物车");
    }
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *homeString = @"homeString";
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:homeString];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeString];
    }
//    cell.textLabel.text = [NSString stringWithFormat:@"%d",(int)indexPath.row];
    cell.textLabel.text = [self getTimeStr:timeArr[indexPath.row]];
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.tag = indexPath.row;//通过tag 获取对应cell的位置
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //判断是否可以删除
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PanliMoneyViewController *panliMoney = [[PanliMoneyViewController alloc] init];
    panliMoney.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:panliMoney animated:YES];
}

@end
