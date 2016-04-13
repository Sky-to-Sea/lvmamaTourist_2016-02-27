//
//  TNTripDaysModel.h
//  lvmamaTourist
//
//  Created by Earth on 16/2/20.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNTripDaysModel : NSObject

//  游玩时间
@property (nonatomic, strong) NSString *date;
//  游玩者id
@property (nonatomic, strong) NSString *ide;
//  具体每一个游玩地点
@property (nonatomic, strong) NSMutableArray *tracks;

- (TNTripDaysModel *)analizeDictionaryToModel:(NSDictionary *)dict;

@end
