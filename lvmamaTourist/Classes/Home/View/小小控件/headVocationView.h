//
//  headVocationView.h
//  lvmamaTourist
//
//  Created by Earth on 15/12/9.
//  Copyright © 2015年 Earth. All rights reserved.
//
//  "度周末""度长假"按钮控件

#import <UIKit/UIKit.h>

@interface headVocationView : UIView


@property (nonatomic, strong) NSString *flag;

@property (nonatomic, strong) void (^changeDataSource)(BOOL);


- (instancetype)initWithFrame:(CGRect)frame;


@end
