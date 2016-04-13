//
//  WebViewController.m
//  lvmamaTourist
//
//  Created by Earth on 15/12/14.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>

@end

@implementation WebViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor lightGrayColor];
    self.webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.webView.y = -45;
    self.webView.height = self.webView.height + 45;

    self.webView.delegate = self;
    
    
    self.webView.scrollView.bounces = NO;
    
    self.urlString = [self.urlString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    
    [self.view addSubview:self.webView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    LMMLog(@"%@",error);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
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
