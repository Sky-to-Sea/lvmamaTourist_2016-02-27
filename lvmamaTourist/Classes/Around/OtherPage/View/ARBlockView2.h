//
//  ARBlockView2.h
//  lvmamaTourist
//
//  Created by Earth on 16/3/3.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARBlockView2 : UIView

@property (weak, nonatomic) IBOutlet UILabel *labelOfTexts;

+ (ARBlockView2 *)blockView2WithHeight:(NSInteger)height;

@end
