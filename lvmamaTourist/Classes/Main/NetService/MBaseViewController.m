//
//  MBaseViewController.m
//  Jadebox
//
//  Created by Mike Mai on 6/13/14.
//  Copyright (c) 2014 mSquare. All rights reserved.
//

#import "MBaseViewController.h"

@interface MBaseViewController ()
@end

@implementation MBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didOnBackButtonTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
