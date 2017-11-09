//
//  ToolHomeViewController.m
//  JasonBlog
//
//  Created by jason on 16/1/8.
//  Copyright © 2016年 PanliMobile. All rights reserved.
//

#import "ToolHomeViewController.h"
#import "HomeDetailViewController.h"
#import <MediaPlayer/MediaPlayer.h>
@interface ToolHomeViewController ()
@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;

@end

@implementation ToolHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = J_COLOR_RED;
    
    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    
    self.navigationItem.title = @"工具";
    // Do any additional setup after loading the view.
    
    CustomButton *btn_ToolClick = [CustomButton buttonWithType:UIButtonTypeCustom];
    btn_ToolClick.frame = CGRectMake(100.0f, 110.0f, 100.0f, 100.0f);
    btn_ToolClick.backgroundColor = J_COLOR_WHITE;
    [btn_ToolClick btnClickEventBlock:^{
//        HomeDetailViewController *detailVC = [[HomeDetailViewController alloc] init];
//        detailVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:detailVC animated:YES];
        
        NSString *file = @"http://mvvideo2.meitudata.com/5785a7e3e6a1b824.mp4";
        NSURL *url = [NSURL URLWithString:file];
        if (_moviePlayer == nil) {
            _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
        }else {
            [_moviePlayer setContentURL:url];
        }
        
        _moviePlayer.controlStyle = MPMovieControlStyleNone;
        _moviePlayer.shouldAutoplay = YES;
        _moviePlayer.repeatMode = MPMovieRepeatModeOne;
        [_moviePlayer setFullscreen:YES animated:YES];
        _moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
        [_moviePlayer play];
        
        _moviePlayer.view.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, 200);
        [self.view addSubview:_moviePlayer.view];

    }];
////    [[btn_ToolClick rac_command] regis]
    [self.view addSubview:btn_ToolClick];
    
//    NSString *newString = [html stringByReplacingOccurrencesOfString:@"<img" withString:[NSString stringWithFormat:@"<img width=\"%f\"",width]];
//    
//    NSAttributedString *attributeString=[[NSAttributedString alloc] initWithData:[newString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    
    //HTML代码
//    NSString *htmlStr = @"<img src=\"https://cdn-test.iyb.tm/bbs/img/post/218.jpg\" width=\"275px\"; left:100px; right:100px; \">sadfasfasfasfsadfssfsfa<font size=\"3\" color=\"red\">This is some text!</font><img src=\"http://cdn.v2ex.com/site/logo@2x.png\"/><img src=\"http://cdn.v2ex.com/site/logo@2x.png\"/><img src=\"http://cdn.v2ex.com/site/logo@2x.png\"/><img src=\"http://cdn.v2ex.com/site/logo@2x.png\"/><img src=\"http://cdn.v2ex.com/site/logo@2x.png\"/><img src=\"http://cdn.v2ex.com/site/logo@2x.png\"/><img src=\"https://cdn-test.iyb.tm/bbs/img/post/218.jpg\"/><img src=\"http://cdn.v2ex.com/site/logo@2x.png\"/><img src=\"http://cdn.v2ex.com/site/logo@2x.png\"/><img src=\"https://cdn-test.iyb.tm/bbs/img/post/218.jpg\"/><img src=\"http://cdn.v2ex.com/site/logo@2x.png\"/>";
    NSString *htmlStr = @"<strong>加粗的文字<\/strong><span style=\"color:#ff0000\">有颜色的文字<img alt=\"\" src=\"https:\/\/cdn-test.iyb.tm\/bbs\/img\/post\/725.png\" \/><\/span><img alt=\"\" src=\"https:\/\/cdn-test.iyb.tm\/bbs\/img\/post\/725.png\" \/><img alt=\"\" src=\"https:\/\/cdn-test.iyb.tm\/bbs\/img\/post\/725.png\" \/><img alt=\"\" src=\"https:\/\/cdn-test.iyb.tm\/bbs\/img\/post\/725.png\" \/><img alt=\"\" src=\"https:\/\/cdn-test.iyb.tm\/bbs\/img\/post\/725.png\" \/><img alt=\"\" src=\"https:\/\/cdn-test.iyb.tm\/bbs\/img\/post\/725.png\" \/><img alt=\"\" src=\"https:\/\/cdn-test.iyb.tm\/bbs\/img\/post\/725.png\" \/>\n";
    
    //对图片大小进行处理，适应屏幕宽度
    NSString *newString = [htmlStr stringByReplacingOccurrencesOfString:@"<img" withString:[NSString stringWithFormat:@"<img width=\"%f\"",MainScreenFrame_Width - 20]];
//    style="display:block;width:100%;"
    NSMutableString *html = [NSMutableString stringWithFormat:@"<style type=\"text/css\" > img { width:100%%; margin-top:5px;margin-bottom:5px } </style><div style='width:%dpx;font-size:15px;color:#333;line-height:20px'>",375];
    NSString *newContent = [htmlStr stringByReplacingOccurrencesOfString:@"\n" withString:@"<br />"];
    [html appendString:newContent];
    [html appendString:@"</div>"];

    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];;
    
    CGFloat height = [attributedString boundingRectWithSize:CGSizeMake(MainScreenFrame_Width - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10.0f, 200.0f, MainScreenFrame_Width - 20, height)];
    //    textView.editable = NO;
    textView.attributedText = attributedString;
    [self.view addSubview:textView];
    
    
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n"
                                                                                    options:0
                                                                                      error:nil];
    NSString *content = @"<img src=\"http://cdn.v2ex.com/site/logo@2x.png\"/>sadfasfasfasfsadfssfsfa<font size=\"3\" color=\"red\">This is some text!</font>";
    NSArray *components = [content componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSMutableArray *componentsToKeep = [NSMutableArray array];
    
    for (int i = 0; i < [components count]; i = i + 2) {
        
        [componentsToKeep addObject:[components objectAtIndex:i]];
        
    }
    NSString *plainText = [componentsToKeep componentsJoinedByString:@""];
    
    content = [regularExpretion stringByReplacingMatchesInString:htmlStr options:NSMatchingReportProgress range:NSMakeRange(0, htmlStr.length) withTemplate:@"-"];//替换所有html和换行匹配元素为"-"
    
    regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"-{1,}" options:0 error:nil] ;
    content = [regularExpretion stringByReplacingMatchesInString:content options:NSMatchingReportProgress range:NSMakeRange(0, content.length) withTemplate:@"-"];//把多个"-"匹配为一个"-"
    
    NSArray *arr=[NSArray array];
    content=[NSString stringWithString:content];
    arr =  [content componentsSeparatedByString:@"-"];
    NSMutableArray *marr=[NSMutableArray arrayWithArray:arr];
    [marr removeObject:@""];
    for (NSString *str in marr) {
        NSLog(@"%@\n",str);
    }
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
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
