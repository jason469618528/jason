//
//  OneCollectionViewCell.m
//  JSPatch_demo
//
//  Created by huangjian on 17/2/24.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "OneCollectionViewCell.h"

@implementation OneCollectionViewCell


- (void)awakeFromNib {
    NSLog(@"awakeFromNib");
    [super awakeFromNib];
}

- (void)prepareForReuse {
    NSLog(@"prepareForReuse");
}
@end
