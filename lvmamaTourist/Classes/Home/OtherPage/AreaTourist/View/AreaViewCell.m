//
//  AreaViewCell.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/12.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "AreaViewCell.h"
#import "UIImageView+WebCache.h"
#import "LMMTapGestureRecognizer.h"
#import "LMMWebViewController.h"

@interface AreaViewCell ()

@property (nonatomic, strong) UIViewController *controller;

@end

@implementation AreaViewCell

- (void)setCellWithData:(TopicModel *)model withController:(UIViewController *)controller
{
    self.controller = controller;
    
    [self.imageOfMain sd_setImageWithURL:[NSURL URLWithString:model.large_image] placeholderImage:[UIImage imageNamed:@"defaultDetailImage"]];
    self.labelOfTitle.text = model.title;
    self.labelOfDetail.text = model.content;
    
    LMMTapGestureRecognizer *tap = [[LMMTapGestureRecognizer alloc]initWithTarget:self action:@selector(onClick:)];
    tap.topicModel = model;
    [self.imageOfMain addGestureRecognizer:tap];
    
}

- (void)onClick:(LMMTapGestureRecognizer *)tapGesture
{
    LMMWebViewController *viewCtl = [[LMMWebViewController alloc]init];
    viewCtl.urlString = tapGesture.topicModel.url;
    viewCtl.titleName = tapGesture.topicModel.title;
    
    [self.controller.navigationController pushViewController:viewCtl animated:YES];
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
