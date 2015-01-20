//
//  IndexViewCell.h
//  PanliBuyHD
//
//  Created by jason on 15-1-20.
//  Copyright (c) 2015年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomUIButton.h"
@interface IndexViewCell : UITableViewCell
{
    
}
- (void)reloadView:(NSArray*)arr_Data;
@property (nonatomic, strong)IBOutlet  CustomUIButton* btn_Left;
@property (strong, nonatomic) IBOutlet CustomUIButton *btn_Center;
@property (strong, nonatomic) IBOutlet CustomUIButton *btn_Right;
@end
