//
//  TourNoteCellTableViewCell.m
//  lvmamaTourist
//
//  Created by Earth on 15/12/10.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import "TourNoteCellTableViewCell.h"
#import "UIImageView+WebCache.h"

#import "AppDelegate.h"

#import "TableViewController.h"
#import "MicroViewController.h"
#import "PMTableViewController.h"

#define APPDELEGATE ((AppDelegate*)[[UIApplication sharedApplication] delegate])

@interface TourNoteCellTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel     *timeDataLabel;
@property (weak, nonatomic) IBOutlet UILabel     *lastTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel     *receiveCountLabel;
@property (weak, nonatomic) IBOutlet UILabel     *scoreCountLabel;
@property (weak, nonatomic) IBOutlet UILabel     *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfmainImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfSecondView;

@property (nonatomic, strong) NSString *tripId;
@property (nonatomic, strong) MicroViewController *controller;

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *headImageUrl;
@property (nonatomic, strong) NSString *userName;

@end

@implementation TourNoteCellTableViewCell

- (void)setTourData:(Model_TourNote *)modelData controller:(id)controller
{
    
    self.userId = modelData.userId;
    self.headImageUrl = modelData.userImg;
    
    self.heightOfmainImage.constant = WIDTH * 31.0/62.0;
    
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"http://pic.lvmama.com",modelData.coverImg]] placeholderImage:[UIImage imageNamed:@"defaultRecommendImage"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap)];
    [self.mainImageView addGestureRecognizer:tap];
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString: modelData.userImg] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    UITapGestureRecognizer *tapHead = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapHead)];
    [self.headImageView addGestureRecognizer:tapHead];
    
    self.userNameLabel.text = modelData.username;
    self.lastTimeLabel.text = [NSString stringWithFormat:@"%@天",modelData.dayCount];
    self.scoreCountLabel.text = modelData.favoriteCount;
    self.receiveCountLabel.text = modelData.commentCount;
    self.titleLabel.text = modelData.title;
    self.tripId = modelData.tripId;
    self.controller = controller;
    
    self.timeDataLabel.text = [self formateDateFormSecond:modelData.visitTime];
}

- (NSString *)formateDateFormSecond:(NSString *)second
{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy.MM.dd"];
    return [format stringFromDate:[NSDate dateWithTimeIntervalSince1970:[second integerValue]]];
}


- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)onTap
{
    NSString *urlString = [NSString stringWithFormat:@"http://api3g2.lvmama.com/trip/router/rest.do?method=api.com.trip.note.details&version=1.0.0&tripId=%@&udid=000000000000000&formate=json",self.tripId];
    
    self.controller.hidesBottomBarWhenPushed = YES;
    
    TableViewController *tableView = [[TableViewController alloc]init];
    tableView.urlString = urlString;
    
    [self.controller.navigationController pushViewController:tableView animated:YES];
    
    self.controller.hidesBottomBarWhenPushed = NO;
}

- (void)onTapHead
{
    PMTableViewController *view = [[PMTableViewController alloc]init];
    view.userId = _userId;
    view.headImageUrl = _headImageUrl;
    view.userName = self.userNameLabel.text;
    self.controller.hidesBottomBarWhenPushed = YES;
    [self.controller.navigationController pushViewController:view animated:YES];
    self.controller.hidesBottomBarWhenPushed = NO;
}


- (void)onBackTap:(id)sender
{
    [self.controller.navigationController popViewControllerAnimated:YES];
    self.controller.navigationController.navigationBarHidden = NO;
    
    for (UIView *view in self.controller.navigationController.navigationBar.subviews)
    {
        if (view.tag == 100)
        {
            [view removeFromSuperview];
        }
    }
    
}

@end
