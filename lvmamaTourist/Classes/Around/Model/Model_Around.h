//
//  Model_Around.h
//  lvmamaTourist
//
//  Created by Earth on 15/12/13.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model_Around : NSObject

/**
 *  具体地址
 */
@property (nonatomic, strong) NSString *adress;
/**
 *  经度
 */
@property (nonatomic, strong) NSString *baiduLatitude;
/**
 *  纬度
 */
@property (nonatomic, strong) NSString *baiduLongitude;
/**
 *  返现金额
 */
@property (nonatomic, strong) NSString *cashBack;
/**
 *  城市名
 */
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *cmtNum;
@property (nonatomic, strong) NSString *cmtStarts;
/**
 *  好评率
 */
@property (nonatomic, strong) NSString *commentGood;
//@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *featureDesc;
@property (nonatomic, strong) NSString *featureId;
@property (nonatomic, strong) NSString *forPhone;
@property (nonatomic, strong) NSString *freenessNum;
@property (nonatomic, strong) NSString *googleLatitude;
@property (nonatomic, strong) NSString *googleLongitude;
@property (nonatomic, strong) NSString *hasActivity;
@property (nonatomic, strong) NSString *hasBusinessCoupon;
@property (nonatomic, strong) NSString *hasBuyPresent;
/**
 *  是否有免费保险送 True/False
 */
@property (nonatomic, assign) NSString *hasFreeInsurance;
@property (nonatomic, strong) NSString *hasIn;
@property (nonatomic, strong) NSArray  *imageList;
@property (nonatomic, strong) NSString *importantTips;
/**
 *  距离
 */
@property (nonatomic, strong) NSString *juli;
@property (nonatomic, strong) NSString *mainDestId;
/**
 *  原售价
 */
@property (nonatomic, strong) NSString *marketPrice;
@property (nonatomic, strong) NSString *maxCashRefund;
/**
 *  图片
 */
@property (nonatomic, strong) NSString *middleImage;
@property (nonatomic, strong) NSString *orderNotice;
/**
 *  今天能否预定
 */
@property (nonatomic, strong) NSString *orderTodayAble;
@property (nonatomic, strong) NSString *outingNum;

@property (nonatomic, strong) NSString *placeActivity;
@property (nonatomic, strong) NSString *productId;
/**
 *  产品名称/大标题
 */
@property (nonatomic, strong) NSString *productName;
/**
 *  惠 False/True
 */
@property (nonatomic, strong) NSString *promotionFlag;
/**
 *  首地址
 */
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, strong) NSString *recommend;
@property (nonatomic, strong) NSString *recommendReason;
@property (nonatomic, strong) NSString *routeNum;
@property (nonatomic, strong) NSString *scenicOpenTime;
@property (nonatomic, strong) NSString *sellPrice;
@property (nonatomic, strong) NSString *stage;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *subjectId;
@property (nonatomic, strong) NSArray  *tagNames;
@property (nonatomic, strong) NSString *ticketProducType;
@property (nonatomic, strong) NSString *trafficInfo;
@property (nonatomic, strong) NSString *virtualSaleQuantity;


+ (NSMutableArray *)analyzeJsonWithData:(NSDictionary *)list;


@end
