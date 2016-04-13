//
//  ARHotelService.m
//  lvmamaTourist
//
//  Created by Earth on 16/2/22.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "ARHotelService.h"

NSString *hotelPath = @"http://api3g2.lvmama.com/api/router/rest.do?method=api.com.search.searchHotel&formate=json&version=1.0.0&lvsessionid=&udid=66Y6R15A08002222&firstChannel=ANDROID&secondChannel=LVMM&lvversion=6.2.0&osVersion=4.4.4&deviceName=T1-A21w";

@implementation ARHotelService

- (void)requestPageInde:(int)pageIndex pRadius:(int)pRadius location:(CLLocationCoordinate2D)location pageSize:(int)pageSize
{
    HttpQuery *query = [HttpQuery new];
    
    [query addParam:@"pageIndex" andValue:[NSString stringWithFormat:@"%d",pageIndex]];
    [query addParam:@"pRadius" andValue:[NSString stringWithFormat:@"%d",pRadius]];
    [query addParam:@"pLatitude" andValue:[NSString stringWithFormat:@"%.6f",location.latitude]];
    [query addParam:@"pLongitude" andValue:[NSString stringWithFormat:@"%.6f",location.longitude]];
    [query addParam:@"pageSize" andValue:[NSString stringWithFormat:@"%d",pageSize]];
    
    [self postWithPath:hotelPath andQuery:query];
}

@end
