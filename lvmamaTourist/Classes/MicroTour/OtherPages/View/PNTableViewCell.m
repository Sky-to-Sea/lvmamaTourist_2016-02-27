//
//  PNTableViewCell.m
//  lvmamaTourist
//
//  Created by Earth on 16/2/22.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "PNTableViewCell.h"
#import "UIImageView+WebCache.h"

#import "PMTableViewController.h"
#import "TableViewController.h"


@interface PNTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageOfLarge;
@property (weak, nonatomic) IBOutlet UILabel *labelOfDescrib;
@property (weak, nonatomic) IBOutlet UILabel *labelOfTripDay;
@property (weak, nonatomic) IBOutlet UILabel *labelOfTripDays;

@property (nonatomic, strong) NSString *tripId;
@property (nonatomic, strong) PMTableViewController *tableViewController;

@end

@implementation PNTableViewCell


- (void)setCellWithData:(PNTableViewCellModel *)modelData controller:(PMTableViewController *)controller
{
    self.tripId = modelData.tripId;
    self.tableViewController = controller;
    
    self.imageOfLarge.contentMode = UIViewContentModeScaleAspectFill;
    self.imageOfLarge.clipsToBounds = YES;
    [self.imageOfLarge sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://pic.lvmama.com%@",modelData.coverImg]] placeholderImage:[UIImage imageNamed:@"defaultDetailImage"]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapAction)];
    [self.imageOfLarge addGestureRecognizer:tap ];
    
    self.labelOfDescrib.text = modelData.title;
    self.labelOfTripDays.text = [NSString stringWithFormat:@"%@天",modelData.dayCount];
    self.labelOfTripDay.text =[self formatteSecondToDay:modelData.visitTime];
    
    self.height = self.contentView.height;
}

- (void)onTapAction
{
    NSString *urlString = [NSString stringWithFormat:@"http://api3g2.lvmama.com/trip/router/rest.do?method=api.com.trip.note.details&version=1.0.0&tripId=%@&udid=000000000000000&formate=json",self.tripId];
    
    TableViewController *tableView = [[TableViewController alloc]init];
    tableView.urlString = urlString;
    
    self.tableViewController.hidesBottomBarWhenPushed = YES;
    
    [self.tableViewController.navigationController pushViewController:tableView animated:YES];
}

- (NSString *)formatteSecondToDay:(NSString *)visitTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yy年MM月dd日"];
    return [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[visitTime integerValue]]];
}

@end
