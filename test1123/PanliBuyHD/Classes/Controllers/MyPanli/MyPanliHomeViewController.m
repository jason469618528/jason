//
//  MyPanliHomeViewController.m
//  PanliBuyHD
//
//  Created by guo on 14-10-17.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "MyPanliHomeViewController.h"
#import "MenuViewController.h"
#import "DetailViewController.h"

@interface MyPanliHomeViewController ()

@end

@implementation MyPanliHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MenuViewController *menu = [[MenuViewController alloc] init];
    UINavigationController *nav_menu = [[UINavigationController alloc] initWithRootViewController:menu];
    
    DetailViewController *detail = [[DetailViewController alloc] init];
    UINavigationController *nav_detail = [[UINavigationController alloc] initWithRootViewController:detail];
    self.viewControllers = [NSArray arrayWithObjects:nav_menu, nav_detail, nil];
    [self setValue:[NSNumber numberWithFloat:320] forKey:@"_masterColumnWidth"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
