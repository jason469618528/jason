//
//  CartHomeViewController.h
//  JasonBlog
//
//  Created by jason on 15-5-4.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartHomeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *timeArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tab_Main;
@property (strong, nonatomic) NSTimer *timer;
@end
