//
//  Student.h
//  JasonBlog
//
//  Created by huangjian on 17/5/15.
//  Copyright © 2017年 PanliMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject <NSCopying, NSCoding>

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSInteger age;

@end
