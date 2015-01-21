//
//  HelpShowViewController.m
//  PanliApp
//
//  Created by Liubin on 13-6-17.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "HelpShowViewController.h"
#import "CustomerPageControl.h"

@interface HelpShowViewController ()

@end

@implementation HelpShowViewController
@synthesize type;
#pragma mark - default

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(mArr_images);
    [super dealloc];
}

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
	// Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = PL_COLOR_CLEAR;
    
    mArr_images = [NSMutableArray new];
    
    switch (type) {
        case 1:
        {
            if(IS_568H)
            {
                for (int i = 0; i < 10 ; i++)
                {
                    NSString *str_Image = [NSString stringWithFormat:@"bg_HS_BY_%d_h568@2x.png",i+1];
                    [mArr_images addObject:str_Image];
                }
            }
            else
            {
                for (int i = 0; i < 10 ; i++)
                {
                    NSString *str_Image = [NSString stringWithFormat:@"bg_HS_BY_%d@2x.png",i+1];
                    [mArr_images addObject:str_Image];
                }
            }
            
            break;
        }
        case 2:
        {
            if(IS_568H)
            {
                for (int i = 0; i < 9 ; i++)
                {
                    NSString *str_Image = [NSString stringWithFormat:@"bg_HS_BYTwo_%d_h568@2x.png",i+1];
                    [mArr_images addObject:str_Image];
                }
            }
            else
            {
                for (int i = 0; i < 9 ; i++)
                {
                    NSString *str_Image = [NSString stringWithFormat:@"bg_HS_BYTwo_%d@2x.png",i+1];
                    [mArr_images addObject:str_Image];
                }
            }
            break;
        }
        case 3:
        {
            if(IS_568H)
            {
                for (int i = 0; i < 6 ; i++)
                {
                    NSString *str_Image = [NSString stringWithFormat:@"bg_HS_JoB_%d_h568@2x.png",i+1];
                    [mArr_images addObject:str_Image];
                }
            }
            else
            {
                for (int i = 0; i < 6 ; i++)
                {
                    NSString *str_Image = [NSString stringWithFormat:@"bg_HS_JoB_%d@2x.png",i+1];
                    [mArr_images addObject:str_Image];
                }
            }
            break;
        }

        default:
            break;
    }

    scroll_helpScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake((1024-320)/2.0f, 0, 320, 568+20)];
    scroll_helpScrollView.contentSize = CGSizeMake(320*mArr_images.count, 568);
    scroll_helpScrollView.pagingEnabled = YES;
    scroll_helpScrollView.scrollEnabled = YES;
    scroll_helpScrollView.showsHorizontalScrollIndicator = NO;
    scroll_helpScrollView.showsVerticalScrollIndicator = NO;
    scroll_helpScrollView.bounces = NO;
    scroll_helpScrollView.delegate = self;
    [self.view addSubview:scroll_helpScrollView];
    [scroll_helpScrollView release];
    
    
    for (int i = 0; i < [mArr_images count]; i++)
    {
        NSString *img_FilePath = [NSString stringWithFormat:@"%@",[mArr_images objectAtIndex:i]];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[PanliHelper getImageFileByName:img_FilePath]];
        imgView.frame = CGRectMake(320*i, 0, 320, 568+20);
        [scroll_helpScrollView addSubview:imgView];
        [imgView release];
    }
    
    page_helpPageControl = [[CustomerPageControl alloc] initWithFrame:CGRectMake((1024/2.0f)-10, 568-25, 20, 20) selectImage:@"guide_select" unSelectImage:@"guide_unselect" selectColor:[PanliHelper colorWithHexString:@"#479c00"] unSelectColor:[PanliHelper colorWithHexString:@"#ededed"]];
    page_helpPageControl.numberOfPages = mArr_images.count;
    page_helpPageControl.currentPage = 0;
    page_helpPageControl.userInteractionEnabled = NO;
    page_helpPageControl.hidden = YES;
    [self.view addSubview:page_helpPageControl];
    [page_helpPageControl release];

    //关闭按钮
    UIButton *btn_exit = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_exit setImage:[UIImage imageNamed:@"btn_HS_Close"] forState:UIControlStateNormal];
    [btn_exit setFrame:CGRectMake(((1024+320)/2.0f)-29.5, 0 , 29.5, 29.5)];
    [btn_exit addTarget:self action:@selector(btnExitClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn_exit];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

#pragma mark - scrollview delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint mContentOffset = scroll_helpScrollView.contentOffset;
    NSInteger mCurrentPage = mContentOffset.x / 320;
    currentPage = mCurrentPage;
    page_helpPageControl.currentPage = currentPage;
}

- (void)btnExitClick
{
    [self dismissModalViewControllerAnimated:YES];
}


@end
