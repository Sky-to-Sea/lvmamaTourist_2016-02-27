//
//  PMTableViewService.h
//  lvmamaTourist
//
//  Created by Earth on 16/3/1.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "MApi.h"

@interface PMTableViewService : MApi

- (void)requestDataWith:(NSString *)userId pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize;

@end
