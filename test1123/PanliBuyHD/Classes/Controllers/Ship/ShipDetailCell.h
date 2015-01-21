//
//  ShipDetailCell.h
//  PanliApp
//
//  Created by jason on 13-4-25.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShipStatusRecord.h"
#import "ExpressInfo.h"
@interface ShipDetailCell : UITableViewCell

{
    UIImageView *img_Background;
    
    UIImageView *img_falg;
    
    UILabel *lab_Time;
    UILabel *lab_Content;
    UIView *lineTop;

}

-(void)SetData:(id)data IsFirstTitle:(BOOL)isFirst infoType:(int)type IsLastTitle:(BOOL)isLast;

@end
