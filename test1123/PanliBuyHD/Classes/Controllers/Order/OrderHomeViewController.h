//
//  OrderHomeViewController.h
//  PanliBuyHD
//
//  Created by Liubin on 14-6-16.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderProInfoView.h"
#import "GetUserOrdersRequest.h"

@interface OrderHomeViewController : BaseViewController
{
    NSInteger _currentIndex;
    BOOL isAllChecked;
    NSArray *orderStatusDataSource;
    
    OrderProInfoView *view_ProInfo;
    GetUserOrdersRequest *req_GetUserOrdersRequest;
    DataRepeater *rpt_GetUserOrders;
}

@property (strong, nonatomic) NSMutableArray *productDataSource;

@property (weak, nonatomic) IBOutlet UITableView *tab_OrderStatus;
@property (weak, nonatomic) IBOutlet UITableView *tab_Products;

@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UIButton *btn_Check;
@property (weak, nonatomic) IBOutlet UILabel *lab_Count;
@property (weak, nonatomic) IBOutlet UILabel *lab_Weight;
@property (weak, nonatomic) IBOutlet UILabel *lab_Price;

-(IBAction)buttonOnClick:(id)sender;

@end
