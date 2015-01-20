//
//  ProductCell.m
//  PanliApp
//
//  Created by Liubin on 13-4-24.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "ProductCell.h"
#import <QuartzCore/QuartzCore.h>
#define STATE_IMAGE_HEIGHT 28
@implementation ProductCell

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(mUserProduct);
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = PL_COLOR_CLEAR;
        //商品缩略图
        img_Product = [[CustomUIImageView alloc] initWithFrame:CGRectMake(10, 10, 58, 58)];
        img_Product.layer.cornerRadius = 6.0f;
        img_Product.layer.masksToBounds = YES;
        img_Product.layer.borderColor = [PanliHelper colorWithHexString:@"#c1c1c1"].CGColor;
        img_Product.layer.borderWidth = 0.5f;
		[self.contentView addSubview:img_Product];
        [img_Product release];
        
        //商品名称
        lab_ProductName = [[UILabel alloc] initWithFrame:CGRectMake(76.0f, 12.0f, 145.0f, 14)];
        lab_ProductName.numberOfLines = 1;
        lab_ProductName.textColor = [PanliHelper colorWithHexString:@"#4e4e4f"];
        lab_ProductName.font = DEFAULT_FONT(14);
        lab_ProductName.backgroundColor = PL_COLOR_CLEAR;
        [self addSubview:lab_ProductName];
        [lab_ProductName release];
        
        //商品价格
        lab_ProductPrice = [[UILabel alloc] initWithFrame:CGRectMake(190.0f, 10.0f, 100, 20)];
        lab_ProductPrice.textColor = [PanliHelper colorWithHexString:@"#fe6902"];
        lab_ProductPrice.font = DEFAULT_FONT(15);
        lab_ProductPrice.backgroundColor = PL_COLOR_CLEAR;
        [self addSubview:lab_ProductPrice];
        [lab_ProductPrice release];

               
        //商品数量
        lab_ProductCount = [[UILabel alloc]initWithFrame:CGRectMake(190, STATE_IMAGE_HEIGHT + 1, 100, 20)];
        lab_ProductCount.textColor = [PanliHelper colorWithHexString:@"#9a9a9b"];
        lab_ProductCount.backgroundColor = PL_COLOR_CLEAR;
        lab_ProductCount.font = DEFAULT_FONT(12);
        [self addSubview:lab_ProductCount];
        [lab_ProductCount release];
        
        //商品标识
        img_ProductType =  [[UIImageView alloc]initWithFrame:CGRectMake(38, 38, 30, 30)];
        [self addSubview:img_ProductType];
        [img_ProductType release];

        
        //敏感商品标识
        img_Forrbidden = [[UIImageView alloc]initWithFrame:CGRectMake(105, 70, 20, 20)];
        [self addSubview:img_Forrbidden];
        [img_Forrbidden release];
        
        //超重商品标识
        img_Weight = [[UIImageView alloc]initWithFrame:CGRectMake(105, 70, 20, 20)];
        [self addSubview:img_Weight];
        [img_Weight release];
        
        //商品状态
        img_ProductState = [[UIImageView alloc]init];
        [self addSubview:img_ProductState];
        [img_ProductState release];
        
        //商品数量
        lab_SkuRemark = [[UILabel alloc]initWithFrame:CGRectMake(76.0f, 55.0f, MainScreenFrame_Width - 98, 14)];
        lab_SkuRemark.textColor = [PanliHelper colorWithHexString:@"#9a9a9b"];
        lab_SkuRemark.backgroundColor = PL_COLOR_CLEAR;
        lab_SkuRemark.font = DEFAULT_FONT(14);
        lab_SkuRemark.numberOfLines = 0;
        [self addSubview:lab_SkuRemark];
        [lab_SkuRemark release];
        
        btn_isNewMessage = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_isNewMessage.frame = CGRectMake(MainScreenFrame_Width - 29.5, 0.0f, 41.0f, 41.0f);
        [btn_isNewMessage setImage:[UIImage imageNamed:@"icon_Common_newMessage"] forState:UIControlStateNormal];
        btn_isNewMessage.hidden = YES;
        [btn_isNewMessage addTarget:self action:@selector(SendMessagesClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn_isNewMessage];
    }
    return self;
}


- (void)setOrderDate:(UserProduct *)data withType:(OrderDisState)OrderState isFullWidth:(BOOL)fullWidthFlag isShipOrder:(BOOL)isShipOrders
{
    //全屏宽度
    if (fullWidthFlag)
    {
        
        mUserProduct = [data retain];
        
        [self getStatus:OrderState];
        
        lab_ProductPrice.textAlignment = UITextAlignmentRight;
        lab_ProductCount.textAlignment = UITextAlignmentRight;
        
        CGFloat x = 76.0f + img_ProductState.frame.size.width;
        //敏感商品
        if (data.isForbidden)
        {
            [img_Forrbidden setImage:[UIImage imageNamed:@"icon_OrderState_forbindden"]];
            img_Forrbidden.frame = CGRectMake(x, STATE_IMAGE_HEIGHT + 1, 20, 20);
            x += 21;
        }
        else
        {
            [img_Forrbidden setImage:[UIImage imageNamed:@""]];
        }
        //超重商品
        if (data.isLightOverWeight || data.isHeavyOverWeight)
        {
            [img_Weight setImage:[UIImage imageNamed:@"icon_OrderState_weight"]];
            img_Weight.frame = CGRectMake(x, STATE_IMAGE_HEIGHT + 1, 20, 20);
            x+= 21;
        }
        else
        {
            [img_Weight setImage:[UIImage imageNamed:@""]];
        }       
        //团购
        if (data.isGroup)
        {
            [img_ProductType setImage:[UIImage imageNamed:@"icon_OrderState_group"]];
        }
        //拼单购
        else if (data.isPiece)
        {
            [img_ProductType setImage:[UIImage imageNamed:@"icon_OrderState_piece"]];
        }
        //赠品
        else if (data.isGift)
        {
            [img_ProductType setImage:[UIImage imageNamed:@"icon_OrderState_gift"]];
        }
        else
        {
            [img_ProductType setImage:[UIImage imageNamed:@""]];
        }
        
        btn_isNewMessage.frame = CGRectMake(x, STATE_IMAGE_HEIGHT - 5, 41.0f, 41.0f);
        //判断是否有新短信
        if(data.haveUnreadMessage)
        {
            btn_isNewMessage.hidden = NO;
        }
        else
        {
            btn_isNewMessage.hidden = YES;
        }
        
        [img_Product setCustomImageWithURL:[NSURL URLWithString:data.thumbnail]
                          placeholderImage:[UIImage imageNamed:@"icon_product"]];
        
       CGSize skuSize = [data.skuRemark sizeWithFont:DEFAULT_FONT(14) constrainedToSize:CGSizeMake(MainScreenFrame_Width - 98, 500.0f) lineBreakMode:NSLineBreakByCharWrapping];
        lab_SkuRemark.frame = CGRectMake(76.0f, 53.0f, skuSize.width,skuSize.height);
        lab_SkuRemark.text = data.skuRemark;
        
        lab_ProductName.text = data.productName;
        lab_ProductPrice.text = [NSString stringWithFormat:@"￥%.2f",data.price];
        lab_ProductCount.text = OrderState == Inpanli ? [NSString stringWithFormat:LocalizedString(@"ProductCell_labProductCount",@"x%d(%d克)"),data.count,data.weight] : [NSString stringWithFormat:@"x%d",data.count];
    }
    //运单详情商品显示
    else if(isShipOrders)
    {
        lab_ProductName.frame = CGRectMake(76, 10.0f, MainScreenFrame_Width - 98, 20.0f);
        lab_ProductName.font = DEFAULT_FONT(15);
    
        CGFloat x = 76.0f;
        //敏感商品
        if (data.isForbidden)
        {
            [img_Forrbidden setImage:[UIImage imageNamed:@"icon_OrderState_forbindden"]];
            img_Forrbidden.frame = CGRectMake(x, STATE_IMAGE_HEIGHT + 1, 20, 20);
            x += 21;
        }
        else
        {
            [img_Forrbidden setImage:[UIImage imageNamed:@""]];
        }
        //超重商品
        if (data.isLightOverWeight || data.isHeavyOverWeight)
        {
            [img_Weight setImage:[UIImage imageNamed:@"icon_OrderState_weight"]];
            img_Weight.frame = CGRectMake(x, STATE_IMAGE_HEIGHT + 1, 20, 20);
            x += 21;
        }
        else
        {
            [img_Weight setImage:[UIImage imageNamed:@""]];
        }
        
        NSString *str_Price = [NSString stringWithFormat:@"%.2f",data.price];
        CGSize priceSize = [str_Price sizeWithFont:DEFAULT_FONT(14) constrainedToSize:CGSizeMake(100.0f, 20.0f) lineBreakMode:NSLineBreakByCharWrapping];
        lab_ProductPrice.frame = CGRectMake(x, 29, 100, 20);
        lab_ProductCount.frame = CGRectMake(x + priceSize.width + 30, 29, 100, 20);
        
        //团购
        if (data.isGroup)
        {
            [img_ProductType setImage:[UIImage imageNamed:@"icon_OrderState_group"]];
        }
        //拼单购
        else if (data.isPiece)
        {
            [img_ProductType setImage:[UIImage imageNamed:@"icon_OrderState_piece"]];
        }
        //赠品
        else if (data.isGift)
        {
            [img_ProductType setImage:[UIImage imageNamed:@"icon_OrderState_gift"]];
        }
        else
        {
            [img_ProductType setImage:[UIImage imageNamed:@""]];
        }
        
        [img_Product setCustomImageWithURL:[NSURL URLWithString:data.thumbnail]
                          placeholderImage:[UIImage imageNamed:@"icon_product"]];
        
        CGSize skuSize = [data.skuRemark sizeWithFont:DEFAULT_FONT(14) constrainedToSize:CGSizeMake(MainScreenFrame_Width - 98, 500.0f) lineBreakMode:NSLineBreakByCharWrapping];
        lab_SkuRemark.frame = CGRectMake(76.0f, 53.0f, skuSize.width,skuSize.height);
        lab_SkuRemark.text = data.skuRemark;
        
        lab_ProductName.text = data.productName;
        lab_ProductPrice.text = [NSString stringWithFormat:@"￥%.2f",data.price];
        lab_ProductCount.text = OrderState == Inpanli ? [NSString stringWithFormat:LocalizedString(@"ProductCell_labProductCount",@"x%d(%d克)"),data.count,data.weight] : [NSString stringWithFormat:@"x%d",data.count];
    }
     //确认运送方式中的cell
    else
    {
        img_Product.frame = CGRectMake(10, 10, 50, 50);
        lab_ProductName.frame = CGRectMake(70, 10, 170, 30);
        lab_ProductName.font = DEFAULT_FONT(13);
        lab_ProductCount.font = DEFAULT_FONT(14);
        lab_ProductPrice.font = DEFAULT_FONT(14);
        img_ProductType.frame =  CGRectMake(40, 40, 20, 20);
    
        CGFloat x = 70.0f;
        //敏感商品
        if (data.isForbidden)
        {
            [img_Forrbidden setImage:[UIImage imageNamed:@"icon_OrderState_forbindden"]];
            img_Forrbidden.frame = CGRectMake(x, 42, 16, 16);
            x += 17;
        }
        else
        {
            [img_Forrbidden setImage:[UIImage imageNamed:@""]];
        }
        //超重商品
        if (data.isLightOverWeight || data.isHeavyOverWeight)
        {
            [img_Weight setImage:[UIImage imageNamed:@"icon_OrderState_weight"]];
            img_Weight.frame = CGRectMake(x, 42, 16, 16);
            x += 17;
        }
        else
        {
            [img_Weight setImage:[UIImage imageNamed:@""]];
        }
        NSString *str_Price = [NSString stringWithFormat:@"%.2f",data.price];
        CGSize priceSize = [str_Price sizeWithFont:DEFAULT_FONT(14) constrainedToSize:CGSizeMake(100.0f, 20.0f) lineBreakMode:NSLineBreakByCharWrapping];
        lab_ProductPrice.frame = CGRectMake(x, 40, 100, 20);
        lab_ProductCount.frame = CGRectMake(x + priceSize.width + 15, 40, 100, 20);
        //团购
        if (data.isGroup)
        {
            [img_ProductType setImage:[UIImage imageNamed:@"icon_OrderState_group"]];
        }
        //拼单购
        else if (data.isPiece)
        {
            [img_ProductType setImage:[UIImage imageNamed:@"icon_OrderState_piece"]];
        }
        //赠品
        else if (data.isGift)
        {
            [img_ProductType setImage:[UIImage imageNamed:@"icon_OrderState_gift"]];
        }
        else
        {
            [img_ProductType setImage:[UIImage imageNamed:@""]];
        }
        
        [img_Product setCustomImageWithURL:[NSURL URLWithString:data.thumbnail]
                          placeholderImage:[UIImage imageNamed:@"icon_product"]];
        
        lab_ProductName.text = data.productName;
        lab_ProductPrice.text = [NSString stringWithFormat:@"￥%.2f",data.price];
        lab_ProductPrice.textColor = [PanliHelper colorWithHexString:@"#9a9a9b"];
        lab_ProductCount.text = [NSString stringWithFormat:LocalizedString(@"ProductCell_labProductCount",@"x%d(%d克)"),data.count,data.weight];
    }
}
- (void)getStatus:(int)status
{
    UIImage *imageStatus = nil;
    switch (status)
    {
        case YetDGOrder:
        {
            imageStatus = [UIImage imageNamed:@"icon_Product_YetDg"];
            break;
        }
        case Inpanli:
        {
            imageStatus = [UIImage imageNamed:@"icon_Product_InPanli"];
            break;
        }
        case IssueOrder:
        {
            imageStatus = [UIImage imageNamed:@"icon_Product_Issue"];
            break;
        }
        case UntreatedOrder:
        {
            imageStatus = [UIImage imageNamed:@"icon_Product_Untreated"];
            break;
        }
        case Inhand:
        {
            imageStatus = [UIImage imageNamed:@"icon_Product_Inhand"];
            break;
        }
        case InvalidOrder:
        {
            imageStatus = [UIImage imageNamed:@"icon_Product_Invalid"];
            break;
        }
        default:
        {
            imageStatus = [UIImage imageNamed:@"icon_Product_Invalid"];
            break;
        }
    }
    img_ProductState.frame = CGRectMake(76.0f, STATE_IMAGE_HEIGHT, imageStatus.size.width, imageStatus.size.height);
    img_ProductState.image = imageStatus;
    btn_isNewMessage.frame = CGRectMake(img_ProductState.frame.origin.x + imageStatus.size.width, STATE_IMAGE_HEIGHT - 8.0f, 41.0f, 41.0f);
}

//发送短信
- (void)SendMessagesClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PRODUCTLIST_SENDMESSAGE" object:mUserProduct];
}

@end
