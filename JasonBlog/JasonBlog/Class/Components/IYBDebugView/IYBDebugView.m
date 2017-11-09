//
//  IYBDebugView.m
//  JasonBlog
//
//  Created by iyb-hj on 2017/9/11.
//  Copyright © 2017年 PanliMobile. All rights reserved.
//

#import "IYBDebugView.h"

@interface IYBDebugView () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *toolbarView;
@property (nonatomic, strong) UITextView *logTextView;
@end

@implementation IYBDebugView


- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self redirectSTD:STDOUT_FILENO];
        [self redirectSTD:STDERR_FILENO];
        [self addSubview:self.toolbarView];
        [self addSubview:self.logTextView];
        
        UIPanGestureRecognizer *PanGestureRecognizer =
        [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleTableviewCellLongPressed:)];
        PanGestureRecognizer.delegate = self;
        [self addGestureRecognizer:PanGestureRecognizer];
    }
    return self;
}
- (void) handleTableviewCellLongPressed:(UIPanGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state ==
        UIGestureRecognizerStateBegan) {
//        NSLog(@"UIGestureRecognizerStateBegan");
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [gestureRecognizer translationInView:self];
        [self setCenter:(CGPoint){self.center.x + translation.x, self.center.y + translation.y}];
        [gestureRecognizer setTranslation:CGPointZero inView:self.superview];
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGFloat centerY = self.center.y;
        if(centerY > UI_SCREEN_HEIGHT - UI_TAB_BAR_HEIGHT) {
            centerY = UI_SCREEN_HEIGHT  + UI_TAB_BAR_HEIGHT - 100;
        } else if(centerY <= UI_TAB_BAR_HEIGHT + UI_STATUS_BAR_HEIGHT) {
            centerY = UI_TAB_BAR_HEIGHT + UI_STATUS_BAR_HEIGHT;
        }
        [self setCenter:(CGPoint){MainScreenFrame_Width/2, centerY}];
        [gestureRecognizer setTranslation:CGPointZero inView:self.superview];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*) gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*) otherGestureRecognizer {
    if([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [NSStringFromClass([otherGestureRecognizer class])isEqualToString:@"UIScrollViewPanGestureRecognizer"]){
        return NO;
    }
    return YES;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)redirectNotificationHandle:(NSNotification *)nf{
    NSData *data = [[nf userInfo] objectForKey:NSFileHandleNotificationDataItem];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    self.logTextView.text = [NSString stringWithFormat:@"%@\n%@",self.logTextView.text, str];
    NSRange range;
    range.location = [self.logTextView.text length] - 1;
    range.length = 0;
    [self.logTextView scrollRangeToVisible:range];
    
    [[nf object] readInBackgroundAndNotify];
}

- (void)redirectSTD:(int )fd{
    NSPipe * pipe = [NSPipe pipe] ;
    NSFileHandle *pipeReadHandle = [pipe fileHandleForReading] ;
    dup2([[pipe fileHandleForWriting] fileDescriptor], fd) ;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSFileHandleReadCompletionNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(redirectNotificationHandle:)
                                                 name:NSFileHandleReadCompletionNotification
                                               object:pipeReadHandle];
    [pipeReadHandle readInBackgroundAndNotify];
}

- (void)show {
    self.hidden = NO;
    self.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = .5f;
        [[UIApplication sharedApplication].delegate.window addSubview:self];
    } completion:^(BOOL finished) {
    }];
}

- (void)dimss {
    [UIView animateWithDuration:.5f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - getter
- (BOOL)isDisplay {
    if(self && self.superview == nil) {
        return YES;
    }
    return NO;
}

- (UITextView*)logTextView {
    if(_logTextView == nil) {
        _logTextView = [[UITextView alloc] initWithFrame:CGRectMake(0.0f, 20.f, MainScreenFrame_Width, 80.f)];
        _logTextView.font = [UIFont systemFontOfSize:14.0f];
        _logTextView.textColor = J_COLOR_WHITE;
        _logTextView.editable = NO;
        _logTextView.backgroundColor = J_COLOR_CLEAR;
    }
    return _logTextView;
}

- (UIView*)toolbarView {
    if(_toolbarView == nil) {
        _toolbarView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, .0f, MainScreenFrame_Width, 20.f)];
        _toolbarView.backgroundColor = J_COLOR_RED;
    }
    return _toolbarView;
}

@end
