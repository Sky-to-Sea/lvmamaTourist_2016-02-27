//
//  PMTableViewService.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/1.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "PMTableViewService.h"

#define Path @"http://api3g2.lvmama.com/trip/router/rest.do?method=api.com.trip.note.user&version=1.0.0&userID=%@&pageIndex=%ld&pageSize=6&udid=000000000000000&osVersion=4.4.4&version=1.0.0&lvversion=6.2.0&formate=json&secondChannel=XIAOMI&firstChannel=ANDROID"

@implementation PMTableViewService

- (void)requestDataWith:(NSString *)userId pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize
{
    [self getWithPath:[NSString stringWithFormat:Path,userId,pageIndex] andQuery:nil];
}

@end
