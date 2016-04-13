//
//  ARPlaceIntroductModel.h
//  lvmamaTourist
//
//  Created by Earth on 16/3/3.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface ARPlaceIntroductModel : NSObject

//  地址
@property (nonatomic, strong) NSString *address;
//  产品ID
@property (nonatomic, strong) NSString *productId;
//  产品名称
@property (nonatomic, strong) NSString *productName;
//  推荐理由
@property (nonatomic, strong) NSString *recommendedReason;
//  简介
@property (nonatomic, strong) NSString *ticketProductDesc;
//  游玩项目
@property (nonatomic, strong) NSMutableArray *clientProdViewSpotVos;
//  轮播图片
@property (nonatomic, strong) NSMutableArray *clientImageBaseVos;

+ (instancetype)analizeDictionary:(NSDictionary *)dict;

@end



//  图片对象
@interface ClientImageBaseVosModel : NSObject

//  低像素图片地址
@property (nonatomic, strong) NSString *compressPicUrl;
@property (nonatomic, strong) NSString *photoContent;
//  高像素图片地址
@property (nonatomic, strong) NSString *photoUrl;

+ (instancetype)analizeDictionary:(NSDictionary *)dict;

@end



//  游玩项目对象
@interface ClientProdViewSpotVosModel : NSObject
//  游玩项目里面的图片
@property (nonatomic, strong) NSMutableArray *imageList;
@property (nonatomic, strong) NSString *spotDesc;
@property (nonatomic, strong) NSString *spotName;

+ (instancetype)analizeDictionary:(NSDictionary *)dict;

@end
