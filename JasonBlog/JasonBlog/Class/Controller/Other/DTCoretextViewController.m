//
//  DTCoretextViewController.m
//  JasonBlog
//
//  Created by iyb-hj on 2017/9/12.
//  Copyright © 2017年 PanliMobile. All rights reserved.
//

#import "DTCoretextViewController.h"
#import <DTCoreText.h>
//#import <CoreMedia/CoreMedia.h>
#import <MediaPlayer/MediaPlayer.h>
#import <DTWebVideoView.h>

@interface DTCoretextViewController ()<DTAttributedTextContentViewDelegate,DTLazyImageViewDelegate> {
    NSString *_content;
    DTAttributedTextView *_textView;
    NSURL *lastActionLink;
}
@property (nonatomic, strong) NSMutableSet *mediaPlayers;


@end
@interface DTCoretextViewController ()

@end

@implementation DTCoretextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = J_COLOR_WHITE;
    
    _content = @"<p style=\"margin-left:0pt; margin-right:0pt; text-align:justify\"><span style=\"font-family:微软雅黑\"><span style=\"font-size:16px\">上期【大咖驾到】爪先生来头条发文交流，许多老师都回复称赞\"才子\"，夸赞爪先生有互联网保险的思维。</span></span>\n\n<p style=\"margin-left:0pt; margin-right:0pt; text-align:justify\"><span style=\"font-family:微软雅黑\"><span style=\"font-size:16px\">本期\"大咖\"又会有哪位老师来作客呢？她就是女神级代理人---夏葵！</span></span>\n\n<img src=\"https://cdn.iyb.tm/bbs/img/post/1289.jpg\" />\n\n<p style=\"margin-left:0pt; margin-right:0pt; text-align:justify\"> \n\n<p style=\"margin-left:0pt; margin-right:0pt; text-align:justify\">适逢七夕佳节，男生女生要互相送礼物，其实一份【爱情险】也是很好的礼物选择。关于买东西，我们来听听夏奎的见解：\n\n<p style=\"margin-left:0pt; margin-right:0pt; text-align:justify\">------------------------正文开始-------------------------------\n\n<p style=\"margin-left:0pt; margin-right:0pt; text-align:justify\"><span style=\"font-size:10.5pt\"><span style=\"font-family:等线\"><span style=\"font-size:12.0000pt\"><span style=\"font-family:微软雅黑\">每一个</span></span><span style=\"font-size:12.0000pt\"><span style=\"font-family:微软雅黑\">节日，我</span></span>";
    
//    _content =@"<span style=\"font-size:18px\">2009年，《保险法》中首次加入\"两年不可抗辩\"条款，多年运行下来，不同的朋友有不同的看法，有的朋友认为\"只要拖过两年什么都赔\"，也有的朋友认为只要是\"恶意隐瞒重大病史（比如恶性肿瘤之类的），任何时候都不该赔\"，那么，到底该怎么正确理解\"两年不可抗辩\"，一时间众说纷纭，眼花缭乱。笔者作为一个人身险资深理赔人，现在就来谈谈自己的看法，也非常欢迎各位朋友一起讨论：</span>\n\n<strong><span style=\"font-size:18px\">一、两年不可抗辩的核心内容就是\"保险公司在合同成立超过两年后不得解除保险合同\"，且没有其他</span></strong>\n\n<img alt=\"\" src=\"https://cdn.iyb.tm/bbs/img/post/2765.png\" />\n\n<span style=\"font-size:18px\">上面是《保险法》（2015修正版）的截图，简单清楚，两年不可抗辩就是\"保险公司在合同成立超过两年后不得解除保险合同\"，换个说法就是\"解除合同应该在合同成立之日起两年内\"。</span>\n\n<span style=\"font-size:18px\">从保险法条款很容易看出，保险公司必须同时满足以下五个条件才能解约：<br />\n<strong>1.投保人故意或重大过失不如实告知；<br />\n2.不如实告知内容足以影响保险公司决定是否承保或提高保险费率；<br />\n3.在合同签订时保险公司不知道投保人有不如实告知事项；<br />\n4.保险公司在知道能解除保险合同之日起的三十天之内；<br />\n5.合同成立之日起两年内</strong></span><img alt=\"\" src=\"https://cdn.iyb.tm/bbs/img/post/2766.png\" />\n\n<span style=\"font-size:18px\">在实际操作中，很明显1、2都是主观性很强的而且是保险公司占主导地位的，所以在实务操作中也给了保险公司很多操作空间，对客户来说相对不利；3、4更是基本就由保险公司自己说了算；<strong>严格来说只有5条，即\"两年不可抗辩\"，是容易量化且没有争议的</strong>。</span>\n\n<span style=\"font-size:18px\">在两年不可抗辩条款加入之前，保险公司因为";
    
//    _content  =	@"​<img src=\"https://www.cocoanetics.com/files/Cocoanetics_Square.jpg\">";
    
//    _content =	@"<h1>Image Handling</h1>\n<p>Some basic <b>image</b> handling has been implemented</p>\n<h2>Inline</h2>\n<p>So far <img src=\"icon_smile.gif\"> images work inline, sitting on the line's baseline. There is a workaround in place that if an image is more than twice as high as the surrounding text it will be treated as it's own block.</p>\n<h2>Block</h2>\n<p>There is a known issue with images as blocks, outside of p tags.</p>\n<img class=\"Bla\" style=\"width:150px; height:150px\" src=\"Oliver.jpg\">\n<p>An Image outside of P is treated as a paragraph</p>\n<p><img style=\"float:right;\" width=\"100\" height=\"100\" src=\"Oliver.jpg\">The previous image has float style. As a <span style=\"background-color:yellow;\">Workaround</span> a newline is added after it until we can support floating in the layouting. This is done if the inline image is more than 5 times as large as the current font pixel size. This should allow small inline images, like smileys to stay in line, while most float images would probably be larger than this.</p>\n<h2>Supp";
    
//    @"<img src=\"https://www.cocoanetics.com/files/Cocoanetics_Square.jpg\">";
    
    _content = @"最近，有很多朋友都向我咨询关于三口之家的家庭保障意见。\n\n从一个单身汉到组建一个家庭，从一个人吃饱全家不饿到需要为整个家庭考虑，完成这些转变的同时，更要求升级为父母的朋友们提升整个家庭抵御风险的能力，珍惜来之不易的幸福。因此，对于大多数工薪家庭，构建一个完整的家庭保障是必不可少的。\n\n接下来我就用一个三口之家为例，简单给大家说说如何完善家庭保障：\n\n李先生一家三口，李先生30岁，年收入20万，李太太25岁，年收入10万，宝宝出生100天岁。李先生一家计划用每年12000元的费用作为全家人的保费预算。\n\n \n\n<strong>家庭保障</strong><strong>需求分析</strong>\n\n<strong>家庭支柱：李先生和李太太</strong>\n\n作为整个年轻家庭的家庭支柱，必须要有充足的保障，才能提升整个家庭抵抗风险的能力。\n\n目前李先生和李太太比较年轻，正处在事业上升期。在工作压力、生活压力的影响下，应将保障重点放在：重疾保障、医疗保障及意外保障 三个方面。\n\n<strong>重要成员：李宝宝</strong>\n\n宝宝出生满3个月，为了能给宝宝全面的保障，度过无忧童年，保障也围绕三个层面：重疾保障、医疗保障和意外保障。\n\n因此，结合一家三口的情况，为李先生一家制定的保险计划如下：\n\n<img alt=\"\" src=\"https://cdn.iyb.tm/bbs/img/post/2783.png\" />\n\n<strong>保障计划详情</strong>\n\n<strong>重疾保障</strong>\n\n重疾保障是一家三口最重要的风险防火墙。对于一个非常年轻的家庭而言，需要 在保费预算有限的情况下，提供较高的风险保障。因此我为他们配置的重疾保额是：李先生 + 李太太 + 宝宝 = 270万。\n\n<strong>产品选择</strong>\n\n李先生：复星康乐e生40万+乐活e生重疾险（成人版）30万（特定疾病60万）=100万\n\n李太太：复星康乐e生40万+乐活e生重疾险（成人版）30万（特定疾病60万）=100万\n\n李宝宝：复星康乐e生20万+乐活e生重疾险（少儿版）25万（特定疾病50万）=70万\n\n<strong>保费支出</strong>\n\n李先生重疾保障保费4392元，其中：\n\n康乐e生20年交，保至70周岁：3912元；乐活e生首年保费：480元\n\n李太太重疾保障保费2844元，其中：\n\n康乐e最近，有很多朋友都向我咨询关于三口之家的家庭保障意见。\n\n从一个单身汉到组建一个家庭，从一个人吃饱全家不饿到需要为整个家庭考虑，完成这些转变的同时，更要求升级为父母的朋友们提升整个家庭抵御风险的能力，珍惜来之不易的幸福。因此，对于大多数工薪家庭，构建一个完整的家庭保障是必不可少的。\n\n接下来我就用一个三口之家为例，简单给大家说说如何完善家庭保障：\n\n李先生一家三口，李先生30岁，年收入20万，李太太25岁，年收入10万，宝宝出生100天岁。李先生一家计划用每年12000元的费用作为全家人的保费预算。\n\n \n\n<strong>家庭保障</strong><strong>需求分析</strong>\n\n<strong>家庭支柱：李先生和李太太</strong>\n\n作为整个年轻家庭的家庭支柱，必须要有充足的保障，才能提升整个家庭抵抗风险的能力。\n\n目前李先生和李太太比较年轻，正处在事业上升期。在工作压力、生活压力的影响下，应将保障重点放在：重疾保障、医疗保障及意外保障 三个方面。\n\n<strong>重要成员：李宝宝</strong>\n\n宝宝出生满3个月，为了能给宝宝全面的保障，度过无忧童年，保障也围绕三个层面：重疾保障、医疗保障和意外保障。\n\n因此，结合一家三口的情况，为李先生一家制定的保险计划如下：\n\n<img alt=\"\" src=\"https://cdn.iyb.tm/bbs/img/post/2783.png\" />\n\n<strong>保障计划详情</strong>\n\n<strong>重疾保障</strong>\n\n重疾保障是一家三口最重要的风险防火墙。对于一个非常年轻的家庭而言，需要 在保费预算有限的情况下，提供较高的风险保障。因此我为他们配置的重疾保额是：李先生 + 李太太 + 宝宝 = 270万。\n\n<strong>产品选择</strong>\n\n李先生：复星康乐e生40万+乐活e生重疾险（成人版）30万（特定疾病60万）=100万\n\n李太太：复星康乐e生40万+乐活e生重疾险（成人版）30万（特定疾病60万）=100万\n\n李宝宝：复星康乐e生20万+乐活e生重疾险（少儿版）25万（特定疾病50万）=70万\n\n<strong>保费支出</strong>\n\n李先生重疾保障保费4392元，其中：\n\n康乐e生20年交，保至70周岁：3912元；乐活e生首年保费：480元\n\n李太太重疾保障保费2844元，其中：\n\n康乐e最近，有很多朋友都向我咨询关于三口之家的家庭保障意见。\n\n从一个单身汉到组建一个家庭，从一个人吃饱全家不饿到需要为整个家庭考虑，完成这些转变的同时，更要求升级为父母的朋友们提升整个家庭抵御风险的能力，珍惜来之不易的幸福。因此，对于大多数工薪家庭，构建一个完整的家庭保障是必不可少的。\n\n接下来我就用一个三口之家为例，简单给大家说说如何完善家庭保障：\n\n李先生一家三口，李先生30岁，年收入20万，李太太25岁，年收入10万，宝宝出生100天岁。李先生一家计划用每年12000元的费用作为全家人的保费预算。\n\n \n\n<strong>家庭保障</strong><strong>需求分析</strong>\n\n<strong>家庭支柱：李先生和李太太</strong>\n\n作为整个年轻家庭的家庭支柱，必须要有充足的保障，才能提升整个家庭抵抗风险的能力。\n\n目前李先生和李太太比较年轻，正处在事业上升期。在工作压力、生活压力的影响下，应将保障重点放在：重疾保障、医疗保障及意外保障 三个方面。\n\n<strong>重要成员：李宝宝</strong>\n\n宝宝出生满3个月，为了能给宝宝全面的保障，度过无忧童年，保障也围绕三个层面：重疾保障、医疗保障和意外保障。\n\n因此，结合一家三口的情况，为李先生一家制定的保险计划如下：\n\n<img alt=\"\" src=\"https://cdn.iyb.tm/bbs/img/post/2783.png\" />\n\n<strong>保障计划详情</strong>\n\n<strong>重疾保障</strong>\n\n重疾保障是一家三口最重要的风险防火墙。对于一个非常年轻的家庭而言，需要 在保费预算有限的情况下，提供较高的风险保障。因此我为他们配置的重疾保额是：李先生 + 李太太 + 宝宝 = 270万。\n\n<strong>产品选择</strong>\n\n李先生：复星康乐e生40万+乐活e生重疾险（成人版）30万（特定疾病60万）=100万\n\n李太太：复星康乐e生40万+乐活e生重疾险（成人版）30万（特定疾病60万）=100万\n\n李宝宝：复星康乐e生20万+乐活e生重疾险（少儿版）25万（特定疾病50万）=70万\n\n<strong>保费支出</strong>\n\n李先生重疾保障保费4392元，其中：\n\n康乐e生20年交，保至70周岁：3912元；乐活e生首年保费：480元\n\n李太太重疾保障保费2844元，其中：\n\n康乐e最近，有很多朋友都向我咨询关于三口之家的家庭保障意见。\n\n从一个单身汉到组建一个家庭，从一个人吃饱全家不饿到需要为整个家庭考虑，完成这些转变的同时，更要求升级为父母的朋友们提升整个家庭抵御风险的能力，珍惜来之不易的幸福。因此，对于大多数工薪家庭，构建一个完整的家庭保障是必不可少的。\n\n接下来我就用一个三口之家为例，简单给大家说说如何完善家庭保障：\n\n李先生一家三口，李先生30岁，年收入20万，李太太25岁，年收入10万，宝宝出生100天岁。李先生一家计划用每年12000元的费用作为全家人的保费预算。\n\n \n\n<strong>家庭保障</strong><strong>需求分析</strong>\n\n<strong>家庭支柱：李先生和李太太</strong>\n\n作为整个年轻家庭的家庭支柱，必须要有充足的保障，才能提升整个家庭抵抗风险的能力。\n\n目前李先生和李太太比较年轻，正处在事业上升期。在工作压力、生活压力的影响下，应将保障重点放在：重疾保障、医疗保障及意外保障 三个方面。\n\n<strong>重要成员：李宝宝</strong>\n\n宝宝出生满3个月，为了能给宝宝全面的保障，度过无忧童年，保障也围绕三个层面：重疾保障、医疗保障和意外保障。\n\n因此，结合一家三口的情况，为李先生一家制定的保险计划如下：\n\n<img alt=\"\" src=\"https://cdn.iyb.tm/bbs/img/post/2783.png\" />\n\n<strong>保障计划详情</strong>\n\n<strong>重疾保障</strong>\n\n重疾保障是一家三口最重要的风险防火墙。对于一个非常年轻的家庭而言，需要 在保费预算有限的情况下，提供较高的风险保障。因此我为他们配置的重疾保额是：李先生 + 李太太 + 宝宝 = 270万。\n\n<strong>产品选择</strong>\n\n李先生：复星康乐e生40万+乐活e生重疾险（成人版）30万（特定疾病60万）=100万\n\n李太太：复星康乐e生40万+乐活e生重疾险（成人版）30万（特定疾病60万）=100万\n\n李宝宝：复星康乐e生20万+乐活e生重疾险（少儿版）25万（特定疾病50万）=70万\n\n<strong>保费支出</strong>\n\n李先生重疾保障保费4392元，其中：\n\n康乐e生20年交，保至70周岁：3912元；乐活e生首年保费：480元\n\n李太太重疾保障保费2844元，其中：\n\n康乐e";
    
    NSData *data = [_content dataUsingEncoding:NSUTF8StringEncoding];
    // Create text view
    _textView = [[DTAttributedTextView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT)];
    
    // we draw images and links via subviews provided by delegate methods
    _textView.shouldDrawImages = NO;
    _textView.shouldDrawLinks = NO;
    _textView.textDelegate = self; // delegate for custom sub views
    
    // gesture for testing cursor positions
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
//    [_textView addGestureRecognizer:tap];
    
    [_textView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, 44, 0)];
    _textView.contentInset = UIEdgeInsetsMake(10, 10, 54, 10);
    
    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_textView];
    
    // Create attributed string from HTML
    CGSize maxImageSize = CGSizeMake(self.view.bounds.size.width - 20.0, self.view.bounds.size.height - 20.0);
    
    // example for setting a willFlushCallback, that gets called before elements are written to the generated attributed string
    void (^callBackBlock)(DTHTMLElement *element) = ^(DTHTMLElement *element) {
        
        // the block is being called for an entire paragraph, so we check the individual elements
        
        for (DTHTMLElement *oneChildElement in element.childNodes)
        {
            // if an element is larger than twice the font size put it in it's own block
            if (oneChildElement.displayStyle == DTHTMLElementDisplayStyleInline && oneChildElement.textAttachment.displaySize.height > 2.0 * oneChildElement.fontDescriptor.pointSize)
            {
                oneChildElement.displayStyle = DTHTMLElementDisplayStyleBlock;
                oneChildElement.paragraphStyle.minimumLineHeight = element.textAttachment.displaySize.height;
                oneChildElement.paragraphStyle.maximumLineHeight = element.textAttachment.displaySize.height;
            }
        }
    };
    
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:1.0], NSTextSizeMultiplierDocumentOption, [NSValue valueWithCGSize:maxImageSize], DTMaxImageSize,
                                    @"Times New Roman", DTDefaultFontFamily,  @"purple", DTDefaultLinkColor, @"red", DTDefaultLinkHighlightColor, callBackBlock, DTWillFlushBlockCallBack, nil];
    
//    [options setObject:[NSURL fileURLWithPath:readmePath] forKey:NSBaseURLDocumentOption];
    
    NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
    _textView.attributedString = string;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSMutableSet *)mediaPlayers
{
    if (!_mediaPlayers)
    {
        _mediaPlayers = [[NSMutableSet alloc] init];
    }
    
    return _mediaPlayers;
}

#pragma mark Actions

- (void)linkPushed:(DTLinkButton *)button
{
    NSURL *URL = button.URL;
    
    if ([[UIApplication sharedApplication] canOpenURL:[URL absoluteURL]])
    {
        [[UIApplication sharedApplication] openURL:[URL absoluteURL]];
    }
    else
    {
        if (![URL host] && ![URL path])
        {
            
            // possibly a local anchor link
            NSString *fragment = [URL fragment];
            
            if (fragment)
            {
                [_textView scrollToAnchorNamed:fragment animated:NO];
            }
        }
    }
}

- (void)linkLongPressed:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        DTLinkButton *button = (id)[gesture view];
        button.highlighted = NO;
        lastActionLink = button.URL;
        
        if ([[UIApplication sharedApplication] canOpenURL:[button.URL absoluteURL]])
        {
            UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:[[button.URL absoluteURL] description] delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Open in Safari", nil];
            [action showFromRect:button.frame inView:button.superview animated:YES];
        }
    }
}

#pragma mark Custom Views on Text

- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttributedString:(NSAttributedString *)string frame:(CGRect)frame
{
    NSDictionary *attributes = [string attributesAtIndex:0 effectiveRange:NULL];
    
    NSURL *URL = [attributes objectForKey:DTLinkAttribute];
    NSString *identifier = [attributes objectForKey:DTGUIDAttribute];
    
    
    DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:frame];
    button.URL = URL;
    button.minimumHitSize = CGSizeMake(25, 25); // adjusts it's bounds so that button is always large enough
    button.GUID = identifier;
    
    // get image with normal link text
    UIImage *normalImage = [attributedTextContentView contentImageWithBounds:frame options:DTCoreTextLayoutFrameDrawingDefault];
    [button setImage:normalImage forState:UIControlStateNormal];
    
    // get image for highlighted link text
    UIImage *highlightImage = [attributedTextContentView contentImageWithBounds:frame options:DTCoreTextLayoutFrameDrawingDrawLinksHighlighted];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    
    // use normal push action for opening URL
    [button addTarget:self action:@selector(linkPushed:) forControlEvents:UIControlEventTouchUpInside];
    
    // demonstrate combination with long press
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(linkLongPressed:)];
    [button addGestureRecognizer:longPress];
    
    return button;
}

- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame
{
    if ([attachment isKindOfClass:[DTVideoTextAttachment class]])
    {
        NSURL *url = (id)attachment.contentURL;
        
        // we could customize the view that shows before playback starts
        UIView *grayView = [[UIView alloc] initWithFrame:frame];
        grayView.backgroundColor = [DTColor blackColor];
        
        // find a player for this URL if we already got one
        MPMoviePlayerController *player = nil;
        for (player in self.mediaPlayers)
        {
            if ([player.contentURL isEqual:url])
            {
                break;
            }
        }
        
        if (!player)
        {
            player = [[MPMoviePlayerController alloc] initWithContentURL:url];
            [self.mediaPlayers addObject:player];
        }
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_4_2
        NSString *airplayAttr = [attachment.attributes objectForKey:@"x-webkit-airplay"];
        if ([airplayAttr isEqualToString:@"allow"])
        {
            if ([player respondsToSelector:@selector(setAllowsAirPlay:)])
            {
                player.allowsAirPlay = YES;
            }
        }
#endif
        
        NSString *controlsAttr = [attachment.attributes objectForKey:@"controls"];
        if (controlsAttr)
        {
            player.controlStyle = MPMovieControlStyleEmbedded;
        }
        else
        {
            player.controlStyle = MPMovieControlStyleNone;
        }
        
        NSString *loopAttr = [attachment.attributes objectForKey:@"loop"];
        if (loopAttr)
        {
            player.repeatMode = MPMovieRepeatModeOne;
        }
        else
        {
            player.repeatMode = MPMovieRepeatModeNone;
        }
        
        NSString *autoplayAttr = [attachment.attributes objectForKey:@"autoplay"];
        if (autoplayAttr)
        {
            player.shouldAutoplay = YES;
        }
        else
        {
            player.shouldAutoplay = NO;
        }
        
        [player prepareToPlay];
        
        player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        player.view.frame = grayView.bounds;
        [grayView addSubview:player.view];
        
        return grayView;
    }
    else if ([attachment isKindOfClass:[DTImageTextAttachment class]])
    {
        // if the attachment has a hyperlinkURL then this is currently ignored
        DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:frame];
        imageView.delegate = self;
        
        // sets the image if there is one
        imageView.image = [(DTImageTextAttachment *)attachment image];
        
        // url for deferred loading
        imageView.url = attachment.contentURL;
        
        // if there is a hyperlink then add a link button on top of this image
        if (attachment.hyperLinkURL)
        {
            // NOTE: this is a hack, you probably want to use your own image view and touch handling
            // also, this treats an image with a hyperlink by itself because we don't have the GUID of the link parts
            imageView.userInteractionEnabled = YES;
            
            DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:imageView.bounds];
            button.URL = attachment.hyperLinkURL;
            button.minimumHitSize = CGSizeMake(25, 25); // adjusts it's bounds so that button is always large enough
            button.GUID = attachment.hyperLinkGUID;
            
            // use normal push action for opening URL
            [button addTarget:self action:@selector(linkPushed:) forControlEvents:UIControlEventTouchUpInside];
            
            // demonstrate combination with long press
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(linkLongPressed:)];
            [button addGestureRecognizer:longPress];
            
            [imageView addSubview:button];
        }
        
        return imageView;
    }
    else if ([attachment isKindOfClass:[DTIframeTextAttachment class]])
    {
        DTWebVideoView *videoView = [[DTWebVideoView alloc] initWithFrame:frame];
        videoView.attachment = attachment;
        
        return videoView;
    }
    else if ([attachment isKindOfClass:[DTObjectTextAttachment class]])
    {
        // somecolorparameter has a HTML color
        NSString *colorName = [attachment.attributes objectForKey:@"somecolorparameter"];
        UIColor *someColor = DTColorCreateWithHTMLName(colorName);
        
        UIView *someView = [[UIView alloc] initWithFrame:frame];
        someView.backgroundColor = someColor;
        someView.layer.borderWidth = 1;
        someView.layer.borderColor = [UIColor blackColor].CGColor;
        
        someView.accessibilityLabel = colorName;
        someView.isAccessibilityElement = YES;
        
        return someView;
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

#pragma mark -  DTLazyImageViewDelegate
- (void)lazyImageView:(DTLazyImageView *)lazyImageView didChangeImageSize:(CGSize)size {
    NSURL *url = lazyImageView.url;
    CGSize imageSize = size;
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"contentURL == %@", url];
    
    BOOL didUpdate = NO;
    
    // update all attachments that match this URL (possibly multiple images with same size)
    for (DTTextAttachment *oneAttachment in [_textView.attributedTextContentView.layoutFrame textAttachmentsWithPredicate:pred])
    {
        // update attachments that have no original size, that also sets the display size
        if (CGSizeEqualToSize(oneAttachment.originalSize, CGSizeZero))
        {
            oneAttachment.originalSize = imageSize;
            
            didUpdate = YES;
        }
    }
    
    if (didUpdate)
    {
        // layout might have changed due to image sizes
        // do it on next run loop because a layout pass might be going on
        dispatch_async(dispatch_get_main_queue(), ^{
            [_textView relayoutText];
        });
    }

}


@end
