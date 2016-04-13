//
//  ARBlockView.h
//  lvmamaTourist
//
//  Created by Earth on 16/3/3.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARBlockView : UIView

@property (weak, nonatomic) IBOutlet UILabel *labelOfTexts;

@property (weak, nonatomic) IBOutlet UIImageView *imageNote;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelMessage;


+ (ARBlockView *)blockView:(NSInteger)height;

@end
