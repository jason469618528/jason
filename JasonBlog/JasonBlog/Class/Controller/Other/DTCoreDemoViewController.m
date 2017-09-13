//
//  DTCoreDemoViewController.m
//  JasonBlog
//
//  Created by iyb-hj on 2017/9/13.
//  Copyright © 2017年 PanliMobile. All rights reserved.
//

#import "DTCoreDemoViewController.h"
#import <DTCoreText.h>
#import <MediaPlayer/MediaPlayer.h>
#import "DemoTextViewController.h"
#import <UIImageView+WebCache.h>

NSString * const AttributedTextCellReuseIdentifier = @"AttributedTextCellReuseIdentifier";

@interface DTCoreDemoViewController () <UITableViewDelegate, UITableViewDataSource, DTAttributedTextContentViewDelegate> {
    NSCache *cellCache;
    BOOL _useStaticRowHeight;
    NSArray *snippets;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@interface DTCoreDemoViewController ()

@end

@implementation DTCoreDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = J_COLOR_WHITE;
    [self.view addSubview:self.tableView];

//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Snippets" ofType:@"plist"];
//    snippets = [[NSArray alloc] initWithContentsOfFile:plistPath];
//    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DTAttributedTextCell *dtcell = (DTAttributedTextCell *)[self tableView:tableView preparedCellForIndexPath:indexPath];
    return dtcell;
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DTKDropdownMenuViewCell"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DTKDropdownMenuViewCell"];
//    }
//    NSDictionary *rowSnippet = [snippets objectAtIndex:indexPath.row];
//    cell.textLabel.text = [rowSnippet objectForKey:@"Title"];
//    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DTAttributedTextCell *cell = (DTAttributedTextCell *)[self tableView:tableView preparedCellForIndexPath:indexPath];
    return [cell requiredRowHeightInTableView:tableView];
//    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    NSDictionary *rowSnippet = [snippets objectAtIndex:indexPath.row];
//
//    DemoTextViewController *toolHome = [[DemoTextViewController alloc] init];
//    toolHome.fileName = [rowSnippet objectForKey:@"File"];
//    toolHome.baseURL = [NSURL URLWithString:[rowSnippet  objectForKey:@"BaseURL"]];
//    toolHome.navigationItem.title = [rowSnippet objectForKey:@"Title"];
//    toolHome.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:toolHome animated:YES];
}

#pragma mark Custom Views on Text
- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame
{
    if ([attachment isKindOfClass:[DTImageTextAttachment class]])
    {
        CGFloat aspectRatio = 1;
        CGFloat width = MainScreenFrame_Width - 16*2;
        CGFloat height = width * aspectRatio;
        UIView *View = [[UIView alloc] initWithFrame:frame];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,width,height)];
        imageView.backgroundColor = [UIColor grayColor];
        [imageView sd_setImageWithURL:attachment.contentURL placeholderImage:nil options:SDWebImageProgressiveDownload];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [View addSubview:imageView];
        
        return View;
    }
    return nil;
}

#pragma mark -  DTLazyImageViewDelegate
- (void)lazyImageView:(DTLazyImageView *)lazyImageView didChangeImageSize:(CGSize)size {
//    NSURL *url = lazyImageView.url;
//    CGSize imageSize = size;
//    
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"contentURL == %@", url];
//    
//    BOOL didUpdate = NO;
//    
////     update all attachments that match this URL (possibly multiple images with same size)
//    for (DTTextAttachment *oneAttachment in [_textView.attributedTextContentView.layoutFrame textAttachmentsWithPredicate:pred])
//    {
//        // update attachments that have no original size, that also sets the display size
//        if (CGSizeEqualToSize(oneAttachment.originalSize, CGSizeZero))
//        {
//            oneAttachment.originalSize = imageSize;
//            
//            didUpdate = YES;
//        }
//    }
//    
//    if (didUpdate)
//    {
//        // layout might have changed due to image sizes
//        // do it on next run loop because a layout pass might be going on
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [_textView relayoutText];
//        });
//    }
}

- (DTAttributedTextCell *)tableView:(UITableView *)tableView preparedCellForIndexPath:(NSIndexPath *)indexPath
{
    // workaround for iOS 5 bug
    NSString *key = [NSString stringWithFormat:@"%ld-%ld", (long)indexPath.section, (long)indexPath.row];
    
    DTAttributedTextCell *cell = [cellCache objectForKey:key];
    
    if (!cell)
    {
        if ([self _canReuseCells])
        {
            cell = (DTAttributedTextCell *)[tableView dequeueReusableCellWithIdentifier:AttributedTextCellReuseIdentifier];
        }
        
        if (!cell)
        {
            cell = [[DTAttributedTextCell alloc] initWithReuseIdentifier:AttributedTextCellReuseIdentifier];
        }
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.hasFixedRowHeight = _useStaticRowHeight;
        
        // cache it, if there is a cache
        [cellCache setObject:cell forKey:key];
    }
    
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

- (BOOL)_canReuseCells
{
    // reuse does not work for variable height
    
    if ([self respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)])
    {
        return NO;
    }
    
    // only reuse cells with fixed height
    return YES;
}

- (void)configureCell:(DTAttributedTextCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    //    NSDictionary *snippet = [_snippets objectAtIndex:indexPath.row];
    
    NSString *html = @"<p style=\"margin-left:0pt; margin-right:0pt; text-align:justify\"><span style=\"font-family:微软雅黑\"><span style=\"font-size:16px\">上期【大咖驾到】爪先生来头条发文交流，许多老师都回复称赞\"才子\"，夸赞爪先生有互联网保险的思维。</span></span>\n\n<p style=\"margin-left:0pt; margin-right:0pt; text-align:justify\"><span style=\"font-family:微软雅黑\"><span style=\"font-size:16px\">本期\"大咖\"又会有哪位老师来作客呢？她就是女神级代理人---夏葵！</span></span>\n\n<img src=\"https://cdn.iyb.tm/bbs/img/post/1289.jpg\" />\n\n<p style=\"margin-left:0pt; margin-right:0pt; text-align:justify\"> \n\n<p style=\"margin-left:0pt; margin-right:0pt; text-align:justify\">适逢七夕佳节，男生女生要互相送礼物，其实一份【爱情险】也是很好的礼物选择。关于买东西，我们来听听夏奎的见解：\n\n<p style=\"margin-left:0pt; margin-right:0pt; text-align:justify\">------------------------正文开始-------------------------------\n\n<p style=\"margin-left:0pt; margin-right:0pt; text-align:justify\"><span style=\"font-size:10.5pt\"><span style=\"font-family:等线\"><span style=\"font-size:12.0000pt\"><span style=\"font-family:微软雅黑\">每一个</span></span><span style=\"font-size:12.0000pt\"><span style=\"font-family:微软雅黑\">节日，我</span></span>";
    
    [cell setHTMLString:html];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.attributedTextContextView.shouldDrawImages = YES;
    
    cell.attributedTextContextView.delegate = self;
    
//    cell.attributedTextContextView.backgroundColor = [ANGUIColorPlus colorWithHexString:@"#efeff4"];
    
}
#pragma mark - getter
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenFrame_Width, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}

@end
