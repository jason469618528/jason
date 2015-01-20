//
//  NavFilterView.h
//  PanliApp
//
//  Created by Liubin on 14-4-3.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavFilterViewDelegate <NSObject>

@required
- (void)filterSelectDone:(int)index isChange:(BOOL)changed;

@end

@interface NavFilterView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tab_FilterItem;
    UIControl *selectionView;
    UIControl *shadowView;
    UIImageView *img_Arrows;
}

@property (nonatomic, assign) int selectIndex;

@property (nonatomic, retain) NSArray *filterItems;

@property (nonatomic, assign) id<NavFilterViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame itemArray:(NSArray *)items selectedIndex:(int)index;

@end
