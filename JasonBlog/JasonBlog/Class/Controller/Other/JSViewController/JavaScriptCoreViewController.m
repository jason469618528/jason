//
//  JavaScriptCoreViewController.m
//  JasonBlog
//
//  Created by iyb-hj on 2017/9/20.
//  Copyright © 2017年 PanliMobile. All rights reserved.
//

#import "JavaScriptCoreViewController.h"
#import <WebKit/WebKit.h>

@interface JavaScriptCoreViewController () <UIWebViewDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (strong, nonatomic) WKWebView *webView;
@end

@implementation JavaScriptCoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = J_COLOR_WHITE;
    // Do any additional setup after loading the view.
    
    
    [self.view addSubview:self.webView];
    
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"JSCallOC" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:fileName];
    [self.webView loadHTMLString:appHtml baseURL:baseURL];
    
    [[self.webView configuration].userContentController addScriptMessageHandler:self name:@"NativeMethod"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    // 以 html title 设置 导航栏 title
//    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    
//    // 禁用 页面元素选择
//    //[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
//    
//    // 禁用 长按弹出ActionSheet
//    //[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
//    
//    // Undocumented access to UIWebView's JSContext
//    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    // 以 JSExport 协议关联 native 的方法
//    self.context[@"native"] = self;
//}

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"JS 调用了 %@ 方法，传回参数 %@",message.name,message.body);
}

#pragma mark - TestJSExport
- (void)handleFactorialCalculateWithNumber:(NSNumber *)number {
    NSLog(@"handleFactorialCalculateWithNumber");
}

- (void)pushViewController:(NSString *)view title:(NSString *)title {
    NSLog(@"pushViewController");

}
#pragma mark - getter
- (WKWebView*)webView {
    if(_webView == nil) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _webView.navigationDelegate = self;
    }
    return _webView;
}

@end
