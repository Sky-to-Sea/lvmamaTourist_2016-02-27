//
//  ARActiviteItemView.h
//  lvmamaTourist
//
//  Created by Earth on 16/3/5.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARPlaceIntroductModel.h"

@interface ARActiviteItemView : UIView

@property (weak, nonatomic) IBOutlet UILabel *labelOfItemName;
@property (weak, nonatomic) IBOutlet UILabel *labelOfMessage;
@property (weak, nonatomic) IBOutlet UIImageView *imageOfFirst;
@property (weak, nonatomic) IBOutlet UIImageView *imageOfSecond;

+ (ARActiviteItemView *)setViewWithData:(ClientProdViewSpotVosModel *)dataModel;

@end
