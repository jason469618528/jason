//
//  SysMessageUserNoteViewController.h
//  PanliApp
//
//  Created by jason on 13-11-1.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "BaseViewController.h"
#import "MessageTopicCsRequest.h"
#import "GetSysMsgRequest.h"
#import "CustomTableViewController.h"
#import "CustomerExceptionView.h"

@interface SysMessageUserNoteViewController : BaseViewController<CustomTableViewControllerDelegate>

{
    CustomTableViewController *tab_SysMsgTable;
    
    //异常view
    CustomerExceptionView *sys_exceptionView;
    
    //数据转发器
    GetSysMsgRequest *req_SysMsgRequest;
    DataRepeater *rpt_SysMsg;
    
    //数据源
    NSMutableArray *marr_SysMsgArray;
    //是否第一次请求
    BOOL isFirstRequestNotice;
    BOOL isFirstRequestAll;
    
}
@end
