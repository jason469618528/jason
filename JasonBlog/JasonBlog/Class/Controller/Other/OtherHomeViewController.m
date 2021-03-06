//
//  OtherHomeViewController.m
//  JasonBlog
//
//  Created by jason on 15-5-4.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#define DEBUG_FLAG


#import "OtherHomeViewController.h"
#import "ToolHomeViewController.h"
#include <objc/runtime.h>
#import "UIAlertView+EasyUIKit.h"
#import "RSMaskedLabel.h"
#import <AFNetworking.h>
#import <MediaPlayer/MediaPlayer.h>
#import "DTCoretextViewController.h"
#import "DemoTextViewController.h"
#import "DTCoreDemoViewController.h"
#import "JasonAAAViewController.h"
#import "JavascriptBridgeViewController.h"
#import "WKWebViewController.h"


@interface OtherHomeViewController (){
    dispatch_source_t _timer;
}

@property (nonatomic, strong) NSMutableArray<NSString *> *arrayList;
@property (nonatomic, strong) ToolHomeViewController *toolVC;

@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;
@end

@implementation OtherHomeViewController

- (id)init{
    if(self = [super init]){
        NSLog(@"%@",[self class]);
        NSLog(@"%@",[super class]);
    }
    return self;
}

//- (void)loadView
//{
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
//#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_2_2
//    // iPhone OS SDK 3.0 以后版本的处理
//    NSLog(@">3.0");
//#else
//    // iPhone OS SDK 3.0 之前版本的处理
//    NSLog(@"<3.0");
//#endif
    
#ifdef DEBUG_FLAG
    NSLog(@"111111111.0");
#else
    NSLog(@"222222222.0");
#endif
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    
    NSArray *titleArr = @[@"DCDemo",@"selfDemo",@"otherDemo"];
    
    for (NSInteger i = 0; i < titleArr.count; ++i) {
        UIButton *btn_ToolClick = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_ToolClick.frame = CGRectMake(0.0f, i * 100.0f + 10.f, MainScreenFrame_Width, 100.0f);
        btn_ToolClick.tag = 1000 + i;
        btn_ToolClick.backgroundColor = J_COLOR_GRAY;
        [btn_ToolClick setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
        [btn_ToolClick addTarget:self action:@selector(toolClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn_ToolClick];
        
        UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(cellLongPress:)];
        [btn_ToolClick addGestureRecognizer:gesture];
    }
    
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"哈哈123456"];
//    // 设置“哈哈”为蓝色
//    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 2)];
//    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(0, 2)];
//    [string addAttribute:NSBackgroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
//    
//    // 设置“456”为红色
//    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6, 2)];
//    [string addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:24] range:NSMakeRange(6, 2)];
//    [string addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(6, 2)];
//    
//    // 创建图片图片附件
//    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
//    attach.image = [UIImage imageNamed:@"AppIcon60x60"];
//    attach.bounds = CGRectMake(0, 0, 60, 60);
//    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
//    
//    
//    [string appendAttributedString:attachString];
//    
//    [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"789"]];
    
//    NSMutableAttributedString *attributedString = [NSMutableAttributedString nb_attributedStringWithText:@"i云保" font:[UIFont systemFontOfSize:30] color:[UIColor redColor]];
//    [attributedString appendString:@"上海" font:[UIFont systemFontOfSize:14] color:[UIColor blueColor]];
//    [attributedString appendAttributedString:[NSAttributedString nb_attributedStringWithImageName:@"AppIcon60x60" bounds:CGRectMake(0, 0, 160, 160)]];
//    [attributedString appendString:@"网络" font:[UIFont systemFontOfSize:14] color:[UIColor blackColor]];
//    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0.0f, 200.0f, MainScreenFrame_Width, 200)];
////    textView.editable = NO;
//    textView.attributedText = attributedString;
//    [self.view addSubview:textView];
    
    bool res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
    bool res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
    NSLog(@"res1 ==== %d\n res2 === %d",res1,res2);
    
//    class_addProperty(self, @"Test", <#const objc_property_attribute_t *attributes#>, <#unsigned int attributeCount#>)
    
    
    [UIAlertView showConfirmWithTitle:@"sadf" message:@"message" clickComplete:^(UIAlertView *alertView, NSInteger buttonTag) {
        NSLog(@"%@----%ld",alertView,buttonTag);
    }];
    
    NSBundle *myBundle = [NSBundle mainBundle];
    NSLog(@"%@",myBundle);
    
    
    dispatch_queue_t q_queue =  dispatch_queue_create("zy", DISPATCH_QUEUE_SERIAL);
    
        // 将任务添加到队列中
    dispatch_async(q_queue, ^{
            NSLog(@"%@---%zd",[NSThread currentThread],100);
        });
    
    dispatch_async(q_queue, ^{
        NSLog(@"%@---%zd",[NSThread currentThread],200);
    });
    
    dispatch_async(q_queue, ^{
        NSLog(@"%@---%zd",[NSThread currentThread],300);
    });
    
    dispatch_async(q_queue, ^{
        NSLog(@"%@---%zd",[NSThread currentThread],400);
    });
    
    NSLog(@"End");

    
//    [self startGCDTimer];
    
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queueGroup = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_async(group, queueGroup, ^{

    });
    dispatch_group_async(group, queueGroup, ^{

    });
    dispatch_group_async(group, queueGroup, ^{

    });
    
    dispatch_group_notify(group, queueGroup, ^{
        NSLog(@"dispatch_group_notify End");
    });
//    [self performSelector:@selector(loadWait) withObject:self afterDelay:10];
//    [UIView animateWithDuration:10 animations:^{
//        [self loadWait];
//    }];
    
//    RSMaskedLabel *maskLabel = [[RSMaskedLabel alloc] initWithFrame:CGRectMake(0.0f, 20.0f, MainScreenFrame_Width, 50.0f)];
//    maskLabel.text = NSLocalizedString(@"home_back",nil);
//    maskLabel.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:maskLabel];
    

    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *filePath = NSTemporaryDirectory();
        NSString *flleName = [filePath stringByAppendingPathComponent:@"text.jpg"];
        NSData *dataTest = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://img6.bdstatic.com/img/image/smallpic/dongzijianxiaotup.jpg"]];
        if(dataTest) {
            UIImage *image = [UIImage imageWithData:dataTest];
            [dataTest writeToFile:flleName atomically:YES];
        }
    });
    
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:<#(nonnull id)#>];
//    NSKeyedUnarchiver unarchiveObjectWithData:<#(nonnull NSData *)#>

//    NSSearchPathDirectory
    NSDate* tmpStartData = [NSDate date];
    //You code here...
    double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
    NSLog(@"cost time = %f s", deltaTime);
    
    @autoreleasepool {
        
    };
}

-(void)startGCDTimer {
    NSTimeInterval period = 1.0; //设置时间间隔
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        //在这里执行事件
        NSLog(@"每秒执行test");
    });
    dispatch_resume(_timer);
}


- (void)toolClick:(UIButton*)btn
{
//    NSString *file = @"http://mvvideo2.meitudata.com/5785a7e3e6a1b824.mp4";
//    NSURL *url = [NSURL URLWithString:file];
//    if (_moviePlayer == nil) {
//        _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
//    }else {
//        [_moviePlayer setContentURL:url];
//    }
//    
//    _moviePlayer.controlStyle = MPMovieControlStyleNone;
//    _moviePlayer.shouldAutoplay = YES;
//    _moviePlayer.repeatMode = MPMovieRepeatModeOne;
//    [_moviePlayer setFullscreen:YES animated:YES];
//    _moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
//    [_moviePlayer play];
//    
//    _moviePlayer.view.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, 200);
//    [self.view addSubview:_moviePlayer.view];
    
    if(btn.tag == 1000) {
//        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Snippets" ofType:@"plist"];
//        NSArray *snippets = [[NSArray alloc] initWithContentsOfFile:plistPath];
////
//        NSDictionary *rowSnippet = [snippets objectAtIndex:6];
//        
//        
//        DemoTextViewController *toolHome = [[DemoTextViewController alloc] init];
//        toolHome.fileName = [rowSnippet objectForKey:@"File"];
//        toolHome.baseURL = [NSURL URLWithString:[rowSnippet  objectForKey:@"BaseURL"]];
//        toolHome.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:toolHome animated:YES];
        
        DTCoretextViewController *toolHome = [[DTCoretextViewController alloc] init];
        toolHome.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:toolHome animated:YES];
    } else if(btn.tag == 1001) {
        DTCoreDemoViewController *toolHome = [[DTCoreDemoViewController alloc] init];
        toolHome.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:toolHome animated:YES];
    } else {
//        JasonAAAViewController *toolHome = [[JasonAAAViewController alloc] init];
//        toolHome.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:toolHome animated:YES];
        JavascriptBridgeViewController  *toolHome = [[JavascriptBridgeViewController alloc] init];
        toolHome.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:toolHome animated:YES];
    }

////
//    [self.toolVC showInView:self.navigationController.view];
//    btn.transform = CGAffineTransformMakeRotation((45.0f * M_PI) / 180.0f);
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//         NSDictionary *dict = @{@"name": @"zhangsan"};
//         NSDictionary *dict1 = @{@"name": @"wangwu"};
//         NSArray *array = @[dict, dict1];
//         // 设置请求格式
//         manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        // 设置返回格式
//         manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//         [manager POST:@"http://localhost/postjson.php" parameters:array success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//                NSLog(@"%@", result);
//             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                 
//            }];
    
//    for (int i =0; i <20; i++) {
//        dispatch_async(dispatch_get_global_queue(0,0), ^{
//            [NSThread sleepForTimeInterval:3];
//            NSLog(@"NSThread %@ %d",[NSThread currentThread],i);
//        });
//    }
    
    //创建队列 参数1：队列名称  参数2：队列属性
//    dispatch_queue_t serialqueue =dispatch_queue_create("serialqueue",DISPATCH_QUEUE_SERIAL);
//    for (int i =0; i <20; i++) {
//        dispatch_sync(serialqueue, ^{
//            NSLog(@"%@ %d",[NSThread currentThread],i);
//        });
//    }
    
//    dispatch_queue_t serialqueue1 =dispatch_queue_create("serialqueue1",DISPATCH_QUEUE_SERIAL);
//    for (int i =0; i <20; i++) {
//        dispatch_async(serialqueue1, ^{
//            NSLog(@"%@ %d",[NSThread currentThread],i);
//        });
//    }

//    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrentQueue",DISPATCH_QUEUE_CONCURRENT);
//    for (int i =0; i <20; i++) {
//        dispatch_async(concurrentQueue, ^{
//            NSLog(@"%@ %d",[NSThread currentThread],i);
//        });
//    }
//
//    
//    dispatch_queue_t concurrentQueue1 =dispatch_queue_create("concurrentQueue1",DISPATCH_QUEUE_CONCURRENT);
//    for (int i =0; i <20; i++) {
//        dispatch_sync(concurrentQueue1, ^{
//            NSLog(@"%@ %d",[NSThread currentThread],i);
//        });
//    }
//
    //获取主线程
    dispatch_queue_t mainqueue = dispatch_get_main_queue();
    for (int i =0; i <20; i++) {
        dispatch_async(mainqueue, ^{
            NSLog(@"main queue %@ %d",[NSThread currentThread],i);
        });
    }

//    //获取主线程
//    dispatch_queue_t mainqueue =dispatch_get_main_queue();
//    dispatch_sync(mainqueue, ^{
//        NSLog(@"main queue %@",[NSThread currentThread]);
//    });
    
//    dispatch_queue_t gloaQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%d",(int)animated);
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}


//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    NSLog(@"%d",(int)animated);
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//}
//
//
//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter
- (ToolHomeViewController*)toolVC{
    if(_toolVC == nil){
        _toolVC = [[ToolHomeViewController alloc] init];
    }
    return _toolVC;
}

- (void)cellLongPress:(UILongPressGestureRecognizer *)gesture {
    
    // 因为一个手势要经历UIGestureRecognizerStateBegan、UIGestureRecognizerStateChanged、UIGestureRecognizerStateEnded等多个状态，所以这个方法会执行多次。
    
    // 一般只需要在began的时候执行动作，所以需要添加这个if判断
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        NSLog(@"触发了长按手势");
        
        // 创建弹出的menu
        
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        
        // 弹出的menu都有哪几个item
        
        UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyAction)];
        
        UIMenuItem *item1 = [[UIMenuItem alloc] initWithTitle:@"自定义" action:@selector(selAction)];
        
        // 设置item
        
        menuController.menuItems = @[item,item1];
        
        [menuController setTargetRect:gesture.view.frame inView:gesture.view.superview];
        
        // 设置menu可见，因为默认是不可见的
        
        [menuController setMenuVisible:YES animated:YES];
        
        [UIMenuController sharedMenuController].menuItems = nil;
        
        // 获取需要获取的文本
        
//        CGPoint point = [gesture locationInView:self.myTable];
//        
//        NSIndexPath *indexPath = [self.myTable indexPathForRowAtPoint:point];
//        
//        self.needCopyStr = self.dataSource[indexPath.row];
//        
//        NSLog(@"需要复制的文本：%@",self.needCopyStr);
        
    }
}
- (BOOL)canBecomeFirstResponder {
    
    return YES;
    
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    if (action == @selector(copyAction)) {
        
        return YES;
        
    }
    
    return NO;
    
}

@end
