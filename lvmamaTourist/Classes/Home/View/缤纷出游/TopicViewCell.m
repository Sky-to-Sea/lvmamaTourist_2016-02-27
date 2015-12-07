//
//  TopicViewCell.m
//  lvmamaTourist
//
//  Created by Earth on 15/12/4.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import "TopicViewCell.h"
#import "LMMTapGestureRecognizer.h"
#import "UIImageView+WebCache.h"

@interface TopicViewCell ()

@property (weak, nonatomic  ) IBOutlet UIImageView        *topicOne;
@property (weak, nonatomic  ) IBOutlet UIImageView        *topicTwo;
@property (weak, nonatomic  ) IBOutlet UIImageView        *topicThree;
@property (weak, nonatomic  ) IBOutlet UIImageView        *topicFour;
@property (weak, nonatomic  ) IBOutlet UIImageView        *topicFive;
@property (weak, nonatomic  ) IBOutlet UIImageView        *topicSix;

@property (weak, nonatomic  ) IBOutlet NSLayoutConstraint *colorfulHeight;

@property (nonatomic, strong) NSMutableArray              *imageArray;
@property (nonatomic, strong) NSMutableArray              *imageData;

@end

@implementation TopicViewCell

#pragma mark    -   懒加载

- (NSMutableArray *) imageArray
{
    if (!_imageArray)
    {
        _imageArray = [NSMutableArray arrayWithObjects:self.topicOne,self.topicTwo,self.topicThree,self.topicFour,self.topicFive.self,self.topicSix,nil];
    }
    return _imageArray;
}

- (NSMutableArray *)imageData
{
    if (!_imageData)
    {
        _imageData = [[NSMutableArray alloc]init];
    }
    return _imageData;
}

#pragma mark    -   加载图片的方法
- (void)setTopicImage:(NSMutableArray *)imageData
{

    self.colorfulHeight.constant     = WIDTH * 10 / 60;
    self.selectionStyle              = UITableViewCellSelectionStyleNone;
    self.backgroundColor             = [UIColor clearColor] ;

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


- (void) onClick:(LMMTapGestureRecognizer *)tapGesture
{
    if ([tapGesture.model.type isEqualToString:@"url"])
    {
        LMMLog(@"跳转到 : %@",tapGesture.model.url);
    }
    else if ([tapGesture.model.type isEqualToString:@"localFile"])
    {
        LMMLog(@"当前貌似处于离线状态,无法跳转");
    }
    else if ([tapGesture.model.type isEqualToString:@"place"])
    {
        LMMLog(@"这是一个place");
    }
    else if ([tapGesture.model.type isEqualToString:@"pindao"])
    {
        LMMLog(@"这是一个pindao");
    }
    
    //  添加动画,点击弹跳效果
    [self animation:tapGesture.actionView];
}


//  动画效果

- (void) animation:(UIView *)view
{
    [UIView animateWithDuration:0.15 animations:^{
        view.transform = CGAffineTransformMakeScale(0.7, 0.7);
    } completion:^(BOOL finished) {
        if (finished)
        {
            [UIView animateWithDuration:0.17 animations:^{
                view.transform = CGAffineTransformScale(self.transform, 1.1, 1.1);
            } completion:^(BOOL finished) {
                if (finished)
                {
                    [UIView animateWithDuration:0.17 animations:^{
                        view.transform = CGAffineTransformMakeScale(0.9, 0.9);
                    } completion:^(BOOL finished) {
                        if (finished)
                        {
                            [UIView animateWithDuration:0.15 animations:^{
                                view.transform = CGAffineTransformMakeScale(1, 1);
                            } completion:^(BOOL finished) {
                                //LMMLog(@"跳转到:%@",);
                            }];
                        }
                    }];
                }
            }];
        }
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
