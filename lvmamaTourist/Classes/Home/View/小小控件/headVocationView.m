//
//  headVocationView.m
//  lvmamaTourist
//
//  Created by Earth on 15/12/9.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import "headVocationView.h"

#define heighlightColor [UIColor colorWithRed:210/256.0 green:6/256.0 blue:133/256.0 alpha:1]

@interface headVocationView ()

@property (nonatomic, strong) UIButton       *btn1;
@property (nonatomic, strong) UIButton       *btn2;

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;


@end

@implementation headVocationView


- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
//    self.layer.borderWidth           = 0.2;
//    self.layer.borderUIColor         = [UIColor lightGrayColor];
    
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_btn1 setTitle:@"度周末" forState:UIControlStateNormal];
    [_btn2 setTitle:@"度长假" forState:UIControlStateNormal];
    
    [_btn1 setTitleColor:heighlightColor forState:UIControlStateNormal];
    [_btn2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    _btn1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _btn2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    _btn1.frame = CGRectMake(0, 0, frame.size.width / 2, frame.size.height);
    _btn2.frame = CGRectMake(frame.size.width / 2, 0, frame.size.width / 2, frame.size.height);
    
    [_btn1 addTarget:self action:@selector(onClickOne) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(onClickTwo) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_btn1];
    [self addSubview:_btn2];
    
    return self;
}

- (void) onClickOne
{
    [_btn2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_btn1 setTitleColor:heighlightColor forState:UIControlStateNormal];
    
    self.changeDataSource(NO);
}

- (void) onClickTwo
{
    [_btn1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_btn2 setTitleColor:heighlightColor forState:UIControlStateNormal];
    
    self.changeDataSource(YES);
}

@end
