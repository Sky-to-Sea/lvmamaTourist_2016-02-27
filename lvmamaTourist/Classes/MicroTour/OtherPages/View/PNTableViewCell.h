//
//  PNTableViewCell.h
//  lvmamaTourist
//
//  Created by Earth on 16/2/22.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNTableViewCellModel.h"
#import "PMTableViewController.h"

@interface PNTableViewCell : UITableViewCell

- (void)setCellWithData:(PNTableViewCellModel *)modelData controller:(PMTableViewController *)controller;

@end
