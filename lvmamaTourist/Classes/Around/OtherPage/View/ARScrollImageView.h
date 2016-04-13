//
//  ARScrollImageView.h
//  lvmamaTourist
//
//  Created by Earth on 16/2/26.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARScrollImageView : UIScrollView

@property (nonatomic, strong) UIViewController *viewCtl;

- (instancetype)initWithData:(NSArray *)images;


//- (void)setCellWithImageArray:(NSArray *)images;

@end
