//
//  LocationPlaceModel.h
//  lvmamaTourist
//
//  Created by Earth on 16/1/26.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationPlaceModel : NSObject

@property (nonatomic, strong) NSString* fromDestId;
@property (nonatomic, strong) NSString* ide;
@property (nonatomic, assign) BOOL      isHot;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* pinyin;
@property (nonatomic, strong) NSString* seq;
@property (nonatomic, strong) NSString* shortPinyin;
@property (nonatomic, strong) NSString* subName;

- (NSMutableArray *)modelWithDict:(NSDictionary *)dict;

- (NSMutableArray *)arrayWithDict:(NSDictionary *)dict;


@end
