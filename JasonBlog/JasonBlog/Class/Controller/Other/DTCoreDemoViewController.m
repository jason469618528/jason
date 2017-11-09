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

@interface DTCoreDemoViewController () <UITableViewDelegate, UITableViewDataSource, DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate> {
    NSCache *cellCache;
    BOOL _useStaticRowHeight;
    NSArray *snippets;
}
@property (nonatomic, strong) UITableView *mainTableView;
@end

@interface DTCoreDemoViewController ()

@end

@implementation DTCoreDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = J_COLOR_WHITE;
    
    cellCache = [[NSCache alloc] init];
    
    [self.view addSubview:self.mainTableView];

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
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DTAttributedTextCell *cell = (DTAttributedTextCell *)[self tableView:tableView preparedCellForIndexPath:indexPath];
    return [cell requiredRowHeightInTableView:tableView];
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
        CGFloat width = MainScreenFrame_Width - 15*2;
        CGFloat height = width * aspectRatio;


        CGRect tempFrame = frame;
        tempFrame.size.width = MainScreenFrame_Width - 30.f;
        tempFrame.size.height = (MainScreenFrame_Width - 30.f) * (MainScreenFrame_Width/MainScreenFrame_Height);
        
        UIView *View = [[UIView alloc] initWithFrame:tempFrame];
        View.backgroundColor = J_COLOR_GRAY;
        
        DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tempFrame.size.width, tempFrame.size.height)];
        imageView.accessibilityIdentifier = attachment.contentURL.absoluteString;
        imageView.contentView = attributedTextContentView;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
//        imageView.backgroundColor = J_COLOR_RED;
        [self lazyImageView:imageView didChangeImageSize:tempFrame.size];
        
        [imageView sd_setImageWithURL:attachment.contentURL placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [self lazyImageView:imageView didChangeImageSize:image.size];
        }];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPictureWithAbsoluteUrl:)];
        [imageView addGestureRecognizer:gesture];
        [View addSubview:imageView];
        
        return View;
        
//      if the attachment has a hyperlinkURL then this is currently ignored
//        CGRect tempFrame = frame;
//        tempFrame.size.width = MainScreenFrame_Width - 30.f;
//        tempFrame.size.height = 100.f;
//        
//        DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:tempFrame];
//        imageView.delegate = self;
//        imageView.backgroundColor = J_COLOR_GRAY;
//        // sets the image if there is one
//        imageView.image = [(DTImageTextAttachment *)attachment image];
//        // url for deferred loading
//        imageView.url = attachment.contentURL;
//        
//        imageView.contentView = attributedTextContentView;
//        
//        imageView.userInteractionEnabled = YES;
//        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPictureWithAbsoluteUrl:)];
//        [imageView addGestureRecognizer:gesture];
//
//        return imageView;
    }
    return nil;
}

- (void)showPictureWithAbsoluteUrl:(UIGestureRecognizer *)gesture {
    DTLazyImageView *lazyImage = (DTLazyImageView*)gesture.view;
    
    UIView *bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgView.backgroundColor = [UIColor blackColor];
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:lazyImage.image];
    
    CGFloat y,width,height;
    y = ([UIScreen mainScreen].bounds.size.height - lazyImage.image.size.height * [UIScreen mainScreen].bounds.size.width / lazyImage.image.size.width) * 0.5;
    //宽度为屏幕宽度
    width = [UIScreen mainScreen].bounds.size.width;
    //高度 根据图片宽高比设置
    height = lazyImage.image.size.height * [UIScreen mainScreen].bounds.size.width / lazyImage.image.size.width;
    [imgView setFrame:CGRectMake(0, y, width, height)];
    //重要！ 将视图显示出来
//    self.hoverView.alpha = 0.0f;
    [self.navigationController.view addSubview:bgView];
    [self.navigationController.view addSubview:imgView];
}

#pragma mark -  DTLazyImageViewDelegate
- (void)lazyImageView:(DTLazyImageView *)lazyImageView didChangeImageSize:(CGSize)size {
    NSString *url = lazyImageView.accessibilityIdentifier;
    CGSize imageSize = size;
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"contentURL.absoluteString == %@", url];
    
    BOOL didUpdate = NO;
    
//     update all attachments that match this URL (possibly multiple images with same size)
    for (DTTextAttachment *oneAttachment in [lazyImageView.contentView.layoutFrame textAttachmentsWithPredicate:pred])
    {
        // update attachments that have no original size, that also sets the display size
        if (CGSizeEqualToSize(oneAttachment.originalSize, CGSizeZero))
        {
            imageSize.width = MIN(size.width, MainScreenFrame_Width - 30);
            CGFloat height = imageSize.height * (imageSize.width / size.width);
            imageSize.height = height;
            oneAttachment.displaySize = imageSize;
            lazyImageView.frame = CGRectMake(0.0f, 0.0f, imageSize.width, imageSize.height);
            didUpdate = YES;
        }
    }
    
    if (didUpdate)
    {
        // layout might have changed due to image sizes
        // do it on next run loop because a layout pass might be going on
        dispatch_async(dispatch_get_main_queue(), ^{
            lazyImageView.contentView.layouter = nil;
            [lazyImageView.contentView relayoutText];
            [self.mainTableView reloadData];
        });
    }
}


- (DTAttributedTextCell *)tableView:(UITableView *)tableView preparedCellForIndexPath:(NSIndexPath *)indexPath
{
    // workaround for iOS 5 bug
    NSString *key = [NSString stringWithFormat:@"IYBDTCore-%ld-%ld", (long)indexPath.section, (long)indexPath.row];
    
    DTAttributedTextCell *cell = [cellCache objectForKey:key];
    
    if (!cell) {
        if ([self _canReuseCells]) {
            cell = (DTAttributedTextCell *)[tableView dequeueReusableCellWithIdentifier:AttributedTextCellReuseIdentifier];
        }
        if (!cell) {
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

- (BOOL)_canReuseCells {
    // reuse does not work for variable height
    if ([self respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return NO;
    }
    // only reuse cells with fixed height
    return YES;
}

- (void)configureCell:(DTAttributedTextCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    //    NSDictionary *snippet = [_snippets objectAtIndex:indexPath.row];
    NSString *html = @"<p style=\"margin-left:0pt; margin-right:0pt; text-align:justify\"><span style=\"font-family:微软雅黑\"><span style=\"font-size:16px\">上期【大咖驾到】爪先生来头条发文交流，许多老师都回复称赞\"才子\"，夸赞爪先生有互联网保险的思维。</span></span>\n\n<p style=\"margin-left:0pt; margin-right:0pt; text-align:justify\"><span style=\"font-family:微软雅黑\"><span style=\"font-size:16px\">本期\"大咖\"又会有哪位老师来作客呢？她就是女神级代理人---夏葵！</span></span>\n\n<img src=\"https://cdn.iyb.tm/bbs/img/post/1289.jpg\" />\n\n<p style=\"margin-left:0pt; margin-right:0pt; text-align:justify\"> \n\n<p style=\"margin-left:0pt; margin-right:0pt; text-align:justify\">适逢七夕佳节，男生女生要互相送礼物，其实一份【爱情险】也是很好的礼物选择。关于买东西，我们来听听夏奎的见解：\n\n<p style=\"margin-left:0pt; margin-right:0pt; text-align:justify\">------------------------正文开始-------------------------------\n\n<p style=\"margin-left:0pt; margin-right:0pt; text-align:justify\"><span style=\"font-size:10.5pt\"><span style=\"font-family:等线\"><span style=\"font-size:12.0000pt\"><span style=\"font-family:微软雅黑\">每一个</span></span><span style=\"font-size:12.0000pt\"><span style=\"font-family:微软雅黑\">节日，我</span></span>";
    
    [cell setHTMLString:html];
    cell.attributedTextContextView.shouldDrawImages = YES;
    cell.attributedTextContextView.delegate = self;
    cell.attributedTextContextView.edgeInsets = UIEdgeInsetsMake(0.0f, 15.f, 0.0f, 15.f);
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(cellLongPress:)];
    [cell addGestureRecognizer:gesture];
}

- (void)cellLongPress:(UILongPressGestureRecognizer *)gesture {
    
    // 因为一个手势要经历UIGestureRecognizerStateBegan、UIGestureRecognizerStateChanged、UIGestureRecognizerStateEnded等多个状态，所以这个方法会执行多次。
    // 一般只需要在began的时候执行动作，所以需要添加这个if判断
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"触发了长按手势");
        // 创建弹出的menu
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        // 弹出的menu都有哪几个item
        UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyAction)];
        UIMenuItem *item1 = [[UIMenuItem alloc] initWithTitle:@"自定义" action:@selector(selAction)];
        // 设置item
        menuController.menuItems = @[item,item1];
        [menuController setTargetRect:gesture.view.frame inView:gesture.view.superview];
        // 设置menu可见，因为默认是不可见的
        [menuController setMenuVisible:YES animated:YES];
        [UIMenuController sharedMenuController].menuItems = nil;
        // 获取需要获取的文本
//        CGPoint point = [gesture locationInView:_mainTableView];
//        
//        NSIndexPath *indexPath = [_mainTableView indexPathForRowAtPoint:point];
//        
//        self.needCopyStr = self.dataSource[indexPath.row];
//        
//        NSLog(@"需要复制的文本：%@",self.needCopyStr);
        
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
    
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(copyAction)) {
        return YES;
    }
    return NO;
}

//- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}

//- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
//    if (action == @selector(copy:)) {  // 只包含拷贝功能
//        return YES;
//    }
//    return NO;
//}
//
//
//- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
//    if (action == @selector(copy:)) {
////        NSString *str = self.dataSource[indexPath.row];
////        [UIPasteboard generalPasteboard].string = str;
//    }
//}


#pragma mark - getter
- (UITableView *)mainTableView {
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenFrame_Width, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT)];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor clearColor];
        _mainTableView.tableFooterView = [[UIView alloc] init];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _mainTableView;
}

@end
