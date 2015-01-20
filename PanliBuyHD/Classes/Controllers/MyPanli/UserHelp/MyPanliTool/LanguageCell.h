//
//  LanguageCell.h
//  PanliBuyHD
//
//  Created by ZhaoFucheng on 14-11-3.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LanguageCell : UITableViewCell
{
    BOOL    _isPatch;
}
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgPatch;

@property (nonatomic, assign) BOOL isPatch; //控制是否打钩

@end
