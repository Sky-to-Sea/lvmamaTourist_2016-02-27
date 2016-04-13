//
//  limitedShoppinigModel.m
//  lvmamaTourist
//
//  Created by Earth on 16/1/6.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "limitedShoppinigModel.h"
#import "MJExtension.h"

@interface limitedShoppinigModel ()



@end

@implementation limitedShoppinigModel

- (limitedShoppinigModel *)analizeDictToModel:(NSDictionary *)dict
{
    limitedShoppinigModel *model = [[limitedShoppinigModel alloc]init];
    
    model.object_id     = dict[@"object_id"];
    model.title         = dict[@"title"];
    model.type          = dict[@"type"];
    model.market_price  = dict[@"market_price"];
    model.price         = dict[@"price"];
    model.large_image   = dict[@"large_image"];
    model.buyCount      = dict[@"buyCount"];
    model.end_time      = dict[@"end_time"];
    model.groupSiteId   = dict[@"groupSiteId"];
    model.sub_object_id = dict[@"sub_object_id"];
    model.branchType    = dict[@"branchType"];
    model.productType   = dict[@"productType"];
    model.productType2  = dict[@"productType2"];
    model.left_time     = dict[@"left_time"];
    model.secKillStatus = dict[@"secKillStatus"];
    model.pindao        = dict[@"pindao"];
    
    return model;
}



@end
