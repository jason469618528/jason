//
//  ShipListCell.m
//  PanliApp
//
//  Created by jason on 13-8-14.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShipListCell.h"

@implementation ShipListCell
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(mShipOrderTemp);
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = PL_COLOR_CLEAR;
        img_State = [[UIImageView alloc]initWithFrame:CGRectMake(15, 13, 60, 55.5)];
        [self addSubview:img_State];
        [img_State release];
        
        img_Time  = [[UIImageView alloc]initWithFrame:CGRectMake(82, 56.5, 15, 15)];
        [self addSubview:img_Time];
        [img_Time release];
        
        lab_ShipID = [[UILabel alloc]initWithFrame:CGRectMake(82, 10, MainScreenFrame_Width - 100.0f, 20)];
        lab_ShipID.backgroundColor = PL_COLOR_CLEAR;
        lab_ShipID.textColor = [PanliHelper colorWithHexString:@"#4d4d4d"];
        lab_ShipID.font = DEFAULT_FONT(18);
        [self.contentView addSubview:lab_ShipID];
        [lab_ShipID release];
                
        lab_ShipMessage = [[UILabel alloc]initWithFrame:CGRectMake(82, 34, MainScreenFrame_Width - 100.0f, 20)];
        lab_ShipMessage.backgroundColor = PL_COLOR_CLEAR;
        lab_ShipMessage.textColor = [PanliHelper colorWithHexString:@"#4d4d4d"];
        lab_ShipMessage.font = DEFAULT_FONT(15);
        [self.contentView addSubview:lab_ShipMessage];
        [lab_ShipMessage release];
        
        lab_Time = [[UILabel alloc]initWithFrame:CGRectMake(106, 54, MainScreenFrame_Width - 100.0f, 20)];
        lab_Time.font = DEFAULT_FONT(15);
        lab_Time.textColor = [PanliHelper colorWithHexString:@"#93a3ad"];
        lab_Time.backgroundColor = PL_COLOR_CLEAR;
        [self.contentView addSubview:lab_Time];
        [lab_Time release];
        
        btn_isNewMessage = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_isNewMessage.frame = CGRectMake(220.0f, 2.0f, 41.0f, 41.0f);
        [btn_isNewMessage setImage:[UIImage imageNamed:@"icon_Common_newMessage"] forState:UIControlStateNormal];
        btn_isNewMessage.hidden = YES;
        [btn_isNewMessage addTarget:self action:@selector(SendMessagesClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn_isNewMessage];
    }
    return self;
}

-(void)Setdata:(ShipOrder*)mShipOrder state:(ShipDisState)shipState
{
    mShipOrderTemp = [mShipOrder retain];
    switch (shipState)
    {
        case YFHWay:
        {
            img_State.image = [UIImage imageNamed:@"bg_ShipHome_YFH"];
            break;
        }
        case DCLWay:
        {
            img_State.image = [UIImage imageNamed:@"bg_ShipHome_ Issue"];
            break;
        }
        case CLCWay:
        {
            img_State.image = [UIImage imageNamed:@"bg_ShipHome_CLC"];
            break;
        }
        case WCLWay:
        {
            img_State.image = [UIImage imageNamed:@"bg_ShipHome_WCL"];
            break;
        }
        case YSHWay:
        {
            img_State.image = [UIImage imageNamed:@"bg_ShipHome_YSH"];
            break;
        }
        case shipCanceled:
        {
            img_State.image = [UIImage imageNamed:@"bg_ShipHome_Cancel"];
            break;
        }
        default:
            break;
    }
    
    //判断是否有新短信
    if(mShipOrder.haveUnreadMessage)
    {
        btn_isNewMessage.hidden = NO;
    }
    else
    {
        btn_isNewMessage.hidden = YES;
    }

    img_Time.image = [UIImage imageNamed:@"icon_ShipList_Time"];
    lab_ShipID.text = [NSString stringWithFormat:@"%@",mShipOrder.orderId];
    lab_ShipMessage.text = [NSString stringWithFormat:@"%@",mShipOrder.shipArea];
    lab_Time.text=[NSString stringWithFormat:@"%@",[PanliHelper timestampToDateString:mShipOrder.createDate formatterString:@"yyyy-MM-dd HH:mm:ss"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//发送短信
- (void)SendMessagesClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SHIPSLIST_SENDMESSAGE" object:mShipOrderTemp];
}

@end
