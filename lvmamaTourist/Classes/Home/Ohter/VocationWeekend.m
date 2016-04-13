//
//  VocationWeekend.m
//  lvmamaTourist
//
//  Created by Earth on 16/1/15.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "VocationWeekend.h"

#define WEEK @"http://m.lvmama.com/bullet/index.php?s=/Api/getInfos&stationCode=SH&osVersion=4.4.4&lvversion=7.3.2&tagCodes=NSY_ZM&globalLatitude=23.344053&channelCode=NSY&page=%d&globalLongitude=112.708708&pageSize=6&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=BAIDU&lvkey=d40dee781557ea2ba80152b74d44ca75"
#define WEEK_LBS @"http://m.lvmama.com/bullet/index.php?s=/Api/getInfos&stationCode=SH&osVersion=4.4.4&lvversion=7.3.2&tagCodes=NSY_ZM&globalLatitude=%.6f&channelCode=NSY&page=%d&globalLongitude=%.6f&pageSize=6&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=BAIDU&lvkey=d40dee781557ea2ba80152b74d44ca75"

@implementation VocationWeekend

- (void)requestData:(int)offset
{
    [self postWithPath:[NSString stringWithFormat:WEEK,offset] andQuery:nil];
}

-(void)requestDataLocation:(CLLocationCoordinate2D)location withOffset:(int)offset
{
    [self postWithPath:[NSString stringWithFormat:WEEK_LBS,location.latitude,offset,location.longitude] andQuery:nil];
}

@end
