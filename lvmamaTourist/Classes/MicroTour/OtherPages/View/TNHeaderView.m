//
//  TNHeaderView.m
//  lvmamaTourist
//
//  Created by Earth on 16/2/19.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "TNHeaderView.h"

@implementation TNHeaderView

+ (TNHeaderView *)loadHeader
{
    TNHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"TNHeaderView" owner:nil options:nil] lastObject];
    view.clipsToBounds = YES;
    return view;
}

@end
