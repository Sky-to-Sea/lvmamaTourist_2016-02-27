//
//  LMMHeaderView.h
//  lvmamaTourist
//
//  Created by Earth on 16/3/11.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderProtocol <NSObject>

@required
- (void)change;

@end

@interface LMMHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *buttonOne;
@property (weak, nonatomic) IBOutlet UIView *markViewOne;
@property (weak, nonatomic) IBOutlet UILabel *labelOne;


@property (weak, nonatomic) IBOutlet UIButton *buttonTwo;
@property (weak, nonatomic) IBOutlet UIView *markViewTwo;
@property (weak, nonatomic) IBOutlet UILabel *labelTwo;

+ (LMMHeaderView *)headerView;

@property (nonatomic, strong) id<HeaderProtocol>delegate;

@end
