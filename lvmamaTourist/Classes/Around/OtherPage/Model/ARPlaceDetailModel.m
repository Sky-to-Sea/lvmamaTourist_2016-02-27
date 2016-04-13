//
//  ARPlaceDetailModel.m
//  lvmamaTourist
//
//  Created by Earth on 16/2/24.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "ARPlaceDetailModel.h"
#import "MJExtension.h"

@implementation ARPlaceDetailModel

+ (ARPlaceDetailModel *)analizeDictionaryToModel:(NSDictionary *)dict
{
    ARPlaceDetailModel *model = [[ARPlaceDetailModel alloc]init];
    model = [ARPlaceDetailModel mj_objectWithKeyValues:dict];
    
    model.descrip = dict[@"description"];
    
    return model;
}

@end
