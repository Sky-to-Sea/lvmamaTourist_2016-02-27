//
//  TableModel.m
//  lvmamaTourist
//
//  Created by Earth on 16/2/19.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "TableModel.h"

@implementation TableModel

-(void)analizeDictionaryToModel:(NSMutableDictionary *)dict
{
    self.date = dict[@"date"];
    self.ide  = dict[@"id"];
    
}

@end
