//
//  PNTableViewCellModel.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/1.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "PNTableViewCellModel.h"
#import "MJExtension.h"

@implementation PNTableViewCellModel

+ (PNTableViewCellModel *)initWithDict:(NSDictionary *)dict
{
    return  [[self alloc]analizeDictionaryToModel:dict];
}

- (PNTableViewCellModel *)analizeDictionaryToModel:(NSDictionary *)dict
{
    PNTableViewCellModel *model = [PNTableViewCellModel mj_objectWithKeyValues:dict];
    return  model;
}

@end
