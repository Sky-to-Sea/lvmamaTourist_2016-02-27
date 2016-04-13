//
//  ARPlaceIntroductService.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/3.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "ARPlaceIntroductService.h"

#define PATH @"http://api3g2.lvmama.com/api/router/rest.do?method=api.com.ticket.product.getDetails&formate=json&version=1.0.0&lvsessionid=&udid=66Y6R15A08002222&firstChannel=ANDROID&secondChannel=LVMM&lvversion=6.2.0&osVersion=4.4.4&deviceName=T1-A21w"

@implementation ARPlaceIntroductService

- (void)requestDataWithProductId:(NSString *)productId
{
    HttpQuery *query = [HttpQuery new];
    
    [query addParam:@"productId" andValue:productId];
    
    [self postWithPath:PATH andQuery:query];
}

@end
