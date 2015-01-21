//
//  BrowseWebViewController.h
//  PanliBuyHD
//
//  Created by jason on 15-1-21.
//  Copyright (c) 2015年 Panli. All rights reserved.
//

#import "BaseViewController.h"
#import "indexCategory.h"
@interface BrowseWebViewController : BaseViewController
@property(nonatomic,strong)indexCategory *category;
@property (strong, nonatomic) IBOutlet UIWebView *mainWebView;
@end
