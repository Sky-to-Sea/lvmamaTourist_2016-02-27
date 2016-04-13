//
//  LimitedService.m
//  lvmamaTourist
//
//  Created by Earth on 16/1/13.
//  Copyright © 2016年 Earth. All rights reserved.
//

#define LIMITED @"http://m.lvmama.com/bullet/index.php?s=/Api/getInfos&stationCode=GD&osVersion=4.4.4&lvversion=7.3.2&tagCodes=NSY_MS&globalLatitude=23.116613&channelCode=NSY&globalLongitude=112.503564&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=BAIDU&lvkey=9a78e64f7ab2eaa83f71c77e3dcc0635"

#define LIMITED_LBS @"http://m.lvmama.com/bullet/index.php?s=/Api/getInfos&stationCode=GD&osVersion=4.4.4&lvversion=7.3.2&tagCodes=NSY_MS&globalLatitude=%.6f&channelCode=NSY&globalLongitude=%.6f&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=BAIDU&lvkey=9a78e64f7ab2eaa83f71c77e3dcc0635"

#import "LimitedService.h"

@implementation LimitedService

- (void)requestData
{
    [self postWithPath:LIMITED andQuery:nil];
}

-(void)requestDataLocation:(CLLocationCoordinate2D)location
{
    [self postWithPath:[NSString stringWithFormat:LIMITED_LBS,location.latitude,location.longitude] andQuery:nil];
}

@end
