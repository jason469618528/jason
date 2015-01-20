//
//  EstimateListViewController.h
//  PanliApp
//
//  Created by jason on 13-5-13.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "BaseViewController.h"
#import "EstimatesRequest.h"

/**************************************************
 * 内容描述: 费用估算结果
 * 创 建 人: Jason
 * 创建日期: 2013-05-13
 **************************************************/
@interface EstimateListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *arr_Estimatrs;
    UITableView *tab_Estimates;
    
    EstimatesRequest *req_Estimates;
    DataRepeater *data_Estimates;
  
    
}
@property (nonatomic, retain) NSString  * type;
@property (nonatomic, retain) NSString  * shipCountryId;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * weight;

@end
