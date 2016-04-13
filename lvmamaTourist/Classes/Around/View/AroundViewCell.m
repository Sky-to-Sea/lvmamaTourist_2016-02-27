//
//  AroundViewCell.m
//  lvmamaTourist
//
//  Created by Earth on 15/12/13.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import "AroundViewCell.h"
#import "UIImageView+WebCache.h"
#import "ARPlaceIntroductViewController.h"

@interface AroundViewCell()

@property (weak, nonatomic) IBOutlet UILabel *describText;

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel     *productTitle;
@property (weak, nonatomic) IBOutlet UILabel     *adressOne;
@property (weak, nonatomic) IBOutlet UILabel     *adressTwo;
@property (weak, nonatomic) IBOutlet UILabel     *theStar;
@property (weak, nonatomic) IBOutlet UILabel     *todayAble;
@property (weak, nonatomic) IBOutlet UILabel     *freeInsurance;
@property (weak, nonatomic) IBOutlet UILabel     *theInstance;
@property (weak, nonatomic) IBOutlet UILabel     *sellPrice;
@property (weak, nonatomic) IBOutlet UILabel     *marketPrice;
@property (weak, nonatomic) IBOutlet UILabel     *promotingFlag;
@property (weak, nonatomic) IBOutlet UILabel     *crashBack;
@property (weak, nonatomic) IBOutlet UILabel     *crashBaceNum;

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) ARAroundViewController *controller;

@end

@implementation AroundViewCell


- (void)setAroundPalaceData:(Model_Around *)modelData withController:(ARAroundViewController *)controller
{

    [self.mainImage sd_setImageWithURL:[NSURL URLWithString:modelData.middleImage] placeholderImage:[UIImage imageNamed:@"defaultCellImage"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        LMMLog(@"图片加载还算成功");
        
    }];
    
    self.productId = modelData.productId;
    self.controller = controller;
    
    self.mainImage.contentMode = UIViewContentModeScaleAspectFill;
    
    self.productTitle.text = modelData.productName;
    self.adressOne.text = modelData.provinceName;
    self.adressTwo.text = modelData.cityName;
    self.theStar.text = modelData.star;
    
    self.describText.text = modelData.subject;
    self.crashBaceNum.text = modelData.sellPrice;
    
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *deletePrice = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%@", modelData.marketPrice] attributes:attribtDic] ;
    
    self.marketPrice.attributedText = deletePrice;

    if ([modelData.orderTodayAble isEqualToString: @"1"])
    {
        self.todayAble.hidden = NO;
    }
    else
    {
        self.todayAble.hidden = YES;
    }
    

}


- (void)awakeFromNib
{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
