//
//  AreaService.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/12.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "AreaService.h"

#define PATH @"http://m.lvmama.com/bullet/index.php?s=/Api/getInfos&stationCode=GD&osVersion=4.4.4&lvversion=7.4.1&tagCodes=SY_HDTJ5,SY_HDTJ6,SY_HDTJ7,SY_HDTJ8&appFixVersion=1.0.0&globalLatitude=23.116747&channelCode=GNY&globalLongitude=112.503657&firstChannel=ANDROID&udid=32830611116237181901081018212529231731126222882525102613&formate=json&secondChannel=XIAOMI&lvkey=0baf1ad697d19b1518a01485f81dd723"



@implementation AreaService

/**
 *  请求图片的数据
 */
- (void)requestData
{
    [self getWithPath:PATH andQuery:nil];
}



@end
