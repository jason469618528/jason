//
//  lucencyViewController.m
//  JasonBlog
//
//  Created by iyb-hj on 2017/11/27.
//  Copyright © 2017年 PanliMobile. All rights reserved.
//

#import "lucencyViewController.h"

@interface lucencyViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *bckView;
@property (nonatomic, assign) CGFloat alpha;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation lucencyViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
        [self setExtendedLayoutIncludesOpaqueBars:YES];
        [self setEdgesForExtendedLayout:UIRectEdgeAll];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = J_COLOR_WHITE;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(testClick)];
    
    self.alpha = 0.0; // 初始化透明度
    UIView *backgroundView = [[self.navigationController valueForKey:@"_navigationBar"] valueForKey:@"_backgroundView"]; //获取bar背景view
    backgroundView.backgroundColor = [UIColor whiteColor]; // 颜色
    backgroundView.alpha = self.alpha; //渐变
    self.bckView = backgroundView;

    [self.view addSubview:self.tableView];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0.0, 0.0, 100, 50);
//    btn.backgroundColor = J_COLOR_RED;
//    [self.tableView addSubview:btn];
}

- (void)testClick {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.translucent = YES;
//    self.bckView.alpha = self.alpha;
    [self setNeedsNavigationBackground:self.alpha];
}

- (void)setNeedsNavigationBackground:(CGFloat)alpha {
    // 导航栏背景透明度设置
    UIView *barBackgroundView = [[self.navigationController.navigationBar subviews] objectAtIndex:0];// _UIBarBackground
    UIImageView *backgroundImageView = [[barBackgroundView subviews] objectAtIndex:0];// UIImageView
    if (self.navigationController.navigationBar.isTranslucent) {
        if (backgroundImageView != nil && backgroundImageView.image != nil) {
            barBackgroundView.alpha = alpha;
        } else {
            UIView *backgroundEffectView = [[barBackgroundView subviews] objectAtIndex:1];// UIVisualEffectView
            if (backgroundEffectView != nil) {
                backgroundEffectView.alpha = alpha;
            }
        }
    } else {
        barBackgroundView.alpha = alpha;
    }
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    self.bckView.alpha = self.alpha;
//}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.translucent = NO;
    self.bckView.alpha = 1.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellStr = @"lucencyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        cell.textLabel.text = @"我是一个兵";
    }
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y - 44;
    CGFloat alpha = 0;
    if (offset < 0) {
        self.alpha = alpha = 0;
    }else {
        self.alpha = alpha = 1 - ((250 - 100 - offset) / (250 - 100));
    }
//    self.bckView.alpha = alpha;
    [self setNeedsNavigationBackground:alpha];
}

- (UITableView*)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, UI_SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

// 递归获取子视图
- (void)getSub:(UIView *)view andLevel:(int)level {
    NSArray *subviews = [view subviews];
    // 如果没有子视图就直接返回
    if ([subviews count] == 0) return;
    for (UIView *subview in subviews) {
        // 根据层级决定前面空格个数，来缩进显示
        NSString *blank = @"";
        for (int i = 1; i < level; i++) {
            blank = [NSString stringWithFormat:@"  %@", blank];
        }
        // 打印子视图类名
        NSLog(@"%@%d: %@", blank, level, subview.class);
        // 递归获取此视图的子视图
        [self getSub:subview andLevel:(level+1)];
    }
}
@end
