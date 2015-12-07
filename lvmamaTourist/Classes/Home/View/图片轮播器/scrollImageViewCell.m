//
//  scrollImageViewCell.m
//  lvmamaTourist
//
//  Created by Earth on 15/11/28.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import "scrollImageViewCell.h"
#import "UIImageView+WebCache.h"
#import "LMMTapGestureRecognizer.h"

@interface scrollImageViewCell() <UIScrollViewDelegate>

/**
 *  网络图片地址
 */
@property (nonatomic, strong) NSMutableArray    *imageDataArray;
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

@end

@implementation scrollImageViewCell


-(void)dealloc
{
    // 析构函数中顺便把定时器也销毁.
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - 懒加载

- (NSMutableArray *)imageDataArray
{
    if (!_imageDataArray)
    {
        _imageDataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _imageDataArray;
}


- (NSTimer *)timer
{
    if (!_timer)
    {
        //  定时器的设置
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(onExpired) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (UIScrollView *)scrollImageView
{
    if (!_scrollImageView)
    {
        _scrollImageView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH * 20 / 60)];
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

- (void)setScrollViewImage:(NSMutableArray *)imageData
{
    self.pageNumber = 1;
    
    
    //  从数据中挨个取出图片地址和跳转地址
    for (Model_scrollImage *imageString in imageData)
    {
        [self.imageDataArray addObject:imageString];
    }
    
    //  约束cell视图宽高的比例
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:62/20 constant:0]];
    
   // self.backgroundColor = [UIColor clearColor];
    
    //  设置scrollView(这里需要修改)
    self.scrollImageView.contentSize                = CGSizeMake(WIDTH * _imageDataArray.count, self.frame.size.height);
    _scrollImageView.bounces                        = NO;
    _scrollImageView.pagingEnabled                  = YES;
    _scrollImageView.showsHorizontalScrollIndicator = NO;
    
    
    //  加载图片并设置跳转url
    for (int i = 0; i < _imageDataArray.count; i ++)
    {
        //  根据图片的数量,设置imageView 在 scrollView 上的布局.
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * i, 0, WIDTH, _scrollImageView.frame.size.height)];
        
        //  给视图添加手势
        LMMTapGestureRecognizer *tapGesture = [[LMMTapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpTo:)];
        
        tapGesture.model = _imageDataArray[i];

        //  允许UIImageView控件能够交互
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tapGesture];
        
        NSString *imageString = [_imageDataArray[i] large_image];
        
        //  加载网络图片
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"defaultDestDetailImage"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (error)
            {
                LMMLog(@"加载第%d张图片失败",i);
            }
            else
            {
                // LMMLog(@"加载图片成功");
                [_scrollImageView addSubview:imageView];
                [self.contentView addSubview:_scrollImageView];
            }
        }];
    }
    
    
    //  用self.timer调用懒加载,启动定时器(可以考虑将它放到上面complete里面去.)
    self.timer;
    
    _scrollImageView.delegate = self;
    
}


#pragma mark - 自定义的方法

/**
 *  点击图片的跳转方法
 */
- (void) jumpTo:(LMMTapGestureRecognizer *)gestureTap
{
    if ([gestureTap.model.type isEqualToString: @"url"])
    {
        LMMLog(@"跳转到:%@",gestureTap.model.url);
    }
    else if ([gestureTap.model.type isEqualToString:@"place"])
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
    
    if (self.pageNumber == _imageDataArray.count)
    {
        self.pageNumber = 0;
    }
    
    [_scrollImageView scrollRectToVisible:CGRectMake(WIDTH * self.pageNumber, 0, WIDTH, _scrollImageView.frame.size.height) animated:YES];
    
}



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
    self.timer;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
