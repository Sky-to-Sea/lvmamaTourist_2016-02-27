//
//  TopicView_new.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/11.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "TopicView_new.h"
#import "Model_scrollImage.h"
#import "UIImageView+WebCache.h"
#import "TopicModel.h"
#import "LMMWebViewController.h"
#import "AreaViewController.h"

@interface TopicView_new ()

@property (weak, nonatomic) IBOutlet UIImageView *topicOne;
@property (weak, nonatomic) IBOutlet UIImageView *topicTwo;
@property (weak, nonatomic) IBOutlet UIImageView *topicThree;
@property (weak, nonatomic) IBOutlet UIImageView *topicFour;
@property (weak, nonatomic) IBOutlet UIImageView *topicFive;
@property (weak, nonatomic) IBOutlet UIImageView *topicSix;

@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *modelArray;

@property (nonatomic, strong) UIViewController *controller;

@end

@implementation TopicView_new

+ (TopicView_new *)colorfulView
{
    TopicView_new *colorfulView = [[[NSBundle mainBundle] loadNibNamed:@"TopicView_new" owner:nil options:nil] lastObject];
    return colorfulView;
}


- (NSMutableArray *) imageArray
{
    if (!_imageArray)
    {
        _imageArray = [NSMutableArray arrayWithObjects:self.topicOne,self.topicTwo,self.topicThree,self.topicFour,self.topicFive,self.topicSix,nil];
    }
    return _imageArray;
}

- (void)setViewWithData:(NSMutableArray *)imageData withController:(UIViewController *)controller
{
    self.modelArray = imageData;
    self.backgroundColor = [UIColor clearColor];
    self.controller = controller;
    
    for (int i = 0 ; i < imageData.count ; i ++)
    {
        UIImageView *imageView = self.imageArray[i];
        imageView.tag = i;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClick:)];
        
        [imageView addGestureRecognizer:gesture];
        
        TopicModel *model = imageData[i];
        NSString *imageString = [model large_image];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"defaultBannerImage"]];
    }
}

- (void) onClick:(UITapGestureRecognizer *)tapGesture
{
    TopicModel *model = self.modelArray[tapGesture.view.tag];
    
    if ([model.type isEqualToString:@"url"])
    {
        LMMWebViewController *webView = [[LMMWebViewController alloc]init];
        webView.urlString = model.url;
        webView.titleName = model.title;
        
        webView.hidesBottomBarWhenPushed = YES;
                
        [self animation:tapGesture.view withController:webView];
    }
    else if ([model.type isEqualToString:@"place"])
    {
        LMMLog(@"这是一个place");
    }
    else if ([model.type isEqualToString:@"pindao"])
    {
        LMMLog(@"这是一个pindao");
    }
    
    if (tapGesture.view.tag == 3)
    {
        AreaViewController *viewCtl = [[AreaViewController alloc]init];
        
        viewCtl.hidesBottomBarWhenPushed = YES;
        [self animation:tapGesture.view withController:viewCtl];
    }
    
}


//  动画效果

- (void) animation:(UIView *)view withController:(UIViewController *)viewCtl
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
                                
                                [self.controller.navigationController pushViewController:viewCtl animated:YES];
                                
                            }];
                        }
                    }];
                }
            }];
        }
    }];
}

@end
