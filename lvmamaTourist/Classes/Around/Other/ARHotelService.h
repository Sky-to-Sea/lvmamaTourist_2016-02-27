//
//  ARHotelService.h
//  lvmamaTourist
//
//  Created by Earth on 16/2/22.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "MApi.h"
#import <CoreLocation/CoreLocation.h>


@interface ARHotelService : MApi

- (void)requestPageInde:(int)pageIndex pRadius:(int)pRadius location:(CLLocationCoordinate2D)location pageSize:(int)pageSize;

@end
