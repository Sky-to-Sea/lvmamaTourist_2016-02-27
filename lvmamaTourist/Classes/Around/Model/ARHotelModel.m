//
//  ARHotelModel.m
//  lvmamaTourist
//
//  Created by Earth on 16/2/23.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "ARHotelModel.h"
#import "MJExtension.h"

@implementation ARHotelModel

+ (NSMutableArray *)analyzeJsonWithData:(NSDictionary *)list
{
    NSMutableArray *mArray = [[NSMutableArray alloc]initWithCapacity:20];
    
    for (NSDictionary *dic in list)
    {
        ARHotelModel *model = [ARHotelModel mj_objectWithKeyValues:dic];
        
        [mArray addObject:model];
    }
    
    return mArray;
}

@end
