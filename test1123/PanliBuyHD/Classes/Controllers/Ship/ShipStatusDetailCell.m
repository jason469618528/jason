//
//  ShipStatusDetailCell.m
//  PanliApp
//
//  Created by jason on 13-10-29.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShipStatusDetailCell.h"

@implementation ShipStatusDetailCell

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(arr_ShipDetail);
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //运单ID
        lab_ShipID = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 239, 20)];
        lab_ShipID.backgroundColor = PL_COLOR_CLEAR;
        lab_ShipID.font = DEFAULT_FONT(15);
        [self addSubview:lab_ShipID];
        [lab_ShipID release];
        
        //运单提交时间
        lab_ShipTime = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 239, 20)];
        lab_ShipTime.backgroundColor = PL_COLOR_CLEAR;
        lab_ShipTime.font = DEFAULT_FONT(15);
        [self addSubview:lab_ShipTime];
        [lab_ShipTime release];
        
        //运单状态
        lab_ShipStatus = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 239, 20)];
        lab_ShipStatus.font = DEFAULT_FONT(15);
        lab_ShipStatus.backgroundColor = PL_COLOR_CLEAR;
        [self addSubview:lab_ShipStatus];
        [lab_ShipStatus release];

        icon_Status = [[UIImageView alloc] initWithFrame:CGRectMake(MainScreenFrame_Width - 120.0f,37.0f,18.0f,11.5f)];
        icon_Status.image = [UIImage imageNamed:@"icon_OrderDetail_DOWM"];
        icon_Status.hidden = YES;
        [self addSubview:icon_Status];
        [icon_Status release];
        
        tab_shipDetail = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 83.5f, MainScreenFrame_Width - 20.0f, 0.0f)style:UITableViewStylePlain];
        tab_shipDetail.delegate = self;
        tab_shipDetail.dataSource = self;
        tab_shipDetail.separatorColor = PL_COLOR_CLEAR;
        tab_shipDetail.scrollEnabled = NO;
        [PanliHelper setExtraCellLineHidden:tab_shipDetail];
        [self addSubview:tab_shipDetail];
        [tab_shipDetail release];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tab_shipDetail.frame.size.width - 20.0f, 1.0f)];
        line.backgroundColor = [PanliHelper colorWithHexString:@"#cfcfcf"];
        [tab_shipDetail setTableHeaderView:line];
        [line release];
        
        activity_Messages = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activity_Messages.frame = CGRectMake(MainScreenFrame_Width - 135.0f,25.0f,40.0,40.0);
        [self addSubview:activity_Messages];
        [activity_Messages startAnimating];
        [activity_Messages release];

    }
    return self;
}

- (void)SetData:(ShipOrder*)mShipOrder isSelect:(BOOL)select messageData:(NSArray*)arr_MessageData
{
    
    if(arr_MessageData.count <= 0)
    {
        [activity_Messages startAnimating];
        activity_Messages.hidden = NO;
        icon_Status.hidden = YES;
    }
    else
    {
        [activity_Messages stopAnimating];
        activity_Messages.hidden = YES;
        icon_Status.hidden = NO;
        arr_ShipDetail = [arr_MessageData retain];
        
        lab_ShipID.text = [NSString stringWithFormat:LocalizedString(@"ShipStatusDetailCell_labShipID",@"运单号码:%@") , mShipOrder.orderId];
        lab_ShipTime.text = [NSString stringWithFormat:LocalizedString(@"ShipStatusDetailCell_labShipTime",@"提交时间:%@") , [PanliHelper timestampToDateString:mShipOrder.createDate formatterString:@"yyyy-MM-dd HH:mm:ss"]];
        lab_ShipStatus.text = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:LocalizedString(@"ShipStatusDetailCell_labShipStatus",@"运单状态:%@") ,[self GetShipStatsu:mShipOrder.status]]];
    }
    
    if(select)
    {
        tab_shipDetail.frame = CGRectMake(0.0f, 83.5f,MainScreenFrame_Width - 20.0f, 6*33.0f);
        [tab_shipDetail reloadData];
        [UIView animateWithDuration:0.5 animations:
         ^{
             icon_Status.transform = CGAffineTransformRotate(icon_Status.transform, 3.14);
         }
         ];
    }
    else
    {
        tab_shipDetail.frame = CGRectMake(0.0f, 83.5f, MainScreenFrame_Width - 20.0f, 0.0f);
        [tab_shipDetail reloadData];
        [UIView animateWithDuration:0.5 animations:
         ^{
             icon_Status.transform = CGAffineTransformRotate(icon_Status.transform, 3.14);
         }
         ];
    }
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 33.0f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str_ShipDetail = @"ShipDetailCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str_ShipDetail];
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str_ShipDetail]autorelease];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = PL_COLOR_GRAY;
        
        UILabel * label1=[[UILabel alloc]initWithFrame:CGRectMake(40, 5, 250, 20)];
        label1.tag=111;
        label1.textColor=PL_COLOR_GRAY;
        label1.backgroundColor=PL_COLOR_CLEAR;
        label1.font=[UIFont fontWithName:@"Arial" size:15];
        [cell.contentView addSubview:label1];
        [label1 release];
        
        UIImageView * titleimage=[[UIImageView alloc]initWithFrame:CGRectMake(15, 5, 18, 18)];
        titleimage.tag=888;
        [cell addSubview:titleimage];
        [titleimage release];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tab_shipDetail.frame.size.width - 20.0f, 1.0f)];
        line.tag = 9999;
        [cell addSubview:line];
        [line release];
    }
    UILabel *label1 = (UILabel *)[cell viewWithTag:111];
    label1.text = [NSString stringWithFormat:@"%@",[arr_ShipDetail objectAtIndex:indexPath.row]];
    UIImageView * titleimage=(UIImageView*)[cell viewWithTag:888];
    titleimage.image=[UIImage imageNamed:[NSString stringWithFormat:@"icon_ShipDetail_UserMsg%d",indexPath.row%6+1]];
    
    UIImageView * line =(UIImageView*)[cell viewWithTag:9999];
    line.image = [UIImage imageNamed:@"icon_CartSubmit_Line"];
    if(indexPath.row == 0)
    {
        line.hidden = YES;
    }
    else
    {
        line.hidden = NO;
    }
    return cell;
}

-(NSString*)GetShipStatsu:(int)state
{
    switch (state)
    {
        case 0:
            return LocalizedString(@"ShipStatusDetailCell_ShipStatsu1",@"未处理");
            break;
        case 1:
            return LocalizedString(@"ShipStatusDetailCell_ShipStatsu2",@"已接单");
            break;
        case 2:
            return LocalizedString(@"ShipStatusDetailCell_ShipStatsu3",@"发货中");
            break;
        case 3:
            return LocalizedString(@"ShipStatusDetailCell_ShipStatsu4",@"已发货");
            break;
        case 4:
            return LocalizedString(@"ShipStatusDetailCell_ShipStatsu5",@"信息错误");
            break;
        case 5:
            return LocalizedString(@"ShipStatusDetailCell_ShipStatsu6",@"已出关退包");
            break;
        case 6:
            return LocalizedString(@"ShipStatusDetailCell_ShipStatsu7",@"未出关退包");
            break;
        case 7:
            return LocalizedString(@"ShipStatusDetailCell_ShipStatsu8",@"重发");
            break;
        case 8:
            return LocalizedString(@"ShipStatusDetailCell_ShipStatsu9",@"付费重发");
            break;
        case 9:
            return LocalizedString(@"ShipStatusDetailCell_ShipStatsu10",@"二次免费重发");
            break;
        case 10:
            return LocalizedString(@"ShipStatusDetailCell_ShipStatsu11",@"包裹二次退回");
            break;
        case 11:
            return LocalizedString(@"ShipStatusDetailCell_ShipStatsu12",@"处理中");
            break;
        case 12:
            return LocalizedString(@"ShipStatusDetailCell_ShipStatsu13",@"运输方式错误");
            break;
        case -1:
            return LocalizedString(@"ShipStatusDetailCell_ShipStatsu14",@"确认收包");
            break;
        case -2:
            return LocalizedString(@"ShipStatusDetailCell_ShipStatsu15",@"取消");
            break;
        case -3:
            return LocalizedString(@"ShipStatusDetailCell_ShipStatsu16",@"财务审核完成");
            break;
        case 99:
            return LocalizedString(@"ShipStatusDetailCell_ShipStatsu17",@"状态出错");
            break;
        default:
            return LocalizedString(@"ShipStatusDetailCell_ShipStatsu18",@"状态出错");
            break;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
