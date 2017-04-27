//
//  HJBaseModel.m
//  JSPatch_demo
//
//  Created by huangjian on 17/2/10.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJBaseModel.h"
#import <objc/runtime.h>

@implementation HJBaseModel

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if(self = [super init]) {
        
        
        NSString *attrinName;
        while ((attrinName = [dictionary objectEnumerator])) {
            
        }
        
        
        
        
        ///存储属性的个数
        unsigned int propertyCount = 0;
        ///通过运行时获取当前类的属性
        objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
        //把属性放到数组中
        for (int i = 0; i < propertyCount; i ++) {
            ///取出第一个属性
            objc_property_t property = propertys[i];
            const char * propertyName = property_getName(property);
            NSLog(@"%s",propertyName);
        }
    }
    return self;
}



@end
