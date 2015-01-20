//
//  CustomerSkusView.m
//  PanliApp
//
//  Created by Liubin on 13-6-20.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "CustomerSkusView.h"

#define LABLE_HEIGHT  17.0f
#define BUTTON_HEIGHT 25.0f
#define MARGIN 7.0f
@implementation CustomerSkusView

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
}

- (id)initWithFrame:(CGRect)frame skus:(NSArray *)skuArr skuCombinations:(NSArray *)skuCombinations
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        self.backgroundColor = PL_COLOR_CLEAR;
        
        self.mArr_skus = skuArr;
        self.mArr_skuCombinations = skuCombinations;
        
        //款式分类
        mArr_skuType = [NSMutableArray new];
        for (SkuObject *sku in self.mArr_skus)
        {
            NSString *typeName = sku.typeName;
            if (![mArr_skuType containsObject:typeName])
            {
                [mArr_skuType addObject:typeName];
                
            }
        }
        
        //button数组列表
        mArr_propertyBtns = [NSMutableArray new];
        
        //存放选中SkuId的数组
        mArr_selectSkuIds = [[NSMutableArray alloc] init];
        
        
        //坐标
        float x = 10.0f;
        float y = 0.0f;
        
        //按钮默认背景
        img_propertyBtnBackground = [UIImage imageNamed:@"btn_style_unSelected"];
        img_propertyBtnBackground = [img_propertyBtnBackground stretchableImageWithLeftCapWidth:floorf(img_propertyBtnBackground.size.width/2) topCapHeight:floorf(img_propertyBtnBackground.size.height/2)];
        
        //按钮选中背景
        img_propertyBtnSelectBackground = [UIImage imageNamed:@"btn_style_selected"];
        img_propertyBtnSelectBackground = [img_propertyBtnSelectBackground stretchableImageWithLeftCapWidth:floorf(img_propertyBtnSelectBackground.size.width/2) topCapHeight:floorf(img_propertyBtnSelectBackground.size.height/2)];
    
        for (NSString *typeName in mArr_skuType)
        {
            //存放分类下属性按钮数组
            NSMutableArray *buttonArr = [[NSMutableArray alloc] init];
            
            //计算属性名长度
            CGSize maxSize = CGSizeMake(300.0, LABLE_HEIGHT);
            CGSize typeSize = [typeName sizeWithFont:DEFAULT_FONT(16) constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
            
            //分类名
            UILabel *lab_typeName = [[UILabel alloc] initWithFrame:CGRectMake(x, y, typeSize.width, LABLE_HEIGHT)];
            lab_typeName.numberOfLines = 1;
            lab_typeName.lineBreakMode = NSLineBreakByCharWrapping;
            lab_typeName.textColor = [PanliHelper colorWithHexString:@"#717171"];
            lab_typeName.font = DEFAULT_FONT(16);
            lab_typeName.backgroundColor = PL_COLOR_CLEAR;
            lab_typeName.text = typeName;
            [self addSubview:lab_typeName];
            //计算坐标
            y = y + LABLE_HEIGHT + MARGIN;
            
            //分类下的款式按钮
            NSArray *skuArray = [_mArr_skus filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.typeName = %@",typeName]];
            for (SkuObject *sku in skuArray)
            {
                //计算属性名长度
                NSString *propertyName = sku.propertyName;
                CGSize maxSize = CGSizeMake(300, BUTTON_HEIGHT);
                CGSize protertySize = [propertyName sizeWithFont:DEFAULT_FONT(16) constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
                protertySize.width = protertySize.width > 55 ? protertySize.width + 25 : 75;
                //判断是否需要换行
                if (x + protertySize.width > 300 - 5)
                {
                    x = 10.0f;
                    y = y + BUTTON_HEIGHT + MARGIN;
                    
                }
                //按钮实现
                UIButton *btn_property = [UIButton buttonWithType:UIButtonTypeCustom];
                btn_property.frame = CGRectMake(x, y, protertySize.width, BUTTON_HEIGHT);
                [btn_property setBackgroundImage:img_propertyBtnBackground forState:UIControlStateNormal];
                [btn_property setBackgroundImage:img_propertyBtnSelectBackground forState:UIControlStateHighlighted];
                [btn_property setBackgroundImage:img_propertyBtnSelectBackground forState:UIControlStateSelected];
                [btn_property setBackgroundColor:PL_COLOR_CLEAR];
                btn_property.titleLabel.font = DEFAULT_FONT(16);
                [btn_property setTitle:propertyName forState:UIControlStateNormal];
                [btn_property setTitleColor:[PanliHelper colorWithHexString:@"#4F4F4F"] forState:UIControlStateNormal];
                [btn_property setTitleColor:[PanliHelper colorWithHexString:@"#51A500"] forState:UIControlStateSelected];
                [btn_property setTag:[sku.skuId intValue]];
                [btn_property addTarget:self action:@selector(propertyClick:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn_property];
                //计算下一个按钮的起始坐标
                x = x + protertySize.width + MARGIN;
                //将按钮放入数组
                [buttonArr addObject:btn_property];
            }
            
            //按钮数组
            [mArr_propertyBtns addObject:buttonArr];
            //计算坐标
            x = 10.0f;
            y = y + BUTTON_HEIGHT + MARGIN*2;
        }
        if (y > 10)
        {
            y += MARGIN*2;
        }
        //重进计算frame
        CGRect frame = self.frame;
        frame.size.height = y;
        self.frame = frame;
    }
    return self;
}

/**
 * 功能描述: 款式选择
 * 输入参数: 款式按钮
 * 返 回 值: N/A
 */
- (void)propertyClick:(id)sender;
{
    UIButton *button  = (UIButton *)sender;
    NSString *tag = [NSString stringWithFormat:@"%ld",(long)button.tag];
    //正选
    if (![mArr_selectSkuIds containsObject:tag])
    {
        //修改按钮的背景和字体
        [button setBackgroundImage:img_propertyBtnSelectBackground forState:UIControlStateNormal];
        [button setTitleColor:[PanliHelper colorWithHexString:@"#51A500"] forState:UIControlStateNormal];
        //添加到已选skuid
        [mArr_selectSkuIds addObject:[NSString stringWithFormat:@"%ld",(long)button.tag]];
        
        //筛选相同分类下的按钮
        NSArray *sameTypeBtnArray = [mArr_propertyBtns filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains %@",button]];

        sameTypeBtnArray = [sameTypeBtnArray objectAtIndex:0];
        for (UIButton *btn in sameTypeBtnArray)
        {
            if (btn != button)
            {
                [btn setBackgroundImage:img_propertyBtnBackground forState:UIControlStateNormal];
                [btn setTitleColor:[PanliHelper colorWithHexString:@"#4F4F4F"] forState:UIControlStateNormal];
                //将同组其他的skuid移出选中数组
                if ([mArr_selectSkuIds containsObject:[NSString stringWithFormat:@"%ld",(long)btn.tag]])
                {
                    [mArr_selectSkuIds removeObject:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
                }
            }
        }
        
    }
    //反选
    else
    {
        if ([mArr_selectSkuIds containsObject:[NSString stringWithFormat:@"%ld",(long)button.tag]])
        {
            [mArr_selectSkuIds removeObject:[NSString stringWithFormat:@"%ld",(long)button.tag]];
            //修改按钮的背景和字体
            [button setBackgroundImage:img_propertyBtnBackground forState:UIControlStateNormal];
            [button setTitleColor:[PanliHelper colorWithHexString:@"#4F4F4F"] forState:UIControlStateNormal];
        }
    }

    if (self.skuDelegate && [self.skuDelegate respondsToSelector:@selector(skuCombinationDidChange:)])
    {
        selectSkuCombination = nil;
        for (SkuCombination *mSkuCombinatin in self.mArr_skuCombinations)
        {
            if (mSkuCombinatin.skuIds.count == mArr_selectSkuIds.count)
            {
                BOOL isContains = YES;
                for (NSString *skuid in mArr_selectSkuIds)
                {
                    if (![mSkuCombinatin.skuIds containsObject:skuid])
                    {
                        isContains = NO;
                        break;
                    }
                }
                if (isContains)
                {
                    selectSkuCombination = mSkuCombinatin;
                    break;
                }
            }
        }
        [self.skuDelegate skuCombinationDidChange:selectSkuCombination];
    }
    
    //更改图片
    if(self.skuDelegate && [self.skuDelegate respondsToSelector:@selector(updateSelectSkuImageView:)])
    {
        for (SkuObject *sku in self.mArr_skus)
        {
            if ([tag isEqual:sku.skuId])
            {
                [self.skuDelegate updateSelectSkuImageView:sku];
                break;
            }
        }
    }
}

@end
