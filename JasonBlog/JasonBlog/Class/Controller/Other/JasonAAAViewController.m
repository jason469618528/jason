//
//  JasonAAAViewController.m
//  JasonBlog
//
//  Created by iyb-hj on 2017/9/13.
//  Copyright © 2017年 PanliMobile. All rights reserved.
//

#import "JasonAAAViewController.h"
#import <DTCoreText.h>
NSString * const AttributedTextCellReuseIdentifier1 = @"AttributedTextCellReuseIdentifier1";

@interface JasonAAAViewController () <UITableViewDelegate, UITableViewDataSource, DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate> {
    NSCache *cellCache;
    UITableView *mainTableView;
}
@end

@implementation JasonAAAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = J_COLOR_WHITE;
    [self setUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- UITableViewDelegateAnDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTAttributedTextCell *cell = (DTAttributedTextCell *)[self tableView:tableView preparedCellForIndexPath:indexPath];
    return [cell requiredRowHeightInTableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTAttributedTextCell *cell = [self tableView:tableView preparedCellForIndexPath:indexPath];
    cell.textDelegate = self;
    return cell;
}

#pragma mark DTAttributedTextCell

- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame
{
    if ([attachment isKindOfClass:[DTImageTextAttachment class]])
    {
        DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:frame];
        imageView.delegate = self;
        
        imageView.image = [(DTImageTextAttachment *)attachment image];
        
        imageView.url = attachment.contentURL;
        
        imageView.contentView = attributedTextContentView;
        return imageView;
    }
    
    return nil;
}

- (BOOL)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView shouldDrawBackgroundForTextBlock:(DTTextBlock *)textBlock frame:(CGRect)frame context:(CGContextRef)context forLayoutFrame:(DTCoreTextLayoutFrame *)layoutFrame
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(frame,1,1) cornerRadius:10];
    
    CGColorRef color = [textBlock.backgroundColor CGColor];
    if (color)
    {
        CGContextSetFillColorWithColor(context, color);
        CGContextAddPath(context, [roundedRect CGPath]);
        CGContextFillPath(context);
        
        CGContextAddPath(context, [roundedRect CGPath]);
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
        CGContextStrokePath(context);
        return NO;
    }
    
    return YES; // draw standard background
}

- (void)lazyImageView:(DTLazyImageView *)lazyImageView didChangeImageSize:(CGSize)size {
    
    NSURL *url = lazyImageView.url;
    CGSize imageSize = size;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"contentURL == %@", url];
    BOOL didUpdate = NO;
    
    for (DTTextAttachment *oneAttachment in [lazyImageView.contentView.layoutFrame textAttachmentsWithPredicate:pred])
    {
        NSLog(@"oneAttachment : %@",oneAttachment);
        oneAttachment.originalSize = imageSize;
        
        if (!CGSizeEqualToSize(imageSize, oneAttachment.displaySize))
        {
            oneAttachment.displaySize = imageSize;
            
            didUpdate = YES;
        }
    }
    if (didUpdate) {
        
        lazyImageView.contentView.layouter = nil;
        [lazyImageView.contentView relayoutText];
    }
}

- (DTAttributedTextCell *)tableView:(UITableView *)tableView preparedCellForIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [NSString stringWithFormat:@"%ld-%ld", (long)indexPath.section, (long)indexPath.row];
    DTAttributedTextCell *cell = [cellCache objectForKey:key];
    if (!cell)
    {
        if ([self _canReuseCells])
        {
            cell = [tableView dequeueReusableCellWithIdentifier:AttributedTextCellReuseIdentifier1];
        }
        if (!cell)
        {
            cell = [[DTAttributedTextCell alloc] initWithReuseIdentifier:AttributedTextCellReuseIdentifier1];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        [cellCache setObject:cell forKey:key];
    }
    
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

- (BOOL)_canReuseCells
{
    if ([self respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)])
    {
        return NO;
    }
    return YES;
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    DTAttributedTextCell *attributeCell = (DTAttributedTextCell *)cell;
    NSString *html = @"【商品名称】氢溴酸右美沙芬口服溶液【主要成分】本品主要成分为：氢溴酸右美沙芬。【性　　状】本品为棕色具有芳香气味的液体。【适 应 症】中枢性镇咳药。适用于急慢性呼吸系统疾病引起的干咳。【用法用量】口服。成人一次15ml，一日3次；儿童每日按1mg/kg体重，分3～4次服用。或遵医嘱。不良反应】偶有头晕、轻度嗜睡、恶心、胃部不适、皮疹等轻微反应，但不影响继续用药。【禁 忌 症】有精神病史者忌用。盒【注意事项】痰多病人慎用。【规　　格】100毫升/【储藏方法】密闭保存。<img src=\"http://pic1.syt.cn/upload/2016/09/07/182000LSTPJJSAN6WXAAPJ.jpg\"><img src=\"http://pic1.syt.cn/upload/2016/09/07/1820009ACEBCEB1WRMZU7K.jpg\"><img src=\"http://pic3.syt.cn/upload/2016/09/07/182000RPESNZCWRMZJDEAB.jpg\"><img src=\"http://pic1.syt.cn/upload/2016/09/07/182000TSN7E4BJQFT6JEXA.jpg\"><img src=\"http://pic1.syt.cn/upload/2016/09/07/182000APSNQ41K4HRY1EA1.jpg\">";
    CGSize maxImageSize = CGSizeMake(self.view.bounds.size.width - 20.0, self.view.bounds.size.height - 20.0);
    void (^callBackBlock)(DTHTMLElement *element) = ^(DTHTMLElement *element) {
        
        for (DTHTMLElement *oneChildElement in element.childNodes)
        {
            
            if (oneChildElement.displayStyle == DTHTMLElementDisplayStyleInline && oneChildElement.textAttachment.displaySize.height > 2.0 * oneChildElement.fontDescriptor.pointSize)
            {
                oneChildElement.displayStyle = DTHTMLElementDisplayStyleBlock;
                oneChildElement.paragraphStyle.minimumLineHeight = element.textAttachment.displaySize.height;
                oneChildElement.paragraphStyle.maximumLineHeight = element.textAttachment.displaySize.height;
            }
        }
    };
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:1.0], NSTextSizeMultiplierDocumentOption, [NSValue valueWithCGSize:maxImageSize], DTMaxImageSize,
                                    callBackBlock, DTWillFlushBlockCallBack, nil];
    [attributeCell setHTMLString:html options:options];
}

- (void)setUI
{
    mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
//    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [mainTableView setSeparatorInset:UIEdgeInsetsZero];
    mainTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainTableView];
}

@end
