//
//  TableViewService.m
//  lvmamaTourist
//
//  Created by Earth on 16/2/16.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "TableViewService.h"

@implementation TableViewService

- (void)requestDataWithPath:(NSString *)urlString
{
    [self getWithPath:urlString andQuery:nil];
}

@end
