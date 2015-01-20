//
//  FullScreenImageView.m
//  PanliApp
//
//  Created by Liubin on 13-12-18.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "FullScreenImageView.h"
#import "CustomUIImageView.h"

#define IMAGE_MAX_WIDTH  UI_SCREEN_WIDTH
#define IMAGE_MAX_HEIGHT UI_SCREEN_HEIGHT
@implementation FullScreenImageView
@synthesize delegate = _delegate;
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    self.imageArray = nil;
    _delegate = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame imageArray:(NSArray *)array showIndex:(int)index
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = PL_COLOR_BLACK;
//        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        self.imageArray = array;
        pageIndex = index;
        
        mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Height - 300.0f, MainScreenFrame_Width - 20.0f - UI_NAVIGATION_BAR_HEIGHT - 72.0f)];
        mainScrollView.backgroundColor = PL_COLOR_CLEAR;
        mainScrollView.canCancelContentTouches = NO;
        mainScrollView.clipsToBounds = NO;
        mainScrollView.pagingEnabled = YES;
        mainScrollView.scrollEnabled = YES;
        mainScrollView.showsHorizontalScrollIndicator = NO;
        mainScrollView.showsVerticalScrollIndicator = NO;
        mainScrollView.bounces = YES;
        mainScrollView.delegate = self;
        mainScrollView.contentSize = CGSizeMake(self.imageArray.count * (MainScreenFrame_Height - 300.0f), MainScreenFrame_Width - 20.0f - UI_NAVIGATION_BAR_HEIGHT - 72.0f);
        [self addSubview:mainScrollView];
        [mainScrollView release];
        
        if (self.imageArray && self.imageArray.count > 0)
        {
            for (int i = 0; i < self.imageArray.count ; i++)
            {
                //加载图片
                CustomUIImageView *fullImgView = [[CustomUIImageView alloc] initWithFrame:CGRectMake((MainScreenFrame_Height - 300.0f) * i, 0.0f, MainScreenFrame_Height - 300.0f, MainScreenFrame_Width - 20.0f - UI_NAVIGATION_BAR_HEIGHT - 72.0f)];
                UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                indicator.frame = CGRectMake(0.0f, 0.0f, MainScreenFrame_Height - 300.0f, MainScreenFrame_Width - 20.0f - UI_NAVIGATION_BAR_HEIGHT - 72.0f);
                [fullImgView addSubview:indicator];
                [indicator release];
                [indicator startAnimating];

                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    //异步下载图片
                    NSURL * url = [NSURL URLWithString:[self.imageArray objectAtIndex:i]];
                    NSData * data = [NSData dataWithContentsOfURL:url];
                    //网络请求之后进入主线程
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //关闭loading
                        [indicator stopAnimating];
                        indicator.hidden = YES;
                        if (data) {
                            //显示图片
                            fullImgView.image = [UIImage imageWithData:data];
                            CGSize imgSize = [self scaleSize:fullImgView.image.size];
                            if (imgSize.width > 0 && imgSize.height > 0)
                            {
                                fullImgView.frame = CGRectMake((MainScreenFrame_Height - 300.0f) * i + ((MainScreenFrame_Height - 300.0f) - imgSize.width)/2,((MainScreenFrame_Width - 20.0f - UI_NAVIGATION_BAR_HEIGHT - 72.0f) - imgSize.height)/2,imgSize.width,imgSize.height);
                            }
                            else
                            {
                                fullImgView.frame = CGRectMake((MainScreenFrame_Height - 300.0f) * i + 10.0f,10.0f,IMAGE_MAX_WIDTH,IMAGE_MAX_HEIGHT);
                            }
                            
                        }
                    });
                });

                [mainScrollView addSubview:fullImgView];
                [fullImgView release];
            }
        }
        
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.0f, MainScreenFrame_Height - 10, MainScreenFrame_Width, 10.0f)];
        pageControl.backgroundColor = PL_COLOR_CLEAR;
        pageControl.numberOfPages = self.imageArray.count;
        pageControl.currentPage = pageIndex;
        pageControl.userInteractionEnabled = NO;
        [self addSubview:pageControl];
        [pageControl release];
        
        mainScrollView.contentOffset = CGPointMake(pageIndex*MainScreenFrame_Width, 0.0f);
        pageControl.currentPage = pageIndex;
 
        UITapGestureRecognizer *fullTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeScrollView)];
        [mainScrollView addGestureRecognizer:fullTapGesture];
        [fullTapGesture release];

    }
    return self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint mContentOffset = scrollView.contentOffset;
    NSInteger mCurrentPage = mContentOffset.x / MainScreenFrame_Width;
    pageControl.currentPage = mCurrentPage;
}

- (void)removeScrollView
{
    NSArray *subView = mainScrollView.subviews;
    CustomUIImageView *imageView = [subView objectAtIndex:pageIndex];
    [UIView animateWithDuration:0.5 animations:^{
        CGAffineTransform transform =  CGAffineTransformScale(imageView.transform, 0.01, 0.01);
        [imageView setTransform:transform];
        [imageView setAlpha:0];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
//        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        
        if(_delegate != nil && [_delegate respondsToSelector:@selector(fullImageDidRemove)])
        {
            [_delegate fullImageDidRemove];
        }
    }];
}

/**
 * 功能描述: 等比例缩放图片
 * 输入参数: 原始尺寸
 * 返 回 值: 缩放尺寸
 */
- (CGSize)scaleSize:(CGSize)size
{
    CGSize scaleSize;
    if (size.width >= IMAGE_MAX_WIDTH &&
        size.height < IMAGE_MAX_HEIGHT)
    {
        scaleSize.width = IMAGE_MAX_WIDTH;
        scaleSize.height = IMAGE_MAX_WIDTH/size.width * size.height;
        
    }
    else if (size.width < IMAGE_MAX_WIDTH &&
             size.height >= IMAGE_MAX_HEIGHT)
    {
        scaleSize.width = IMAGE_MAX_HEIGHT/size.height * size.width;
        scaleSize.height = IMAGE_MAX_HEIGHT;
    }
    else if (size.width > IMAGE_MAX_WIDTH &&
             size.height > IMAGE_MAX_HEIGHT)
    {
        float scaleWidth = size.width/IMAGE_MAX_WIDTH;
        float scaleHeight = size.height/IMAGE_MAX_HEIGHT;
        if (scaleWidth >= scaleHeight)
        {
            scaleSize.width = IMAGE_MAX_WIDTH;
            scaleSize.height = IMAGE_MAX_WIDTH/size.width * size.height;
        }
        else
        {
            scaleSize.width = IMAGE_MAX_HEIGHT/size.height * size.width;
            scaleSize.height = IMAGE_MAX_HEIGHT;
        }
    }
    else
    {
        scaleSize = size;
    }
    return scaleSize;
}
@end
