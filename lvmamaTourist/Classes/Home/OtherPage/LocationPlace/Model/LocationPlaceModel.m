//
//  LocationPlaceModel.m
//  lvmamaTourist
//
//  Created by Earth on 16/1/26.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "LocationPlaceModel.h"
#import "MJExtension.h"

#define WORLD @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"

@implementation LocationPlaceModel

/**
 *  仅解析数据
 */
- (NSMutableArray *)arrayWithDict:(NSDictionary *)dict
{
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *jsonDic in  dict)
    {
        LocationPlaceModel *model = [LocationPlaceModel mj_objectWithKeyValues:jsonDic];
        [mArray addObject:model];
    }
    return mArray;
}


/**
 *  解析数据,并按首字母封装好
 */
- (NSMutableArray *)modelWithDict:(NSDictionary *)dict
{
    //  预创建一堆数组,指定字母前缀为key
    NSMutableDictionary *mainDict = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < WORLD.length; i ++)
    {
        NSMutableArray *mArray = [[NSMutableArray alloc]init];
        [mainDict setObject:mArray forKey:[WORLD substringWithRange:NSMakeRange(i, 1)]];
    }
    
    //  解析字典并装填到对应字母key的数组中
    for (NSDictionary *jsonDic in dict)
    {
        LocationPlaceModel *model = [LocationPlaceModel mj_objectWithKeyValues:jsonDic];
        NSString *prefix = [model.pinyin substringToIndex:1];
        [((NSMutableArray *)mainDict[prefix]) addObject:model];
    }
    
    //  根据key值,将数据装填到目标数组中去
    NSMutableArray *mainArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < WORLD.length ; i ++)
    {
        [mainArray addObject:[mainDict objectForKey:[WORLD substringWithRange:NSMakeRange(i, 1)]]];
    }
    
    return mainArray;
}


@end
