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
@property (weak, nonatomic) IBOutlet UIView *view_DisplayImage;
@property (strong, nonatomic) IBOutlet UIImageView *img_Hea;
@end

@implementation HomeCell

- (void)awakeFromNib
{
    // Initialization code
    
//    self.view_Detail.frame = self.contentView.frame;
//    [self.contentView addSubview:self.view_Detail];
    [self.contentView addSubview:self.view_DisplayImage];
}

- (void)setDisplayImage:(UIImage*)displayImage
{
    self.img_Hea.image = displayImage;
    self.img_Hea.frame = CGRectMake(0.0f, 0.0f, displayImage.size.width, displayImage.size.height);
    self.view_DisplayImage.frame = CGRectMake(0.0f, 0.0f, self.img_Hea.frame.size.width, self.img_Hea.frame.size.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
