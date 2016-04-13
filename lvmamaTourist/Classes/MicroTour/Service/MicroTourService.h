//
//  MicroTourService.h
//  lvmamaTourist
//
//  Created by Earth on 16/2/15.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "MApi.h"

@interface MicroTourService : MApi

- (void)requestByPageIndex:(int)pageIndex pageSize:(int)pageSize;

@end
