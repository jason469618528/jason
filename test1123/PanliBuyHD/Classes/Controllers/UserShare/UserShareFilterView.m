//
//  UserShareFilterView.m
//  PanliApp
//
//  Created by Liubin on 13-12-12.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "UserShareFilterView.h"

#define ANIMOTION 0.3
#define HIDE_FRAME CGRectMake(0.0f, -150.0f, MainScreenFrame_Width, 150.0f)
#define SHOW_FRAME CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, 150.0f)

@implementation UserShareFilterView

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(shadowView);
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = PL_COLOR_CLEAR;
        selectIndex = 0;
        isShowing = NO;

        tab_menu = [[UITableView alloc] initWithFrame:HIDE_FRAME];
        [tab_menu setDelegate:self];
        [tab_menu setDataSource:self];
        [tab_menu setBackgroundColor:PL_COLOR_WHITE];
        [tab_menu setSeparatorColor:PL_COLOR_CLEAR];
        [tab_menu setShowsHorizontalScrollIndicator:NO];
        [PanliHelper setExtraCellLineHidden:tab_menu];
        [self addSubview:tab_menu];
        [tab_menu release];
        
        //半透明view
        shadowView = [[UIControl alloc]initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, MainScreenFrame_Height)];
        shadowView.backgroundColor = [UIColor blackColor];
        shadowView.alpha = 0;
        [shadowView addTarget:self action:@selector(shadowClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - tableview datasource and delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"filterCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.backgroundColor = PL_COLOR_WHITE;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 49.0f, MainScreenFrame_Width, 1.0f)];
        line.backgroundColor = [PanliHelper colorWithHexString:@"#DFE2E1"];
        [cell.contentView addSubview:line];
        [line release];
    }
    switch (indexPath.row)
    {
        case 0:
        {
            cell.imageView.image = [UIImage imageNamed:@"icon_userShare_menu_unshare"];
            cell.textLabel.text = LocalizedString(@"UserShareFilterView_cell_textLabel1",@"分享商品");
            break;
        }
            
        case 1:
        {
            cell.imageView.image = [UIImage imageNamed:@"icon_userShare_menu_shared"];
            cell.textLabel.text = LocalizedString(@"UserShareFilterView_cell_textLabel2",@"已分享的商品");
            break;
        }
            
        case 2:
        {
            cell.imageView.image = [UIImage imageNamed:@"icon_userShare_menu_praised"];
            cell.textLabel.text = LocalizedString(@"UserShareFilterView_cell_textLabel3",@"赞过的商品");
            break;
        }
            
        default:
            break;
    }
    
    if (indexPath.row == selectIndex)
    {
        UIImageView *img_select = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 23.0f, 17.0f)];
        img_select.image = [UIImage imageNamed:@"icon_userShare_menu_select"];
        cell.accessoryView = img_select;
        [img_select release];
    }
    else
    {
        cell.accessoryView = nil;
    }
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = DEFAULT_FONT(15);
    cell.textLabel.backgroundColor = PL_COLOR_CLEAR;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectIndex = indexPath.row;
    [tableView reloadData];
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(filterDidSelectedWithIndex:)])
    {
        [self.delegate filterDidSelectedWithIndex:selectIndex];
    }
}



- (void)show
{
    self.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, MainScreenFrame_Height);
    [self.superview bringSubviewToFront:self];
    [self insertSubview:shadowView belowSubview:tab_menu];
    [UIView animateWithDuration:ANIMOTION animations:^{
        tab_menu.frame = SHOW_FRAME;
        shadowView.alpha = 0.5;
    }];
    isShowing = YES;
}

- (void)hide
{
    self.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, 0.0f);
    [UIView animateWithDuration:ANIMOTION animations:^{
        tab_menu.frame = HIDE_FRAME;
        shadowView.alpha = 0;
    } completion:^(BOOL finished) {
        [shadowView removeFromSuperview];
    }];
    isShowing = NO;
}

- (void)action
{
    if (isShowing)
    {
        [self hide];
    }
    else
    {
        [self show];
    }
}

- (void)shadowClick
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(filterDidSelectedWithIndex:)])
    {
        [self.delegate filterDidSelectedWithIndex:selectIndex];
    }
}

@end
