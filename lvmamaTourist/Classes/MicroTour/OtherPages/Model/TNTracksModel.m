//
//  TNTracksModel.m
//  lvmamaTourist
//
//  Created by Earth on 16/2/20.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "TNTracksModel.h"
#import "TNSegmentsModel.h"

@implementation TNTracksModel

- (NSMutableArray *)segments
{
    if (!_segments)
    {
        _segments = [[NSMutableArray alloc]init];
    }
    return _segments;
}

- (TNTracksModel *)analizeDictionaryToModel:(NSDictionary *)dict
{
    self.poiDesc = dict[@"poiDesc"];
    self.poiName = dict[@"poiName"];
    self.poiId = dict[@"poiId"];
    
    for (NSDictionary *jsonDic in dict[@"segments"])
    {
        TNSegmentsModel *model = [[TNSegmentsModel alloc]init];
        [self.segments addObject:[model analizeDictionaryToModel:jsonDic]];
    }
    return self;
}

@end
