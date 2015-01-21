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
#import "BrowseWebViewController.h"
#import "SVWebViewController.h"
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
    [PanliHelper setExtraCellLineHidden:self.tab_Category];
    [PanliHelper setExtraCellPixelExcursion:self.tab_Category];
    //init数据
    _currentIndex = 0;
    arr_Data = [[NSMutableArray alloc] init];
    NSArray *arr_Name = @[LocalizedString(@"IndexViewController_arrName_item1",@"淘宝"),
                          LocalizedString(@"IndexViewController_arrName_item2",@"京东商城"),
                          LocalizedString(@"IndexViewController_arrName_item3",@"当当网"),
                          LocalizedString(@"IndexViewController_arrName_item4",@"易讯网"),
                          LocalizedString(@"IndexViewController_arrName_item5",@"亚马逊"),
                          LocalizedString(@"IndexViewController_arrName_item6",@"拍拍"), @"VANCL",
                          LocalizedString(@"IndexViewController_arrName_item7",@"唯品会")];
    NSArray *arr_Url =  [NSArray arrayWithObjects:@"http://www.taobao.com/",@"http://www.jd.com/",@"http://www.dangdang.com/",@"http://www.yixun.com/",@"http://www.amazon.cn/ref=z_cn?tag=zcn0e-23",@"http://www.paipai.com/",@"http://www.vancl.com/?source=bdzqbtd56a1cce0ea3fe76",@"http://www.vip.com/?utm_source=baiduzone", nil];
    for(int i = 0;i < arr_Name.count;i++)
    {
        indexCategory *mCategory = [[indexCategory alloc] init];
        mCategory.str_Name = [arr_Name objectAtIndex:i];
        mCategory.str_Url = [arr_Url objectAtIndex:i];
        [arr_Data addObject:mCategory];
    }
}

#pragma mark - IndexCell Delegate
- (void)indexViewDelegate:(indexCategory *)category
{
    BrowseWebViewController *webView = [[BrowseWebViewController alloc] init];
    webView.category = category;
    [self.navigationController pushViewController:webView animated:YES];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (arr_Data.count%3 == 0)
    {
        return arr_Data.count/3;
    }
    else
    {
        return arr_Data.count/3 + 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 151.0f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *category = @"indexCell";
    IndexViewCell *indexCell = [tableView dequeueReusableCellWithIdentifier:category];
    if(!indexCell)
    {
        indexCell= (IndexViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"IndexViewCell" owner:self options:nil] lastObject];
        indexCell.delegate = self;
        indexCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (arr_Data.count >= indexPath.row*3+3)
    {
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(indexPath.row*3, 3)];
        [indexCell reloadIndeCellArray:[arr_Data objectsAtIndexes:indexSet]];
    }
    else
    {
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(indexPath.row*3, arr_Data.count % 3)];
        [indexCell reloadIndeCellArray:[arr_Data objectsAtIndexes:indexSet]];
    }
    
    return indexCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
