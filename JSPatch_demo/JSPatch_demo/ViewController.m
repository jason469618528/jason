//
//  ViewController.m
//  JSPatch_demo
//
//  Created by huangjian on 17/2/7.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa.h>
#import "NSObject+Sark.h"
#import "OneViewController.h"
#import "ProductModel.h"
#import <objc/runtime.h>
#import "UIView+HJDrawCornet.h"


typedef void (^Block)();

@interface ViewController () {
    dispatch_source_t _timer;
    NSThread* myThread;
}
@property (nonatomic, assign) BOOL isOpen;

@property (nonatomic, strong) NSMutableArray *imagesArr;

@property (nonatomic, copy) ProductModel *product;

//@property (nonatomic, strong) NSCache *cache;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UIButton *button = [[UIButton alloc] init];
    [self.view addSubview:button];
    button.frame = CGRectMake(50, 200, self.view.frame.size.width - 100, 100);
    [button setTitle:@"进入界面" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor redColor];
    
//    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        NSLog(@"sss");
//    }];
    
    NSDictionary *dic = @{@"name":@"jason",@"age":@"28"};
    [dic.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    NSLog(@"%@",[[dic objectEnumerator] nextObject]);
    
    [dic.rac_sequence.signal subscribeNext:^(RACTuple *tuple) {
        RACTupleUnpack(NSString *key, NSString *vaule) = tuple;
        NSLog(@"%@--%@",key,vaule);
    }];
    
    NSArray *arr = @[@"1",@"2",@"3",@"4",@"5",@"1",@"2"];
    [arr.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    
    NSArray *tempArr = [arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSLog(@"%d",[obj1 integerValue] < [obj2 integerValue] == NSOrderedDescending);
        return [obj1 integerValue] < [obj2 integerValue] == NSOrderedDescending;
    }];
    NSLog(@"%@",tempArr);
    
    
    RACSubject *subject = [RACSubject subject];
    
    [subject subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@"123456"];
    
//    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        NSLog(@"发送请求");
//        [subscriber sendNext:@1];
//        return nil;
//    }];
//    // 2.订阅信号
//    [signal subscribeNext:^(id x) {
//        NSLog(@"接收数据");
//    }];
//    // 2.订阅信号
//    [signal subscribeNext:^(id x) {
//        NSLog(@"接收数据");
//    }];
    
    // RACMulticastConnection:解决重复请求问题
    // 1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送请求");
        [subscriber sendNext:@1];
        return nil;
    }];
    // 2.创建连接
    RACMulticastConnection *connect = [signal publish];
    // 3.订阅信号，
    // 注意：订阅信号，也不能激活信号，只是保存订阅者到数组，必须通过连接,当调用连接，就会一次性调用所有订阅者的sendNext:
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"订阅者一信号");
    }];
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"订阅者二信号");
    }];
    // 4.连接,激活信号
    [connect connect];
    
    
    id obj1 = [NSArray alloc];
    id obj2 = [obj1 init];
    
    BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
    BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
    
    [NSObject foo];
    [[NSObject new] foo];
    
    
    unsigned int count;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (unsigned int i = 0; i < count; ++i) {
        Ivar ivar = ivars[i];
        NSString *name = [NSString stringWithFormat:@"%s",ivar_getName(ivar)];
        NSLog(@"name = %@",name);
    }
    
    unsigned int count2;
    objc_property_t *propertys = class_copyPropertyList([self class], &count2);
    
    for (unsigned int i = 0; i < count2; ++i) {
        objc_property_t property = propertys[i];
        NSString *name = [NSString stringWithFormat:@"%s",property_getName(property)];
        NSLog(@"name = %@",name);
    }
    
    
    unsigned int count3;
    Method *classs = class_copyMethodList([self class], &count3);
    for (unsigned int i = 0; i < count3; ++i) {
        Method class = classs[i];
        NSLog(@"name = %@",NSStringFromSelector(method_getName(class)));
//        [self performSelectorInBackground:method_getName(class) withObject:nil];
    }
//    [self buttonAction:nil];
//    objc_messageSend(self,@selector(buttonAction:));
    self.product = [[ProductModel alloc] init];
    [self.product setValue:@"10.0" forKey:@"price"];
    
    [self.product addObserver:self forKeyPath:@"price" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"asdfasdfasdfasdf"];
    
    for (int i = 0; i < 1; i++) {
        NSString *string = @"Abc";
        string = [string lowercaseString];
        string = [string stringByAppendingString:@"xyz"];
        NSLog(@"%@", string);
    }
    
    /*
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(120,50,80,80)];
    view2.backgroundColor = [UIColor redColor];
    [self.view addSubview:view2];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view2.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(40,40)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view2.bounds;
    maskLayer.path = maskPath.CGPath;
    view2.layer.mask = maskLayer;*/
    
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(120,50,80,80)];
    view2.backgroundColor = [UIColor redColor];
    view2.layer.cornerRadius = 40.0f;
    //view2.layer.masksToBounds = YES;
    [self.view addSubview:view2];
    
    
    /*
    SEL originalSelector = @selector(viewWillAppear:);
    SEL swizzledSelector = @selector(xxx_viewWillAppear:);

    Method orginalMethod = class_getInstanceMethod([self class], originalSelector);
    Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
    
    
    BOOL didAddMethod = class_addMethod([self class], originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if(didAddMethod) {
        class_replaceMethod([self class], swizzledSelector, method_getImplementation(orginalMethod), method_getTypeEncoding(orginalMethod));
    } else {
        method_exchangeImplementations(orginalMethod, swizzledMethod);
    }
     */
    objc_setAssociatedObject(self, @"myName", @"jason", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"price"]) {
        
    }
}



/**
 按钮本来输出sss的
 但是通过JSPatch替换了这个方法
 直接查看index.js文件
 */
- (void)buttonAction:(UIButton *)sender {
    
    NSString *name = objc_getAssociatedObject(self, @"myName");
    NSLog(@"name = %@",name);

    NSLog(@"sss");
    
    [self block:^{
        NSLog(@"sadfasdfasdf");
    }];
    
    [self blockMethod:^(NSString *string) {
        NSLog(@"%@",string);
    }];
    
    //获取Documents路径
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"%@",filePath);
    
    NSString *tempData = @"测试TEMP文件夹";
    NSString *tempPath = [NSTemporaryDirectory() stringByAppendingPathComponent:tempData];
    [@"aaa.txt" writeToFile:tempPath atomically:YES];
    
    NSString *fileName = [filePath stringByAppendingPathComponent:tempData];
    [@"aaa.txt" writeToFile:fileName atomically:YES];

    NSLog(@"%@",NSTemporaryDirectory());
    
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.product];
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:data forKey:@"ProductToTest"];
//    
//    
//    NSData *toData = [userDefaults objectForKey:@"ProductToTest"];
//    id toProduct = [NSKeyedUnarchiver unarchiveObjectWithData:toData];
//    NSLog(@"%@",toProduct);
    NSCache *cache = [[NSCache alloc] init];
//    for (int i = 0; i < 1000; i++) {
//        NSLog(@"缓存中----->%@", [cache objectForKey:@(i)]);
//    }
    
//    for (NSInteger i = 0; i < 100; i++) {
//        NSString *key = [NSString stringWithFormat:@"key%ld",i];
//        [cache setObject:key forKey:@(i)];
//    }
//    
    // - 查看缓存内容，NSCache 没有提供遍历的方法，只支持用 key 来取值
//    for (int i = 0; i < 1000; i++) {
//        NSLog(@"缓存中----->%@", [cache objectForKey:@(i)]);
//    }
//    
    [self.product setValue:@"20.0" forKey:@"price"];
//    for (int i = 0; i < 5; i++) {
//        OneViewController *viewController = [[OneViewController alloc] init];
//    }
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//    });
//    dispatch_async(<#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>)
    
    
//    NSLog(@"%@",[NSRunLoop currentRunLoop]);
//
//    do {
//        NSLog(@"sss");
//        @autoreleasepool {
//            if ([[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]]) {
//                continue;
//            }
//        }
//    } while (YES);
//    
//    [self performSelector:@selector(afterMethod) withObject:self afterDelay:10.0f];
//
//    NSTimeInterval period = 1.0; //设置时间间隔
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
//    
//    dispatch_source_set_event_handler(_timer, ^{
//        //在这里执行事件.
//        NSLog(@"sss");
//    });
//    dispatch_resume(_timer);
    //创建一个常驻服务线程的很好方法
//    [[NSThread currentThread] setName:@"AFNetworking"];
//    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
//    [runloop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];//一直活着
//    [runloop run];
    
//    dispatch_queue_t queue = dispatch_queue_create("test1", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t queue1 = dispatch_queue_create("test2", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t queue2 = dispatch_queue_create("test3", DISPATCH_QUEUE_CONCURRENT);
    
    
    
//    dispatch_async(queue, ^{
//        
//    });
//    
//    dispatch_async(queue, ^{
//        
//    });
//    
//    dispatch_async(queue, ^{
//        
//    });
    
//    
//    myThread = [[NSThread alloc] initWithTarget:self
//                                                 selector:@selector(doSomething)
//                                                   object:nil];
//    [myThread start];
    
//    http://img6.bdstatic.com/img/image/smallpic/mingxing11.jpeg
//    http://img6.bdstatic.com/img/image/smallpic/duorou112.jpg
//    https://img6.bdstatic.com/img/image/smallpic/xiaoqingxin112.jpg
//    //下载三张图片，合并成一张照片
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_queue_t queue = dispatch_queue_create("queue_test", DISPATCH_QUEUE_CONCURRENT);
//    __weak typeof(self) weSelf = self;
//
//    dispatch_group_async(group, queue, ^{
//        __strong typeof(weSelf) strongSelf = weSelf;
//        NSString *url = @"https://img6.bdstatic.com/img/image/smallpic/xiaoqingxin112.jpg";
//        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if(data) {
//                [strongSelf.imagesArr addObject:data];
//            }
//        });
//    });
//    dispatch_group_async(group, queue, ^{
//        __strong typeof(weSelf) strongSelf = weSelf;
//        NSString *url = @"https://img6.bdstatic.com/img/image/smallpic/xiaoqingxin112.jpg";
//        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if(data) {
//                [strongSelf.imagesArr addObject:data];
//            }
//        });
//    });
//        
//    dispatch_group_async(group, queue, ^{
//        __strong typeof(weSelf) strongSelf = weSelf;
//        NSString *url = @"https://img6.bdstatic.com/img/image/smallpic/xiaoqingxin112.jpg";
//        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if(data) {
//                [strongSelf.imagesArr addObject:data];
//            }
//        });
//    });
//    NSLog(@"wait task 1,2,3.");
//    dispatch_group_notify(group, queue, ^{
//        NSLog(@"group end");
//        NSLog(@"%@",self.imagesArr);
//    });
//    
//    //NSOperation
//    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operationAction) object:nil];
//    NSOperationQueue *operationQueue = [NSOperationQueue mainQueue];
//    [operationQueue addOperation:operation];
    
//    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id subscriber) {
//        [subscriber sendNext:@"唱歌"];
//        [subscriber sendCompleted];
//        return nil;
//    }];
//    RAC(self, value) = [signalA map:^id(NSString* value) {
//        if ([value isEqualToString:@"唱歌"]) {
//            return @"跳舞";
//        }
//        return @"";
//    }];
    
    
    OneViewController *oneVC = [[OneViewController alloc] init];
    [self presentViewController:oneVC animated:YES completion:nil];
}

- (void)operationAction {
    NSLog(@"NSOperation Test");
}

- (void)doSomething {
   
}

- (void)block:(Block)test {
    if(test) {
        test();
    }
}

- (void)blockMethod:(void(^)(NSString *string))testBlock {
    if(testBlock) {
        testBlock(@"blockMethod");
    }
}

- (void)downImageUrlString:(NSString*)url {
    __weak typeof(self) weSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __strong typeof(weSelf) strongSelf = weSelf;
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(data) {
                [strongSelf.imagesArr addObject:data];
            }
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter
- (NSMutableArray *)imagesArr {
    if(_imagesArr == nil) {
        _imagesArr = [NSMutableArray new];
    }
    return _imagesArr;
}

//- (ProductModel *)product {
//    if(_product == nil) {
//        _product = [ProductModel new];
//    }
//    return _product;
//}

@end
