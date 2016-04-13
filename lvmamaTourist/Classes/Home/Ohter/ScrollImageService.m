//
//  ScrollImageService.m
//  lvmamaTourist
//
//  Created by Earth on 16/1/13.
//  Copyright © 2016年 Earth. All rights reserved.
//


//  轮播图片API
#define SCROLL @"http://m.lvmama.com/bullet/index.php?s=/Api/getInfos&stationCode=GD&osVersion=4.4.4&lvversion=7.4.1&tagCodes=NSY_BANNER&appFixVersion=1.0.0&globalLatitude=23.116629&channelCode=NSY&globalLongitude=112.503464&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=XIAOMI&lvkey=f7711367e0c7e7d20429f7cebe1ad920"
//  带参数的API
#define SCROLL_LBS @"http://m.lvmama.com/bullet/index.php?s=/Api/getInfos&stationCode=GD&osVersion=4.4.4&lvversion=7.4.1&tagCodes=NSY_BANNER&appFixVersion=1.0.0&globalLatitude=%.6f&channelCode=NSY&globalLongitude=%.6f&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=XIAOMI&lvkey=f7711367e0c7e7d20429f7cebe1ad920"

#import "ScrollImageService.h"


@implementation ScrollImageService


- (void)requestData
{
    [self postWithPath:SCROLL andQuery:nil];
}

-(void)requestDataLocation:(CLLocationCoordinate2D)location
{
    [self postWithPath:[NSString stringWithFormat:SCROLL_LBS,location.latitude,location.longitude] andQuery:nil];
    
    NSLog(@"%@",[NSString stringWithFormat:SCROLL_LBS,location.latitude,location.longitude]);
    
}

@end
