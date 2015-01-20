//
//  InternationalViewController.m
//  PanliBuyHD
//
//  Created by ZhaoFucheng on 14-11-3.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "InternationalViewController.h"
#import "LanguageCell.h"

@interface InternationalViewController ()

@end

@implementation InternationalViewController

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
    
    self.navigationItem.title = LocalizedString(@"InternationalViewController_Nav_Title",@"多语言设置");
    self.view.backgroundColor = [PanliHelper colorWithHexString:@"#ededed"];
    
    languageList = [[NSArray alloc]initWithObjects:@"简体中文",@"繁體中文", nil];
    
    [PanliHelper setExtraCellLineHidden:self.languageTab];
    [PanliHelper setExtraCellPixelExcursion:self.languageTab];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableview Datasource and Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return languageList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *languageCellIdentifier = @"languageCell";
    LanguageCell *cell = [tableView dequeueReusableCellWithIdentifier:languageCellIdentifier];
    
    if(cell == nil)
    {
        cell = (LanguageCell *)[[[NSBundle mainBundle] loadNibNamed:@"LanguageCell" owner:self options:nil] lastObject];
    }
    
    cell.labTitle.text = [languageList objectAtIndex:indexPath.row];
    
    NSString *lan = [InternationalControl userLanguage];
    if ([lan isEqualToString:@"zh-Hans"])
    {
        if (indexPath.row == 0)
        {
            cell.isPatch = YES;
            cell.labTitle.textColor = [PanliHelper colorWithHexString:@"#ff6700"];
        }
    }
    else
    {
        if (indexPath.row == 1)
        {
            cell.isPatch = YES;
            cell.labTitle.textColor = [PanliHelper colorWithHexString:@"#ff6700"];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *cellArr = [tableView visibleCells];
    for (LanguageCell *cellTem in cellArr) {
        cellTem.isPatch = NO;
        cellTem.labTitle.textColor = [PanliHelper colorWithHexString:@"#444444"];
    }
    LanguageCell *cell = (LanguageCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.isPatch = YES;
    cell.labTitle.textColor = [PanliHelper colorWithHexString:@"#ff6700"];
    if([cell.labTitle.text isEqualToString:@"简体中文"])
    {
        [InternationalControl setUserLanguage:@"zh-Hans"];
    }
    else
    {
        [InternationalControl setUserLanguage:@"zh-Hant"];
    }
    //改变完成之后发送通知，告诉其他页面修改完成，提示刷新界面
    [[NSNotificationCenter defaultCenter] postNotificationName:CHANGE_LANGUAGE_NOTIFICATION object:nil];
}


@end
