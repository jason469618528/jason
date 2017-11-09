//
//  IYBSlideLabel.m
//  iYunBao
//
//  Created by iyb-hj on 2017/8/18.
//  Copyright © 2017年 iYunBao. All rights reserved.
//

#import "IYBSlideLabel.h"

@implementation IYBSlideLabel

- (void)initializeLabel {
    self.animationDuration = 0.8;
    self.scrollDirection = ADTickerLabelScrollDirectionUp;
    
    self.font = [UIFont systemFontOfSize: 12.];
    self.textColor = [UIColor blackColor];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        [self initializeLabel];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self initializeLabel];
    }
    return self;
}

- (void)setSlideText:(NSString *)slideText {
    [self setText:slideText animated:YES];
}

- (void)setText:(NSString *)text animated:(BOOL)animated {
    if ([_slideText isEqualToString:text]) {
        return;
    }
    if(animated) {
        NSInteger oldValue = _slideText.integerValue;
        NSInteger newValue = text.integerValue;
        
        if(newValue > oldValue) {
            [self animationWithdirection:ADTickerLabelScrollDirectionUp];
        } else {
            [self animationWithdirection:ADTickerLabelScrollDirectionDown];
        }
    }
    _slideText = text;
    self.text = text;
}

#pragma mark - getter
- (void)animationWithdirection:(ADTickerLabelScrollDirection)scrollDirection {
    CATransition *transition = [CATransition animation];
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.duration = self.animationDuration;
    transition.type = kCATransitionPush;
    transition.subtype = (scrollDirection == ADTickerLabelScrollDirectionUp ? kCATransitionFromTop : kCATransitionFromBottom);
    [self.layer addAnimation:transition forKey:nil];
}


@end
