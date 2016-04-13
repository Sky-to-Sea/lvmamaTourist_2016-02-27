//
//  LMMWebViewController.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/12.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "LMMWebViewController.h"

@interface LMMWebViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *labelOfTitle;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation LMMWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.labelOfTitle.text = self.titleName;
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
    
    self.urlString = [self.urlString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [GiFHUD show];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [GiFHUD dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    
}

- (IBAction)tapOnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}




@end
