//
//  Model_scrollImage.m
//  lvmama
//
//  Created by Earth on 15/11/18.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import "Model_scrollImage.h"
#import "MJExtension.h"

#import "JSONKit.h"

@implementation Model_scrollImage

+ (NSMutableArray *) analyzeJsonWithData:(NSDictionary *)list
{
    
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:10];
    
    for (NSDictionary *dic in list)
    {
        //  用MJExtension,快速字典转模型.
        Model_scrollImage *model = [Model_scrollImage mj_objectWithKeyValues:dic];
        //  属性名不能用"id",只能手动了.
        model.ide = dic[@"id"];
        
        [mArray addObject:model];
    }
    
    LMMLog(@" ---- model解析完毕,返回数据 ---- ");
    
    return mArray;
}

+ (NSMutableArray *)analyzeJsonWithData:(NSDictionary *)listOne andData:(NSDictionary *)listTwo
{
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:3];
    
    for (NSDictionary *dic in listOne)
    {
        Model_scrollImage *model = [Model_scrollImage mj_objectWithKeyValues:dic];
        model.ide = dic[@"id"];
        
        [mArray addObject:model];
    }
    for (NSDictionary *dic in listTwo)
    {
        Model_scrollImage *model = [Model_scrollImage mj_objectWithKeyValues:dic];
        model.ide = dic[@"id"];
        
        [mArray addObject:model];
    }
    return mArray;
}



@end
