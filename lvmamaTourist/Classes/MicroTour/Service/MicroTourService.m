//
//  MicroTourService.m
//  lvmamaTourist
//
//  Created by Earth on 16/2/15.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "MicroTourService.h"

static NSString *PATH = @"http://api3g2.lvmama.com/trip/router/rest.do?method=api.com.trip.note.hot&version=1.0.0";

static NSString *LVSESSIONID   = @"lvsessionid";
static NSString *PAGEINDEX     = @"pageIndex";
static NSString *UDID          = @"udid";
static NSString *OSVERSION     = @"osVersion";
static NSString *VERSION       = @"version";
static NSString *LVVERSION     = @"lvversion";
static NSString *FORMATE       = @"formate";
static NSString *SECONDCHANNEL = @"secondChannel";
static NSString *PAGESIZE      = @"pageSize";
static NSString *FIRSTCHANNEL  = @"firstChannel";

@implementation MicroTourService

- (void)requestByPageIndex:(int)pageIndex pageSize:(int)pageSize
{
//    NSString *default_lvsessionid   = @"bb212eec-99aa-4 5fe-8f3a-7a1161e6372d";
//    NSString *default_udid          = @"66Y6R15A08002222";
//    NSString *default_osVersion     = @"4.4.4";
//    NSString *default_version       = @"1.0.0";
//    NSString *default_lvversion     = @"6.2.0";
//    NSString *default_formate       = @"json";
//    NSString *default_secondChannel = @"LVMM";
//    NSString *default_firstChannel  = @"ANDROID";
    
    HttpQuery *query = [HttpQuery new];
    
//    [query addParam:LVSESSIONID     andValue:default_lvsessionid];
//    [query addParam:UDID            andValue:default_udid];
//    [query addParam:OSVERSION       andValue:default_osVersion];
//    [query addParam:VERSION         andValue:default_version];
//    [query addParam:LVVERSION       andValue:default_lvversion];
//    [query addParam:FORMATE         andValue:default_formate];
//    [query addParam:SECONDCHANNEL   andValue:default_secondChannel];
//    [query addParam:FIRSTCHANNEL    andValue:default_firstChannel];
    
    [query addParam:PAGEINDEX       andValue:[NSString stringWithFormat:@"%d",pageIndex]];
    [query addParam:PAGESIZE        andValue: [NSString stringWithFormat:@"%d",pageSize]];
    
    [self postWithPath:PATH andQuery:query];
}

@end
