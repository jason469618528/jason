//
//  SysMsgDetailViewController.h
//  PanliApp
//
//  Created by jason on 13-4-19.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetSysMsgIsReadRequest.h"
#import "IFTweetLabel.h"
#import "SysMsgTopic.h"
#import "BaseViewController.h"
@interface SysMsgDetailViewController : BaseViewController

{
    SetSysMsgIsReadRequest *req_SysMIsRead;
    DataRepeater *data_SysMIsRead;
    
}
@property(nonatomic,retain)SysMsgTopic *m_SysMsgTopic;
@end
