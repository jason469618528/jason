//
//  ExpenditureViewController.h
//  PanliApp
//
//  Created by jason on 14-5-12.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "BaseViewController.h"
#import "NavFilterView.h"
#import "AccountRecordsRequest.h"
#import "CustomTableViewController.h"
#import "CustomerExceptionView.h"
/**************************************************
 * 内容描述: 用户消费记录
 * 创 建 人: jason
 * 创建日期: 2014-5-12
 **************************************************/
@interface ExpenditureViewController : BaseViewController<NavFilterViewDelegate,CustomTableViewControllerDelegate>
{
    NavFilterView *filterView;
    UIButton *btnNavOrder;
    UIImageView *imgFilterIcon;
    
    CustomTableViewController *tab_Expenditure;
    CustomerExceptionView *exceptionView;
    int showFlag;
    BOOL isFirstRequest;
    
    //面码
    int pageIndexAll;
    int pageIndexExpend;
    int pageIndexIncome;
    
    //总页数
    int pageCountAll;
    int pageCountExpend;
    int pageCountIncome;
    
    AccountRecordsRequest *req_Records;
    DataRepeater *rpt_Records;
}


@property (nonatomic, retain) NSMutableArray *marr_AllRecords;
@property (nonatomic, retain) NSMutableArray * marr_IncomeRecords;
@property (nonatomic, retain) NSMutableArray * marr_ExpendRecords;
@end
