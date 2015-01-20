//
//  ShipDownListCell.h
//  PanliApp
//
//  Created by jason on 13-10-31.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShipStatusRecord.h"
#import "ExpressInfo.h"
#import "ShipOrder.h"

@protocol shipDownListCellClickDelegate <NSObject>
- (void)SendShipDownListCellHeight:(CGFloat)Tableviewheight Type:(int)cellType;
@end



@interface ShipDownListCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
{
    UILabel *lab_Title;
    UIImageView *icon_Status;
    UIImageView *icon_DownUp;
    UIActivityIndicatorView *activity_Messages;
    UITableView *tab_Messages;
    NSArray *arr_Messages;
    UITextView *txt_LogisticsNo;
    UILabel *lab_LogisticsDealer;
    UIView *lineNo;
    int cellType;
    BOOL isCellSelect;
    BOOL isReqState;
    UIView *line;
    
    int mainHeightFlag;
    
    ShipOrder *mShipOrder;
}

@property (nonatomic, assign) id<shipDownListCellClickDelegate> cellClickDelegate;

- (void)SetData:(NSArray*)arr_Data ViewType:(int)type isSelect:(BOOL)selectMessages isReqStatus:(BOOL)reqState shipModel:(ShipOrder*)iModel;
@end
