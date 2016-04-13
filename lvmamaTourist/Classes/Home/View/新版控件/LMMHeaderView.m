//
//  LMMHeaderView.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/11.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "LMMHeaderView.h"

#define headerColor [UIColor colorWithRed:204/255.0 green:32/255.0 blue:139/255.0 alpha:1]

@interface LMMHeaderView ()



@end

@implementation LMMHeaderView

+ (LMMHeaderView *)headerView
{
    LMMHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"LMMHeaderView" owner:nil options:nil] lastObject];
    return headerView;
}

- (IBAction)onTapOne:(id)sender
{
    
    //  执行代理,修改flag
    if (self.markViewOne.hidden)
    {
        [self.delegate change];
    }
}


- (IBAction)onTapTwo:(id)sender
{

    //  执行代理,修改flag
    if (self.markViewTwo.hidden)
    {
        [self.delegate change];
    }
}




@end
