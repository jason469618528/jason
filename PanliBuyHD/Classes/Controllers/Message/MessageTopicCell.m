//
//  NoteMessageCell.m
//  PanliApp
//
//  Created by jason on 13-4-18.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "MessageTopicCell.h"
#import "SysMsgTopic.h"
#import "MessageTopic.h"

@implementation MessageTopicCell



- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(dataSource);
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = PL_COLOR_CLEAR;
        //是否已读
        img_isRead = [[UIImageView alloc] initWithFrame:CGRectMake(5.0f, 34.0f, 11.0f, 12.0f)];
        img_isRead.image = [UIImage imageNamed:@"icon_msgTopic_unRead"];
        [self.contentView addSubview:img_isRead];
        [img_isRead release];
        
        //消息图标
        img_icon = [[UIImageView alloc] initWithFrame:CGRectMake(25.0f, 10.0f, 18.0f, 20.0f)];
        img_icon.image = [UIImage imageNamed:@"icon_msgTopic_user"];
        [self.contentView addSubview:img_icon];
        [img_icon release];

        //短信标题
        lab_title = [[UILabel alloc] initWithFrame:CGRectMake(45.0f, 10.0f, 160.0f, 20.0f)];
        lab_title.backgroundColor = PL_COLOR_CLEAR;
        lab_title.font = DEFAULT_FONT(16);
        lab_title.numberOfLines = 1;
        [self.contentView addSubview:lab_title];
        [lab_title release];
        
        //短信时间
        lab_date =[[UILabel alloc] initWithFrame:CGRectMake(MainScreenFrame_Height - 300 - 110, 10.0f, 80.0f, 20.0f)];
        lab_date.backgroundColor = PL_COLOR_CLEAR;
        lab_date.textColor = [PanliHelper colorWithHexString:@"#8e8e91"];
        lab_date.font = DEFAULT_FONT(15);
        lab_date.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:lab_date];
        [lab_date release];
        
        //短信内容
        lab_content =[[UILabel alloc] initWithFrame:CGRectMake(25.0f, 35.0f, MainScreenFrame_Height - 345, 40.0f)];
        lab_content.backgroundColor = PL_COLOR_CLEAR;
        lab_content.textColor = [PanliHelper colorWithHexString:@"#939393"];
        lab_content.numberOfLines = 0;
        lab_content.font = DEFAULT_FONT(14);
        lab_content.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:lab_content];
        [lab_content release];
        
//        //箭头
        img_arrow = [[UIImageView alloc] initWithFrame:CGRectMake(300.0f, 32.0f, 10.0f, 16.0f)];
        img_arrow.image = [UIImage imageNamed:@"icon_msgTopic_arrow"];
        [self.contentView addSubview:img_arrow];
        [img_arrow release];
        
//        //虚线
//        img_line = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 78.0f, 320.0f, 2.0f)];
//        img_line.image = [UIImage imageNamed:@"bg_msgTopic_line"];
//        [self.contentView addSubview:img_line];
//        [img_line release];
    }
    return self;
}

-(void)SetData:(id)object type:(int)type indexRow:(int)row
{
    dataSource = [object retain];
    indexRow = row;
    if(type  == 0)
    {
        SysMsgTopic *sysMsg=(SysMsgTopic*)dataSource;
        img_arrow.hidden = YES;
        //是否已读
        if (sysMsg.isRead)
        {
            img_isRead.hidden = YES;
        }
        else
        {
            img_isRead.hidden = NO;
        }
        
        //内容
//        CGSize singleLineSize = [sysMsg.content sizeWithFont:DEFAULT_FONT(14) constrainedToSize:CGSizeMake(270.0f, 20.0f) lineBreakMode:NSLineBreakByCharWrapping];
        CGSize skuSize = [sysMsg.content sizeWithFont:DEFAULT_FONT(14) constrainedToSize:CGSizeMake(MainScreenFrame_Height - 345, 500.0f) lineBreakMode:NSLineBreakByCharWrapping];
        lab_content.frame = CGRectMake(25.0f, 35.0f,skuSize.width, skuSize.height);
        lab_content.text = sysMsg.content;
        
        //时间
        lab_date.text = sysMsg.dateCreated_zhCN;
        
        //类型
        int sys_Status = sysMsg.msgType;
        NSString* str_MsgTitle = nil;
        switch (sys_Status)
        {
            case 0:
                str_MsgTitle = LocalizedString(@"MessageTopicCell_strMsgTitle1", @"用户间私信");
                break;
            case 1:
                str_MsgTitle = LocalizedString(@"MessageTopicCell_strMsgTitle2", @"网站公告");
                break;
            case 11:
                str_MsgTitle = LocalizedString(@"MessageTopicCell_strMsgTitle3", @"团购通知");
                break;
            case 31:
                str_MsgTitle = LocalizedString(@"MessageTopicCell_strMsgTitle4", @"优惠券通知");
                break;
            case 41:
                str_MsgTitle = LocalizedString(@"MessageTopicCell_strMsgTitle5", @"线下充值审核通知");
                break;
                
            default:
                str_MsgTitle = LocalizedString(@"MessageTopicCell_strMsgTitle6", @"其它通知");
                break;
        }
        lab_title.text = str_MsgTitle;
        
        int subX = 25.0f;
        int subY = lab_content.frame.origin.y + lab_content.frame.size.height + 5.0f;
        int tempI= 0;
        
        for (UIView *view in self.contentView.subviews)
        {
            if([view isKindOfClass:[UIButton class]])
            {
                [view removeFromSuperview];
            }
        }
        
        for (int i = 0; i < sysMsg.links.count; i++)
        {
            UIButton *btn_ClickUrl = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn_ClickUrl setBackgroundImage:[UIImage imageNamed:@"btn_SysMsg_ClickUrl"] forState:UIControlStateNormal];
            [btn_ClickUrl setBackgroundImage:[UIImage imageNamed:@"btn_SysMsg_ClickUrl_on"] forState:UIControlStateHighlighted];
            [btn_ClickUrl setTitle:LocalizedString(@"MessageTopicCell_btnClickUrl", @"访问链接") forState:UIControlStateNormal];
            btn_ClickUrl.titleLabel.font = DEFAULT_FONT(15.0f);
            [btn_ClickUrl setTitleColor:[PanliHelper colorWithHexString:@"#018ca6"] forState:UIControlStateNormal];
            [btn_ClickUrl setTitleColor:PL_COLOR_RED forState:UIControlStateHighlighted];
            btn_ClickUrl.tag = i;
            if(tempI % 3 == 0 && tempI > 0)
            {
                subX = 25.0f;
                tempI = 0;
                subY+= 25.0f;
            }
            btn_ClickUrl.frame = CGRectMake(subX + tempI * 75.5f + tempI * 5, subY ,75.5f, 20.0f);
            [btn_ClickUrl addTarget:self action:@selector(urlClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btn_ClickUrl];
            tempI++;
        }

    }
    else
    {
        MessageTopic *messageTopic = (MessageTopic*)dataSource;
        
        //是否已读
        if (messageTopic.isRead)
        {
            img_isRead.hidden = YES;
        }
        else
        {
            img_isRead.hidden = NO;
        }
        
        //标题
        lab_title.text = messageTopic.lastSender;
        
        //内容
        CGSize maxSize = CGSizeMake(270.0f, 40.0f);
        NSString *dateString = messageTopic.lastMessageContent;
        CGSize dateStringSize = [dateString sizeWithFont:DEFAULT_FONT(14)
                                       constrainedToSize:maxSize
                                           lineBreakMode:lab_content.lineBreakMode];
        lab_content.frame = CGRectMake(25.0f, 35.0f, MainScreenFrame_Height - 345, dateStringSize.height);
        lab_content.text = dateString;

        //时间
        lab_date.text = messageTopic.lastMessageTime_zhCn;
        
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)urlClick:(UIButton*)btn
{
    NSArray *arr = @[[NSString stringWithFormat:@"%d",indexRow],[NSString stringWithFormat:@"%d",btn.tag]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SYS_MSG_CLICK_URL" object:arr];
}

@end
