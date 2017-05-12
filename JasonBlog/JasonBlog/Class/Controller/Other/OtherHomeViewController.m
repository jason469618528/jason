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


@interface OtherHomeViewController (){
    dispatch_source_t _timer;
}

@property (nonatomic, strong) NSMutableArray<NSString *> *arrayList;
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
    [btn_ToolClick setImage:[UIImage imageNamed:@"icon_home_open"] forState:UIControlStateNormal];
    [btn_ToolClick addTarget:self action:@selector(toolClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_ToolClick];
    

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
    
    RSMaskedLabel *maskLabel = [[RSMaskedLabel alloc] initWithFrame:CGRectMake(0.0f, 20.0f, MainScreenFrame_Width, 50.0f)];
    maskLabel.text = NSLocalizedString(@"home_back",nil);
    maskLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:maskLabel];
    

    
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
//    ToolHomeViewController *toolHome = [[ToolHomeViewController alloc] init];
//    toolHome.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:toolHome animated:YES];
//    [self.toolVC showInView:self.navigationController.view];
//    btn.transform = CGAffineTransformMakeRotation((45.0f * M_PI) / 180.0f);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
         NSDictionary *dict = @{@"name": @"zhangsan"};
         NSDictionary *dict1 = @{@"name": @"wangwu"};
         NSArray *array = @[dict, dict1];
         // 设置请求格式
         manager.requestSerializer = [AFJSONRequestSerializer serializer];
        // 设置返回格式
         manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
         [manager POST:@"http://localhost/postjson.php" parameters:array success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"%@", result);
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 
            }];
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
