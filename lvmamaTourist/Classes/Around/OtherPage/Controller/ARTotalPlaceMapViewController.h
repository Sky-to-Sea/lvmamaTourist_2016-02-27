//
//  ARTotalPlaceMapViewController.h
//  lvmamaTourist
//
//  Created by Earth on 16/3/8.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ARTotalPlaceMapViewController : UIViewController

/**
 *  各景点的数据源(包括百度坐标、预览图url地址、productId)
 */
@property (nonatomic, strong) NSMutableArray *dataSource;

/**
 *  标题显示的内容
 */
@property (nonatomic, strong) NSString *titleName;

/**
 *  当前自己的地理位置
 */
@property (nonatomic, assign) CLLocationCoordinate2D myLocation;

/**
 *  当前地图中间的位置
 */
@property (nonatomic, assign) CLLocationCoordinate2D mapCenter;

@end
