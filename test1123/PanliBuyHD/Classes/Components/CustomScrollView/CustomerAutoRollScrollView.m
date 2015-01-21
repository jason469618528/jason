//
//  CustomerAutoRollScrollView.m
//  PanliApp
//
//  Created by Liubin on 13-10-24.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "CustomerAutoRollScrollView.h"

@implementation CustomerAutoRollScrollView
@synthesize dataSource = _dataSource;


- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = YES;
        _scrollView.scrollsToTop = NO;
        [self addSubview:_scrollView];
        [_scrollView release];
        
        _pageControl = [[CustomerPageControl alloc] initWithFrame:CGRectMake(0.0f, _scrollView.frame.size.height - 20, MainScreenFrame_Width, 10.0f) selectImage:@"icon_pagedont_selected" unSelectImage:@"icon_pagedont_unSelected" selectColor:[PanliHelper colorWithHexString:@"#ffffff"] unSelectColor:[PanliHelper colorWithHexString:@"#898a8d"]];
        [_pageControl setBackgroundColor:PL_COLOR_CLEAR];
        _pageControl.numberOfPages = _totalPages;
        _pageControl.currentPage = 0;
        _pageControl.userInteractionEnabled = NO;
        [self addSubview:_pageControl];
        [_pageControl release];
 
    }
    return self;
}


- (void)reloadData
{
    _totalPages = [_dataSource scrollView:self];
    _scrollView.contentSize = CGSizeMake(self.bounds.size.width * _totalPages, self.bounds.size.height);
    
    _pageControl.numberOfPages = _totalPages;
    _pageControl.currentPage = 0;
    
    //从scrollView上移除所有的subview
    NSArray *subViews = [_scrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    for (int i = 0; i < _totalPages; i++) {
        UIView *v = [_dataSource scrollView:self viewAtIndex:i];
        v.userInteractionEnabled = YES;
        v.frame = CGRectMake(v.frame.size.width * i, 0, v.frame.size.width, v.frame.size.height);
        [_scrollView addSubview:v];
    }
    
    [_scrollView setContentOffset:CGPointMake(0, 0)];
    
    //自动滚动计时器
    if (_totalPages > 1 && _rollTimer == nil)
    {
        _rollTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(autoRoll) userInfo:nil repeats:YES];
    }
}

- (void)autoRoll
{
    timerNumber++;
    if (timerNumber > 0 && timerNumber % 5 == 0)
    {
        timerNumber = 0;
        _curPage += 1;
        if (_curPage == _totalPages)
        {
            _curPage = 0;
        }
        [UIView animateWithDuration:0.5 animations:^{
            [_scrollView setContentOffset:CGPointMake(self.bounds.size.width * _curPage, 0)];
        }];
        _pageControl.currentPage = _curPage;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    int x = aScrollView.contentOffset.x;

    _curPage = x/self.frame.size.width;
    _pageControl.currentPage = _curPage;
    
    timerNumber = 0;
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    if ([_rollTimer isValid])
    {
        [_rollTimer invalidate];
    }
}

@end
