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

@interface OtherHomeViewController ()

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
    dispatch_queue_t queue = dispatch_queue_create("Test", DISPATCH_QUEUE_CONCURRENT);
    
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
    
    bool res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
    bool res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
    NSLog(@"res1 ==== %d\n res2 === %d",res1,res2);
    
//    class_addProperty(self, @"Test", <#const objc_property_attribute_t *attributes#>, <#unsigned int attributeCount#>)
    
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
