//
//  AppDelegate.m
//  lvmama
//
//  Created by Earth on 15/11/16.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import "AppDelegate.h"
#import "LMTabBarController.h"
#import "GudieViewController.h"
#import "LMMWriteToPlist.h"

@interface AppDelegate ()

@property (nonatomic ,strong) GudieViewController *viewCtl;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    __mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [__mapManager start:@"Ydt4Bu1mW6P81KKjGdwZA880"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
//        利用NSUserDefaults实现
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        NSLog(@"首次启动");
        _viewCtl = [[GudieViewController alloc]init];
        self.window.rootViewController = _viewCtl;
        [_viewCtl.button addTarget:self action:@selector(changeRootViewController) forControlEvents:UIControlEventTouchUpInside];
        _viewCtl.view.tag = 101;
    }else {
        NSLog(@"非首次启动");
        LMTabBarController * tabBar = [[LMTabBarController alloc]init];
        self.window.rootViewController = tabBar;
    }



    return YES;
}

- (void)changeRootViewController
{
    _tabBar = [[LMTabBarController alloc]init];

    UIView *view = self.window.rootViewController.view;
    
    self.window.rootViewController = _tabBar;
    [_tabBar.view addSubview:view];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        view.alpha = 0.1;
        
    } completion:^(BOOL finished) {
        
        [view removeFromSuperview];
        
    }];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
