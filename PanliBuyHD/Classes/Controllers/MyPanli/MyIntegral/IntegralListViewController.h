//
//  IntegralListViewController.h
//  PanliBuyHD
//
//  Created by guo on 14-10-23.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "BaseViewController.h"
#import "NavFilterView.h"
#import "CustomTableViewController.h"
#import "CustomerExceptionView.h"
#import "ScoreRecordsRequest.h"

@interface IntegralListViewController : BaseViewController<NavFilterViewDelegate,CustomTableViewControllerDelegate>
{
    NavFilterView *filterView;
    UIButton *btnNavOrder;
    UIImageView *imgFilterIcon;
    
    CustomTableViewController *tab_ScoreRecords;
    CustomerExceptionView *exceptionView_Score;
    
    int showFlag;
    BOOL isFirstRequest;
    //面码
    int pageIndexScoreAll;
    int pageIndexScoreExpend;
    int pageIndexScoreIncome;
    
    //总页数
    int pageCountScoreAll;
    int pageCountScoreExpend;
    int pageCountScoreIncome;
    ScoreRecordsRequest *req_ScoreRecords;
    DataRepeater *rpt_ScoreRecords;
}

@property (nonatomic, retain) NSMutableArray *marr_AllRecords;
@property (nonatomic, retain) NSMutableArray * marr_IncomeRecords;
@property (nonatomic, retain) NSMutableArray * marr_ExpendRecords;

@end
