//
//  MessageDetailCell.m
//  PanliApp
//
//  Created by Liubin on 13-4-22.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "MessageDetailCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UserInfo.h"


@implementation MessageDetailCell

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    // Custom initialization
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTweetNotification:) name:IFTweetLabelURLNotification object:nil];

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = PL_COLOR_CLEAR;
        //昵称
        lab_NickName = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 100.0f, 20.0f)];
        lab_NickName.backgroundColor = PL_COLOR_CLEAR;
        lab_NickName.font = DEFAULT_FONT(15);
        lab_NickName.textAlignment = UITextAlignmentLeft;
        [self.contentView addSubview:lab_NickName];
        [lab_NickName release];
        
        //日期
        lab_Date = [[UILabel alloc] initWithFrame:CGRectMake(160.0f, 10.0f, 150.0f, 20.0f)];
        lab_Date.backgroundColor = PL_COLOR_CLEAR;
        lab_Date.font = DEFAULT_FONT(15);
        lab_Date.textColor = [PanliHelper colorWithHexString:@"#888785"];
        lab_Date.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:lab_Date];
        [lab_Date release];
        
        //背景
        view_BackColor = [[UIView alloc] init];
        view_BackColor.backgroundColor = [PanliHelper colorWithHexString:@"#ececec"];
        [[view_BackColor layer] setCornerRadius:6.0f];
        [self.contentView addSubview:view_BackColor];
        [view_BackColor release];
        
        //内容
        lab_Content = [[IFTweetLabel alloc] initWithFrame:CGRectMake(10.0f, 40.0f, MainScreenFrame_Width - 100, 200.0f)];
        lab_Content.numberOfLines = 0;
        lab_Content.font = DEFAULT_FONT(15);
        lab_Content.textColor = [PanliHelper colorWithHexString:@"#5a5a5a"];
        [lab_Content setLinksEnabled:YES];
        lab_Content.backgroundColor = PL_COLOR_CLEAR;
        lab_Content.label.textAlignment = UITextAlignmentLeft;
        [self.contentView addSubview:lab_Content];
        [lab_Content release];
        
        //状态图片
        img_State = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 10.0f, MainScreenFrame_Width - 100, 2.0f)];
        [self.contentView addSubview:img_State];
        [img_State release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMessageData:(Message *)data
{
    //用户留言
    NSString *str_Date = [PanliHelper timestampToDateString:data.dateCreated formatterString:@"yyyy-MM-dd HH:mm:ss"];
    NSString *str_content = data.content;
    CGSize size = [str_content sizeWithFont:DEFAULT_FONT(15)
                          constrainedToSize:CGSizeMake(MainScreenFrame_Width - 65.0f - 82.0f, 700.0f)
                              lineBreakMode:NSLineBreakByCharWrapping];
    if (data.isOwn)
    {
        lab_NickName.text = LocalizedString(@"MessageDetailCell_labNickName", @"我");
        lab_NickName.textColor = [PanliHelper colorWithHexString:@"#ff6600"];
        //更改图片及位置
        img_State.frame = CGRectMake(MainScreenFrame_Width - 65.0f - 14.0f - 10.0f, 13.0f, 14.0f, 15.5f);
        img_State.image = [UIImage imageNamed:@"icon_Message_Isme"];
        
        lab_NickName.frame = CGRectMake(img_State.frame.origin.x - 20.0f, 10.0f, 50.0f, 20.0f);
        
        lab_Date.frame = CGRectMake(MainScreenFrame_Width - 160.0f - 110.0f, 10.0f, 160.0f, 20.0f);
        lab_Date.text = [NSString stringWithFormat:@"%@ : ",str_Date];
        
        //重新计算高度 (多行展示状态)
        if(size.height >= 20)
        {
            lab_Content.frame = CGRectMake(41.0f, 40.0f, size.width,size.height);
            lab_Content.label.textAlignment = UITextAlignmentLeft;
        }
        else
        {
            lab_Content.label.textAlignment = UITextAlignmentRight;
            lab_Content.frame = CGRectMake(MainScreenFrame_Width - size.width - 45.0f - 65.0, 40.0f, size.width, size.height);
        }
    }
    //客服回复
    else
    {
        lab_NickName.text = data.kefuName;
        lab_NickName.textColor = [PanliHelper colorWithHexString:@"#65ca07"];
        //更改图片及位置
        img_State.frame = CGRectMake(10.0f, 13.0f, 20.0f, 14.5f);
        img_State.image = [UIImage imageNamed:@"icon_Message_IsKufu"];
        
        lab_Date.frame = CGRectMake(50.0f, 10.0f, 170.0f, 20.0f);
        lab_Date.text = [NSString stringWithFormat:@" : %@",str_Date];
        
        lab_NickName.frame = CGRectMake(img_State.frame.origin.x + img_State.frame.size.width + 5.0f, 10.0f, 50.0f, 20.0f);
        
        //重新计算高度
        lab_Content.frame = CGRectMake(41.0f, 40.0f, size.width, size.height);
        lab_Content.label.textAlignment = UITextAlignmentLeft;
    }
    view_BackColor.frame = CGRectMake(lab_Content.frame.origin.x - 10.0f, 30.0f, lab_Content.frame.size.width + 20.0f, size.height + 20.0f);
    lab_Content.text = str_content;
}

#pragma mark - IFWlabel
- (void)handleTweetNotification:(NSNotification *)notification
{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"MESSAGECLICKURL" object:notification];
       
}

@end
