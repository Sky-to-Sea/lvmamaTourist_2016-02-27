//
//  PeculiarServicesCell.m
//  lvmamaTourist
//
//  Created by Earth on 15/12/7.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import "PeculiarServicesCell.h"
#import "LMMTapGestureRecognizer.h"
#import "UIImageView+WebCache.h"

@interface PeculiarServicesCell ()

@property (weak, nonatomic  ) IBOutlet UIImageView    *smallOne;
@property (weak, nonatomic  ) IBOutlet UIImageView    *smallTwo;
@property (weak, nonatomic  ) IBOutlet UIImageView    *smallThree;
@property (weak, nonatomic  ) IBOutlet UIImageView    *smallFour;
@property (weak, nonatomic  ) IBOutlet UIImageView    *smallFive;
@property (weak, nonatomic  ) IBOutlet UIImageView    *smallSix;
@property (weak, nonatomic  ) IBOutlet UIImageView    *smallSeven;
@property (weak, nonatomic  ) IBOutlet UIImageView    *smallEight;

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *smallImageHeight;


@end

@implementation PeculiarServicesCell

- (NSMutableArray *)imageArray
{
    if (!_imageArray)
    {
        _imageArray = [NSMutableArray arrayWithObjects:self.smallOne,self.smallTwo,self.smallThree,self.smallFour,self.smallFive,self.smallSix,self.smallSeven,self.smallEight, nil];
    }
    return _imageArray;
}

- (void) setSmallImage:(NSMutableArray *)imageData
{
    
    self.smallImageHeight.constant = 75;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (int i = 0 ; i < imageData.count ; i ++)
    {
        LMMTapGestureRecognizer *gesture = [[LMMTapGestureRecognizer alloc]initWithTarget:self action:@selector(onClick:)];
        
        gesture.model = imageData[i];
        gesture.actionView = self.imageArray[i];
        [self.imageArray[i] addGestureRecognizer:gesture];
        
        NSString *imageString = [imageData[i] large_image];
        
        [self.imageArray[i] sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (error)
            {
                LMMLog(@"图片加载失败");
            }
            else
            {
                
            }
        }];
        
    }
}

- (void) onClick: (LMMTapGestureRecognizer *)tapGesture
{
    LMMLog(@"业务类型是 : %@", tapGesture.model.type);
    
    [self animation:tapGesture.actionView];
}


//  动画效果

- (void) animation:(UIView *)view
{
    [UIView animateWithDuration:0.1 animations:^{
        view.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        if (finished)
        {
            [UIView animateWithDuration:0.2 animations:^{
                view.transform = CGAffineTransformMakeScale(1, 1);
                
            } completion:^(BOOL finished) {
                //LMMLog(@"跳转到:%@",);
            }];
        }
    }];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
