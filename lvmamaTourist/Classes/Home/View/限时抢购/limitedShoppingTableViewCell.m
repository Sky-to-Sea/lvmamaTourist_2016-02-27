//
//  limitedShoppingTableViewCell.m
//  lvmamaTourist
//
//  Created by Earth on 16/1/6.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "limitedShoppingTableViewCell.h"
#import "UIImageView+WebCache.h"

#define DAY  86400
#define HOUR 3600
#define MINUTE 60
#define SECOND 60

@interface limitedShoppingTableViewCell ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) int     time;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthOfImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthOfDetail;

@end



@implementation limitedShoppingTableViewCell

-(void)dealloc
{
    [_timer invalidate];
    _timer = nil;
}


- (void)setCellWithData:(limitedShopModel *)dict
{
    
    self.widthOfImageView.constant = WIDTH * 33.0/62.0;
    
    
    self.widthOfDetail.constant = self.widthOfImageView.constant * 24.0/33.0;
    
   [self.imageOfDetail sd_setImageWithURL:[NSURL URLWithString:dict.large_image] placeholderImage:[UIImage imageNamed:@"defaultBannerImage"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
   }];
    
    self.labelOfDescribe.text = dict.title;
    
    self.labelOfPrice.text = dict.price;
    
    self.time = (int)[dict.left_time integerValue];
   
    if (![_timer isValid])
    {
       _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refreshedTime) userInfo:nil repeats:YES];
    }
}

- (void)refreshedTime
{
    self.time --;
    
    self.labelOfDay.text = [NSString stringWithFormat:@"%.2d", self.time/DAY];
    
    self.labelOfHour.text = [NSString stringWithFormat:@"%.2d", self.time%DAY/HOUR];
    
    self.labelOfMinute.text = [NSString stringWithFormat:@"%.2d",self.time%HOUR/MINUTE];
    
    self.labelOfSecond.text = [NSString stringWithFormat:@"%.2d",self.time%SECOND];
    }


- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.height = WIDTH * 28.4/62.0;
   
    

    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
