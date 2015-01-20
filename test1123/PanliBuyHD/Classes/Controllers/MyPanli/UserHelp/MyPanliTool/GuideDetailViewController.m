//
//  GuideDetailViewController.m
//  PanliApp
//
//  Created by Liubin on 13-11-4.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "GuideDetailViewController.h"

@interface GuideDetailViewController ()

@end

@implementation GuideDetailViewController

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_mGuide);
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoadWithBackButtom:YES];
	self.navigationItem.title = self.mGuide.guideName;
    self.view.backgroundColor = [PanliHelper colorWithHexString:@"#eeeeeb"];
    mainWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT)];
    mainWebView.delegate = self;
    mainWebView.scalesPageToFit = YES;
    [self.view addSubview:mainWebView];
    [mainWebView release];
    NSString *urlStr = [NSString stringWithFormat:[[BASE_URL stringByReplacingOccurrencesOfString:@"API/" withString:@""] stringByAppendingString:URL_GUIDE_DETAIL],self.mGuide.guideId];
    [mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showHUDIndicatorMessage:LocalizedString(@"GuideDetailViewController_HUDIndMsg",@"正在加载...")];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self showHUDErrorMessage:error.localizedDescription];
}

@end
