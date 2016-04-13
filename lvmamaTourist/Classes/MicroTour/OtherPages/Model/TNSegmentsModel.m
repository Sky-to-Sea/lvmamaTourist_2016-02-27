//
//  TNSegmentsModel.m
//  lvmamaTourist
//
//  Created by Earth on 16/2/20.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "TNSegmentsModel.h"

@implementation TNSegmentsModel

- (TNSegmentsModel *)analizeDictionaryToModel:(NSDictionary *)dict
{
    self.imageUrl = dict[@"image"][@"imgUrl"];
    self.text = dict[@"text"];
    
    return self;
}

@end
