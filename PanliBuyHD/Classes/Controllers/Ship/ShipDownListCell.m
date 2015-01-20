//
//  ShipDownListCell.m
//  PanliApp
//
//  Created by jason on 13-10-31.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShipDownListCell.h"
#import "ShipDetailCell.h"
#define MESSAGE_CELL_HEIGHT 70.0f
@implementation ShipDownListCell
@synthesize cellClickDelegate;
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(arr_Messages);
    SAFE_RELEASE(mShipOrder);
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //title
        lab_Title = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, MainScreenFrame_Width - 90, 20)];
        lab_Title.backgroundColor = PL_COLOR_CLEAR;
        lab_Title.font = DEFAULT_FONT(15);
        [self addSubview:lab_Title];
        [lab_Title release];
        
        icon_Status = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f,12.0f,17.5f,17.0f)];
        [self addSubview:icon_Status];
        [icon_Status release];
        
        icon_DownUp = [[UIImageView alloc] initWithFrame:CGRectMake(MainScreenFrame_Width - 120.0f,15.0f,18.0f,11.5f)];
        icon_DownUp.image = [UIImage imageNamed:@"icon_OrderDetail_DOWM"];
        icon_DownUp.hidden = YES;
        [self addSubview:icon_DownUp];
        [icon_DownUp release];
        
        activity_Messages = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activity_Messages.frame = CGRectMake(MainScreenFrame_Width - 135.0f,0.0f,40.0,40.0);
        [self addSubview:activity_Messages];
        [activity_Messages startAnimating];
        [activity_Messages release];
        
        tab_Messages = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 39.5, MainScreenFrame_Width - 20.0f, 39.5) style:UITableViewStylePlain];
        tab_Messages.dataSource = self;
        tab_Messages.delegate = self;
        tab_Messages.scrollEnabled = NO;
        tab_Messages.separatorColor = PL_COLOR_CLEAR;
        tab_Messages.backgroundColor = [UIColor whiteColor];
        [PanliHelper setExtraCellLineHidden:tab_Messages];
        [self addSubview:tab_Messages];
        [tab_Messages release];
        
        line = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, 1.0f)];
        UIImageView *img_Line = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 0.0, tab_Messages.frame.size.width - 20.0f, 1.0f)];
        img_Line.image = [UIImage imageNamed:@"icon_CartSubmit_Line"];
        [line addSubview:img_Line];
        [img_Line release];
        [tab_Messages setTableHeaderView:line];
        [line release];
        
        //物流线条
        lineNo = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 39.5f, tab_Messages.frame.size.width - 20.0f, 1.0f)];
        lineNo.backgroundColor = [PanliHelper colorWithHexString:@"#cfcfcf"];
        [self addSubview:lineNo];
        [lineNo release];
        
        txt_LogisticsNo = [[UITextView alloc] initWithFrame:CGRectMake(10.0f, 39.5f, MainScreenFrame_Width - 320 - 20.0f, 30.0f)];
        txt_LogisticsNo.backgroundColor = PL_COLOR_CLEAR;
        txt_LogisticsNo.font = DEFAULT_FONT(15.0f);
        txt_LogisticsNo.editable = NO;
        txt_LogisticsNo.scrollEnabled = NO;
        [self addSubview:txt_LogisticsNo];
        [txt_LogisticsNo release];
        
        lab_LogisticsDealer = [[UILabel alloc] initWithFrame:CGRectMake(14.0f, 70.0f, MainScreenFrame_Width - 20.0f, 18.0f)];
        lab_LogisticsDealer.backgroundColor = PL_COLOR_CLEAR;
        lab_LogisticsDealer.font = DEFAULT_FONT(15.0f);
        lab_LogisticsDealer.textColor = [PanliHelper colorWithHexString:@"#535453"];
        [self addSubview:lab_LogisticsDealer];
        [lab_LogisticsDealer release];
    }
    return self;
}

- (void)SetData:(NSArray*)arr_Data ViewType:(int)type isSelect:(BOOL)selectMessages isReqStatus:(BOOL)reqState shipModel:(ShipOrder*)iModel
{
    
    mShipOrder = [iModel retain];
    
    if(arr_Data == nil)
    {
        [activity_Messages startAnimating];
        activity_Messages.hidden = NO;
        icon_DownUp.hidden = YES;
        [NSTimer scheduledTimerWithTimeInterval:8.0 target:self selector:@selector(StopActivity) userInfo:nil repeats:NO];
    }
    else
    {
        [activity_Messages stopAnimating];
        activity_Messages.hidden = YES;
        arr_Messages = [arr_Data retain];
        icon_DownUp.hidden = NO;
    }
    cellType = type;
    isReqState = reqState;
    isCellSelect = selectMessages;
    
    //type 1:为包裹处理 0:国际物流
    if(type)
    {
        lab_Title.text = LocalizedString(@"ShipDownListCell_labTitle1",@"包裹处理");
        icon_Status.image = [UIImage imageNamed:@"icon_ShipDetail_Schedule"];
        txt_LogisticsNo.text = nil;
        lab_LogisticsDealer.text = nil;
        lineNo.hidden = YES;
        line.backgroundColor = [PanliHelper colorWithHexString:@"#cfcfcf"];
    }
    else
    {
        lab_Title.text = LocalizedString(@"ShipDownListCell_labTitle2",@"国际物流");
        icon_Status.image = [UIImage imageNamed:@"icon_ShipDetail_Logistics"];
        txt_LogisticsNo.text = [NSString stringWithFormat:LocalizedString(@"ShipDownListCell_txtLogisticsNo1",@"物流单号:%@"),
                                mShipOrder.packageCode ? mShipOrder.packageCode : LocalizedString(@"ShipDownListCell_txtLogisticsNo2",@"暂无物流单号")];
        lab_LogisticsDealer.text = [NSString stringWithFormat:LocalizedString(@"ShipDownListCell_labLogisticsDealer1",@"承运商:%@"),
                                    mShipOrder.shipDeliveryName ? mShipOrder.shipDeliveryName : LocalizedString(@"ShipDownListCell_labLogisticsDealer2",@"暂无承运商")];
        lineNo.hidden = NO;
        line.backgroundColor = PL_COLOR_CLEAR;
    }
    
    mainHeightFlag = 0.0f;
    [tab_Messages reloadData];
    
    if(selectMessages)
    {
        tab_Messages.frame = CGRectMake(0.0f, type ? 39.5f:99.5, MainScreenFrame_Width - 20.0f, mainHeightFlag + (type ? 0.0f : 10.0f));
        [UIView animateWithDuration:0.5 animations:
         ^{
             icon_DownUp.transform = CGAffineTransformRotate(icon_DownUp.transform, 3.14);
         }
         ];
    }
    else
    {
        tab_Messages.frame = CGRectMake(0.0f, type ? 39.5f:99.5, MainScreenFrame_Width - 20.0f, 79.0f);
        
        [UIView animateWithDuration:0.5 animations:
         ^{
             icon_DownUp.transform = CGAffineTransformRotate(icon_DownUp.transform, 3.14);
         }
         ];
    }
    [cellClickDelegate SendShipDownListCellHeight:mainHeightFlag Type:type];
}

- (void)StopActivity
{
    [activity_Messages stopAnimating];
    activity_Messages.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(arr_Messages.count <= 0)
    {
        return 1;
    }
    else
    {
        return arr_Messages.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!isCellSelect || arr_Messages.count <= 0)
    {
        static NSString *cellIdentifier = @"Cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(cellType)
        {
            ShipStatusRecord *productStatus = (ShipStatusRecord*)[arr_Messages lastObject];
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[arr_Messages lastObject] ? productStatus.remark : LocalizedString(@"ShipDownListCell_cell_textLabel1",@"暂无代购进度")];
            cell.textLabel.textColor = [PanliHelper colorWithHexString:@"#4bb21b"];
            cell.textLabel.font = DEFAULT_FONT(15.0f);
        }
        else
        {
            if(isReqState)
            {
                cell.textLabel.text = @"";
            }
            else
            {
                ExpressInfo *productStatus = (ExpressInfo*)[arr_Messages lastObject];
                NSString *str_LastContent = productStatus.content;
                str_LastContent = [str_LastContent stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                cell.textLabel.text = [NSString stringWithFormat:@"%@",[arr_Messages lastObject] ? str_LastContent : LocalizedString(@"ShipDownListCell_cell_textLabel2",@"暂无国际物流")];
                cell.textLabel.textColor = [PanliHelper colorWithHexString:@"#4bb21b"];
                cell.textLabel.font = DEFAULT_FONT(15.0f);
            }
        }
        return cell;
    }
    else
    {
        static NSString *cellIdentifier = @"Cell2";
        ShipDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[[ShipDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        id data = [arr_Messages objectAtIndex:arr_Messages.count - indexPath.row-1];
        [cell SetData:data IsFirstTitle:(indexPath.row == 0) infoType:cellType IsLastTitle:(indexPath.row == arr_Messages.count - 1)];
         return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str_Content;
    if(!cellType)
    {
        ExpressInfo *ex = [arr_Messages objectAtIndex:arr_Messages.count - indexPath.row - 1];
        str_Content = [ex.content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    else
    {
        ShipStatusRecord *ex = [arr_Messages objectAtIndex:arr_Messages.count - indexPath.row - 1];
        str_Content = [ex.remark stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    CGSize skuSize = [str_Content sizeWithFont:DEFAULT_FONT(15) constrainedToSize:CGSizeMake(MainScreenFrame_Width - 90, 500.0f) lineBreakMode:NSLineBreakByCharWrapping];
    mainHeightFlag += skuSize.height + 30;
    
    if(isCellSelect)
    {
        return skuSize.height + 30;
    }
    else
    {
        return 39.5;
    }
}

@end
