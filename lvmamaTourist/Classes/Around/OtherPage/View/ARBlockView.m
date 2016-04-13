//
//  ARBlockView.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/3.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "ARBlockView.h"

@implementation ARBlockView

+ (ARBlockView *)blockView:(NSInteger)height
{
    ARBlockView *view = [[[NSBundle mainBundle] loadNibNamed:@"ARBlockView" owner:nil options:nil] lastObject];
    view.height = height + 36;
    view.width = WIDTH;
    return view;
}

@end
