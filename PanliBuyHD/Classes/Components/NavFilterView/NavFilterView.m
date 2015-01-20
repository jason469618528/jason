//
//  NavFilterView.m
//  PanliApp
//
//  Created by Liubin on 14-4-3.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "NavFilterView.h"

@implementation NavFilterView

- (void)dealloc
{
    self.filterItems = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame itemArray:(NSArray *)items selectedIndex:(int)index
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.filterItems = items;
        self.selectIndex = index;
        //小箭头
        img_Arrows = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 11.5f)/2-30,UI_NAVIGATION_BAR_HEIGHT - 6.0f, 11.5f, 6.0f)];
        [self addSubview:img_Arrows];
        [img_Arrows release];
        
        //下拉框
        selectionView = [[UIControl alloc] initWithFrame:CGRectMake((frame.size.width-152.0f)/2-30,UI_NAVIGATION_BAR_HEIGHT, 152.0f, items.count <= 6 ? items.count*40 + 5 : 245.0f)];
        [selectionView setBackgroundColor:PL_COLOR_CLEAR];
        selectionView.layer.masksToBounds = YES;
        selectionView.layer.cornerRadius = 4.0f;
        [self addSubview:selectionView];
        [selectionView release];
        
        //选项列表
        tab_FilterItem = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 152.0f, items.count <= 6 ? items.count*40 : 240.0f)];
        tab_FilterItem.layer.masksToBounds = YES;
        tab_FilterItem.layer.cornerRadius = 4.0f;
        [tab_FilterItem setDelegate:self];
        [tab_FilterItem setDataSource:self];
        [tab_FilterItem setBackgroundColor:PL_COLOR_CLEAR];
        [tab_FilterItem setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [tab_FilterItem setShowsHorizontalScrollIndicator:NO];
        [tab_FilterItem setScrollEnabled:items.count > 6];
        [PanliHelper setExtraCellLineHidden:tab_FilterItem];
        [selectionView addSubview:tab_FilterItem];
        [tab_FilterItem release];
        
        //半透明view
        shadowView = [[UIControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, UI_SCREEN_HEIGHT)];
        shadowView.backgroundColor = PL_COLOR_CLEAR;
        [shadowView addTarget:self action:@selector(clickShadowView) forControlEvents:UIControlEventTouchUpInside];
        [self insertSubview:shadowView belowSubview:selectionView];
        [shadowView release];
    }
    return self;
}

- (void)clickShadowView
{
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(filterSelectDone:isChange:)]) {
        [self.delegate filterSelectDone:self.selectIndex isChange:NO];
    }
}

#pragma mark - tableview datasource and delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    @try
    {
        return self.filterItems.count;
    }
    @catch (NSException *exception)
    {
        return 0;
    }
    @finally {
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"filterCellName";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(6.0f, 0.0f, tableView.frame.size.width - 12.0f, 0.8f)];
        line.tag = 3001;
        line.backgroundColor = [PanliHelper colorWithHexString:@"#b1b1b1"];
        [cell.contentView addSubview:line];
        [line release];
        
        cell.textLabel.font = DEFAULT_FONT(15);
        cell.textLabel.backgroundColor = PL_COLOR_CLEAR;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        cell.textLabel.textColor = [PanliHelper colorWithHexString:@"#ffffff"];
    }
    cell.textLabel.text = [self.filterItems objectAtIndex:indexPath.row];
    if (self.selectIndex == indexPath.row)
    {
        cell.contentView.backgroundColor = [PanliHelper colorWithHexString:@"#656565"];
//        cell.backgroundColor = [PanliHelper colorWithHexString:@"#656565"];
    }
    else
    {
        cell.contentView.backgroundColor = [PanliHelper colorWithHexString:@"#888888"];
//        cell.backgroundColor = [PanliHelper colorWithHexString:@"#888888"];
    }
    
    if(self.selectIndex == 0)
    {
        img_Arrows.image = [UIImage imageNamed:@"icon_Common_arrows_Select_on"];
    }
    else
    {
        img_Arrows.image = [UIImage imageNamed:@"icon_Common_arrows"];
    }
    
    //选中颜色
    UIView *view_SelectBack = [[[UIView alloc] initWithFrame:cell.frame] autorelease];
    view_SelectBack.backgroundColor = [PanliHelper colorWithHexString:@"#777777"];
    cell.selectedBackgroundView = view_SelectBack;
    
    //判断线条是否出现
    UIView *line = (UIView*)[cell.contentView viewWithTag:3001];
    BOOL isShow = (indexPath.row != 0);
    if(isShow)
    {
        line.hidden = NO;
    }
    else
    {
        line.hidden = YES;
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    //更换了选项
    if (self.selectIndex != indexPath.row)
    {
        self.selectIndex = (int)indexPath.row;
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(filterSelectDone:isChange:)]) {
            [self.delegate filterSelectDone:self.selectIndex isChange:YES];
        }

    }
    else
    {
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(filterSelectDone:isChange:)]) {
            [self.delegate filterSelectDone:self.selectIndex isChange:NO];
        }
    }
    [tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        img_Arrows.image = [UIImage imageNamed:@"icon_Common_arrows_Select"];
    }
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.selectIndex == 0)
    {
        img_Arrows.image = [UIImage imageNamed:@"icon_Common_arrows_Select_on"];
    }
    else
    {
        img_Arrows.image = [UIImage imageNamed:@"icon_Common_arrows"];
    }
}
@end
