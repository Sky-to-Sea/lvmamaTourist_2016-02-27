//
//  ARPlaceDetailViewController.m
//  lvmamaTourist
//
//  Created by Earth on 16/2/25.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "ARPlaceDetailViewController.h"
#import "ARPlaceDetailService.h"
#import "ARPlaceDetailModel.h"
#import "MJExtension.h"
#import "ARScrollImageView.h"
#import "ARPlaceMapViewController.h"

@interface ARPlaceDetailViewController ()<ServiceCallback>

@property (nonatomic, strong) ARPlaceDetailService *placeDetailService;

@property (nonatomic, strong) ARPlaceDetailModel *detailModel;

@end

@implementation ARPlaceDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [GiFHUD show];

    _placeDetailService = [[ARPlaceDetailService alloc]initWithSid:@"placeDetail" andCallback:self];
    [_placeDetailService requestProductIdData:self.productId];
    
}

- (void)setViewWithData:(ARPlaceDetailModel *)model;
{
    CGPoint point = CGPointMake(0, 0);
    self.detailModel = model;
    
    //  设置滚动视图
    if ([model.largeImages count] > 0)
    {
        ARScrollImageView *view = [[ARScrollImageView alloc]initWithData:model.largeImages];
        
        [self.scrollView addSubview:view];
        
        point.x = 12;
        point.y = view.y + view.height + 16;
    }
    else
    {
        ARScrollImageView *view = [[ARScrollImageView alloc]initWithData:[[NSArray alloc]initWithObjects:@"defaultDetailImage", nil]];
        
        [self.scrollView addSubview:view];
        
        point.x = 12;
        point.y = view.y + view.height + 16;
        
    }
    
    UIView *shadowview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    shadowview.backgroundColor = [UIColor blackColor];
    shadowview.alpha = 0.5;
    [self.scrollView addSubview:shadowview];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 5, WIDTH - 8, 20)];
    nameLabel.text = model.productName;
    [self.scrollView addSubview:nameLabel];
    nameLabel.font = [UIFont boldSystemFontOfSize:14];
    nameLabel.textColor = [UIColor whiteColor];
    
    //  设置地理位置
    if (!([model.productAddress isEqualToString:@""]||model.productAddress == nil))
    {
        UIView *view = [[UIView alloc]init];
        view.origin = point;
        view.size   = CGSizeMake(WIDTH - 24, 28);
        view.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onAddress)];
        [view addGestureRecognizer:tap];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"associationImage"];
        imageView.size = CGSizeMake(16, 16);
        imageView.origin = CGPointMake(4, 6);
        [view addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]init];
        label.size = CGSizeMake(WIDTH - 52, 20);
        label.text = model.productAddress;
        label.origin = CGPointMake(24, 4);
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentLeft;
        
        [view addSubview:label];
        [self.scrollView addSubview:view];
        
        UIImageView *arrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cellArrow"]];
        arrowView.frame = CGRectMake(WIDTH - 40,8, 8, 12);
        [view addSubview: arrowView];
        
        
        point.y = view.y + view.height + 12;
    }
    
    //  设置酒店简介
    if (![model.descrip isEqualToString:@""] || model.descrip == nil)
    {
        UIView *view = [[UIView alloc]init];
        view.origin = point;
        view.backgroundColor = [UIColor whiteColor];
        
        UIView *item = [self itemView:@"酒店简介" imageName:@"detailHotelIconInfo"];
        [view addSubview:item];
        
        UILabel *label = [self describeLabel:model.descrip];
        label.origin = CGPointMake(4, item.height + 4);
        
        [view addSubview:label];
        view.height = item.height + label.height + 8;
        
        view.backgroundColor = [UIColor whiteColor];
        view.size = CGSizeMake( WIDTH - 24,item.height + label.height + 12) ;
        
        [self.scrollView addSubview:view];
        
        point.y = view.y + view.height + 12;
    }
    
    //  设置设施服务
    if ([model.generalAmenities length] > 0 || [model.roomAmenities length] > 0)
    {
        UIView *view = [[UIView alloc]init];
        view.origin = point;
        view.backgroundColor = [UIColor whiteColor];
        
        UIView *item = [self itemView:@"设施服务" imageName:@"listHotelIconWifi"];
        [view addSubview:item];
        
        NSString *text = [NSString stringWithFormat:@"%@\n%@",model.generalAmenities,model.roomAmenities];
        UILabel *label = [self describeLabel:text];
        label.origin = CGPointMake(4, item.height + 4);
        
        [view addSubview:label];
        view.height = item.height + label.height + 8;
        
        view.backgroundColor = [UIColor whiteColor];
        view.size = CGSizeMake( WIDTH - 24,item.height + label.height + 12) ;
        
        [self.scrollView addSubview:view];
        
        point.y = view.y + view.height + 12;
    }
    
    //  设置交通状况
    if ([model.generalAmenities length] > 0)
    {
        UIView *view = [[UIView alloc]init];
        view.origin = point;
        view.backgroundColor = [UIColor whiteColor];
        
        UIView *item = [self itemView:@"交通状况" imageName:@"detailHotelIconTraffic"];
        [view addSubview:item];
        
        NSString *string = model.traffic;
        if (![string length])
        {
            string = @"无";
        }
        UILabel *label = [self describeLabel:string];
        label.origin = CGPointMake(4, item.height + 4);
        
        [view addSubview:label];
        view.height = item.height + label.height + 8;
        
        view.backgroundColor = [UIColor whiteColor];
        view.size = CGSizeMake( WIDTH - 24,item.height + label.height + 12) ;
        
        [self.scrollView addSubview:view];
        
        point.y = view.y + view.height + 12;
    }
    
    //  设置入住须知
    if (![model.earliestArriveTime isEqualToString:@""])
    {
        UIView *view = [[UIView alloc]init];
        view.origin = point;
        view.backgroundColor = [UIColor whiteColor];
        
        UIView *item = [self itemView:@"入住须知" imageName:@"tipsIcon"];
        [view addSubview:item];
        
        UILabel *label = [self describeLabel:[NSString stringWithFormat:@"最早抵达时间：%@\n最迟离开时间：%@",model.earliestArriveTime,model.latestLeaveTime]];
        label.origin = CGPointMake(4, item.height + 4);
        
        [view addSubview:label];
        view.height = item.height + label.height + 8;
        
        view.backgroundColor = [UIColor whiteColor];
        view.size = CGSizeMake( WIDTH - 24,item.height + label.height + 12) ;
        
        [self.scrollView addSubview:view];
        
        point.y = view.y + view.height + 12;
    }
    
//    UIScrollView *view = [[UIScrollView alloc]init];
//    view.backgroundColor = [UIColor redColor];
//    view.contentSize = CGSizeMake(400, 500);
//    view.size = CGSizeMake(WIDTH - 24, 200);
//    
//    view.origin = point;
//    
//    point.y = view.y + view.height + 12;
//    
//    [self.scrollView addSubview:view];
    
    self.scrollView.contentSize = CGSizeMake(WIDTH, point.y + 8);
}

- (UIView *)itemView:(NSString *)text imageName:(NSString *)name
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH - 24, 28)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(4, 6, 16, 16)];
    imageView.image = [UIImage imageNamed:name];
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(28, 4, WIDTH - 52, 20)];
    label.text = text;
    label.numberOfLines = 1;
    label.font = [UIFont boldSystemFontOfSize:15];
    [view addSubview:label];
    
    UIImageView *breakLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dottedLineImage"]];
    breakLine.frame = CGRectMake(0, view.height - 1, WIDTH - 24, 1);
    [view addSubview:breakLine];
    
    view.origin = CGPointMake(0, 0);
    
    return view;
}

- (UILabel *)describeLabel:(NSString *)labelText
{
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:13];
    label.numberOfLines = 0;
    label.text = labelText;
    
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:13]};
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(WIDTH - 36, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    label.size = size;
    
    return label;
}

- (void)callbackWithResult:(ServiceResult *)result forSid:(NSString *)sid
{
    [GiFHUD dismiss];
    
    ARPlaceDetailModel *model = [ARPlaceDetailModel analizeDictionaryToModel:result.data[@"data"]];
    
    [self setViewWithData:model];
}

- (void)callbackWhenError:(ServiceResult *)result forSid:(NSString *)sid
{
    [GiFHUD dismiss];
}

- (IBAction)onTapBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onAddress
{
    ARPlaceMapViewController *viewCtl = [[ARPlaceMapViewController alloc]init];
    viewCtl.scenicTitle = _detailModel.productAddress;
    
    self.hidesBottomBarWhenPushed = YES;
    viewCtl.location = self.location;
    viewCtl.titleName = _detailModel.productName;
    
    [self.navigationController pushViewController:viewCtl animated:YES];
   
//    self.hidesBottomBarWhenPushed = NO;
}

@end
