//
//  SpecialView_new.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/11.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "SpecialView_new.h"
#import "TopicModel.h"
#import "UIImageView+WebCache.h"
#import "LMMWebViewController.h"

@interface SpecialView_new ()

@property (weak, nonatomic  ) IBOutlet UIImageView    *smallOne;
@property (weak, nonatomic  ) IBOutlet UIImageView    *smallTwo;
@property (weak, nonatomic  ) IBOutlet UIImageView    *smallThree;
@property (weak, nonatomic  ) IBOutlet UIImageView    *smallFour;
@property (weak, nonatomic  ) IBOutlet UIImageView    *smallFive;
@property (weak, nonatomic  ) IBOutlet UIImageView    *smallSix;
@property (weak, nonatomic  ) IBOutlet UIImageView    *smallSeven;
@property (weak, nonatomic  ) IBOutlet UIImageView    *smallEight;

@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *modelArray;

@property (nonatomic, strong) UIViewController *controller;

@end

@implementation SpecialView_new

- (NSMutableArray *)imageArray
{
    if (!_imageArray)
    {
        _imageArray = [NSMutableArray arrayWithObjects:self.smallOne,self.smallTwo,self.smallThree,self.smallFour,self.smallFive,self.smallSix,self.smallSeven,self.smallEight, nil];
    }
    return _imageArray;
}

+ (SpecialView_new *)specialView
{
    SpecialView_new *view = [[[NSBundle mainBundle] loadNibNamed:@"SpecialView_new" owner:nil options:nil] lastObject];
    return view;
}

- (void) setSmallImage:(NSMutableArray *)imageData withController:(UIViewController *)controller
{
    self.modelArray = imageData;
    self.controller = controller;
    
    for (int i = 0 ; i < imageData.count ; i ++)
    {
        UIImageView *imageView = self.imageArray[i];
        imageView.tag = i;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClick:)];
        [imageView addGestureRecognizer:gesture];
        
        TopicModel *model = imageData[i];
        
        NSString *imageString = [model large_image];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"defaultActionLLoading"]];
    }
}

- (void) onClick: (UITapGestureRecognizer *)tapGesture
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
    
}


//  动画效果

- (void) animation:(UIView *)view withController:(UIViewController *)viewCtl
{
    [UIView animateWithDuration:0.1 animations:^{
        view.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        if (finished)
        {
            [UIView animateWithDuration:0.2 animations:^{
                view.transform = CGAffineTransformMakeScale(1, 1);
                
            } completion:^(BOOL finished) {
                        [self.controller.navigationController pushViewController:viewCtl animated:YES];
            }];
        }
    }];
}


@end
