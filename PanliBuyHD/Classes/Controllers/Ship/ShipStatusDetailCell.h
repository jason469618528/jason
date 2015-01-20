//
//  ShipStatusDetailCell.h
//  PanliApp
//
//  Created by jason on 13-10-29.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShipOrder.h"
@interface ShipStatusDetailCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
{
    //运单ID
    UILabel* lab_ShipID;
    //运单提交时间
    UILabel* lab_ShipTime;
    //运单状态
    UILabel* lab_ShipStatus;
    //图标
    UIImageView *icon_Status;
    //表
    UITableView *tab_shipDetail;
    
    NSArray *arr_ShipDetail;
    
    UIActivityIndicatorView *activity_Messages;
}

- (void)SetData:(ShipOrder*)mShipOrder isSelect:(BOOL)select messageData:(NSArray*)arr_MessageData;;

@end
