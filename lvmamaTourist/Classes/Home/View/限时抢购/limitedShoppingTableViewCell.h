//
//  limitedShoppingTableViewCell.h
//  lvmamaTourist
//
//  Created by Earth on 16/1/6.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "limitedShopModel.h"

@interface limitedShoppingTableViewCell : UITableViewCell

/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageOfDetail;
/**
 *  描述内容
 */
@property (weak, nonatomic) IBOutlet UILabel *labelOfDescribe;
/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UILabel *labelOfPrice;
/**
 *  日
 */
@property (weak, nonatomic) IBOutlet UILabel *labelOfDay;
/**
 *  小时
 */
@property (weak, nonatomic) IBOutlet UILabel *labelOfHour;
/**
 *  分钟
 */
@property (weak, nonatomic) IBOutlet UILabel *labelOfMinute;
/**
 *  秒
 */
@property (weak, nonatomic) IBOutlet UILabel *labelOfSecond;


- (void)setCellWithData:(limitedShopModel *)dict;

@end
