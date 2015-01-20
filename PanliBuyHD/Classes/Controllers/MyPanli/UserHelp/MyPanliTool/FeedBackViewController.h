//
//  FeedBackViewController.h
//  PanliBuyHD
//
//  Created by guo on 14-10-29.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "BaseViewController.h"
#import "GCPlaceholderTextView.h"
#import "SendFeedBackRequest.h"

@protocol FeedBackViewDelegate;

@interface FeedBackViewController : BaseViewController<UITextViewDelegate>
{
    BOOL feedBackSuccess;
    
    UIBarButtonItem *_rightbutton;
    
    GCPlaceholderTextView *_txt_FeedBack;
    
    __unsafe_unretained id<FeedBackViewDelegate> _delegate;
    
    SendFeedBackRequest *req_SendFeedBack;
    DataRepeater *data_SendFeedBack;
    
}

@property (nonatomic,assign) id<FeedBackViewDelegate> delegate;

@end

@protocol FeedBackViewDelegate <NSObject>

- (void)feedBackSuccess;

@end
