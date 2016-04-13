//
//  DuringVocationCellTableViewCell.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/12.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "DuringVocationCellTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "LMMWebViewController.h"

@interface DuringVocationCellTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UIView *contentnerView;

@property (nonatomic, strong) TopicModel *model;

@property (nonatomic, strong) UIViewController *controller;

@end

@implementation DuringVocationCellTableViewCell

- (void)setViewWithData:(TopicModel *)modelData withController:(UIViewController *)controller
{
    self.model = modelData;
    self.controller = controller;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleLabel.text = modelData.title;
    self.describeLabel.text = modelData.content;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClick:)];
    
    [self.contentnerView addGestureRecognizer:tapGesture];
    
    NSString *imageString = modelData.large_image;
    
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"defaultBannerImage"]];
}

- (void) onClick:(UITapGestureRecognizer *) tapGesture
{
    LMMWebViewController *webView = [[LMMWebViewController alloc]init];
    webView.urlString = _model.url;
    webView.titleName = _model.title;
    
    webView.hidesBottomBarWhenPushed = YES;
    
    [self.controller.navigationController pushViewController:webView animated:YES];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
