//
//  ARBlockView2.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/3.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "ARBlockView2.h"

@implementation ARBlockView2

+ (ARBlockView2 *)blockView2WithHeight:(NSInteger)height
{
    ARBlockView2 *view = [[[NSBundle mainBundle] loadNibNamed:@"ARBlockView2" owner:nil options:nil] lastObject];
    
    view.height = height + 50;
    
    return view;
}

@end
