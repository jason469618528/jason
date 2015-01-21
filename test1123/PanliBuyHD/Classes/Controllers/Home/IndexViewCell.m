//
//  IndexViewCell.m
//  PanliBuyHD
//
//  Created by jason on 15-1-21.
//  Copyright (c) 2015年 Panli. All rights reserved.
//

#import "IndexViewCell.h"
@interface IndexViewCell ()

@property(nonatomic,strong) NSArray *arr_Index;
@end

@implementation IndexViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)btnClick:(id)sender
{
    UIButton *button = sender;
    NSInteger index = button.tag - 1001;
    if (index < self.arr_Index.count)
    {
        indexCategory *category = [self.arr_Index objectAtIndex:index];
        if (self.delegate && [self.delegate respondsToSelector:@selector(indexViewDelegate:)])
        {
            [self.delegate indexViewDelegate:category];
        }
    }
}

- (void)reloadIndeCellArray:(NSArray*)arr
{
    if(arr == nil || arr.count <= 0)
    {
        return;
    }
    self.arr_Index = arr;
    for (NSInteger i = 0; i < self.arr_Index.count; i++) {
        indexCategory *category = [self.arr_Index objectAtIndex:i];
        switch (i)
        {
            case 0:
            {
                self.lab_Left.text = category.str_Name;
                break;
            }
            case 1:
            {
                self.lab_Mid.text = category.str_Name;
                break;
            }
            case 2:
            {
                self.lab_Right.text = category.str_Name;
                break;
            }
            default:
                break;
        }
    }
}
@end
