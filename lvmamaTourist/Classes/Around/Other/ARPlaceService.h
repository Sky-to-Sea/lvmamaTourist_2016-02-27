//
//  ARPlaceService.h
//  lvmamaTourist
//
//  Created by Earth on 16/2/22.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "MApi.h"
#import <CoreLocation/CoreLocation.h>

@interface ARPlaceService : MApi

- (void)requestPageNum:(int)pageNum pageSize:(int)pageSize location:(CLLocationCoordinate2D)location;

@end
