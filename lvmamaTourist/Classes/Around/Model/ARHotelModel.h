//
//  ARHotelModel.h
//  lvmamaTourist
//
//  Created by Earth on 16/2/23.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARHotelModel : NSObject

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *cashBack;
@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, strong) NSString *commentGoodRate;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *freeBroadband;
@property (nonatomic, strong) NSString *freePark;
@property (nonatomic, strong) NSString *freeWifi;
@property (nonatomic, strong) NSString *gaodelatitude;
@property (nonatomic, strong) NSString *gaodelongitude;
@property (nonatomic, strong) NSString *generalAmenities;
@property (nonatomic, strong) NSString *hasBusinessCenter;
@property (nonatomic, strong) NSString *hasDiningRoom;
@property (nonatomic, strong) NSString *hasGym;
@property (nonatomic, strong) NSString *hasMeetingRoom;
@property (nonatomic, strong) NSString *hotelBrand;
@property (nonatomic, strong) NSString *hotelId;
@property (nonatomic, strong) NSString *hotelStar;
@property (nonatomic, strong) NSString *images;
@property (nonatomic, strong) NSString *indoorSwimmingPool;
@property (nonatomic, strong) NSString *introEditor;
@property (nonatomic, strong) NSMutableArray *largeImages;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSMutableArray *middleImages;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *netDesc;
@property (nonatomic, strong) NSString *pickupService;
@property (nonatomic, strong) NSString *placeType;
@property (nonatomic, strong) NSString *recreationAmenities;
@property (nonatomic, strong) NSString *roomAmenities;
@property (nonatomic, strong) NSString *sellPrice;
@property (nonatomic, strong) NSString *shareContent;
@property (nonatomic, strong) NSMutableArray *smallImages;
@property (nonatomic, strong) NSString *supplierType;
@property (nonatomic, strong) NSString *traffic;
@property (nonatomic, strong) NSString *wapUrl;

+ (NSMutableArray *)analyzeJsonWithData:(NSDictionary *)list;

@end
