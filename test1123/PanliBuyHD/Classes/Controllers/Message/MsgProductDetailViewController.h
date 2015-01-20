//
//  MsgProductDetailViewController.h
//  PanliApp
//
//  Created by jason on 13-6-19.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetUserProductRequest.h"
#import "BaseViewController.h"
@interface MsgProductDetailViewController : BaseViewController

{
    UIScrollView *mainScrollView;
    
    GetUserProductRequest *req_GetProduct;
    DataRepeater *data_GetProduct;
}
@property(nonatomic,retain)NSString * str_ProductId;
@end
