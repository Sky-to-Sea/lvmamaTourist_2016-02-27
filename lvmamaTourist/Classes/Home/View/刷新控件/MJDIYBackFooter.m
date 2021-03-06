//
//  MJDIYBackFooter.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJDIYBackFooter.h"

@interface MJDIYBackFooter()
@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UIImageView *logo;
@property (weak, nonatomic) UIActivityIndicatorView *loading;
@property (strong, nonatomic) NSMutableAttributedString *iconString;

@end

@implementation MJDIYBackFooter
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:17 weight:1];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    
    // logo
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:logo];
    self.logo = logo;
    
    // loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loading.color = [UIColor colorWithRed:210/256.0 green:6/256.0 blue:133/256.0 alpha:1];
    [self addSubview:loading];
    self.loading = loading;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.label.frame = self.bounds;
    
    self.logo.bounds = CGRectMake(0, 0, self.bounds.size.width, 100);
    self.logo.center = CGPointMake(self.mj_w * 0.5, self.mj_h + self.logo.mj_h * 0.5);
    
    self.loading.center = CGPointMake(35, self.mj_h - 25);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    // icon
    NSTextAttachment *icon = [[NSTextAttachment alloc]init];
    icon.image = [UIImage imageNamed:@"activityLvImage"];
    icon.bounds = CGRectMake(0, -10, 40, 40);
    
    switch (state) {
        case MJRefreshStateIdle:
        {
            [self.loading stopAnimating];
            
            self.iconString = [[NSMutableAttributedString alloc]initWithString:@"  上拉查看更多..." attributes:nil];
            NSAttributedString  *text = [NSAttributedString attributedStringWithAttachment:icon];
            [self.iconString insertAttributedString:text atIndex:0];
            self.label.attributedText =self.iconString;

            break;
        }
        case MJRefreshStatePulling:
        {
            [self.loading stopAnimating];
            
            self.iconString = [[NSMutableAttributedString alloc]initWithString:@"  松开即可刷新..." attributes:nil];
            NSAttributedString  *text = [NSAttributedString attributedStringWithAttachment:icon];
            [self.iconString insertAttributedString:text atIndex:0];
            self.label.attributedText =self.iconString;

            break;
        }
        case MJRefreshStateRefreshing:
        {
            [self.loading startAnimating];
            
            self.iconString = [[NSMutableAttributedString alloc]initWithString:@"  正在加载.." attributes:nil];
            NSAttributedString  *text = [NSAttributedString attributedStringWithAttachment:icon];
            [self.iconString insertAttributedString:text atIndex:0];
            self.label.attributedText =self.iconString;

            break;
        }
        case MJRefreshStateNoMoreData:
        {
            [self.loading stopAnimating];
            
            self.iconString = [[NSMutableAttributedString alloc]initWithString:@"  已加载显示完全部内容" attributes:nil];
            NSAttributedString  *text = [NSAttributedString attributedStringWithAttachment:icon];
            [self.iconString insertAttributedString:text atIndex:0];
            self.label.attributedText =self.iconString;
            
            break;
        }
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
}

@end
