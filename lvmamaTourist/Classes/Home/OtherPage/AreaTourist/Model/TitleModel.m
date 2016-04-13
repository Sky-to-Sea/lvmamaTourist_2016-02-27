//
//  TitleModel.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/12.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "TitleModel.h"
#import "MJExtension.h"

@implementation TitleModel

- (NSMutableArray *)analizeDictToModelArrays:(NSDictionary *)dict
{
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dictionary in dict)
    {
        for (NSDictionary *modelDict in dictionary[@"infos"])
        {
            [mArray addObject:[TitleModel mj_objectWithKeyValues:modelDict]];
        }
    }
    [mArray exchangeObjectAtIndex:3 withObjectAtIndex:4];
    
    return mArray;
}

@end
