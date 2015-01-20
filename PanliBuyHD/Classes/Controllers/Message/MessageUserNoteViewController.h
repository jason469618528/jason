//
//  MessageUserNoteViewController.h
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

@interface MessageUserNoteViewController : BaseViewController<CustomTableViewControllerDelegate>

{
    CustomTableViewController *tab_MessageTable;

    //异常view
    CustomerExceptionView *msg_exceptionView;
    
    //数据请求
    MessageTopicCsRequest *req_MessageRequest;
    DataRepeater *rpt_Message;
    
    //数据源
    NSMutableArray *marr_MessageArray;
    
    //是否第一次请求
    BOOL isFirstRequestMessage;
    BOOL isFirstRequestAll;
}
@end
