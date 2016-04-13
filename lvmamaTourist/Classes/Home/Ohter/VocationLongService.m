//
//  VocationLongService.m
//  lvmamaTourist
//
//  Created by Earth on 16/1/15.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "VocationLongService.h"

#define LONG @"http://m.lvmama.com/bullet/index.php?s=/Api/getInfos&stationCode=SH&osVersion=4.4.4&lvversion=7.3.2&tagCodes=NSY_CJ&globalLatitude=23.344053&channelCode=NSY&page=%d&globalLongitude=112.708708&pageSize=6&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=BAIDU&lvkey=1b087804712e7b8b1855aabe1fbc5072"

#define LONG_LBS @"http://m.lvmama.com/bullet/index.php?s=/Api/getInfos&stationCode=SH&osVersion=4.4.4&lvversion=7.3.2&tagCodes=NSY_CJ&globalLatitude=%.6f&channelCode=NSY&page=%d&globalLongitude=%.6f&pageSize=6&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=BAIDU&lvkey=1b087804712e7b8b1855aabe1fbc5072"

@implementation VocationLongService

- (void)requestData:(int)offset
{
    [self postWithPath:[NSString stringWithFormat:LONG,offset] andQuery:nil];
}

-(void)requestDataLocation:(CLLocationCoordinate2D)location withOffset:(int)offset
{
    [self postWithPath:[NSString stringWithFormat:LONG_LBS,location.latitude,offset,location.longitude] andQuery:nil];
}

@end
