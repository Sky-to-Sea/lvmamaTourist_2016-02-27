//
//  ARPlaceService.m
//  lvmamaTourist
//
//  Created by Earth on 16/2/22.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "ARPlaceService.h"

NSString *path = @"http://api3g2.lvmama.com/api/router/rest.do?method=api.com.ticket.search.searchTicket&formate=json&version=1.0.0&lvsessionid=&udid=66Y6R15A08002222&firstChannel=ANDROID&secondChannel=LVMM&lvversion=6.2.0&osVersion=4.4.4&deviceName=T1-A21w";


@implementation ARPlaceService

-(void)requestPageNum:(int)pageNum pageSize:(int)pageSize location:(CLLocationCoordinate2D)location
{
    HttpQuery *query = [HttpQuery new];
    
    [query addParam:@"pageNum" andValue:[NSString stringWithFormat:@"%d",pageNum]];
    [query addParam:@"longitude" andValue:[NSString stringWithFormat:@"%f",location.longitude]];
    [query addParam:@"latitude" andValue:[NSString stringWithFormat:@"%f",location.latitude]];
    [query addParam:@"pageSize" andValue:[NSString stringWithFormat:@"%d",pageSize]];
    [query addParam:@"windage" andValue:@"100"];
    
    [self postWithPath:path andQuery:query];
}

@end
