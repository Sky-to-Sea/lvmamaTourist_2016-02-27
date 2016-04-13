//
//  ARScrollImageView.m
//  lvmamaTourist
//
//  Created by Earth on 16/2/26.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "ARScrollImageView.h"
#import "UIImageView+WebCache.h"
#import "SDPhotoBrowser.h"

@interface ARScrollImageView ()<UIScrollViewDelegate,SDPhotoBrowserDelegate>

/**
 *  定时器
 */
@property (nonatomic, strong) NSTimer           *timer;
/**
 *  flag记录当前滚动到的页面
 */
@property (nonatomic, assign) int               pageNumber;
/**
 *  页面控制器
 */
@property (nonatomic, strong) UIPageControl     *pageControl;
/**
 *  滚动视图总页面
 */
@property (nonatomic, assign) int               totalPage;

@property (nonatomic, strong) NSMutableArray   *imagesData;

@end

@implementation ARScrollImageView

- (instancetype)initWithData:(NSArray *)images
{
    ARScrollImageView *view = [[ARScrollImageView alloc]init];
    
    [view setCellWithImageArray:images];
    
    self.imagesData = images;
    
    view.size  = CGSizeMake(WIDTH, 150);
    
    return view;
}

-(void)dealloc;
{
    // 析构函数中顺便把定时器也销毁.
    [self.timer invalidate];
    self.timer = nil;
}

- (NSTimer *)timer
{
    if (!_timer)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(beforeExpired) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl)
    {
        _pageControl = [[UIPageControl alloc]init];
    }
    return _pageControl;
}

- (void)setCellWithImageArray:(NSArray *)images
{
    
    self.pageNumber = 1;
    self.totalPage = (int)images.count;
    //  设置scrollView(这里需要修改)
    self.contentSize = CGSizeMake(WIDTH * images.count, 150);
    self.bounces                        = NO;
    self.pagingEnabled                  = YES;
    self.clipsToBounds = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.userInteractionEnabled = YES;
    
    //  加载图片并设置跳转url
    for (int i = 0; i < images.count; i ++)
    {
        //  根据图片的数量,设置imageView 在 scrollView 上的布局.
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * i, 0, WIDTH, 150)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        
        NSString *imageString = images[i];
        
        //  加载网络图片
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"defaultDetailImage"]];
        [self addSubview:imageView];
        
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browser:)];
        [imageView addGestureRecognizer:tap];
    }
    
    //  用self.timer调用懒加载,启动定时器(可以考虑将它放到上面complete里面去.)
    self.timer;
    
    self.height = self.contentSize.height;
    self.width = self.contentSize.width;
}

- (void)beforeExpired
{
    [self performSelectorOnMainThread:@selector(onExpired) withObject:nil waitUntilDone:YES];
}

/**
 *  滚图的方法∂
 */
- (void) onExpired
{
    
    self.pageNumber = self.contentOffset.x/WIDTH + 1;
    
    if (self.pageNumber == self.totalPage)
    {
        self.pageNumber = 0;
    }
    
    [self scrollRectToVisible:CGRectMake(WIDTH * self.pageNumber, 0, WIDTH, self.frame.size.height) animated:YES];
    
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

- (void)browser:(UITapGestureRecognizer *)tap
{
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc]init];
    browser.sourceImagesContainerView = self.viewCtl.view;
    
    browser.imageCount = self.totalPage;
    browser.currentImageIndex = tap.view.tag;
    browser.delegate = self;
    
    [browser show];
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    for (UIImageView *imageView in self.subviews)
    {
        if ([imageView isKindOfClass:[UIImageView class]]&&imageView.tag == index)
        {
            return imageView.image;
        }
    }
    return nil;
}

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSURL *url = [NSURL URLWithString:self.imagesData[index]];
    return url;
}

@end
