//
//  limitedShopModel.m
//  lvmamaTourist
//
//  Created by Earth on 16/1/8.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "limitedShopModel.h"
#import "MJExtension.h"

@implementation limitedShopModel

+ (instancetype)analizeToModelWithDict:(NSDictionary *)dict
{
    limitedShopModel *model = [[limitedShopModel alloc]init];
    
    model = [limitedShopModel mj_objectWithKeyValues:dict];
    
    return model;
}

@end
