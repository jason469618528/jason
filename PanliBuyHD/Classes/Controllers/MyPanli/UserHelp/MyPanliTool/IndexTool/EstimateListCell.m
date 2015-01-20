//
//  EstimateListCell.m
//  PanliApp
//
//  Created by jason on 13-5-13.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "EstimateListCell.h"

@implementation EstimateListCell

- (void) dealloc
{
    DLOG(@"%@ dealloc",[self class]);
    SAFE_RELEASE(lab_Name);
    SAFE_RELEASE(lab_Freight);
    SAFE_RELEASE(lab_ServerPrice);
    SAFE_RELEASE(lab_EntryPrice);
    SAFE_RELEASE(lab_SumPrice);
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = PL_COLOR_CLEAR;
        UIImageView * bg_Main = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_Esmate_Cell"]];
        bg_Main.frame = CGRectMake(10, 0, 301,137.5);
        [self.contentView addSubview:bg_Main];
        [bg_Main release];

                
        
        //运送名
        lab_Name = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 200, 17)];
        lab_Name.backgroundColor = PL_COLOR_CLEAR;
        lab_Name.textColor = PL_COLOR_WHITE;
        lab_Name.font = DEFAULT_FONT(15);
        [self.contentView addSubview:lab_Name];
        
     
        
        //运费
        UILabel *lab_FreightStr = [[UILabel alloc]initWithFrame:CGRectMake(45, 40, 200, 17)];
        lab_FreightStr.backgroundColor = PL_COLOR_CLEAR;
        lab_FreightStr.font = DEFAULT_FONT(16);
        lab_FreightStr.text = LocalizedString(@"EstimateListCell_labFreightStr",@"运费");
        [self.contentView addSubview:lab_FreightStr];
        [lab_FreightStr release];
        
        UILabel *lab_FreightM = [[UILabel alloc]initWithFrame:CGRectMake(35, 80, 200, 17)];
        lab_FreightM.backgroundColor = PL_COLOR_CLEAR;
        lab_FreightM.font = DEFAULT_FONT(15);
        lab_FreightM.text = @"￥";
        [self.contentView addSubview:lab_FreightM];
        [lab_FreightM release];
        
        lab_Freight = [[UILabel alloc]initWithFrame:CGRectMake(50, 80, 200, 17)];
        lab_Freight.backgroundColor = PL_COLOR_CLEAR;
        lab_Freight.font = DEFAULT_FONT(15);
        lab_Freight.textColor = [UIColor orangeColor];
        [self.contentView addSubview:lab_Freight];
        
        //服务费
        UILabel *lab_ServerPriceStr = [[UILabel alloc]initWithFrame:CGRectMake(135, 40, 200, 17)];
        lab_ServerPriceStr.backgroundColor = PL_COLOR_CLEAR;
        lab_ServerPriceStr.font = DEFAULT_FONT(16);
        lab_ServerPriceStr.text = LocalizedString(@"EstimateListCell_labServerPriceStr",@"服务费");
        [self.contentView addSubview:lab_ServerPriceStr];
        [lab_ServerPriceStr release];
        
        UILabel *lab_ServerM = [[UILabel alloc]initWithFrame:CGRectMake(140, 80, 200, 17)];
        lab_ServerM.backgroundColor = PL_COLOR_CLEAR;
        lab_ServerM.font = DEFAULT_FONT(15);
        lab_ServerM.text = @"￥";
        [self.contentView addSubview:lab_ServerM];
        [lab_ServerM release];
        
        
        lab_ServerPrice = [[UILabel alloc]initWithFrame:CGRectMake(155, 80, 200, 17)];
        lab_ServerPrice.backgroundColor = PL_COLOR_CLEAR;
        lab_ServerPrice.font = DEFAULT_FONT(15);
        lab_ServerPrice.textColor = [UIColor orangeColor];
        [self.contentView addSubview:lab_ServerPrice];
        
        //报关费
        UILabel *lab_EntryPriceStr = [[UILabel alloc]initWithFrame:CGRectMake(230, 40, 200, 17)];
        lab_EntryPriceStr.backgroundColor = PL_COLOR_CLEAR;
        lab_EntryPriceStr.font = DEFAULT_FONT(16);
        lab_EntryPriceStr.text = LocalizedString(@"EstimateListCell_labEntryPriceStr",@"报关费");
        [self.contentView addSubview:lab_EntryPriceStr];
        [lab_EntryPriceStr release];
        
        UILabel *lab_EntryM = [[UILabel alloc]initWithFrame:CGRectMake(240, 80, 200, 17)];
        lab_EntryM.backgroundColor = PL_COLOR_CLEAR;
        lab_EntryM.font = DEFAULT_FONT(15);
        lab_EntryM.text = @"￥";
        [self.contentView addSubview:lab_EntryM];
        [lab_EntryM release];
        
        lab_EntryPrice = [[UILabel alloc]initWithFrame:CGRectMake(255, 80, 200, 17)];
        lab_EntryPrice.backgroundColor = PL_COLOR_CLEAR;
        lab_EntryPrice.font = DEFAULT_FONT(15);
        lab_EntryPrice.textColor = [UIColor orangeColor];
        [self.contentView addSubview:lab_EntryPrice];
        
        //总费用
        UILabel *lab_SumPriceStr = [[UILabel alloc]initWithFrame:CGRectMake(25, 115, 200, 17)];
        lab_SumPriceStr.backgroundColor = PL_COLOR_CLEAR;
        lab_SumPriceStr.font = DEFAULT_FONT(13);
        lab_SumPriceStr.text = LocalizedString(@"EstimateListCell_labSumPriceStr",@"总计￥");
        [self.contentView addSubview:lab_SumPriceStr];
        [lab_SumPriceStr release];
        
        lab_SumPrice = [[UILabel alloc]initWithFrame:CGRectMake(100, 115, 200, 17)];
        lab_SumPrice.backgroundColor = PL_COLOR_CLEAR;
        lab_SumPrice.font = DEFAULT_FONT(15);
        lab_SumPrice.textColor = [UIColor orangeColor];
        [self.contentView addSubview:lab_SumPrice];
    }
    return self;
}

-(void)SetData:(SendType*)mObject productPrice:(float)productPrice
{
    lab_Name.text = mObject.deliveryName;
    float server = 0.0f;
    
    float temp = mObject.shipPrice + mObject.entryPrice;
    server = (productPrice + temp) * 0.1;
    
    lab_Freight.text = [NSString stringWithFormat:@"%.1f", mObject.shipPrice];
    lab_EntryPrice.text = [NSString stringWithFormat:@"%.0f", mObject.entryPrice];
    lab_ServerPrice.text = [NSString stringWithFormat:@"%.2f", server];
    lab_SumPrice.text = [NSString stringWithFormat:@"%.2f", mObject.sumPrice];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
