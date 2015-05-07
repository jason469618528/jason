//
//  HomeCell.m
//  JasonBlog
//
//  Created by jason on 15-5-5.
//  Copyright (c) 2015年 PanliMobile. All rights reserved.
//

#import "HomeCell.h"

@interface HomeCell ()
@property (strong, nonatomic) IBOutlet UIView *view_Detail;
@end

@implementation HomeCell

- (void)awakeFromNib
{
    // Initialization code
    self.view_Detail.frame = self.contentView.frame;
    [self.contentView addSubview:self.view_Detail];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
