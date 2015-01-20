//
//  PushNotificationCell.h
//  PanliBuyHD
//
//  Created by ZhaoFucheng on 14-10-27.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PushNotificationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img_icon;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UISwitch *swt_isReceive;

@property (nonatomic, strong) NSMutableDictionary *dic_dataSource;

- (void)setDataWithDictionary:(NSMutableDictionary *)dic;

- (IBAction)switchAction:(id)sender;
@end
