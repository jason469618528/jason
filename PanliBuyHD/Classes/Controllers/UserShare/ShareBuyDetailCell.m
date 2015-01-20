//
//  ShareBuyDetailCell.m
//  PanliApp
//
//  Created by jason on 13-12-16.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ShareBuyDetailCell.h"

#define BOTTOM_HEIGHT 20.0f
#define TOP_HEIGHT 33.0f
#define IMAGE_HEIGHT 50.0f
#define SHAREBUYDETAILCELL_COUNT 4
@implementation ShareBuyDetailCell
@synthesize m_ShareBuyDetail = _m_ShareBuyDetail;
@synthesize goToImageDelegate = _goToImageDelegate;
- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(_m_ShareBuyDetail);
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = PL_COLOR_CLEAR;
        //短信icon
        UIImageView *icon_Message = [[UIImageView alloc] initWithFrame:CGRectMake(26.0f, 16.0f, 11.5f, 10.0f)];
        icon_Message.image = [UIImage imageNamed:@"icon_ShareDetail_isMessage"];
        [self.contentView addSubview:icon_Message];
        [icon_Message release];
        
        //用户名称
        lab_NickName = [[UILabel alloc] initWithFrame:CGRectMake(46.0f, 12.0f, 200.0f, 20.0f)];
        lab_NickName.backgroundColor = PL_COLOR_CLEAR;
        lab_NickName.font = DEFAULT_FONT(14.0f);
        lab_NickName.textColor = [PanliHelper colorWithHexString:@"#7f5a5f"];
        lab_NickName.textAlignment = UITextAlignmentLeft;
        [self.contentView addSubview:lab_NickName];
        [lab_NickName release];
        
        //评论内容
        lab_Message = [[UILabel alloc] initWithFrame:CGRectMake(46.0f, 33.0f, 262.0f, 20.0f)];
        lab_Message.backgroundColor = PL_COLOR_CLEAR;
        lab_Message.numberOfLines = 0;
        lab_Message.font = DEFAULT_FONT(13.0f);
        lab_Message.textColor = [PanliHelper colorWithHexString:@"#979797"];
        lab_Message.textAlignment = UITextAlignmentLeft;
        [self.contentView addSubview:lab_Message];
        [lab_Message release];
        
        img_Line = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 135.0f, MainScreenFrame_Width, 1.0f)];
        img_Line.image = [UIImage imageNamed:@"bg_Message_ProductLine"];
        [self.contentView addSubview:img_Line];
        [img_Line release];
    }
    return self;
}

- (void)setDisplayData:(ShareBuyDetail*)mShareBuyDetail
{
    self.m_ShareBuyDetail = mShareBuyDetail;
    
    CGSize remarkSize = [mShareBuyDetail.message sizeWithFont:DEFAULT_FONT(13.0f) constrainedToSize:CGSizeMake(262.0f, 500.0f) lineBreakMode:NSLineBreakByCharWrapping];
    
    lab_Message.frame = CGRectMake(46.0f, 33.0f, remarkSize.width, remarkSize.height);
    
    for (UIView *view in self.contentView.subviews)
    {
        if([view isKindOfClass:[CustomUIButton class]])
        {
            [view removeFromSuperview];
        }
    }
    //排序算法
    if(mShareBuyDetail.pictureArray == nil || mShareBuyDetail.pictureArray.count <= 0)
    {
        img_Line.frame = CGRectMake(0.0f, lab_Message.frame.origin.y + lab_Message.frame.size.height + 9.0f, MainScreenFrame_Width, 1.0f);
    }
    else
    {
        NSInteger imageCount = 1;
        int subX = 26.0f;
        int subY = lab_Message.frame.origin.y + lab_Message.frame.size.height + 10.0f;
        int tempI= 0;
        
        if (mShareBuyDetail.pictureArray.count % SHAREBUYDETAILCELL_COUNT ==0)
        {
            imageCount = mShareBuyDetail.pictureArray.count / SHAREBUYDETAILCELL_COUNT;
        }
        else
        {
            imageCount = mShareBuyDetail.pictureArray.count / SHAREBUYDETAILCELL_COUNT + 1;
        }
        
        for (int i = 0 ; i < mShareBuyDetail.pictureArray.count; i ++)
        {
            CustomUIButton *btn_Image = [[CustomUIButton alloc] init];
            if(tempI % 4 == 0 && tempI > 0)
            {
                subX = 26.0f;
                tempI = 0;
                subY+= 60.0f;
            }
            btn_Image.frame = CGRectMake(subX + tempI * IMAGE_HEIGHT + tempI * 10.0f, subY, IMAGE_HEIGHT, IMAGE_HEIGHT);
//            [btn_Image setCustomImageWithURL:[mShareBuyDetail.pictureArray objectAtIndex:i] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"btn_ShareList_Product_None"]];
            [btn_Image setCustomImageWithURL:[mShareBuyDetail.pictureArray objectAtIndex:i] placeholderImage:[UIImage imageNamed:@"btn_ShareList_Product_None"]];
//            @autoreleasepool {
//                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[mShareBuyDetail.pictureArray objectAtIndex:i]]];
//                UIImage *img = [UIImage imageWithData:data];
//                [btn_Image setImage:img forState:UIControlStateNormal];
//            }
           
           
            btn_Image.tag = i;
            [btn_Image addTarget:self action:@selector(shareBuyDetailImageClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btn_Image];
            [btn_Image release];
            tempI ++;
        }
        img_Line.frame = CGRectMake(0.0f, lab_Message.frame.origin.y + lab_Message.frame.size.height + imageCount * IMAGE_HEIGHT + imageCount * 10.0f + 10.0f, MainScreenFrame_Width, 1.0f);
    }
    lab_NickName.text = mShareBuyDetail.nickname;
    lab_Message.text = mShareBuyDetail.message;
}

- (void)shareBuyDetailImageClick:(UIButton *)btn
{
    if(_goToImageDelegate != nil && [_goToImageDelegate respondsToSelector:@selector(shareBuyDetailGoToImage:ImageRow:)])
    {
        [_goToImageDelegate shareBuyDetailGoToImage:_m_ShareBuyDetail ImageRow:(int)btn.tag];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
