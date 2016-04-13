//
//  LocationHeaderView.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/13.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "LocationHeaderView.h"

@interface LocationHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *LabelOfName;

@end

@implementation LocationHeaderView

+ (LocationHeaderView *)headerView
{
    LocationHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"LocationHeaderView" owner:nil options:nil] lastObject];
    view.LabelOfName.text = view.labelText;
    
    return view;
}

- (void)setLabelText:(NSString *)labelText
{
    self.LabelOfName.text = labelText;
}

@end
