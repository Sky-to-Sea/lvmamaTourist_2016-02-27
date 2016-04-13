//
//  TableViewService.h
//  lvmamaTourist
//
//  Created by Earth on 16/2/16.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "MApi.h"

@interface TableViewService : MApi

- (void)requestDataWithPath:(NSString *)urlString;

@end
