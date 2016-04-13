//
//  ARPlaceIntroductTableViewController.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/3.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "ARPlaceIntroductTableViewController.h"
#import "ARScrollImageView.h"
#import "ARPlaceIntroductService.h"
#import <CoreLocation/CoreLocation.h>

@interface ARPlaceIntroductTableViewController ()<ServiceCallback>

@property (nonatomic, strong) ARPlaceIntroductService *placeService;

@end

@implementation ARPlaceIntroductTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _placeService = [[ARPlaceIntroductService alloc]initWithSid:@"placeService" andCallback:self];
    
    [_placeService requestDataWithProductId:self.productId];
}

- (void)callbackWithResult:(ServiceResult *)result forSid:(NSString *)sid
{
    
}

- (void)callbackWhenError:(ServiceResult *)result forSid:(NSString *)sid
{
    
}



@end
