//
//  AppDelegate.h
//  lvmama
//
//  Created by Earth on 15/11/16.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMTabBarController.h"
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LMTabBarController *tabBar;

@property (strong, nonatomic) CLLocationManager *manager;

@property (assign, nonatomic) CLLocationCoordinate2D locationPlace;

@property (nonatomic, strong) BMKMapManager *_mapManager;

@end

