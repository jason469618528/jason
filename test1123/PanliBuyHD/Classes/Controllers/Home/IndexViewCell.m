//
//  IndexViewCell.m
//  PanliBuyHD
//
//  Created by jason on 15-1-20.
//  Copyright (c) 2015年 Panli. All rights reserved.
//

#import "IndexViewCell.h"
@interface IndexViewCell()

@property (strong, nonatomic) NSArray *arr_Index;
@end

@implementation IndexViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)reloadView:(NSArray*)arr_Data
{
    if (arr_Data == nil || arr_Data.count == 0)
    {
        return;
    }
    self.arr_Index = arr_Data;
    for (int i = 0; i < _arr_Index.count; i++)
    {
        switch (i)
        {
            case 0:
            {
                [self.btn_Left setCustomImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_135X120"]];
                break;
            }
                
            case 1:
            {
                [self.btn_Center setCustomImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_135X120"]];
                break;
            }
                
            case 2:
            {
                [self.btn_Right setCustomImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_135X120"]];
                break;
            }
                
            default:
                break;
        }
    }

}
@end
