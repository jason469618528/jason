//
//  GuideView.m
//  PanliApp
//
//  Created by Liubin on 13-11-4.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "GuideView.h"

@implementation GuideView

@synthesize mGuide = _mGuide;
@synthesize guideViewDelegate = _guideViewDelegate;

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_mGuide);
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIControl *clickControl = [[UIControl alloc] initWithFrame:self.bounds];
        [clickControl addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clickControl];
        
        _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgImageView.layer.cornerRadius = 8.0f;
        _bgImageView.layer.masksToBounds = YES; 
        [self addSubview:_bgImageView];
        [_bgImageView release];
    }
    return self;
}

- (void)clickAction
{
    if (_guideViewDelegate != nil && [_guideViewDelegate respondsToSelector:@selector(goToGuideDetailView:)]) {
        [_guideViewDelegate goToGuideDetailView:self.mGuide];
    }
}

- (void)setGuideData:(Guide *)data
{
    self.mGuide = data;
    [_bgImageView setImageWithURL:[NSURL URLWithString:data.guideImage] placeholderImage:[UIImage imageNamed:@"bg_index_default_a"]];
}


@end
