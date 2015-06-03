//
//  CategoryView.m
//  JasonBlog
//
//  Created by jason on 15/5/20.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import "CategoryView.h"

@interface CategoryView()
{
    NSInteger categorySelectRow;
}
@end

@implementation CategoryView

- (void) dealloc
{
    NSLog(@"%@ dealloc",[self class]);
}

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = J_COLOR_WHITE;
        
        categorySelectRow = 0;
        
        tab_Category = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 150.0f, frame.size.height)];
        tab_Category.delegate = self;
        tab_Category.dataSource = self;
        [self addSubview:tab_Category];
        
        
        tab_SonCategory = [[UITableView alloc] initWithFrame:CGRectMake(150.0f, 0.0f,MainScreenFrame_Width - 150.0f, frame.size.height)];
        tab_SonCategory.delegate = self;
        tab_SonCategory.dataSource = self;
        [self addSubview:tab_SonCategory];
        
        
        tab_Category.rowHeight = 50.0f;
        tab_SonCategory.rowHeight = 80.0f;
        
    }
    return self;
}

#pragma mark - UITableviewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tab_Category == tableView)
    {
        return 10;
    }
    else
    {
        return 5;
    }
    return 0;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 50.0f;
//}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tab_Category == tableView)
    {
        static NSString *categoryString = @"categoryString";
        UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:categoryString];
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:categoryString];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(categorySelectRow == indexPath.row)
        {
            cell.backgroundColor = [UIColor redColor];
        }
        else
        {
            cell.backgroundColor = [UIColor whiteColor];
        }
        
        cell.textLabel.text = [NSString stringWithFormat:@"%d",(int)indexPath.row];
        return cell;
    }
    else
    {
        static NSString *categoryString = @"categoryString";
        UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:categoryString];
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:categoryString];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%d",(int)(categorySelectRow * 10.0f + indexPath.row)];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(tableView == tab_Category)
    {
        //切换主分类
        if(categorySelectRow != indexPath.row)
        {
            categorySelectRow = indexPath.row;
            [tableView reloadData];
            [tab_SonCategory reloadData];
        }
    }
    else
    {
        //进入搜索列表界面
    }
}

@end
