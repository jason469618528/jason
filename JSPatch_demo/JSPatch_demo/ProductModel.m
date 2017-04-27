//
//  ProductModel.m
//  JSPatch_demo
//
//  Created by huangjian on 17/2/10.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel 

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_productName forKey:@"ProductName"];
    [aCoder encodeFloat:_price forKey:@"Price"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        self.productName = [aDecoder decodeObjectForKey:@"ProductName"];
        self.price = [aDecoder decodeFloatForKey:@"Price"];
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    ProductModel *product = [[self class] allocWithZone:zone];
    if(product) {
        product.productName = self.productName;
        product.price = self.price;
    }
    return product;
}


@end
