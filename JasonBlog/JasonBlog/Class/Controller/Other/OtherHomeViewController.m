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


@interface OtherHomeViewController (){
    dispatch_source_t _timer;
}

@property (nonatomic, strong) ToolHomeViewController *toolVC;

@end

@implementation OtherHomeViewController

- (id)init{
    if(self = [super init]){
        NSLog(@"%@",[self class]);
        NSLog(@"%@",[super class]);
    }
    return self;
}

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
    
    UIButton *btn_ToolClick = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_ToolClick.frame = CGRectMake(100.0f, 100.0f, 100.0f, 100.0f);
//    btn_ToolClick.backgroundColor = J_COLOR_RED;
    [btn_ToolClick setImage:[UIImage imageNamed:@"icon_home_open"] forState:UIControlStateNormal];
    [btn_ToolClick addTarget:self action:@selector(ToolClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_ToolClick];
    
    //创建队列
    dispatch_queue_t queue = dispatch_queue_create("Test", DISPATCH_QUEUE_SERIAL);
    
    NSLog(@"Star");
    
    dispatch_async(queue, ^{
         NSLog(@"任务1---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"任务2---%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"任务3---%@", [NSThread currentThread]);
    });
    
    NSLog(@"End");
//    NSLog(@"任务4---%@", [NSThread currentThread]);

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

    
    [self startGCDTimer];
    
}

-(void) startGCDTimer{
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


- (void)ToolClick:(UIButton*)btn
{
//    ToolHomeViewController *toolHome = [[ToolHomeViewController alloc] init];
//    toolHome.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:toolHome animated:YES];
//    [self.toolVC showInView:self.navigationController.view];
    btn.transform = CGAffineTransformMakeRotation((45.0f * M_PI) / 180.0f);
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%d",(int)animated);
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ToolHomeViewController*)toolVC{
    if(_toolVC == nil){
        _toolVC = [[ToolHomeViewController alloc] init];
    }
    return _toolVC;
}

@end
