//
//  CustomerPageControl.m
//  GuideDemo
//
//  Created by liubin on 13-4-17.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "CustomerPageControl.h"

@implementation CustomerPageControl

@synthesize selectedImage = _selectedImage;
@synthesize unSelectedImage = _unSelectedImage;
@synthesize selectColor = _selectColor;
@synthesize unSelectColor = _unSelectColor;
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_selectedImage);
    SAFE_RELEASE(_unSelectedImage);
    SAFE_RELEASE(_selectColor);
    SAFE_RELEASE(_unSelectColor);
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame selectImage:(NSString *)selectImage unSelectImage:(NSString *) unSelectImage selectColor:(UIColor*)selectColor unSelectColor:(UIColor*)unSelectColor
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.selectedImage = selectImage;
        self.unSelectedImage = unSelectImage;
        self.selectColor = selectColor;
        self.unSelectColor = unSelectColor;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

/**
 * 功能描述: 重绘页码图片
 * 输入参数: N/A
 * 返 回 值: N/A
 */
- (void)updateDots
{    
    for(int i = 0; i< [self.subviews count]; i++)
    {
        UIImageView *dot = [self.subviews objectAtIndex:i];
        //适配7.0 --modify by liubin
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            if (i == self.currentPage)
            {
//                [dot setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:self.selectedImage]]];
//                [dot setBackgroundColor:[PanliHelper colorWithHexString:@"#f3f3f3"]];
                [dot setBackgroundColor:self.selectColor];
            }
            else
            {
//                [dot setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:self.unSelectedImage]]];
//                [dot setBackgroundColor:[PanliHelper colorWithHexString:@"#459d00"]];
                [dot setBackgroundColor:self.unSelectColor];
            }
        }
        else
        {
            if(i == self.currentPage)
            {
                dot.image = [UIImage imageNamed:_selectedImage];
            }
            else
            {
                dot.image = [UIImage imageNamed:_unSelectedImage];
            }
        }
    }
    
}

- (void)setCurrentPage:(NSInteger)currentPage
{    
    [super setCurrentPage:currentPage];    
    [self updateDots];    
}

@end
