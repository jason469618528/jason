//
//  InternationalViewController.h
//  PanliBuyHD
//
//  Created by ZhaoFucheng on 14-11-3.
//  Copyright (c) 2014年 Panli. All rights reserved.
//

#import "BaseViewController.h"

@interface InternationalViewController : BaseViewController
{
    NSArray *languageList;  //语言数据
}
@property (weak, nonatomic) IBOutlet UITableView *languageTab;  //语言列表
@end
