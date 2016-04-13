//
//  limitedShopModel.h
//  lvmamaTourist
//
//  Created by Earth on 16/1/8.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface limitedShopModel : NSObject

@property (nonatomic, strong) NSString *object_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *market_price;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *large_image;
@property (nonatomic, strong) NSString *buyCount;
@property (nonatomic, strong) NSString *end_time;
@property (nonatomic, strong) NSString *groupSiteId;
@property (nonatomic, strong) NSString *sub_object_id;
@property (nonatomic, strong) NSString *branchType;
@property (nonatomic, strong) NSString *productType;
@property (nonatomic, strong) NSString *productType2;
@property (nonatomic, strong) NSString *left_time;
@property (nonatomic, strong) NSString *secKillStatus;
@property (nonatomic, strong) NSString *pindao;

+ (instancetype) analizeToModelWithDict:(NSDictionary *)dict;

@end
