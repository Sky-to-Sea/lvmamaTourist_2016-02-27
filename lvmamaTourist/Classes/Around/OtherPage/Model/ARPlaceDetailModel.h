//
//  ARPlaceDetailModel.h
//  lvmamaTourist
//
//  Created by Earth on 16/2/24.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARPlaceDetailModel : NSObject

@property (nonatomic, strong) NSString *arriveDate;
@property (nonatomic, strong) NSString *cashBack;
@property (nonatomic, strong) NSString *cashBackDesc;
@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, strong) NSString *commentGoodRate;
@property (nonatomic, strong) NSString *conferenceAmenities;
@property (nonatomic, strong) NSString *descrip;
@property (nonatomic, strong) NSString *destId;
@property (nonatomic, strong) NSString *diningAmenities;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *earliestArriveTime;
@property (nonatomic, strong) NSString *establishmentDate;
@property (nonatomic, strong) NSString *facilities;
@property (nonatomic, strong) NSString *favorite;
@property (nonatomic, strong) NSString *features;
@property (nonatomic, strong) NSString *freePark;
@property (nonatomic, strong) NSString *freeWifi;
@property (nonatomic, strong) NSString *gaodelatitude;
@property (nonatomic, strong) NSString *gaodelongitude;
@property (nonatomic, strong) NSString *generalAmenities;
@property (nonatomic, strong) NSString *hotelBrand;
@property (nonatomic, strong) NSString *hotelStar;
@property (nonatomic, strong) NSMutableArray *hotelSuitList;
@property (nonatomic, strong) NSString *images;
@property (nonatomic, strong) NSMutableArray *largeImages;
@property (nonatomic, strong) NSString *latestLeaveTime;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *leaveDate;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSMutableArray *middleImages;
@property (nonatomic, strong) NSString *netDesc;
@property (nonatomic, strong) NSString *placeType;
@property (nonatomic, strong) NSString *productAddress;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productNotice;
@property (nonatomic, strong) NSString *productSellPrice;
@property (nonatomic, strong) NSString *recreationAmenities;
@property (nonatomic, strong) NSString *roomAmenities;
@property (nonatomic, strong) NSString *shareContentTitle;
@property (nonatomic, strong) NSMutableArray *shareInfoVos;
@property (nonatomic, strong) NSString *shareWeiBoContent;
@property (nonatomic, strong) NSString *shareWeiXinContent;
@property (nonatomic, strong) NSMutableArray *smallImages;
@property (nonatomic, strong) NSString *telPhone;
@property (nonatomic, strong) NSString *traffic;
@property (nonatomic, strong) NSString *wapUrl;

+ (ARPlaceDetailModel *)analizeDictionaryToModel:(NSDictionary *)dict;

@end
