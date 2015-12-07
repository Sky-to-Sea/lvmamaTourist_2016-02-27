//
//  CALayer+XibConfiguration.m
//  lvmamaTourist
//
//  Created by Earth on 15/12/7.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import "CALayer+XibConfiguration.h"


@implementation CALayer (XibConfiguration)

-(void)setBorderUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}

-(UIColor *)borderUIColor
{
    return  [UIColor colorWithCGColor:self.borderColor];
}


@end
