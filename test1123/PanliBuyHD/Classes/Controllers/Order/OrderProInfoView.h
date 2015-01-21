//
//  OrderProInfoView.h
//  PanliBuyHD
//
//  Created by Liubin on 14-6-23.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomUIImageView.h"
#import "UserProduct.h"

@interface OrderProInfoView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *mainScrollView;
    CustomUIImageView *img_product;
    UIImageView *img_type;
    UILabel *lab_proName;
    UILabel *lab_price;
    UILabel *lab_count;
    
    //进度
    UITableView *tab_schedule;
    //物流
    UITableView *tab_transFlow;
    //备注
    UITextView *txt_remark;
}

@property (strong, nonatomic) UserProduct *mProduct;
//
//@property (weak, nonatomic) IBOutlet CustomUIImageView *img_product;
//
//@property (weak, nonatomic) IBOutlet UIImageView *img_type;
//
//@property (weak, nonatomic) IBOutlet UILabel *lab_proName;
//
//@property (weak, nonatomic) IBOutlet UILabel *lab_price;
//
//@property (weak, nonatomic) IBOutlet UILabel *lab_count;
//
//@property (weak, nonatomic) IBOutlet UITableView *tab_info;

//+ (OrderProInfoView *)instanceWithFrame:(CGRect)frame;
- (void)reloadWithProdduct:(UserProduct *)mProduct;

@end
