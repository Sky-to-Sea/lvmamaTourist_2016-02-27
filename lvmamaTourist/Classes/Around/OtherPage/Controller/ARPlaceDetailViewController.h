//
//  ARPlaceDetailViewController.h
//  lvmamaTourist
//
//  Created by Earth on 16/2/25.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARPlaceDetailViewController : UIViewController

@property (nonatomic, strong) NSString *productId;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, assign) CLLocationCoordinate2D location;

@end
