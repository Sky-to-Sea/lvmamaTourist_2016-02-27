//
//  TNImageTextCell.m
//  lvmamaTourist
//
//  Created by Earth on 16/2/22.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "TNImageTextCell.h"
#import "TNSegmentsModel.h"

#import "UIImageView+WebCache.h"
#import "TableViewController.h"

#import "PLDetailPlaceViewController.h"

@interface TNImageTextCell()

@property (nonatomic, strong) NSString *poiId;
@property (nonatomic, strong) TableViewController *controller;

@end

@implementation TNImageTextCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellWithData:(TNTracksModel *)data withController:(TableViewController *)controller
{
    CGPoint point = CGPointMake(8, 8);

    self.poiId = data.poiId;
    self.controller = controller;
    
    if (![data.poiDesc isEqualToString:@""])
    {
        UILabel *label = [self describeLabel:data.poiDesc];
        label.origin = point;
        [self addSubview:label];
        point.y = label.y + label.height + 8;
        
        UIView *line = [self breakLine:data.poiName];
        line.origin = point;
        [self addSubview:line];
        point.y = line.y + line.height + 8;
    }
    
    for (TNSegmentsModel *model in data.segments)
    {
        if (model.imageUrl != nil)
        {
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.size = CGSizeMake(WIDTH - 16, (WIDTH - 16)/2.0f);
            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://pic.lvmama.com%@",model.imageUrl]] placeholderImage:[UIImage imageNamed:@"defaultRecommendImage-1"]];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            
            imageView.origin = point;
            [self addSubview:imageView];
            
            point.y = imageView.y + imageView.height + 8;
        }
        
        if (![model.text isEqualToString:@""])
        {
            UILabel *label = [self describeLabel:model.text];
            label.origin = point;
            [self addSubview:label];
            point.y = label.origin.y + label.height + 8;
        }
        
        UIView *line = [self breakLine:data.poiName];
        line.origin = point;
        [self addSubview:line];
        point.y = line.origin.y + line.height + 8;
    }
    
    self.height = point.y;
}

- (UILabel *)describeLabel:(NSString *)labelText
{
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:13];
    label.numberOfLines = 0;
    label.text = labelText;
    
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:13]};
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(WIDTH - 16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    label.size = size;
    
    return label;
}

- (UIView *)breakLine:(NSString *)string
{
    UIView *view = nil;
    
    if (!([string isEqualToString:@""]||string == nil))
    {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH - 16, 28)];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 3, 20, 20)];
        imageView.image = [UIImage imageNamed:@"associationImage"];
        [view addSubview:imageView];
        
        view.backgroundColor = [UIColor clearColor];
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(24, 4 , WIDTH - 40, 20)];
        label.text = string;

        label.font = [UIFont boldSystemFontOfSize:14];
        label.userInteractionEnabled = YES;
        
        label.textColor = [UIColor colorWithRed:0/256.0 green:127/256.0 blue:255/256.0 alpha:1];
        
        if (![self.poiId isEqualToString:@"0"])
        {
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap)];
            [label addGestureRecognizer:tap];
        }
        
        
        [view addSubview:label];
        
        
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, view.height - 1, view.width, 1)];
        line.image = [UIImage imageNamed:@"dottedLineImage"];
        
        [view addSubview:line];
    }
    else
    {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH - 16, 2)];
        
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, view.width, 1)];
        line.image = [UIImage imageNamed:@"dottedLineImage"];
        
        [view addSubview:line];
    }
    
    return view;
}


- (void)onTap
{

//    PLDetailPlaceViewController *viewCtl = [[PLDetailPlaceViewController alloc]init];
//    
//    [self.controller.navigationController pushViewController:viewCtl animated:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
