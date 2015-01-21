//
//  UserShareTopicView.m
//  PanliApp
//
//  Created by Liubin on 13-12-19.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "UserShareTopicView.h"

#define ANIMOTION 0.3
#define HIDE_FRAME CGRectMake(0.0f, UI_SCREEN_HEIGHT, MainScreenFrame_Width, 200.0f)
#define SHOW_FRAME CGRectMake(0.0f, UI_SCREEN_HEIGHT-200, MainScreenFrame_Width, 200.0f)

@implementation UserShareTopicView

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(shadowView);
    self.topicArray = nil;
    [super dealloc];
}

//自定义set方法，刷新tableview
- (void)setTopicArray:(NSArray *)topicArray
{
    if (_topicArray != nil) {
        [_topicArray release];
    }
    _topicArray = [topicArray retain];
    [tab_topic reloadData];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = PL_COLOR_CLEAR;
        selectIndex = -1;
        isShowing = NO;
        
        tab_topic = [[UITableView alloc] initWithFrame:HIDE_FRAME];
        [tab_topic setDelegate:self];
        [tab_topic setDataSource:self];
        [tab_topic setBackgroundColor:PL_COLOR_WHITE];
        [tab_topic setSeparatorColor:PL_COLOR_CLEAR];
        [tab_topic setShowsHorizontalScrollIndicator:NO];
        [PanliHelper setExtraCellLineHidden:tab_topic];
        [self addSubview:tab_topic];
        [tab_topic release];
        
        btn_close = [[UIButton alloc] init];
        btn_close.frame = CGRectMake(MainScreenFrame_Width - 28 - 20, UI_SCREEN_HEIGHT, 28.0f, 28.0f);
        [btn_close setImage:[UIImage imageNamed:@"btn_userShare_close"] forState:UIControlStateNormal];
        [btn_close addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn_close];
        
        //半透明view
        shadowView = [[UIControl alloc]initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, UI_SCREEN_HEIGHT)];
        shadowView.backgroundColor = [UIColor blackColor];
        shadowView.alpha = 0;
        [shadowView addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - tableview datasource and delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topicArray.count;
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
    ShareBuyTopic *mShareBuyTopic = [self.topicArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"#%@#",mShareBuyTopic.name];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = DEFAULT_FONT(15);
    cell.textLabel.backgroundColor = PL_COLOR_CLEAR;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hide];
    selectIndex = (int)indexPath.row;
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(topicDidSelectedWithIndex:)])
    {
        [self.delegate topicDidSelectedWithIndex:selectIndex];
    }
}

- (void)show
{
    self.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, UI_SCREEN_HEIGHT);
    [self.superview bringSubviewToFront:self];
    [self insertSubview:shadowView belowSubview:tab_topic];
    [UIView animateWithDuration:ANIMOTION animations:^{
        btn_close.frame = btn_close.frame = CGRectMake(MainScreenFrame_Width - 28 - 20, UI_SCREEN_HEIGHT-200 - 14, 28.0f, 28.0f);
        tab_topic.frame = SHOW_FRAME;
        shadowView.alpha = 0.5;
    }];
    isShowing = YES;
}

- (void)hide
{
    self.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, 0.0f);
    [UIView animateWithDuration:ANIMOTION animations:^{
        btn_close.frame = btn_close.frame = CGRectMake(MainScreenFrame_Width - 28 - 20, UI_SCREEN_HEIGHT, 28.0f, 28.0f);
        tab_topic.frame = HIDE_FRAME;
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


@end
