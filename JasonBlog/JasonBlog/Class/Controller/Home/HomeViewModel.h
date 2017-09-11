//
//  HomeViewModel.h
//  JasonBlog
//
//  Created by iyb-hj on 2017/8/7.
//  Copyright © 2017年 PanliMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeViewModel : NSObject

@property (nonatomic, strong, readonly) RACCommand *homeCommand;
@end
