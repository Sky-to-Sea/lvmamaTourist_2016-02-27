//
//  TopicModel.m
//  lvmamaTourist
//
//  Created by Earth on 16/1/3.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "TopicModel.h"
#import "MJExtension.h"

@implementation TopicModel


+ (NSMutableArray *) analyzeJsonWithData:(NSDictionary *) dict;
{
    NSMutableArray *mArray = [[NSMutableArray alloc]initWithCapacity:10];
    
    for (NSDictionary *dic in dict)
    {
        TopicModel *model = [TopicModel mj_objectWithKeyValues:dic];
        
        model.ide = dic[@"id"];
        
        [mArray addObject:model];
    }
    return mArray;
}


@end
