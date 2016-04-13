//
//  ARPlaceIntroductModel.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/3.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "ARPlaceIntroductModel.h"
#import "MJExtension.h"

@implementation ARPlaceIntroductModel

+ (instancetype)analizeDictionary:(NSDictionary *)dictionary
{
    return [[self alloc]initWithDictionary:dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [ARPlaceIntroductModel mj_objectWithKeyValues:dictionary];
    
    _clientImageBaseVos = [[NSMutableArray alloc]init];
    _clientProdViewSpotVos = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dic in dictionary[@"clientImageBaseVos"])
    {
        [self.clientImageBaseVos addObject:[ClientImageBaseVosModel analizeDictionary:dic]];
    }
    
    for (NSDictionary *dic in dictionary[@"clientProdViewSpotVos"])
    {
        [self.clientProdViewSpotVos addObject:[ClientProdViewSpotVosModel analizeDictionary:dic]];
    }
    
    return self;
}

@end

@implementation ClientImageBaseVosModel

+ (instancetype)analizeDictionary:(NSDictionary *)dictionary
{
    return [[self alloc]initWithDictionary:dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [ClientImageBaseVosModel mj_objectWithKeyValues:dictionary];
    return self;
}

@end

@implementation ClientProdViewSpotVosModel

+ (instancetype)analizeDictionary:(NSDictionary *)dictionary
{
    return [[self alloc]initWithDictionary:dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [ClientProdViewSpotVosModel mj_objectWithKeyValues:dictionary];
    
    _imageList = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dic in dictionary[@"imageList"])
    {
        [self.imageList addObject:[ClientImageBaseVosModel analizeDictionary:dic]];
    }
    
    return self;
}

@end