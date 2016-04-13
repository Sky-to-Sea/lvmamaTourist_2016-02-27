//
//  ColorfulService.h
//  lvmamaTourist
//
//  Created by Earth on 16/1/13.
//  Copyright © 2016年 Earth. All rights reserved.
//

/**
 *  发起对[缤纷出游/特色业务]的数据请求
 */

#import "MApi.h"
#import <CoreLocation/CoreLocation.h>

@interface ColorfulService : MApi

/**
 *  用默认地址发送请求
 */
- (void)requestData;
/**
 *  用指定地址发送请求
 */
- (void)requestDataLocation:(CLLocationCoordinate2D)location;

@end
