//
//  TNImageTextCell.h
//  lvmamaTourist
//
//  Created by Earth on 16/2/22.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TNTracksModel.h"
#import "TableViewController.h"

@interface TNImageTextCell : UITableViewCell

- (void)setCellWithData:(TNTracksModel *)data withController:(TableViewController *)controller;

@end
