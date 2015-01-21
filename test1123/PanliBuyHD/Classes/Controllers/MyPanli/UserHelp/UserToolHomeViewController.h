//
//  UserToolHomeViewController.h
//  PanliApp
//
//  Created by jason on 14-4-4.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "BaseViewController.h"
#import "FeedBackViewController.h"
@interface UserToolHomeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,FeedBackViewDelegate>
{
    NSArray *arr_Data;
    NSArray *arr_Image;
    UIButton * btn_logout;
    UITableView *tab_Main;
}

@property (nonatomic,strong) UIPopoverController *popOver;
@end
