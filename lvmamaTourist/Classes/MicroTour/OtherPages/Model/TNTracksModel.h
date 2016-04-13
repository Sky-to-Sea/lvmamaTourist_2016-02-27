//
//  TNTracksModel.h
//  lvmamaTourist
//
//  Created by Earth on 16/2/20.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNTracksModel : NSObject

//  游玩地点的首要描述
@property (nonatomic, strong) NSString *poiDesc;

//  游玩的地点
@property (nonatomic, strong) NSString *poiName;

//  游玩地点的照片和描述
@property (nonatomic, strong) NSMutableArray *segments;

//  游玩地点编号
@property (nonatomic, strong) NSString *poiId;

- (TNTracksModel *)analizeDictionaryToModel:(NSDictionary *)dict;

@end
