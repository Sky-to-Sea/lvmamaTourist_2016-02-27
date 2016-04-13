//
//  TNHeaderView.h
//  lvmamaTourist
//
//  Created by Earth on 16/2/19.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TNHeaderView : UIView

//  行程第几天
@property (weak, nonatomic) IBOutlet UILabel *numberOfDay;
//  行程日期
@property (weak, nonatomic) IBOutlet UILabel *dayOfTravelDay;

+ (TNHeaderView *)loadHeader;

@end
