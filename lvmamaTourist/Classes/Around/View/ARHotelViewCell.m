//
//  ARHotelViewCell.m
//  lvmamaTourist
//
//  Created by Earth on 16/2/23.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "ARHotelViewCell.h"
#import "UIImageView+WebCache.h"

@interface ARHotelViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageOfMain;
@property (weak, nonatomic) IBOutlet UILabel *labelOfName;
@property (weak, nonatomic) IBOutlet UILabel *labelOfHotelDescribe;
@property (weak, nonatomic) IBOutlet UIImageView *imageOfWifi;
@property (weak, nonatomic) IBOutlet UILabel *labelOfLocatePlace;
@property (weak, nonatomic) IBOutlet UILabel *labelOfPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelOfReturnPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelOfDistance;


@end

@implementation ARHotelViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellWithData:(ARHotelModel *)model withController:(ARAroundViewController *)controller
{
    [self clearCell];
    
    self.labelOfLocatePlace.text = model.address;
    self.labelOfReturnPrice.text = model.cashBack;
    self.labelOfDistance.text = model.distance;
    if (![model.freeWifi isEqualToString:@"1"])
    {
        self.imageOfWifi.hidden = YES;
    }
    else
    {
        self.imageOfWifi.hidden = NO;
    }
    
    self.labelOfHotelDescribe.text = model.placeType;
    
    [self.imageOfMain sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:[UIImage imageNamed:@"defaultCellImage"]];
    
    self.labelOfName.text = model.name;
    
    self.labelOfPrice.text = model.sellPrice;
}

- (void)onTap
{
    
}

- (void)clearCell
{
    self.labelOfLocatePlace.text = nil;
    self.labelOfReturnPrice.text = nil;
    self.labelOfDistance.text = @"0m";
    self.imageOfWifi.hidden = YES;
    self.labelOfHotelDescribe.text = nil;
    self.imageOfMain.image = [UIImage imageNamed:@"defaultCellImage"];
    self.labelOfName.text = nil;
    self.labelOfPrice.text = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
