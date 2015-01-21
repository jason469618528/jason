//
//  OrderProCell.h
//  PanliBuyHD
//
//  Created by Liubin on 14-6-19.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomUIImageView.h"
#import "UserProduct.h"

@interface OrderProCell : UITableViewCell
{
    
}

@property (weak, nonatomic) IBOutlet UIButton *btn_select;

@property (weak, nonatomic) IBOutlet CustomUIImageView *img_product;

@property (weak, nonatomic) IBOutlet UIImageView *img_type;

@property (weak, nonatomic) IBOutlet UILabel *lab_proName;

@property (weak, nonatomic) IBOutlet UILabel *lab_proSku;

@property (weak, nonatomic) IBOutlet UIImageView *icon_m;

@property (weak, nonatomic) IBOutlet UIImageView *icon_z;

@property (weak, nonatomic) IBOutlet UILabel *lab_price;

@property (weak, nonatomic) IBOutlet UILabel *lab_number;

@property (strong, nonatomic) UserProduct *mProduct;

- (void)initWithProduct:(UserProduct *)mProduct hiddenButton:(BOOL)hidden;

-(IBAction)onSelected:(id)sender;


@end
