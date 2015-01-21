//
//  ShipDetailCell.m
//  PanliApp
//
//  Created by jason on 13-4-25.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShipDetailCell.h"
#import "ExpressInfo.h"
@implementation ShipDetailCell

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = PL_COLOR_WHITE;
        //进度条
        lineTop = [[UIView alloc] initWithFrame:CGRectMake(15.25f, 0.0f, 1.0f, 70.f)];
        lineTop.backgroundColor = [PanliHelper colorWithHexString:@"#efefef"];
        [self.contentView addSubview:lineTop];
        [lineTop release];
        
        //图标
        img_Background = [[UIImageView alloc]init];
        [self.contentView addSubview:img_Background];
        [img_Background release];
        
        img_falg = [[UIImageView alloc] initWithFrame:CGRectMake(270, 27, 32, 32)];
        [self.contentView addSubview:img_falg];
        [img_falg release];
        
        lab_Time = [[UILabel alloc] init];
        lab_Time.backgroundColor = PL_COLOR_CLEAR;
        [self.contentView addSubview:lab_Time];
        [lab_Time release];
        
        
        lab_Content = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, 255, 30)];
        lab_Content.backgroundColor = PL_COLOR_CLEAR;
        lab_Content.textAlignment = UITextAlignmentLeft;
        lab_Content.font = DEFAULT_FONT(15);
        lab_Content.numberOfLines = 0;
//        lab_Content.contentMode = UIViewContentModeTop;
        [self.contentView addSubview:lab_Content];
        [lab_Content release];
    }
    return self;
}
-(void)SetData:(id)data IsFirstTitle:(BOOL)isFirst infoType:(int)type IsLastTitle:(BOOL)isLast
{
    CGSize size;
    NSString *str_Content = nil;
    // 0 国际物流 1 代购进度
    if(type == 0)
    {
        ExpressInfo *m_Info = (ExpressInfo*)data;
        str_Content = m_Info.content;
        lab_Time.text = m_Info.time;
    }
    else if(type == 1)
    {
        ShipStatusRecord *m_Record = (ShipStatusRecord*)data;
        str_Content = m_Record.remark;
        NSString *str_Time = [NSString stringWithFormat:@"%@",[PanliHelper timestampToDateString:m_Record.dataCreated formatterString:@"yyyy-MM-dd HH:mm:ss"]];
        lab_Time.text = str_Time;
    }
    str_Content = [str_Content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    lab_Content.text = str_Content;
    
    size = [str_Content sizeWithFont:DEFAULT_FONT(15)
                   constrainedToSize:CGSizeMake(MainScreenFrame_Width - 90, 500)
                       lineBreakMode:NSLineBreakByCharWrapping];
    
    lab_Content.frame = CGRectMake(35, 10, MainScreenFrame_Width - 90, size.height);
    
    lab_Time.frame = CGRectMake(35, lab_Content.frame.origin.y + size.height, MainScreenFrame_Width - 90, 15);
    img_Background.frame = CGRectMake(10, lab_Content.frame.origin.y + 2, 10.5, 10.5);
    
    if(isLast && isFirst)
    {
        lineTop.frame = CGRectMake(15.25f , 0, 1.0f, 0);
        lab_Time.textColor = [PanliHelper colorWithHexString:@"#969696"];
        lab_Content.textColor = [PanliHelper colorWithHexString:@"#535353"];
        img_Background.image = [UIImage imageNamed:@"icon_OrderDetail_Highlight"];
    }
    else if(isLast)
    {
        lineTop.frame = CGRectMake(15.25f, 0, 1.0f,12);
        lab_Time.textColor = [PanliHelper colorWithHexString:@"#d3d3d3"];
        lab_Content.textColor = [PanliHelper colorWithHexString:@"#b4b7b6"];
        img_Background.image = [UIImage imageNamed:@"icon_OrderDetail_Default"];
    } else  if(isFirst)
    {
        lab_Time.textColor = [PanliHelper colorWithHexString:@"#969696"];
        lab_Content.textColor = [PanliHelper colorWithHexString:@"#535353"];
        img_Background.image = [UIImage imageNamed:@"icon_OrderDetail_Highlight"];
        lineTop.frame = CGRectMake(15.25f, img_Background.frame.origin.y, 1.0f, size.height + 30);
    }
    else
    {
        lab_Time.textColor = [PanliHelper colorWithHexString:@"#d3d3d3"];
        lab_Content.textColor = [PanliHelper colorWithHexString:@"#b4b7b6"];
        img_Background.image = [UIImage imageNamed:@"icon_OrderDetail_Default"];
        lineTop.frame = CGRectMake(15.25f, 0.0f, 1.0f, size.height + 30);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
