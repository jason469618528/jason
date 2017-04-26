//
//  ToolHomeViewController.m
//  JasonBlog
//
//  Created by jason on 16/1/8.
//  Copyright © 2016年 PanliMobile. All rights reserved.
//

#import "ToolHomeViewController.h"

@interface ToolHomeViewController ()

@end

@implementation ToolHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = J_COLOR_RED;
    self.navigationItem.title = @"工具";
    // Do any additional setup after loading the view.
    CustomButton *btn_ToolClick = [CustomButton buttonWithType:UIButtonTypeCustom];
    btn_ToolClick.frame = CGRectMake(100.0f, 110.0f, 100.0f, 100.0f);
    btn_ToolClick.backgroundColor = J_COLOR_WHITE;
    [btn_ToolClick btnClickEventBlock:^{
        NSLog(@"asdfasdfasf");
        [self dimss];
    }];
    [self.view addSubview:btn_ToolClick];
    

}

- (void)showInView:(UIView*)view{
    if(self.view.superview != view){
        [self.view removeFromSuperview];
        [view addSubview:self.view];
    }
    self.view.hidden = NO;
    self.view.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 1;
    } completion:^(BOOL finished){
    }];
}

- (void)dimss{
//    self.view.alpha = 1;
//    [UIView animateWithDuration:0.3 animations:^{
//        self.view.alpha = 0;
//    } completion:^(BOOL finished){
//        [self.view removeFromSuperview];
//    }];
//    
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT)];
//    webView.backgroundColor = [UIColor whiteColor];
//    webView.scalesPageToFit = YES;
//    webView.scrollView.clipsToBounds = YES;
//    webView.scrollView.scrollsToTop = YES;
//    
//    NSString *path = [[NSBundle mainBundle] bundlePath];
//    NSURL *baseURL = [NSURL fileURLWithPath:path];
//    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"上海"
//                                                          ofType:@"html"];
//    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
//                                                    encoding:NSUTF8StringEncoding
//                                                       error:nil];
//    [webView loadHTMLString:htmlCont baseURL:baseURL];
//    [self.view addSubview:webView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController isCanBack:NO];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController isCanBack:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
