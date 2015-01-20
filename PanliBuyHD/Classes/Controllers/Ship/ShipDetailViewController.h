//
//  WayBillDetailViewController.h
//  PanliApp
//
//  Created by jason on 13-4-23.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShipDetailRequest.h"
#import "ShipRecordRequest.h"
#import "ShipExpressRequest.h"
#import "ConfimReceivedRequest.h"
#import "CancelShipRequest.h"
#import "PopView.h"
#import "ShipOrder.h"
#import "ShipDownListCell.h"
#import "BaseViewController.h"

@protocol isShipNewDisplayStateDelegate <NSObject>
- (void)isShipNewDisplayState;
- (void)isDeleteShip;
@end
/**************************************************
 * 内容描述: 运单列表
 * 创 建 人: jason
 * 创建日期: 2013-4-21
 **************************************************/
@interface ShipDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,shipDownListCellClickDelegate>

{
    
    //滑动
    UIScrollView *scr_ShipScroll;
    
    NSMutableArray *marr_ShipDetail;
    //商品详情
    NSArray *arr_ShipOrders;
    
    //进度追踪数组
    NSArray *arr_Schedule;
    
    //物流数组
    NSArray *arr_Logistics;
    
    //进度追踪表
    UITableView *tab_Schedule;
    
    //国际物流
    UITableView *tab_Logistics;
    
    //运单信息
    UITableView *tab_ShipDetail;
    
    //运单商品
    UITableView *tab_ShipOrders;
    
    BOOL b_RateState;
    
    //记录滑动页面
    int currentPage;
    
    UIView *view_Bottom;
    
    float scheduleHeightFlag;
    float logisticsHeightFlag;
    
    
    //运单详情请求
    ShipDetailRequest *req_ShipDetail;
    DataRepeater *data_ShipDetail;
    
    //进度追踪
    ShipRecordRequest *req_ShipSchedule;
    DataRepeater *data_ShipSchedule;
    
    //物流
    ShipExpressRequest *req_ShipLogistics;
    DataRepeater *data_ShipLogistics;
    
    //确认收货
    ConfimReceivedRequest *req_ConfimReceived;
    DataRepeater *data_ConfimReceived;
    
    //删除订单
    CancelShipRequest *req_CancelShip;
    DataRepeater *data_CancelShip;
    
    PopView *view_PopView;
      
    int i_ShipState;
    
    BOOL isShipDetailFlag;
    BOOL isScheduleFlag;
    BOOL isLogisticsFlag;
    BOOL isShipOrdersFlag;
    
    BOOL isReqLogisticsFlag;
    ShipOrder  * mShipDetail;
}

//运单id
@property(nonatomic,retain)NSString *str_ShipId;

//物流url
@property(nonatomic,retain)NSString *str_ShipExpressUrl;

//物流no
@property (nonatomic, retain) NSString *str_ShipExpressNo;

/**
 *判断新消息状态
 */
@property (nonatomic, assign) id<isShipNewDisplayStateDelegate> isNewDisplayStateDelegate;

//列表数据源
@property (nonatomic, retain) ShipOrder  * mShipOrder;
@property (nonatomic, retain) NSMutableArray * arr_OrderObject;
@end
