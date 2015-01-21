//
//  UserProduct.m
//  PanliApp
//
//  Created by jason on 13-4-15.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "UserProduct.h"

@implementation UserProduct
@synthesize userProductStatus = _userProductStatus;
@synthesize count = _count;
@synthesize weight = _weight;
@synthesize weightDate = _weightDate;
@synthesize remark = _remark;
@synthesize userProductId = _userProductId;
@synthesize isGroup = _isGroup;
@synthesize isPiece = _isPiece;
@synthesize isGift = _isGift;
@synthesize isForbidden = _isForbidden;
@synthesize isLightOverWeight = _isLightOverWeight;
@synthesize isHeavyOverWeight = _isHeavyOverWeight;
@synthesize canReturns = _canReturns;
@synthesize canDeliver = _canDeliver;
@synthesize isYellovWarning = _isYellowWarning;
@synthesize isRedWarning = _isRedWarning;
@synthesize expressUrl = _expressUrl;
@synthesize expressNo = _expressNo;
@synthesize status = _status;
@synthesize sendMessageId = _sendMessageId;
@synthesize orderDate = _orderDate;
@synthesize skuRemark = _skuRemark;
@synthesize haveUnreadMessage = _haveUnreadMessage;
@synthesize isSelected = _isSelected;

/**
 *序列化
 */
//- (void) encodeWithCoder:(NSCoder *)aCoder
//{
//    [super encodeWithCoder:aCoder];
//    [aCoder encodeInt:_userProductId forKey:@"UserProductId"];
//    [aCoder encodeInt:_count forKey:@"Count"];
//    [aCoder encodeInt:_weight forKey:@"Weight"];
//    [aCoder encodeObject:_weightDate forKey:@"WeightDate"];
//    [aCoder encodeObject:_remark forKey:@"Remark"];
//    [aCoder encodeInt:_userProductStatus forKey:@"UserProductStatus"];
//    [aCoder encodeBool:_isGroup forKey:@"IsGroup"];
//    [aCoder encodeBool:_isPiece forKey:@"IsPiece"];
//    [aCoder encodeBool:_isForbidden forKey:@"IsForbidden"];
//    [aCoder encodeBool:_isLightOverWeight forKey:@"IsLightOverweight"];
//    [aCoder encodeBool:_isHeavyOverWeight forKey:@"IsHeavyOverweight"];
//    [aCoder encodeBool:_canReturns forKey:@"CanReturns"];
//    [aCoder encodeBool:_canDeliver forKey:@"CanDeliver"];
//    [aCoder encodeBool:_isYellowWarning forKey:@"IsYellowWarning"];
//    [aCoder encodeBool:_isRedWarning forKey:@"IsRedWarning"];
//    [aCoder encodeObject:_expressUrl forKey:@"ExpressUrl"];
//    [aCoder encodeObject:_expressNo forKey:@"ExpressNo"];
//    [aCoder encodeInt:_status forKey:@"Status"];
//    [aCoder encodeObject:_sendMessageId forKey:@"SendMessageId"];
//    [aCoder encodeObject:_orderDate forKey:@"OrderDate"];
//    [aCoder encodeObject:_skuRemark forKey:@"SkuRemark"];
//    [aCoder encodeBool:_haveUnreadMessage forKey:@"HaveUnreadMessage"];
//}
//
///**
// *反序列化
// */
//- (id) initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super initWithCoder:aDecoder])
//    {
//        self.userProductId     = [aDecoder decodeIntForKey:@"UserProductId"];
//        self.count             = [aDecoder decodeIntForKey:@"Count"];
//        self.weight            = [aDecoder decodeIntForKey:@"Weight"];
//        self.weightDate        = [aDecoder decodeObjectForKey:@"WeightDate"];
//        self.remark            = [aDecoder decodeObjectForKey:@"Remark"];
//        self.userProductStatus = [aDecoder decodeIntForKey:@"UserProductStatus"];
//        self.isGroup           = [aDecoder decodeBoolForKey:@"IsGroup"];
//        self.isPiece           = [aDecoder decodeBoolForKey:@"IsPiece"];
//        self.isForbidden       = [aDecoder decodeBoolForKey:@"IsForbidden"];
//        self.isLightOverWeight = [aDecoder decodeBoolForKey:@"IsLightOverweight"];
//        self.isHeavyOverWeight = [aDecoder decodeBoolForKey:@"IsHeavyOverweight"];
//        self.canReturns        = [aDecoder decodeBoolForKey:@"CanReturns"];
//        self.canDeliver        = [aDecoder decodeBoolForKey:@"CanDeliver"];
//        self.isYellovWarning   = [aDecoder decodeBoolForKey:@"IsYellowWarning"];
//        self.isRedWarning      = [aDecoder decodeBoolForKey:@"IsRedWarning"];
//        self.expressUrl        = [aDecoder decodeObjectForKey:@"ExpressUrl"];
//        self.expressNo         = [aDecoder decodeObjectForKey:@"ExpressNo"];
//        self.status            = [aDecoder decodeIntForKey:@"Status"];
//        self.sendMessageId     = [aDecoder decodeObjectForKey:@"SendMessageId"];
//        self.orderDate         = [aDecoder decodeObjectForKey:@"OrderDate"];
//        self.skuRemark         = [aDecoder decodeObjectForKey:@"SkuRemark"];
//        self.haveUnreadMessage         = [aDecoder decodeBoolForKey:@"HaveUnreadMessage"];
//    }
//    return self;
//}

-(void)dealloc
{
    DLOG(@"%@ dealloc",[self class]);
}

@end
