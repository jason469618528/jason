//
//  MessageDetailCell.h
//  PanliApp
//
//  Created by Liubin on 13-4-22.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
#import "CustomUIImageView.h"
#import "IFTweetLabel.h"
@interface MessageDetailCell : UITableViewCell
{    
    //昵称
    UILabel *lab_NickName;
    
    //内容
    IFTweetLabel *lab_Content;
    
    //日期
    UILabel *lab_Date;
    
    //标识
    UIImageView *img_State;
    
    //背景颜色
    UIView *view_BackColor;
}

- (void)setMessageData:(Message *)data;

@end
