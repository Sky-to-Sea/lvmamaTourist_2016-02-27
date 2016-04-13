//
//  LMMTapGestureRecognizer.h
//  lvmamaTourist
//
//  Created by Earth on 15/12/6.
//  Copyright © 2015年 Earth. All rights reserved.
//
//  这用来给图片轮播器添加url跳转路径

#import <UIKit/UIKit.h>
#import "Model_scrollImage.h"
#import "LocationPlaceModel.h"
#import "TopicModel.h"

@interface LMMTapGestureRecognizer : UITapGestureRecognizer

/**
 *  触发手势时,传递整个数据模型
 */
@property (nonatomic, strong) Model_scrollImage *model;
@property (nonatomic, strong) LocationPlaceModel *locationModel;
@property (nonatomic, strong) TopicModel *topicModel;
/**
 *  触发手势时,传递当前手势视图
 */
@property (nonatomic, strong) UIView *actionView;

@property (nonatomic, strong) UIViewController *viewController;

@end
