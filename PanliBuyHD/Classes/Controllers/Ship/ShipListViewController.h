//
//  ShipDetailViewController.h
//  PanliApp
//
//  Created by jason on 13-4-23.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShipOrdersRequest.h"
#import "CustomerExceptionView.h"
#import "ShipExpressRequest.h"
#import "ShipDetailViewController.h"
#import "UserUnReadMessages.h"
/**************************************************
 * 内容描述: 运单list页
 * 创 建 人: jason
 * 创建日期: 2013-4-21
 **************************************************/
@interface ShipListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,isShipNewDisplayStateDelegate>

{
    //tableview
    UITableView *tab_AllShipList;

    //判断是否更多
    BOOL isAllShipMore;
    
    ShipOrdersRequest *req_AllShip;
    DataRepeater* rpt_AllShip;
    
    //异常view
    CustomerExceptionView *AllShip_exceptionView;
}

/**
 *运单状态
 */
@property (nonatomic, assign) int ShipState;
/**
 *数据源
 */
@property (nonatomic, retain) NSMutableArray * mArr_AllShip;

/**
 *用户未读短信
 */
@property (nonatomic, retain) UserUnReadMessages *shipUnReadMessages;
@end
