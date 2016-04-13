//
//  ARLocationModel.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/10.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "ARLocationModel.h"
#import "Model_Around.h"
#import "ARHotelModel.h"

@implementation ARLocationModel

+ (NSMutableArray *)analizeToModelWithArray:(NSMutableArray *)mArray withType:(BOOL)type
{
    if (mArray.count == 0) return nil;
    
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    //  景点
    if (type)
    {
//        for (NSMutableArray *array in mArray)
//        {
            for (Model_Around *model in mArray[0])
            {
                ARLocationModel *placeModel = [[ARLocationModel alloc]init];
                
                placeModel.location = CLLocationCoordinate2DMake([model.baiduLatitude doubleValue], [model.baiduLongitude doubleValue]);
                placeModel.imageUrl = model.middleImage;
                placeModel.productId = model.productId;
                placeModel.productName = model.productName;
                placeModel.type = type;
                
                [dataArray addObject:placeModel];
            }
//        }
        
    }
    else
    {
//        for (NSMutableArray *array in mArray)
//        {
            for (ARHotelModel *model in mArray[0])
            {
                ARLocationModel *placeModel = [[ARLocationModel alloc]init];
                
                placeModel.location = CLLocationCoordinate2DMake([model.latitude doubleValue], [model.longitude doubleValue]);
                
                placeModel.imageUrl = model.images;
                placeModel.productId = model.hotelId;
                placeModel.productName = model.name;
                placeModel.type = type;
                
                [dataArray addObject:placeModel];
            }
//        }
    }
    
    return dataArray;
}

@end
