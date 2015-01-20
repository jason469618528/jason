//
//  ShipListCell.h
//  PanliApp
//
//  Created by jason on 13-8-14.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShipOrder.h"
@interface ShipListCell : UITableViewCell

{
    UIImageView *img_State;
    UIImageView *img_Time;
    UILabel *lab_ShipID;
    UILabel *lab_ShipMessage;
    UILabel *lab_Time;
    UIButton *btn_isNewMessage;
    ShipOrder* mShipOrderTemp;
}

-(void)Setdata:(ShipOrder*)mShipOrder state:(ShipDisState)shipState;
@end
