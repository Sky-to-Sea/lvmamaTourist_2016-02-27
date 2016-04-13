//
//  ARPlaceIntroductViewController.h
//  lvmamaTourist
//
//  Created by Earth on 16/3/3.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ARPlaceIntroductViewController : UIViewController

@property (nonatomic, strong) NSString *productId;
@property (weak, nonatomic) IBOutlet UIScrollView *totalViewPlace;

@property (nonatomic, assign) CLLocationCoordinate2D location;

@end
