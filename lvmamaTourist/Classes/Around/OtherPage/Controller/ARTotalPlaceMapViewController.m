//
//  ARTotalPlaceMapViewController.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/8.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "ARTotalPlaceMapViewController.h"
#import "ARPlaceService.h"
#import "ARHotelService.h"
#import "ARLocationModel.h"
#import "UIImageView+WebCache.h"

#import "ARPlaceDetailViewController.h"
#import "ARPlaceIntroductViewController.h"

@interface ARTotalPlaceMapViewController ()<BMKMapViewDelegate,ServiceCallback,BMKLocationServiceDelegate>

/**
 *  地图
 */
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *labelOfTitleName;

/**
 *  景点请求
 */
@property (nonatomic, strong) ARPlaceService *serviceOne;
/**
 *  酒店请求
 */
@property (nonatomic, strong) ARHotelService *serviceTwo;

/**
 *  当前半径
 */
@property (nonatomic, assign) NSInteger raiuds;

@property (nonatomic, assign) NSInteger item;

@property (nonatomic, strong) BMKPointAnnotation *myPlace;
@property (nonatomic, strong) BMKCircle* circle;
@property (nonatomic, assign) CLLocationCoordinate2D mylatlong;

@property (nonatomic, strong) BMKLocationService *locationService;

@property (nonatomic, strong) NSDictionary *dictDistAndLevel;

@property (nonatomic, assign) NSInteger level;

@end

@implementation ARTotalPlaceMapViewController

- (NSDictionary *)dictDistAndLevel
{
    if (!_dictDistAndLevel)
    {
        NSArray *arr1 = [NSArray arrayWithObjects:@"21",@"20",@"19",@"18",@"17",@"16",@"15",@"14",@"13",@"12",@"11",@"10",@"9",@"8",@"7",@"6",@"5",@"4",@"3",nil];
        NSArray *arr2 = [NSArray arrayWithObjects:@"5",@"10",@"20",@"50",@"100",@"200",@"500",@"1000",@"2000",@"5000",@"10000",@"20000",@"25000",@"50000",@"100000",@"200000",@"500000",@"1000000",@"2000000",nil];
        _dictDistAndLevel = [[NSDictionary alloc]initWithObjects:arr2 forKeys:arr1];
    }
    return _dictDistAndLevel;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadConfig];
    [self addAnnotation];
}

/**
 *  加载数据
 */
- (void)loadConfig
{
    
    self.locationService = [[BMKLocationService alloc]init];
    self.locationService.delegate = self;
    [self.locationService startUserLocationService];
    //  显示标题
    self.labelOfTitleName.text = self.titleName;
    //  设置中心点
    self.mapView.centerCoordinate = self.myLocation;
    
    _mapView.delegate = self;
    
    self.level = _mapView.zoomLevel;
    
    _item = 0;
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    CLLocationCoordinate2D coor = userLocation.location.coordinate;
    
    if (_myPlace != nil)
    {
        [_mapView removeAnnotation:_myPlace];
    }
    if (_circle != nil)
    {
        [_mapView removeOverlay:_circle];
    }
    
    _myPlace = [[BMKPointAnnotation alloc]init];
    _myPlace.coordinate = coor;
    _myPlace.title = @"我的位置";
    [_mapView addAnnotation:_myPlace];
    
    _circle = [BMKCircle circleWithCenterCoordinate:coor radius:200];
    [_mapView addOverlay:_circle];
    
    _mylatlong = userLocation.location.coordinate;
    
    [_mapView mapForceRefresh];
    
    [self caculateDistance:userLocation.location.coordinate];
}

/**
 *  添加标记点
 */
- (void)addAnnotation
{
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    
    for (ARLocationModel *model in self.dataSource)
    {
        BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc]init];
        annotation.coordinate = model.location;
        annotation.title = model.productName;
        [dataArray addObject:annotation];
    }
    [_mapView addAnnotations:dataArray];
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        
        if ([annotation.title isEqualToString:@"我的位置"])
        {
            newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
            return newAnnotationView;
        }
    
        newAnnotationView.pinColor = BMKPinAnnotationColorRed;
        newAnnotationView.animatesDrop = YES;
        

        
        ARLocationModel *model = self.dataSource[_item];
        _item ++;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"defaultCellImage"]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.tag = _item - 1;
        imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jump:)];
        [imageView addGestureRecognizer:tap];
        newAnnotationView.leftCalloutAccessoryView = imageView;
        
        return newAnnotationView;
    }
    return nil;
}

- (void)jump:(UITapGestureRecognizer *)tap
{
    ARLocationModel *model = self.dataSource[tap.view.tag];
    if (model.type)
    {
        ARPlaceIntroductViewController *viewCtl = [[ARPlaceIntroductViewController alloc]init];
        viewCtl.productId = model.productId;
        viewCtl.location = model.location;
        
        [self.navigationController pushViewController:viewCtl animated:YES];
    }
    else
    {
        ARPlaceDetailViewController *viewCtl = [[ARPlaceDetailViewController alloc]init];
        viewCtl.productId = model.productId;
        viewCtl.location = model.location;
        
        [self.navigationController pushViewController:viewCtl animated:YES];
    }
}

- (void)caculateDistance:(CLLocationCoordinate2D)userLocation
{

    int k = [self.dataSource count];
    ARLocationModel *model = nil;
    
    if (k > 10)
    {
        model = self.dataSource[10];
    }
    else
    {
        model = self.dataSource[k - 1];

    }
    BMKMapPoint point1 = BMKMapPointForCoordinate(userLocation);
    BMKMapPoint point2 = BMKMapPointForCoordinate(model.location);
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1 ,point2);
    
    LMMLog(@"%lf",distance);
    
    for (int i = 21; i >= 3; i --)
    {
        if (distance < [[self.dictDistAndLevel objectForKey:[NSString stringWithFormat:@"%d",i]] floatValue])
        {
            self.level = i + 3;
            break;
        }
    }
    
    self.mapView.centerCoordinate = userLocation;
    [self.mapView setZoomLevel:self.level];
}

- (IBAction)onBackTap:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
