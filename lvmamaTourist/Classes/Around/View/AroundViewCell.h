//
//  AroundViewCell.h
//  lvmamaTourist
//
//  Created by Earth on 15/12/13.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model_Around.h"
#import "ARAroundViewController.h"

@interface AroundViewCell : UITableViewCell

- (void) setAroundPalaceData:(Model_Around *) modelData withController:(ARAroundViewController *)controller;

@end
