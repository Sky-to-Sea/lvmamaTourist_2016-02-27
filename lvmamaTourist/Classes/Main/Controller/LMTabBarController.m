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
#import "FirstViewController.h"

#import "ARAroundViewController.h"
#import "HomePageViewController.h"


@interface LMTabBarController ()

@end

@implementation LMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    HomePageViewController  *_home = [[HomePageViewController alloc]init];
    [self addChildViewController:_home imageNumber:@"0"];
    [_home.navigationController setNavigationBarHidden:YES];
    [[NSNotificationCenter defaultCenter] addObserver:_home selector:@selector(changeData:) name:@"CHANGE_LOCATION" object:nil];
    
    MicroViewController *micro = [[MicroViewController alloc]init];
    [self addChildViewController:micro imageNumber:@"1"];
    
//    AroundViewController *around = [[AroundViewController alloc]init];
    ARAroundViewController *around = [[ARAroundViewController alloc]init];
    [self addChildViewController:around imageNumber:@"2"];
    [[NSNotificationCenter defaultCenter] addObserver:around selector:@selector(changeData:) name:@"CHANGE_LOCATION" object:nil];
    
//    ProfileViewController *profile = [[ProfileViewController alloc]init];
//    [self addChildViewController:profile imageNumber:@"3"];
    
    self.selectedIndex = 0;
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [[UINavigationBar appearance]setBarTintColor:PurpleColor];
    
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
