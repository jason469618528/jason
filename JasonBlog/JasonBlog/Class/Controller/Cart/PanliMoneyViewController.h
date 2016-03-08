//
//  PanliMoneyViewController.h
//  JasonBlog
//
//  Created by jason on 15/6/8.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import "BaseViewController.h"

@interface PanliMoneyViewController : BaseViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tab_MainView;
}
- (IBAction)btn_ClearMessage:(id)sender;
@end
