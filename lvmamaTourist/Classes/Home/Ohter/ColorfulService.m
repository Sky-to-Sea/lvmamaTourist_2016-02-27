//
//  ColorfulService.m
//  lvmamaTourist
//
//  Created by Earth on 16/1/13.
//  Copyright © 2016年 Earth. All rights reserved.
//

#define COLOR @"http://m.lvmama.com/bullet/index.php?s=/Api/getInfos&stationCode=SH&osVersion=4.4.4&lvversion=7.3.2&tagCodes=NSY_NBA,NSY_NSA,NSY_ACTION_L,NSY_ACTION_R,TJHD&globalLatitude=22.583168&channelCode=NSY&globalLongitude=113.870301&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=BAIDU&lvkey=9e324f70acc02f8fb448e7979003468a"

#define COLOR_LBS @"http://m.lvmama.com/bullet/index.php?s=/Api/getInfos&stationCode=SH&osVersion=4.4.4&lvversion=7.3.2&tagCodes=NSY_NBA,NSY_NSA,NSY_ACTION_L,NSY_ACTION_R,TJHD&globalLatitude=%.6f&channelCode=NSY&globalLongitude=%.6f&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=BAIDU&lvkey=9e324f70acc02f8fb448e7979003468a"


#import "ColorfulService.h"

@implementation ColorfulService

- (void)requestData
{
    [self postWithPath:COLOR andQuery:nil];
}

-(void)requestDataLocation:(CLLocationCoordinate2D)location
{
    [self postWithPath:[NSString stringWithFormat:COLOR_LBS,location.latitude,location.longitude] andQuery:nil];
}

@end
