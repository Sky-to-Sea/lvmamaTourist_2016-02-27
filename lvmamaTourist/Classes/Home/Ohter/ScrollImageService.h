//
//  ScrollImageService.h
//  lvmamaTourist
//
//  Created by Earth on 16/1/13.
//  Copyright © 2016年 Earth. All rights reserved.
//

/**
 *  发起对滚动视图的数据请求
 */


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ScrollImageService : MApi

/**
 *  用默认地址发送请求
 */
- (void)requestData;
/**
 *  用指定地址发送请求
 */
- (void)requestDataLocation:(CLLocationCoordinate2D)location;

@end
