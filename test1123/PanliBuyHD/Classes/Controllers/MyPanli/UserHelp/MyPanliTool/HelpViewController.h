//
//  HelpViewController.h
//  PanliBuyHD
//
//  Created by guo on 14-10-28.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomerAutoRollScrollView.h"
#import "GetGuideListRequest.h"
#import "GuideView.h"

@interface HelpViewController : BaseViewController<UIScrollViewDelegate,ScrollViewDataSource,GuideViewDelegate>
{
    UIScrollView *_mainScrollView;
    CustomerAutoRollScrollView *_guideScrollView;
    
    GetGuideListRequest *req_getGuideList;
    
    DataRepeater *rpt_gGetGuideList;
    
}

@property (nonatomic, retain) NSArray *guideBannerArray;
@property (nonatomic, retain) NSArray *guideDetailArray;

@end
