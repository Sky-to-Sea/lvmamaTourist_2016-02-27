//
//  ARPlaceDetailService.m
//  lvmamaTourist
//
//  Created by Earth on 16/2/24.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "ARPlaceDetailService.h"

#define PATH @"http://api3g2.lvmama.com/api/router/rest.do?method=api.com.product.getProductDetail&formate=json&version=1.0.0&productId=%@&arrivalDate=%@&departureDate=%@&lvsessionid=&udid=66Y6R15A08002222&firstChannel=ANDROID&secondChannel=LVMM&lvversion=6.2.0&osVersion=4.4.4&deviceName=T1-A21w"

@interface ARPlaceDetailService ()

@end

@implementation ARPlaceDetailService

- (void)requestProductIdData:(NSString *)productId
{
    NSTimeInterval timeNow = [[NSDate date] timeIntervalSince1970];
    
    NSString *string1 = [self formatterDateOne:timeNow];
    NSString *string2 = [self formatterDateTwo:timeNow + 86400];
    
    [self getWithPath:[NSString stringWithFormat:PATH,productId,string1,string2] andQuery:nil];
}

- (NSString *)formatterDateOne:(long long int)timeNow
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    return [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeNow]];
}

- (NSString *)formatterDateTwo:(long long int)timeNow
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    return [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeNow]];
}

@end
