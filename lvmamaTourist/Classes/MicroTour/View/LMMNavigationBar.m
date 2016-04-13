//
//  LMMNavigationBar.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/2.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "LMMNavigationBar.h"

@implementation LMMNavigationBar


- (IBAction)onTapedBack:(id)sender
{
    
}

+ (LMMNavigationBar *)navigationBar
{
    return [[self alloc]init];
}

- (LMMNavigationBar *)init
{
    LMMNavigationBar *bar = [[[NSBundle mainBundle] loadNibNamed:@"LMMNavigationBar" owner:nil options:nil] lastObject];
    
    return bar;
}

@end
