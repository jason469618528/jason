//
//  DTTextEditorTestController.m
//  JasonBlog
//
//  Created by iyb-hj on 2017/11/9.
//  Copyright © 2017年 PanliMobile. All rights reserved.
//

#import "DTTextEditorTestController.h"
#import "DTCoreText.h"
#import "DTRichTextEditor.h"

@interface DTTextEditorTestController () <DTAttributedTextContentViewDelegate, DTRichTextEditorViewDelegate> {
    DTRichTextEditorView *richEditor;
}
@property (nonatomic, strong) NSCache *imageViewCache;
@end

@implementation DTTextEditorTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = J_COLOR_WHITE;
    
    richEditor = [[DTRichTextEditorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MainScreenFrame_Width, MainScreenFrame_Height - UI_NAVIGATION_BAR_HEIGHT)];
    richEditor.baseURL = [NSURL URLWithString:@"http://www.drobnik.com"];
    richEditor.textDelegate = self;
    richEditor.defaultFontFamily = @"Helvetica";
    richEditor.textSizeMultiplier = 1.0;
    richEditor.maxImageDisplaySize = CGSizeMake(300, 300);
    richEditor.autocorrectionType = UITextAutocorrectionTypeYes;
    richEditor.editable = YES;
    richEditor.editorViewDelegate = self;
    richEditor.defaultFontSize = 30;
    [self.view addSubview:richEditor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"插入图片" style:UIBarButtonItemStyleDone target:self action:@selector(insterImage)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Helpers
- (void)insterImage {
    UIImage *image = [UIImage imageNamed:@"AppIcon29x29"];
    DTImageTextAttachment *attachment = [[DTImageTextAttachment alloc] initWithElement:nil options:nil];
    attachment.image = (id)image;
    attachment.displaySize = image.size;
    attachment.originalSize = image.size;
    attachment.contentURL = [NSURL URLWithString:@"http://test.image"];
    
    [richEditor replaceRange:[richEditor selectedTextRange] withAttachment:attachment inParagraph:YES];
}

- (void)replaceCurrentSelectionWithPhoto:(UIImage *)image {
    // make an attachment
    DTImageTextAttachment *attachment = [[DTImageTextAttachment alloc] initWithElement:nil options:nil];
    attachment.image = (id)image;
    attachment.displaySize = image.size;
    attachment.originalSize = image.size;
    
    [richEditor replaceRange:[richEditor selectedTextRange] withAttachment:attachment inParagraph:YES];
}


#pragma mark - DTAttributedTextContentViewDelegate
- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame
{
    NSNumber *cacheKey = [NSNumber numberWithUnsignedInteger:[attachment hash]];
    UIImageView *imageView = [self.imageViewCache objectForKey:cacheKey];
    if (imageView)
    {
        imageView.frame = frame;
        return imageView;
    }
    
    if ([attachment isKindOfClass:[DTImageTextAttachment class]])
    {
        DTImageTextAttachment *imageAttachment = (DTImageTextAttachment *)attachment;
        
        imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = imageAttachment.image;
        
        [self.imageViewCache setObject:imageView forKey:cacheKey];
        
        return imageView;
    }
    return nil;
}

#pragma mark - DTRichTextEditorViewDelegate
- (BOOL)editorViewShouldBeginEditing:(DTRichTextEditorView *)editorView
{
    NSLog(@"editorViewShouldBeginEditing:");
    return YES;
}

- (void)editorViewDidBeginEditing:(DTRichTextEditorView *)editorView
{
    NSLog(@"editorViewDidBeginEditing:");
}

- (BOOL)editorViewShouldEndEditing:(DTRichTextEditorView *)editorView
{
    NSLog(@"editorViewShouldEndEditing:");
    return YES;
}

- (void)editorViewDidEndEditing:(DTRichTextEditorView *)editorView
{
    NSLog(@"editorViewDidEndEditing:");
}

- (BOOL)editorView:(DTRichTextEditorView *)editorView shouldChangeTextInRange:(NSRange)range replacementText:(NSAttributedString *)text
{
    NSLog(@"editorView:shouldChangeTextInRange:replacementText:");
    if([text.string isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return NO;
    }
    
    return YES;
}

- (void)editorViewDidChangeSelection:(DTRichTextEditorView *)editorView
{
    NSLog(@"editorViewDidChangeSelection:");
}

- (void)editorViewDidChange:(DTRichTextEditorView *)editorView
{
    NSLog(@"editorViewDidChange:");
}

- (NSCache *)imageViewCache
{
    if (!_imageViewCache)
    {
        _imageViewCache = [[NSCache alloc] init];
    }
    
    return _imageViewCache;
}
@end
