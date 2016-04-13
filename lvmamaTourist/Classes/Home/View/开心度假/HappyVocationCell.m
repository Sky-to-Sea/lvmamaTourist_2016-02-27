//
//  HappyVocationCell.m
//  lvmamaTourist
//
//  Created by Earth on 15/12/9.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import "HappyVocationCell.h"
#import "LMMTapGestureRecognizer.h"
#import "Model_scrollImage.h"
#import "UIImageView+WebCache.h"

@interface HappyVocationCell ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UIView *contentnerView;

@end

@implementation HappyVocationCell

- (void)setHappyImage:(Model_scrollImage *)modelData
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleLabel.text = modelData.title;
    self.describeLabel.text = modelData.content;
    
    LMMTapGestureRecognizer *tapGesture = [[LMMTapGestureRecognizer alloc]initWithTarget:self action:@selector(onClick:)];
    tapGesture.model = modelData;
    
    [self.contentnerView addGestureRecognizer:tapGesture];
    
    NSString *imageString = modelData.large_image;

    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error)
        {
            LMMLog(@"加载失败");
        }
        else
        {
            
        }
    }];
}

- (void) onClick:(LMMTapGestureRecognizer *) tapGesture
{
    LMMLog(@"业务类型 : %@",tapGesture.model.type);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
