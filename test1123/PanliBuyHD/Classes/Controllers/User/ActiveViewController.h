//
//  ActiveViewController.h
//  PanliApp
//
//  Created by Liubin on 13-7-19.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ActiveViewController : BaseViewController<UIWebViewDelegate>
{
    
}

@property (nonatomic, retain) NSString *emailSite;
@end
