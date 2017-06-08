//
//  Student.m
//  JasonBlog
//
//  Created by huangjian on 17/5/15.
//  Copyright © 2017年 PanliMobile. All rights reserved.
//

#import "Student.h"

@implementation Student

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    Student *model = [[Student allocWithZone:zone] init];
    model.name = self.name;
    model.age = self.age;
    
    return model;
}

@end
