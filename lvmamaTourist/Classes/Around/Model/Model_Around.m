//
//  Model_Around.m
//  lvmamaTourist
//
//  Created by Earth on 15/12/13.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import "Model_Around.h"
#import "MJExtension.h"

@implementation Model_Around


+ (NSMutableArray *)analyzeJsonWithData:(NSDictionary *)list
{
    NSMutableArray *mArray = [[NSMutableArray alloc]initWithCapacity:20];
    
    for (NSDictionary *dic in list)
    {
        Model_Around *model = [Model_Around mj_objectWithKeyValues:dic];
        
        [mArray addObject:model];
    }
    
    return mArray;
}

@end
