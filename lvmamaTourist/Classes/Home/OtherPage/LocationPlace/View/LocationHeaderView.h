//
//  LocationHeaderView.h
//  lvmamaTourist
//
//  Created by Earth on 16/3/13.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationHeaderView : UIView

@property (nonatomic, strong) NSString *labelText;

+ (LocationHeaderView *)headerView;

- (void)setLabelText:(NSString *)labelText;

@end
