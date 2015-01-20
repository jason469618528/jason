//
//  ShipDetailOrdersCell.h
//  PanliApp
//
//  Created by jason on 13-10-31.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShipDetailOrdersCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
{
    UILabel *lab_Title;
    UIImageView *icon_Status;
    UIImageView *icon_DownUp;
    UITableView *tab_ShipDetailOrders;
    NSArray *arr_Orders;
    UIActivityIndicatorView *activity_Orders;
}

- (void)SetData:(NSArray*)arr_Data isSelect:(BOOL)select;
@end
