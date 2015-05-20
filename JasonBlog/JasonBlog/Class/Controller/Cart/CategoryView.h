//
//  CategoryView.h
//  JasonBlog
//
//  Created by jason on 15/5/20.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tab_Category;
    UITableView *tab_SonCategory;
}
@end
