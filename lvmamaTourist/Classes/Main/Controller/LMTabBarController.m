//
//  LMTabBarController.m
//  lvmama
//
//  Created by Earth on 15/11/17.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import "LMTabBarController.h"
#import "HomeViewController.h"
#import "MicroViewController.h"
#import "AroundViewController.h"
#import "ProfileViewController.h"


@interface LMTabBarController ()

@end

@implementation LMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    HomeViewController *home = [[HomeViewController alloc]init];
    [self addChildViewController:home imageNumber:@"0"];
    
    MicroViewController *micro = [[MicroViewController alloc]init];
    [self addChildViewController:micro imageNumber:@"1"];
    
    AroundViewController *around = [[AroundViewController alloc]init];
    [self addChildViewController:around imageNumber:@"2"];
    
    ProfileViewController *profile = [[ProfileViewController alloc]init];
    [self addChildViewController:profile imageNumber:@"3"];
    
}

- (void)addChildViewController:(UIViewController *)childController imageNumber:(NSString *)imageNumber
{
    childController.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"tabIcon%@",imageNumber]];
    UIImage *image =  [UIImage imageNamed:[NSString stringWithFormat:@"tabIconSel%@",imageNumber]];
    childController.tabBarItem.selectedImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 没有title情况下,图片居中.
    childController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    UINavigationController *navCtl = [[UINavigationController alloc]initWithRootViewController:childController];
    [self addChildViewController:navCtl];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
