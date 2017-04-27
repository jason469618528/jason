//
//  ProductModel.h
//  JSPatch_demo
//
//  Created by huangjian on 17/2/10.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJBaseModel.h"

@interface ProductModel : HJBaseModel <NSCoding,NSCopying>

@property (nonatomic, strong) NSString *productName;

@property (nonatomic, assign) float price;

@end
