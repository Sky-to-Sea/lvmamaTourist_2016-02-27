//
//  LMMNavigationBar.h
//  lvmamaTourist
//
//  Created by Earth on 16/3/2.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMMNavigationBar : UIView

@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *titleView;

- (IBAction)onTapedBack:(id)sender;

+ (LMMNavigationBar *)navigationBar;

- (LMMNavigationBar *)init;

@end
