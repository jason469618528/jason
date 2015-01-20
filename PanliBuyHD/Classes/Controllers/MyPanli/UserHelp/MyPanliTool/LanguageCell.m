//
//  LanguageCell.m
//  PanliBuyHD
//
//  Created by ZhaoFucheng on 14-11-3.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "LanguageCell.h"

@implementation LanguageCell

- (void)awakeFromNib
{
    self.backgroundColor = PL_COLOR_WHITE;
    
    self.isPatch = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Override Methods
- (void)setIsPatch:(BOOL)isPatch
{
    if (isPatch) {
        self.imgPatch.hidden = NO;
    }
    else
    {
        self.imgPatch.hidden = YES;
    }
    _isPatch = isPatch;
}


@end
