//
//  PushNotificationCell.m
//  PanliBuyHD
//
//  Created by ZhaoFucheng on 14-10-27.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "PushNotificationCell.h"

@implementation PushNotificationCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setDataWithDictionary:(NSMutableDictionary *)dic
{
    self.dic_dataSource = dic;
    NSInteger tag = [[dic objectForKey:@"id"] integerValue];
    UIImage *image = [UIImage imageNamed:[dic objectForKey:@"imageName"]];
    NSString *title = [dic objectForKey:@"title"];
    BOOL isReceive = [[dic valueForKey:@"isReceive"] boolValue];
    
    
    [self.img_icon setImage:image];
    self.lab_title.text = title;
    
    self.swt_isReceive.tag = tag;
    [self.swt_isReceive setOn:isReceive animated:YES];
}

- (IBAction)switchAction:(id)sender {
    UISwitch *swt = (UISwitch *)sender;
    [self.dic_dataSource setValue:[NSNumber numberWithBool:swt.isOn] forKey:@"isReceive"];
}

@end
