//
//  HomePageViewController.h
//  lvmamaTourist
//
//  Created by Earth on 16/3/11.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "scrollImageViewCell.h"

@interface HomePageViewController : UIViewController

//  选择地点按钮
@property (weak, nonatomic) IBOutlet UIButton *buttonOfSelectLocation;

//  滚动视图
@property (weak, nonatomic) IBOutlet UIView *contentViewOfScrollView;

//  缤纷出行
@property (weak, nonatomic) IBOutlet UIView *contentViewOfColorfulView;

//  特色业务
@property (weak, nonatomic) IBOutlet UIView *contentViewOfSpecialView;

//  度长短假
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//  度假数据源
@property (nonatomic, strong) NSMutableArray *dataSource;

//  当前地点
@property (weak, nonatomic) IBOutlet UILabel *labelOfPlace;


@end
