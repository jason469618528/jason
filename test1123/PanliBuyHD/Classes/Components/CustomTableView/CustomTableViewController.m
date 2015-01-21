//
//  CustomTableViewController.m
//  panliApp
//
//  Created by liubin on 13-4-28.
//  Copyright (c) 2013年 panli. All rights reserved.
//

#define ERROR_IMAGE_WIDTH  191.0/2
#define ERROR_IMAGE_HEIGHT 189.0/2

#import "CustomTableViewController.h"

@implementation CustomTableViewController
@synthesize tableView = _tableView;
@synthesize customTableViewDelegate = _customTableViewDelegate;
@synthesize needRefresh = _needRefresh;
@synthesize refreshing = _refreshing;
@synthesize moreLoading = _moreLoading;
@synthesize loadingStyle = _loadingStyle;
@synthesize loadingTimeKey = _loadingTimeKey;
@synthesize tableStyle = _tableStyle;

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_tableView);
    SAFE_RELEASE(_loadingTimeKey);
    SAFE_RELEASE(_headView);
    SAFE_RELEASE(_footView);
    _customTableViewDelegate = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        
        _havaNextPage = NO;
        
        _needRefresh = YES;//默认为YES
        
        _refreshing = NO;
        _moreLoading = NO;
        _isAnimating = NO;
        
        _requestType = noRequest;
        
        _loadingStyle = head_none;//默认只有提示
        _loadingTimeKey = nil;
        
        _lastOffsetY = 0.0f;
        
        _tableStyle = UITableViewStylePlain;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                             style:_tableStyle];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [PanliHelper setExtraCellLineHidden:_tableView];
    [self.view addSubview:_tableView];
    
    if (_needRefresh)
    {
        _headView = [[CustomLoadingView alloc] initWithFrame:CGRectMake(0, -80, self.view.frame.size.width, 80) andType:_loadingStyle andKey:_loadingTimeKey imageDown:nil imageUp:nil];
        [_tableView addSubview:_headView];
        
    }
    
    /**
     显示显示错误信息的view
     */
    _noServiceErrorView = [[UIView alloc] initWithFrame:self.view.bounds];
    _noServiceErrorView.backgroundColor = [PanliHelper colorWithHexString:@"#ededed"];
    [self.view insertSubview:_noServiceErrorView belowSubview:_tableView];
    [_noServiceErrorView release];
    
    //图片
    UIImageView *errorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_noServiceErrorView.frame.size.width/2-ERROR_IMAGE_WIDTH/2, _noServiceErrorView.frame.size.height/2-ERROR_IMAGE_HEIGHT/2-100, ERROR_IMAGE_WIDTH, ERROR_IMAGE_HEIGHT)];
    errorImageView.image = [UIImage imageNamed:@"no_service_error.png"];
    [_noServiceErrorView addSubview:errorImageView];
    [errorImageView release];
    
    //错误提示
    UILabel *errorLabelTop = [[UILabel alloc] initWithFrame:CGRectMake(_noServiceErrorView.frame.size.width/2-(ERROR_IMAGE_WIDTH+10)/2-10, _noServiceErrorView.frame.size.height/2-ERROR_IMAGE_HEIGHT/2-100+ERROR_IMAGE_HEIGHT+10, ERROR_IMAGE_WIDTH+25, 30)];
    errorLabelTop.font = [UIFont systemFontOfSize:14];
    errorLabelTop.backgroundColor = PL_COLOR_CLEAR;
    errorLabelTop.text = LocalizedString(@"CustomTableViewController_errorLabelTop",@"网络异常  轻击刷新");
    errorLabelTop.textAlignment = UITextAlignmentCenter;
    errorLabelTop.textColor = [PanliHelper colorWithHexString:@"a4a4a4"];
    [_noServiceErrorView addSubview:errorLabelTop];
    [errorLabelTop release];
    
    //点击重新刷新按钮
    _errorLabelBottom = [[UILabel alloc] initWithFrame:CGRectMake(_noServiceErrorView.frame.size.width/2-(ERROR_IMAGE_WIDTH+10)/2-10, _noServiceErrorView.frame.size.height/2-ERROR_IMAGE_HEIGHT/2-100+ERROR_IMAGE_HEIGHT+30, ERROR_IMAGE_WIDTH+25, 30)];
    _errorLabelBottom.backgroundColor = PL_COLOR_CLEAR;
    [_noServiceErrorView addSubview:_errorLabelBottom];
    [_errorLabelBottom release];
    UIButton *btnRefresh = [[UIButton alloc] initWithFrame:_noServiceErrorView.frame];
    [_noServiceErrorView addSubview:btnRefresh];
    [btnRefresh addTarget:self action:@selector(errorButtonRefresh) forControlEvents:UIControlEventTouchUpInside];
    
    /**
      显示没有数据时的view
     */
    _noHaveDataView = [[UIView alloc] initWithFrame:self.view.bounds];
    _noHaveDataView.backgroundColor = [PanliHelper colorWithHexString:@"#ededed"];
    [self.view insertSubview:_noHaveDataView belowSubview:_tableView];
    [_noHaveDataView release];
    
    _labelNoData = [[UILabel alloc] initWithFrame:CGRectMake(0, (_noHaveDataView.frame.size.height-64-44-100)/2.0, MainScreenFrame_Height, 100)];
    _labelNoData.textAlignment = UITextAlignmentCenter;
    _labelNoData.font = [UIFont systemFontOfSize:18];
    _labelNoData.backgroundColor = PL_COLOR_CLEAR;
    _labelNoData.textColor = [PanliHelper colorWithHexString:@"a4a4a4"];
    [_noHaveDataView addSubview:_labelNoData];
    [_labelNoData release];
}

- (void)errorButtonRefresh
{
    [self requestData:YES];
}

- (void)viewDidUnload
{
    self.tableView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)requestData:(BOOL)isFirst
{
    if (isFirst)
    {
        [self showLoadingView];
    }
    else
    {
        _refreshing = NO;
        _moreLoading = YES;
        
        [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 80, 0)];
        [_tableView setContentOffset:CGPointMake(0, _tableView.contentSize.height - _tableView.frame.size.height + 80)];
        [_footView changeState:Loading];
    }
    
    if (_customTableViewDelegate != nil && [_customTableViewDelegate respondsToSelector:@selector(customTableView:sendRequset:)])
    {
        [_customTableViewDelegate customTableView:self sendRequset:isFirst];
    }
}

- (void)doAfterRequestSuccess:(BOOL)isFirst AndHavaMore:(BOOL)havaMore
{
    [self.view bringSubviewToFront:_tableView];
    _havaNextPage = havaMore;
    if (isFirst)
    {
        if (!_needRefresh)
        {
            [UIView animateWithDuration:0.3f animations:^{
                [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            } completion:^(BOOL finished){
                if (finished) {
                    _headView.hidden = YES;
                }
            }];
        }
        
        if (_havaNextPage)
        {
            if (!_footView) {
                _footView = [[CustomLoadingView alloc] initWithFrame:CGRectMake(0, _tableView.contentSize.height, 320, 80) andType:foot_none andKey:nil imageDown:nil imageUp:nil];
                [_tableView addSubview:_footView];
            }else{
                _footView.hidden = NO;
                _footView.frame = CGRectMake(0, _tableView.contentSize.height, 320, 80);
            }
        }
        else
        {
            if (_footView != nil)
            {
                _footView.hidden = YES;
            }
        }
        
    }
    else
    {
        _moreLoading = NO;
        if (_havaNextPage)
        {
            [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            _footView.frame = CGRectMake(0, _tableView.contentSize.height, 320, 80);
            [_footView changeState:Normal];
        }
        else
        {
            [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            _footView.hidden = YES;
        }
        
    }
}

- (void)doAfterRequestSuccess:(BOOL)isFirst AndHavaData:(BOOL)havaData AndNoDataMessage:(NSString *)message AndHavaMore:(BOOL)havaMore
{
    if (havaData)
    {
        [self.view bringSubviewToFront:_tableView];
        _havaNextPage = havaMore;
        if (isFirst)
        {
            if (!_needRefresh)
            {
                [UIView animateWithDuration:0.3f animations:^{
                    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
                } completion:^(BOOL finished){
                    if (finished) {
                        _headView.hidden = YES;
                    }
                }];
            }
            
            if (_havaNextPage)
            {
                if (_footView == nil) {
                    _footView = [[CustomLoadingView alloc] initWithFrame:CGRectMake(0, _tableView.contentSize.height, 320, 80) andType:foot_none andKey:nil imageDown:nil imageUp:nil];
                    [_tableView addSubview:_footView];
                }else{
                    _footView.hidden = NO;
                    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
                    _footView.frame = CGRectMake(0, _tableView.contentSize.height, 320, 80);
                    [_footView changeState:Normal];
                }
            }
            else
            {
                if (_footView != nil)
                {
                    _footView.hidden = YES;
                }
            }
            
        }
        else
        {
            _moreLoading = NO;
            if (_havaNextPage)
            {
                [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
                _footView.frame = CGRectMake(0, _tableView.contentSize.height, 320, 80);
                [_footView changeState:Normal];
            }
            else
            {
                [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
                _footView.hidden = YES;
            }
            
        }
    }
    else
    {
        if ([NSString isEmpty:message])
        {
            _labelNoData.text = LocalizedString(@"CustomTableViewController_labelNoData",@"暂无相关数据");
        }
        else
        {
            _labelNoData.text = message;
        }
        [self.view bringSubviewToFront:_noHaveDataView];
    }
}

- (void)doAfterRequsetFailure:(BOOL)isFirst{
    
    [self doAfterRequsetFailure:isFirst errorInfo:nil];
}

- (void)doAfterRequsetFailure:(BOOL)isFirst errorInfo:(ErrorInfo *)errorInfo
{
    //第一次请求就出错
    if (errorInfo != nil && isFirst)
    {
        _moreLoading = NO;
        //重置fotter 状态
        [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        _footView.frame = CGRectMake(0, _tableView.contentSize.height, 320, 80);
        [_footView changeState:Normal];
        
        [self.view bringSubviewToFront:_noServiceErrorView];
        _errorLabelBottom.text = [NSString stringWithFormat:LocalizedString(@"CustomTableViewController_errorLabelBottom",@" (错误代码:%d) "),errorInfo.code];
        _errorLabelBottom.textAlignment = UITextAlignmentCenter;
        _errorLabelBottom.font = [UIFont systemFontOfSize:14];
        _errorLabelBottom.textColor = [PanliHelper colorWithHexString:@"a4a4a4"];
        return;
    }
    if (isFirst)
    {
        if (!_needRefresh)
        {
            [UIView animateWithDuration:0.3f animations:^{
                [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            } completion:^(BOOL finished){
                if (finished) {
                    _headView.hidden = YES;
                }
            }];           
        }
        if (_footView != nil)
        {
            _footView.hidden = YES;
            _footView.frame = CGRectMake(0, _tableView.contentSize.height, 320, 80);
        }
    }
    else
    {
        
        _moreLoading = NO;
        
        [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        _footView.frame = CGRectMake(0, _tableView.contentSize.height, 320, 80);
        [_footView
        changeState:Normal];
    }
    [self showHUDErrorMessage:errorInfo.message];
}

- (void)showLoadingView
{
    _refreshing = YES;
    _moreLoading = NO;
    if (_needRefresh)
    {
        if (_headView == nil)
        {
            _headView = [[CustomLoadingView alloc] initWithFrame:CGRectMake(0, -80, 320, 80) andType:_loadingStyle andKey:_loadingTimeKey imageDown:nil imageUp:nil];
            [_tableView addSubview:_headView];
        }
        else
        {
            _headView.hidden = NO;
        }
        [_headView changeState:Loading];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        [_tableView setContentInset:UIEdgeInsetsMake(80, 0, 0, 0)];
        [_tableView setContentOffset:CGPointMake(0, -80)];
        [UIView commitAnimations];
    }
}

- (void)hideLoadingView
{
    _refreshing = NO;
    _lastOffsetY = 0.0f;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [UIView commitAnimations];
}

- (void)hideHeadLoadingView
{
    _refreshing = NO;
    _lastOffsetY = 0.0f;
    if(_headView)
    {
        _headView.hidden = YES;
    }
}

- (void)modifyMoreLoadingView:(float)height
{
    if (_footView)
    {
        if(height)
        {
            [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            _footView.frame = CGRectMake(0, height, 320, 80);
            [_footView changeState:Normal];
        }
        else
        {
            [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            _footView.frame = CGRectMake(0, _tableView.contentSize.height, 320, 80);
            [_footView changeState:Normal];
        }
    }
}

- (void)willDoAnimating
{
    _isAnimating = YES;
}

- (void)doneAnimating
{
    _isAnimating = NO;
}

#pragma mark - ScrollView delegate
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{   
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{    
    _lastOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!_refreshing && !_moreLoading && !_isAnimating) {
        
        if (scrollView.contentOffset.y > _lastOffsetY){
            
            if (_customTableViewDelegate != nil && [_customTableViewDelegate respondsToSelector:@selector(tableMoveUp)]) {
                [_customTableViewDelegate tableMoveUp];
            }
            
        } else if (scrollView.contentOffset.y < _lastOffsetY){

            if (_customTableViewDelegate != nil && [_customTableViewDelegate respondsToSelector:@selector(tableMoveDown)]) {
                [_customTableViewDelegate tableMoveDown];
            }
        }
        
        if (scrollView.contentOffset.y < 0) {
            
            if (_needRefresh) {
                
                if (scrollView.contentOffset.y > -60) {
                    
                    [_headView changeState:Normal];
                    _requestType = noRequest;
                    
                    _lastOffsetY = 0.0f;
                }else if (scrollView.contentOffset.y <= -60) {
                    
                    [_headView changeState:Pulling];
                    _requestType = refreshRequest;
                }
            }
            
        }else if (scrollView.contentOffset.y > 0){
            
            if (_havaNextPage && scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height)) {
                
                if (scrollView.contentOffset.y + scrollView.frame.size.height < scrollView.contentSize.height + 60 ) {
                    
                    [_footView changeState:Normal];
                    _requestType = noRequest;
                    
                    _lastOffsetY = _tableView.contentSize.height - _tableView.frame.size.height;
                }else if (scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height + 60) {
                    
                    [_footView changeState:Pulling];
                    _requestType = loadmoreRequest;
                }
            }
            
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerat
{
    if (!_refreshing && !_moreLoading && !_isAnimating) {
        
        if (_requestType == refreshRequest) {
            
            _requestType = noRequest;
            
            [self requestData:YES];
            
        }else if (_requestType == loadmoreRequest) {
            
            _requestType = noRequest;
            
            [self requestData:NO];
        }
    }
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_customTableViewDelegate != nil && [_customTableViewDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return [_customTableViewDelegate tableView:tableView heightForHeaderInSection:section];
    }
    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_customTableViewDelegate != nil && [_customTableViewDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [_customTableViewDelegate tableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_customTableViewDelegate != nil && [_customTableViewDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return [_customTableViewDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (_customTableViewDelegate != nil && [_customTableViewDelegate respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [_customTableViewDelegate numberOfSectionsInTableView:tableView];
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (_customTableViewDelegate != nil && [_customTableViewDelegate respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        return [_customTableViewDelegate tableView:tableView numberOfRowsInSection:section];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_customTableViewDelegate != nil && [_customTableViewDelegate respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        return [_customTableViewDelegate tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    return nil;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_customTableViewDelegate != nil && [_customTableViewDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [_customTableViewDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_customTableViewDelegate != nil && [_customTableViewDelegate respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
        return  [_customTableViewDelegate tableView:tableView canEditRowAtIndexPath:indexPath];
    }
    return NO;
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (_customTableViewDelegate != nil && [_customTableViewDelegate respondsToSelector:@selector(tableView:shouldHighlightRowAtIndexPath:)])
     {
         return [_customTableViewDelegate tableView:tableView shouldHighlightRowAtIndexPath:indexPath];
     }
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_customTableViewDelegate != nil && [_customTableViewDelegate respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        [_customTableViewDelegate tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_customTableViewDelegate != nil && [_customTableViewDelegate respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
       return  [_customTableViewDelegate tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_customTableViewDelegate != nil && [_customTableViewDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)])
    {
        [_customTableViewDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if (_customTableViewDelegate != nil && [_customTableViewDelegate respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)])
    {
        [_customTableViewDelegate tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
}
@end
