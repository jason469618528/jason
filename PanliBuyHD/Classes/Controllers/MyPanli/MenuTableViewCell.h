//
//  MenuTableViewCell.h
//  PanliBuyHD
//
//  Created by guo on 14-10-20.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicLabelForUpDown.h"

@interface MenuTableViewCell : UITableViewCell
{
    DynamicLabelForUpDown *lab_Message;
    UIView *view_Line;

    //通知动态数字
    UIImageView *img_Sys;
    UILabel *lab_Sys;
}
- (void)initWithData:(NSString*)iStringTitle imageString:(NSString*)iImageString iRow:(NSIndexPath*)indexPath tabBottomLine:(BOOL)isBomLineFlag systemMessageCount:(int)iCount;

@property (weak, nonatomic) IBOutlet UIImageView *menuImageView;
@property (weak, nonatomic) IBOutlet UILabel *menuLabelName;

@end
