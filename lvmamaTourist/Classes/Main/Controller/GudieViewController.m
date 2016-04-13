//
//  GudieViewController.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/19.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "GudieViewController.h"

@interface GudieViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageCtl;

@end

@implementation GudieViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView.delegate = self;
    
    NSMutableArray *imagesName = [[NSMutableArray alloc]initWithObjects:@"001",@"002",@"003",@"004", nil];
    
    self.scrollView.contentSize = CGSizeMake(WIDTH * imagesName.count, HEIGHT);
    
    for (int i = 0; i < imagesName.count; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * i, 0, WIDTH, HEIGHT)];
        imageView.image = [UIImage imageNamed:imagesName[i]];
        
        [self.scrollView addSubview:imageView];
        
        if (i == imagesName.count - 1)
        {
            _button = [[UIButton alloc]initWithFrame:CGRectMake((WIDTH - 130)/2.0, HEIGHT - 65, 130, 35)];
            _button.backgroundColor = [UIColor clearColor];
            imageView.userInteractionEnabled = YES;
            [imageView addSubview:_button];
        }
    }
    
    _pageCtl = [[UIPageControl alloc]initWithFrame:CGRectMake((WIDTH - 80) / 2, HEIGHT - 30, 80, 30)];
    _pageCtl.numberOfPages = imagesName.count;
    [self.view addSubview:_pageCtl];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = self.scrollView.contentOffset.x/WIDTH;
    
    self.pageCtl.currentPage = index;
}




@end
