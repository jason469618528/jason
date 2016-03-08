//
//  MyHomeCell.m
//  JasonBlog
//
//  Created by jason on 15/5/28.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import "MyHomeCell.h"

@interface MyHomeCell () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *cellMainTabView;
}

@end

@implementation MyHomeCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //Initialization code
        self.contentView.frame = CGRectMake(0.0f, 0.0f, 100.0f, MainScreenFrame_Width);
        cellMainTabView = [[UITableView alloc] initWithFrame:self.contentView.frame style:UITableViewStylePlain];
        cellMainTabView.center = CGPointMake(MainScreenFrame_Width / 2 , self.contentView.frame.size.width / 2 );
        cellMainTabView.delegate = self;
        cellMainTabView.dataSource = self;
        //tableview逆时针旋转90度。
        cellMainTabView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        // scrollbar 不显示
        cellMainTabView.showsVerticalScrollIndicator = NO;
        cellMainTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.contentView addSubview:cellMainTabView];
        
    }
    return self;
}

#pragma mark - UITableviewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *homeString = @"homeString";
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:homeString];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeString];
//        cell.backgroundColor = [UIColor greenColor];
        UILabel *labe_Title = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50.0f, 13.0f)];
        labe_Title.text = @"asdfasfdf";
        [cell.contentView addSubview:labe_Title];
    }
    // cell顺时针旋转90度
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI / 2);

//    cell.textLabel.text = @"asdfasfa";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%@",[self findViewController:self]);
}


- (UIViewController *)findViewController:(UIView *)sourceView
{
    id target=sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}
@end
