//
//  ARPlaceIntroductViewController.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/3.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "ARPlaceIntroductViewController.h"
#import "ARPlaceIntroductService.h"
#import "ARPlaceIntroductModel.h"
#import "ARScrollImageView.h"
#import "ARPlaceMapViewController.h"

#import "ARBlockView.h"
#import "ARBlockView2.h"

#import "ARActiviteItemView.h"

@interface ARPlaceIntroductViewController ()<ServiceCallback>

@property (nonatomic, strong) ARPlaceIntroductService *placeService;

@property (nonatomic, strong) ARPlaceIntroductModel *detailModel;

@end

@implementation ARPlaceIntroductViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [GiFHUD show];
    
    _placeService = [[ARPlaceIntroductService alloc]initWithSid:@"placeService" andCallback:self];
    
    [_placeService requestDataWithProductId:self.productId];

}

- (void)setViewWithData:(ARPlaceIntroductModel *)dataModel
{
    NSMutableArray *images = [[NSMutableArray alloc]init];
    
    self.detailModel = dataModel;
    
    for (ClientImageBaseVosModel *imageModel in dataModel.clientImageBaseVos)
    {
        [images addObject:imageModel.photoUrl];
    }
    
    ARScrollImageView *view = [[ARScrollImageView alloc]initWithData:images];
    [self.totalViewPlace addSubview:view];
    
    UIView *shadowview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    shadowview.backgroundColor = [UIColor blackColor];
    shadowview.alpha = 0.5;
    [self.totalViewPlace addSubview:shadowview];
    
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 5, WIDTH - 8, 20)];
    nameLabel.text = dataModel.productName;
    [self.totalViewPlace addSubview:nameLabel];
    nameLabel.font = [UIFont boldSystemFontOfSize:14];
    nameLabel.textColor = [UIColor whiteColor];
    
    
    CGPoint pointer = CGPointMake(0, view.height);
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.origin = pointer;
    titleLabel.size = CGSizeMake(WIDTH, 35);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = PurpleColor;
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.totalViewPlace addSubview:titleLabel];
    titleLabel.text = @"景点介绍";
    titleLabel.backgroundColor = [UIColor whiteColor];
    
    pointer.y = titleLabel.y + titleLabel.height + 16;
    
    
    UIView *addressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 35)];
    addressView.origin = pointer;
    addressView.backgroundColor = [UIColor whiteColor];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"associationImage"]];
    imageView.size = CGSizeMake(16, 16);
    imageView.origin = CGPointMake(16, 10);
    [addressView addSubview:imageView];
    UIImageView *arrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cellArrow"]];
    arrowView.frame = CGRectMake(WIDTH - 24,12, 8, 12);
    [addressView addSubview: arrowView];
    
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(36, 8, WIDTH - 70, 20)];
    addressLabel.text = dataModel.address;
    addressLabel.textColor = [UIColor grayColor];
    addressLabel.font = [UIFont boldSystemFontOfSize:14];
    [addressView addSubview:addressLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onAddress)];
    [addressView addGestureRecognizer:tap];
    addressView.userInteractionEnabled = YES;
    
    [self.totalViewPlace addSubview:addressView];
    
    pointer.y = addressView.y + addressView.height + 16;
    
    UILabel *temp = [self describeLabel:dataModel.recommendedReason];
    
    ARBlockView *blockView = [ARBlockView blockView:temp.height];
    blockView.labelOfTexts.text = dataModel.recommendedReason;
    blockView.origin = pointer;
    [self.totalViewPlace addSubview:blockView];
    
    pointer.y = blockView.y + blockView.height + 16;
    
    UILabel *temp2 = [self describeLabel:dataModel.ticketProductDesc];
    
//    NSLog(@"%f",temp2.height);
    
    ARBlockView2 *blockView2 = [ARBlockView2 blockView2WithHeight:temp2.height + 2];
    blockView2.labelOfTexts.text = dataModel.ticketProductDesc;
    blockView2.origin = pointer;
    [self.totalViewPlace addSubview:blockView2];
    
    pointer.y = blockView2.y + blockView2.height + 16;
    
    ARBlockView *blockView3 = [ARBlockView blockView:0];
    blockView3.origin = pointer;
    [self.totalViewPlace addSubview:blockView3];

    blockView3.imageNote.image = [UIImage imageNamed:@"sortIcon"];
    blockView3.labelTitle.text = @"游玩项目";
    
    pointer.y = blockView3.y + blockView3.height;
    
    
    for (ClientProdViewSpotVosModel *model in dataModel.clientProdViewSpotVos)
    {
        ARActiviteItemView *itemView = [ARActiviteItemView setViewWithData:model];
        itemView.origin = pointer;
        [self.totalViewPlace addSubview:itemView];
        
        pointer.y = itemView.y + itemView.height;
    }
    
    pointer.y += 16;
    
    self.totalViewPlace.contentSize = CGSizeMake(WIDTH, pointer.y);
    
}

- (UILabel *)describeLabel:(NSString *)labelText
{
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:13];
    label.numberOfLines = 0;
    label.text = labelText;
    
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:13]};
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(WIDTH - 32, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    label.size = size;
    
    return label;
}

- (void)callbackWithResult:(ServiceResult *)result forSid:(NSString *)sid
{
    ARPlaceIntroductModel *model = [ARPlaceIntroductModel analizeDictionary:result.data[@"data"]];
    
    [self setViewWithData:model];
    
    [GiFHUD dismiss];
}

- (void)callbackWhenError:(ServiceResult *)result forSid:(NSString *)sid
{
    [GiFHUD dismiss];
}


- (void)onAddress
{
    ARPlaceMapViewController *viewCtl = [[ARPlaceMapViewController alloc]init];
    viewCtl.scenicTitle = _detailModel.address;
    
    self.hidesBottomBarWhenPushed = YES;
    viewCtl.location = self.location;
    viewCtl.titleName = _detailModel.productName;
    
    [self.navigationController pushViewController:viewCtl animated:YES];
    
//    self.hidesBottomBarWhenPushed = NO;
}

- (IBAction)onTapBack:(id)sender
{
       [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    

}


@end
