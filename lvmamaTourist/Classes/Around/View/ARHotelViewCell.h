//
//  ARHotelViewCell.h
//  lvmamaTourist
//
//  Created by Earth on 16/2/23.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARHotelModel.h"
#import "ARAroundViewController.h"

@interface ARHotelViewCell : UITableViewCell

- (void)setCellWithData:(ARHotelModel *)model withController:(ARAroundViewController *)controller;

@end
