//
//  WonderfulCell.m
//  lvmamaTourist
//
//  Created by Earth on 15/12/7.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import "WonderfulCell.h"
#import "LMMTapGestureRecognizer.h"
#import "UIImageView+WebCache.h"

@interface WonderfulCell ()

@property (weak, nonatomic) IBOutlet UIImageView *LargeImage;
@property (weak, nonatomic) IBOutlet UIImageView *smallImageOne;
@property (weak, nonatomic) IBOutlet UIImageView *smallImageTwo;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wonderfulHeight;

@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation WonderfulCell

- (NSMutableArray *)imageArray
{
    if (!_imageArray)
    {
        _imageArray = [NSMutableArray arrayWithObjects:self.LargeImage,self.smallImageOne,self.smallImageTwo, nil];
    }
    return _imageArray;
}

-(void)setWonderImage:(NSMutableArray *)imageData
{

    //self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (int i = 0 ; i < imageData.count ; i ++)
    {
        LMMTapGestureRecognizer *gesture = [[LMMTapGestureRecognizer alloc]initWithTarget:self action:@selector(onClick:)];
        
        [self.imageArray[i] addGestureRecognizer:gesture];
        
        gesture.model = imageData[i];
        gesture.actionView = self.imageArray[i];
        
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


- (void) animation:(UIView *)view
{
    
    [view.superview bringSubviewToFront:view];
    [UIView animateWithDuration:0.2 animations:^{
        view.alpha = 0.7;
        view.transform = CGAffineTransformMakeScale(1.3,1.3);
    } completion:^(BOOL finished) {
        if (finished)
        {
            [UIView animateWithDuration:0.2 animations:^{
                view.transform = CGAffineTransformMakeScale(1, 1);
                view.alpha = 1;
            } completion:^(BOOL finished) {
                
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
