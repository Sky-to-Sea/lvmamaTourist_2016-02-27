//
//  ARActiviteItemView.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/5.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "ARActiviteItemView.h"
#import "UIImageView+WebCache.h"

@implementation ARActiviteItemView

+ (ARActiviteItemView *)setViewWithData:(ClientProdViewSpotVosModel *)dataModel
{
    ARActiviteItemView *view = [[[NSBundle mainBundle] loadNibNamed:@"ARActiviteItemView" owner:nil options:nil] lastObject];
    view.labelOfItemName.text = dataModel.spotName;
    view.labelOfMessage.text = dataModel.spotDesc;
    view.width = WIDTH;
    
    ClientImageBaseVosModel *imageModel1 = nil;
    ClientImageBaseVosModel *imageModel2 = nil;
    
    
    if ([dataModel.imageList count] >0)
    {
        imageModel1 = dataModel.imageList[0];
        [view.imageOfFirst sd_setImageWithURL:[NSURL URLWithString:imageModel1.compressPicUrl] placeholderImage:[UIImage imageNamed:@"defaultBannerImage"]];
        view.imageOfFirst.clipsToBounds = YES;
    }
    
    if ( [dataModel.imageList count] >1 )
    {
        imageModel2 = dataModel.imageList[1];
        [view.imageOfSecond sd_setImageWithURL:[NSURL URLWithString:imageModel2.compressPicUrl]];
        view.imageOfSecond.clipsToBounds = YES;
    }
    
//    view.labelOfMessage.height = [self describeLabel:dataModel.spotDesc];
    
    view.height = [self describeLabel:dataModel.spotDesc] + 155;
    
    return view;
}


+ (CGFloat)describeLabel:(NSString *)text
{
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:13];
    label.numberOfLines = 0;
    label.text = text;
    
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:13]};
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(WIDTH - 32, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    return size.height;
}

@end
