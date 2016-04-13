//
//  AreaCellService.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/12.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "AreaCellService.h"

#define PATH @"http://m.lvmama.com/bullet/index.php?s=/Api/getInfos&stationCode=GD&osVersion=4.4.4&lvversion=7.4.1&appFixVersion=1.0.0&channelCode=GNY&pageSize=6&udid=32830611116237181901081018212529231731126222882525102613&secondChannel=XIAOMI&tagCodes=JXGT&globalLatitude=23.116747&page=%d&globalLongitude=112.503657&firstChannel=ANDROID&formate=json&lvkey=0975e35552270d55476f55ff48131fa4"

@implementation AreaCellService

- (void)requestDataWithPageIndex:(NSInteger)pageIndex
{
    [self getWithPath:[NSString stringWithFormat:PATH ,pageIndex] andQuery:nil];
}

@end
