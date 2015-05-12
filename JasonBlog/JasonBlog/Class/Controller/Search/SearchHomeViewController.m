//
//  SearchHomeViewController.m
//  JasonBlog
//
//  Created by jason on 15-5-4.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import "SearchHomeViewController.h"

@interface SearchHomeViewController ()

@end

@implementation SearchHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    //
    UIView *view_Header = [[UIView alloc] initWithFrame:CGRectMake(100.0f, 100.0f, 100.0f, 100.0f)];
    view_Header.backgroundColor = [UIColor whiteColor];
    view_Header.layer.borderColor = [UIColor blueColor].CGColor;
    view_Header.layer.borderWidth = 10.0f;
    view_Header.layer.cornerRadius = 50.0f;
//    view_Header.layer.masksToBounds = YES;
    [[view_Header layer] setShadowOffset:CGSizeMake(0.0f, 0.0f)];
    [[view_Header layer] setShadowRadius:1];
    [[view_Header layer] setShadowOpacity:1];
    [[view_Header layer] setShadowColor:[UIColor blackColor].CGColor];
    [self.view addSubview:view_Header];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
