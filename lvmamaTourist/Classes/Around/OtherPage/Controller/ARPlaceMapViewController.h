//
//  ARPlaceMapViewController.h
//  lvmamaTourist
//
//  Created by Earth on 16/3/6.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARPlaceMapViewController : UIViewController

@property (nonatomic, assign) CLLocationCoordinate2D location;
@property (nonatomic, strong) NSString *scenicTitle;
@property (nonatomic, strong) NSString *titleName;

@property (weak, nonatomic) IBOutlet UILabel *labelOfTitle;

@end
