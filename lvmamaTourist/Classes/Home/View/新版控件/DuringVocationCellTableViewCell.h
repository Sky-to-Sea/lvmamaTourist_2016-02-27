//
//  DuringVocationCellTableViewCell.h
//  lvmamaTourist
//
//  Created by Earth on 16/3/12.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"

@interface DuringVocationCellTableViewCell : UITableViewCell

- (void)setViewWithData:(TopicModel *)modelData withController:(UIViewController *)controller;
@end
