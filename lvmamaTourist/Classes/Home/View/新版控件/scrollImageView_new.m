//
//  scrollImageView_new.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/11.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "scrollImageView_new.h"
#import "UIImageView+WebCache.h"
#import "LMMTapGestureRecognizer.h"
#import "WebViewController.h"
#import "Model_scrollImage.h"
#import "LMMWebViewController.h"

@interface scrollImageView_new ()<UIScrollViewDelegate>

/**
 *  定时器
 */
@property (nonatomic, strong) NSTimer           *timer;
/**
 *  flag记录当前滚动到的页面
 */
@property (nonatomic, assign) int               pageNumber;
/**
 *  滚动视图
 */
@property (nonatomic, strong) UIScrollView      *scrollImageView;
/**
 *  页面控制器
 */
@property (nonatomic, strong) UIPageControl     *pageControl;

@property (nonatomic, assign) int               totalPage;

@property (nonatomic, strong) NSMutableArray *modelArray;

@property (nonatomic, strong) UIViewController *controller;

@end

@implementation scrollImageView_new


-(void)dealloc
{
    // 析构函数中顺便把定时器也销毁.
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - 懒加载

- (UIScrollView *)scrollImageView
{
    if (!_scrollImageView)
    {
        _scrollImageView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, self.height)];
    }
    return _scrollImageView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl)
    {
        _pageControl = [[UIPageControl alloc]init];
    }
    return _pageControl;
}

#pragma mark - 加载图片的方法

- (void)setScrollViewImage:(NSMutableArray *)imageData withController:(nullable UIViewController*)viewController
{
    self.pageNumber = 1;
    self.totalPage  = (int)imageData.count;
    self.controller = viewController;
        
    //  设置scrollView(这里需要修改)
    self.scrollImageView.contentSize = CGSizeMake(self.scrollImageView.width * imageData.count, self.height);
    _scrollImageView.bounces = NO;
    _scrollImageView.pagingEnabled = YES;
    _scrollImageView.showsHorizontalScrollIndicator = NO;
    
    self.modelArray = imageData;
    self.controller = viewController;
    
    //  加载图片并设置跳转url
    for (int i = 0; i < imageData.count; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * i, 0, WIDTH, self.height)];
        imageView.tag = i;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpTo:)];
        
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tapGesture];
        NSString *imageString = [imageData[i] large_image];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"defaultActionLLoading"]];

        [_scrollImageView addSubview:imageView];
    }
    
    [self addSubview:_scrollImageView];
    
    [self creatTimer];
    
    _scrollImageView.delegate = self;
}


#pragma mark - 自定义的方法

/**
 *  点击图片的跳转方法
 */
- (void) jumpTo:(UITapGestureRecognizer *)gestureTap
{
    Model_scrollImage *model = self.modelArray[gestureTap.view.tag];
    
    if ([model.type isEqualToString: @"url"])
    {
        LMMLog(@"跳转到:%@",model.url);
        
        LMMWebViewController *webView = [[LMMWebViewController alloc]init];
        webView.urlString = model.url;
        webView.titleName = model.title;
        
        webView.hidesBottomBarWhenPushed = YES;
        
        [self.controller.navigationController pushViewController:webView animated:YES];
    }
    else if ([model.type isEqualToString:@"place"])
    {
        LMMLog(@"这是一个place");
    }
}


/**
 *  滚图的方法
 */
- (void) onExpired
{
    self.pageNumber = _scrollImageView.contentOffset.x/WIDTH + 1;
    
    if (self.pageNumber == self.totalPage)
        self.pageNumber = 0;
    
    [_scrollImageView scrollRectToVisible:CGRectMake(WIDTH * self.pageNumber, 0, WIDTH, _scrollImageView.frame.size.height) animated:YES];
}

//- (void)


#define mark - UIScrollViewDelegate代理方法

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //  开始拖动图片的时候,销毁计时器.
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //  结束拖曳的时候,重生计时器.
    [self creatTimer];
}

#pragma mark    -   创建定时器

- (void)creatTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(onExpired) userInfo:nil repeats:YES];
}



@end
