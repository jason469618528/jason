//
//  EstimateListCell.h
//  PanliApp
//
//  Created by jason on 13-5-13.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SendType.h"
@interface EstimateListCell : UITableViewCell

{
    UILabel *lab_Name;
    UILabel *lab_Freight;
    UILabel *lab_ServerPrice;
    UILabel *lab_EntryPrice;
    UILabel *lab_SumPrice;
}

-(void)SetData:(SendType*)mObject productPrice:(float)productPrice;
@end
