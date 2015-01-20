//
//  ATLabel.m
//
// Created by Karthikeya Udupa on 7/14/13.
// Copyright (c) 2012 Karthikeya Udupa K M All rights reserved.

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "DynamicLabelForUpDown.h"

@interface DynamicLabelForUpDown ()
{

}

@property (nonatomic, retain) NSTimer *animator;

@property (nonatomic, assign) float timerInterval;

@property (nonatomic, assign) int displayIndex;

@end

@implementation DynamicLabelForUpDown
@synthesize wordList = _wordList;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_wordList);
    [_animator invalidate];
    _animator = nil;
    [super dealloc];
}

- (void)animateWithWords:(NSArray *)words forDuration:(double)time defaults:(NSString*)defaultString
{
    if(words == nil || words.count < 1)
    {
        self.text = defaultString;
        [_animator invalidate];
        _animator = nil;
        return;
    }
    self.timerInterval = time;
    self.wordList = words;
    self.displayIndex = 0;
    self.text = [self.wordList objectAtIndex:0];
    if (words.count > 1)
    {
        [self startAnimation];
    }
}

- (void)layoutSubviews
{
    
}

- (void)startAnimation
{
    if (!self.animator)
    {
        self.animator = [NSTimer scheduledTimerWithTimeInterval:self.timerInterval
														 target:self
													   selector:@selector(activateAnimation)
													   userInfo:nil
														repeats:YES];
    }
}

- (void)activateAnimation
{
    self.displayIndex ++;
    if (self.displayIndex == [self.wordList count])
    {
        self.displayIndex = 0;
    }
    [UIView animateWithDuration:self.timerInterval/4 animations:^{
        self.alpha = 0.0;
        
    } completion:^(BOOL finished)
     {
         [UIView animateWithDuration:self.timerInterval/4 animations:^{
             self.alpha = 1.0;
             self.text = [self.wordList objectAtIndex:self.displayIndex];
             if (self.delegate && [self.delegate respondsToSelector:@selector(displayWord:)]) {
                 [self.delegate displayWord:[self.wordList objectAtIndex:self.displayIndex]];
             }
         } completion:^(BOOL finished) {
             
         }];
     }];
}
@end
