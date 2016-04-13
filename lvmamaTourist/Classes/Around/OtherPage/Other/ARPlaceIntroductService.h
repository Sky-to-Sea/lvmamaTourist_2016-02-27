//
//  ARPlaceIntroductService.h
//  lvmamaTourist
//
//  Created by Earth on 16/3/3.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "MApi.h"
#import <CoreLocation/CoreLocation.h>

@interface ARPlaceIntroductService : MApi

- (void)requestDataWithProductId:(NSString *)productId;

@end
