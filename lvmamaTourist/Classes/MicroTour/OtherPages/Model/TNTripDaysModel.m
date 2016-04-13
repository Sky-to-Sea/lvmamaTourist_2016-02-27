//
//  TNTripDaysModel.m
//  lvmamaTourist
//
//  Created by Earth on 16/2/20.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "TNTripDaysModel.h"
#import "TNTracksModel.h"

@implementation TNTripDaysModel

- (NSMutableArray *)tracks
{
    if (!_tracks)
    {
        _tracks = [[NSMutableArray alloc]init];
    }
    return _tracks;
}

- (TNTripDaysModel *)analizeDictionaryToModel:(NSDictionary *)dict
{
    self.date = dict[@"date"];
    self.ide = dict[@"id"];
    
    for (NSDictionary *jsonDicc in dict[@"tracks"])
    {
        TNTracksModel *model = [[TNTracksModel alloc]init];
        [self.tracks addObject:[model analizeDictionaryToModel:jsonDicc]];
    }
    
    return self;
}

@end
