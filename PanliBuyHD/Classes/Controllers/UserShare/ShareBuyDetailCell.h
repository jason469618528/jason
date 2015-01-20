//
//  ShareBuyDetailCell.h
//  PanliApp
//
//  Created by jason on 13-12-16.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareBuyDetail.h"
#import "CustomUIButton.h"

@protocol ShareBuyDetaimImageDelegate <NSObject>
- (void)shareBuyDetailGoToImage:(ShareBuyDetail *)shareBuyDetail ImageRow:(int)imageRow;
@end

@interface ShareBuyDetailCell : UITableViewCell

{
    UILabel *lab_NickName;
    
    UILabel *lab_SendTime;
    
    UILabel *lab_Message;
    
    UIImageView *img_Line;
    id<ShareBuyDetaimImageDelegate> _goToImageDelegate;
}

@property (nonatomic, assign) id<ShareBuyDetaimImageDelegate> goToImageDelegate;
@property (nonatomic, retain) ShareBuyDetail * m_ShareBuyDetail;

- (void)setDisplayData:(ShareBuyDetail*)mShareBuyDetail;

@end
