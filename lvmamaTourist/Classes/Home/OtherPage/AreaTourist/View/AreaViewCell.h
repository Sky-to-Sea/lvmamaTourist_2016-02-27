//
//  AreaViewCell.h
//  lvmamaTourist
//
//  Created by Earth on 16/3/12.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"

@protocol AreaViewCellDelegate <NSObject>

@required

- (void)setCellHeight:(NSInteger)height withIndexPath:(NSIndexPath *)indexPath;

@end

@interface AreaViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageOfMain;
@property (weak, nonatomic) IBOutlet UILabel *labelOfTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelOfDetail;

- (void)setCellWithData:(TopicModel *)model withController:(UIViewController *)controller;

@end
