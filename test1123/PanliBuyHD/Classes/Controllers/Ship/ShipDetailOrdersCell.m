//
//  ShipDetailOrdersCell.m
//  PanliApp
//
//  Created by jason on 13-10-31.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShipDetailOrdersCell.h"
#import "UserProduct.h"
#import "ProductCell.h"
@implementation ShipDetailOrdersCell
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(arr_Orders);
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        lab_Title = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, MainScreenFrame_Width - 90, 20)];
        lab_Title.backgroundColor = PL_COLOR_CLEAR;
        lab_Title.text = LocalizedString(@"ShipDetailOrdersCell_labTitle",@"商品清单");
        lab_Title.font = DEFAULT_FONT(15);
        [self addSubview:lab_Title];
        [lab_Title release];
        
        icon_Status = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f,12.0f,17.5f,17.0f)];
        icon_Status.image = [UIImage imageNamed:@"icon_ShipDetail_ShipOrders"];
        [self addSubview:icon_Status];
        [icon_Status release];
        
        icon_DownUp = [[UIImageView alloc] initWithFrame:CGRectMake(MainScreenFrame_Width - 120.0f,15.0f,18.0f,11.5f)];
        icon_DownUp.image = [UIImage imageNamed:@"icon_OrderDetail_DOWM"];
        icon_DownUp.hidden = YES;
        [self addSubview:icon_DownUp];
        [icon_DownUp release];
        
        tab_ShipDetailOrders = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 45.0f, MainScreenFrame_Width - 20.0f, 0.0f)style:UITableViewStylePlain];
        tab_ShipDetailOrders.delegate = self;
        tab_ShipDetailOrders.dataSource = self;
        tab_ShipDetailOrders.separatorColor = [PanliHelper colorWithHexString:@"#cfcfcf"];
        tab_ShipDetailOrders.scrollEnabled = NO;
        [PanliHelper setExtraCellLineHidden:tab_ShipDetailOrders];
        [self addSubview:tab_ShipDetailOrders];
        [tab_ShipDetailOrders release];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tab_ShipDetailOrders.frame.size.width, 1.0f)];
        line.backgroundColor = [PanliHelper colorWithHexString:@"#cfcfcf"];
        [tab_ShipDetailOrders setTableHeaderView:line];
        [line release];
        
        
        activity_Orders = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activity_Orders.frame = CGRectMake(MainScreenFrame_Width - 135.0f,0.0f,40.0,40.0);
        [self addSubview:activity_Orders];
        [activity_Orders startAnimating];
        [activity_Orders release];
    }
    return self;
}

- (void)SetData:(NSArray*)arr_Data isSelect:(BOOL)select
{
    arr_Orders = [arr_Data retain];
    
    if (arr_Data.count <= 0)
    {
        [activity_Orders startAnimating];
        activity_Orders.hidden = NO;
        icon_DownUp.hidden = YES;
        [NSTimer scheduledTimerWithTimeInterval:8.0 target:self selector:@selector(StopActivity) userInfo:nil repeats:NO];
    }
    else
    {
        [activity_Orders stopAnimating];
        activity_Orders.hidden = YES;
        icon_DownUp.hidden = NO;

    }
    if(select)
    {
        tab_ShipDetailOrders.frame = CGRectMake(0.0f, 45.0f, MainScreenFrame_Width - 20.0f, 76.0f * arr_Data.count + 10);
        [tab_ShipDetailOrders reloadData];
        [UIView animateWithDuration:0.5 animations:
         ^{
             icon_DownUp.transform = CGAffineTransformRotate(icon_DownUp.transform, 3.14);
         }
         ];
    }
    else
    {
        tab_ShipDetailOrders.frame = CGRectMake(0.0f, 45.0f, MainScreenFrame_Width - 20.0f, 39.5);
        [tab_ShipDetailOrders reloadData];
        [UIView animateWithDuration:0.5 animations:
         ^{
             icon_DownUp.transform = CGAffineTransformRotate(icon_DownUp.transform, 3.14);
         }
         ];
    }

}
- (void)StopActivity
{
    [activity_Orders stopAnimating];
    activity_Orders.hidden = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_Orders.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str_ShipOrder = @"ShipOrderCell";
    ProductCell *Ordercell = [tableView dequeueReusableCellWithIdentifier:str_ShipOrder];
    if(Ordercell == nil)
    {
        Ordercell = [[[ProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str_ShipOrder] autorelease];
        Ordercell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UserProduct *userProduct = [arr_Orders objectAtIndex:indexPath.row];
    [Ordercell setOrderDate:userProduct withType:Inpanli isFullWidth:NO isShipOrder:YES];
    return Ordercell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserProduct *userProduct = [arr_Orders objectAtIndex:indexPath.row];
    CGSize  singleLineSize = [userProduct.skuRemark sizeWithFont:DEFAULT_FONT(14) constrainedToSize:CGSizeMake(MainScreenFrame_Width - 98, 20.0f) lineBreakMode:NSLineBreakByCharWrapping];
    CGSize skuSize = [userProduct.skuRemark sizeWithFont:DEFAULT_FONT(14) constrainedToSize:CGSizeMake(MainScreenFrame_Width - 98, 500.0f) lineBreakMode:NSLineBreakByCharWrapping];
    if([NSString isEmpty:userProduct.skuRemark])
    {
        return 76.0;
    }
    else
    {
        return 76.0f + skuSize.height - singleLineSize.height;
    }
}
- (void) tableView: (UITableView *) tableView  willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserProduct *userProduct = [arr_Orders objectAtIndex:indexPath.row];
    if(userProduct.isYellovWarning)
    {
        [cell setBackgroundColor:[PanliHelper colorWithHexString:@"#ffffcc"]];
    }
    if(userProduct.isRedWarning)
    {
        [cell setBackgroundColor:[PanliHelper colorWithHexString:@"#fff0f0"]];
    }
}
@end
