//
//  FavoriteActiveCell.m
//  lvmamaTourist
//
//  Created by Earth on 15/12/9.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import "FavoriteActiveCell.h"
#import "LMMTapGestureRecognizer.h"
#import "UIImageView+WebCache.h"

@interface FavoriteActiveCell()

@property (weak, nonatomic) IBOutlet UIImageView *itemOne;
@property (weak, nonatomic) IBOutlet UIImageView *itemTwo;
@property (weak, nonatomic) IBOutlet UIImageView *itemThree;
@property (weak, nonatomic) IBOutlet UIImageView *itemFour;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *itemHeight;

@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation FavoriteActiveCell

- (NSMutableArray *)imageArray
{
    if (!_imageArray)
    {
        _imageArray = [NSMutableArray arrayWithObjects:self.itemOne,self.itemTwo,self.itemThree,self.itemFour, nil];
    }
    return _imageArray;
}

- (void) setFavoriteImage:(NSMutableArray *)imageData
{
    self.itemHeight.constant = WIDTH / 5;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (int i = 0; i < imageData.count; i ++)
    {
        LMMTapGestureRecognizer *tapGesture = [[LMMTapGestureRecognizer alloc]initWithTarget:self action:@selector(onClick:)];
        [self.imageArray[i] addGestureRecognizer:tapGesture];
        
        tapGesture.model = imageData[i];
        tapGesture.actionView = self.imageArray[i];
        
        NSString *imageString = [imageData[i] large_image];
        
        [self.imageArray[i] sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (error)
            {
                LMMLog(@"图片加载失败");
            }
            else
            {
                
            }
        }];
    }
}


- (void) onClick:(LMMTapGestureRecognizer *)tapGesture
{
    LMMLog(@"业务类型是 : %@",tapGesture.model.type);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
