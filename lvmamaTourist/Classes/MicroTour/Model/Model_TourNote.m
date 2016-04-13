//
//  Model_TourNote.m
//  lvmamaTourist
//
//  Created by Earth on 15/12/13.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import "Model_TourNote.h"
#import "MJExtension.h"

@implementation Model_TourNote

+ (NSMutableArray *)analyzeJsonWithData:(NSDictionary *)list
{
    NSMutableArray *mArray = [[NSMutableArray alloc]initWithCapacity:10];
    
    for (NSDictionary *dic in list)
    {
        Model_TourNote *model = [Model_TourNote mj_objectWithKeyValues:dic];
        
        [mArray addObject:model];
    }
    
    return mArray;
}

@end
