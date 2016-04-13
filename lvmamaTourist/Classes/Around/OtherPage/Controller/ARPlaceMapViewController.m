//
//  ARPlaceMapViewController.m
//  ;
//
//  Created by Earth on 16/3/6.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "ARPlaceMapViewController.h"

@interface ARPlaceMapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>

@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationService *locateService;

@property (nonatomic, assign) CGFloat level;
@property (nonatomic, strong) BMKPointAnnotation *myPlace;
@property (nonatomic, strong) BMKCircle* circle;
@property (nonatomic, assign) CLLocationCoordinate2D mylatlong;

@property (nonatomic, strong) NSDictionary *dictDistAndLevel;

@end

@implementation ARPlaceMapViewController

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

- (BMKLocationService *)locateService
{
    if (!_locateService)
    {
        _locateService = [[BMKLocationService alloc]init];
        _locateService.delegate = self;
    }
    return _locateService;
}

- (BMKMapView *)mapView
{
    if (!_mapView)
    {
        _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64)];
        _mapView.delegate = self;
    }
    return _mapView;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.level = 14;
    
    [self.view addSubview: self.mapView];
    
    //  启动定位
    [self.locateService startUserLocationService];
    
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = _location;
    annotation.title = _scenicTitle;
    
    [self.mapView addAnnotation:annotation];
    
    self.labelOfTitle.text = self.titleName;
    [self.mapView setZoomLevel:self.level];
    self.mapView.showMapScaleBar = YES;
    self.mapView.compassPosition = CGPointMake(0, 0);
    
    self.mapView.mapScaleBarPosition = CGPointMake(self.mapView.width - self.mapView.mapScaleBarSize.width - 8,self.mapView.height - self.mapView.mapScaleBarSize.height - 2);
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((self.mapView.width - 50)/2.f, (self.mapView.height- 60), 50, 50)];
    [button setBackgroundImage:[UIImage imageNamed:@"mapLocateBtnNormal"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"mapLocateBtnSelected"] forState:UIControlStateSelected];
    [button addTarget:self action: @selector(onTap) forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:button];
    
    self.mapView.centerCoordinate = self.location;
    [self.mapView setMapType:BMKMapTypeStandard];
    self.mapView.logoPosition = BMKLogoPositionLeftBottom;
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH - 96, 0, 40, 40)];
    [addButton setBackgroundImage:[UIImage imageNamed:@"microAddNoteImage"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(onAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:addButton];
    
    UIButton *lessButton = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH - 48, 0, 40, 40)];
    [lessButton setBackgroundImage:[UIImage imageNamed:@"microLessNoteImage"] forState:UIControlStateNormal];
    [lessButton addTarget:self action:@selector(onLess) forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:lessButton];
    
    
    UIButton *buttonLocate = [[UIButton alloc]initWithFrame:CGRectMake(4, 4, 40, 40)];
    [buttonLocate setBackgroundImage:[UIImage imageNamed:@"routeSearchBtn"] forState:UIControlStateNormal];
    [buttonLocate setBackgroundImage:[UIImage imageNamed:@"routeSearchBtnSel"] forState:UIControlStateSelected];
    [buttonLocate addTarget:self action:@selector(showPlaceAndMyPlace) forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:buttonLocate];
    
}

- (void)showPlaceAndMyPlace
{
    BMKMapPoint point1 = BMKMapPointForCoordinate(_location);
    BMKMapPoint point2 = BMKMapPointForCoordinate(_mylatlong);
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1 ,point2);
    
    CLLocationCoordinate2D centerPoint = CLLocationCoordinate2DMake((_location.latitude + _mylatlong.latitude) / 2.0f, (_location.longitude + _location.longitude) / 2.0f);
    
    for (int i = 21; i >= 3; i --)
    {
        if (distance < [[self.dictDistAndLevel objectForKey:[NSString stringWithFormat:@"%d",i]] floatValue])
        {
            self.level = i + 2;
            break;
        }
    }
    
    _mapView.centerCoordinate = centerPoint;
    [_mapView setZoomLevel:self.level];
    
}

- (void)onTap
{
    self.mapView.centerCoordinate = self.location;
}

- (void)onLess
{
    self.level = _mapView.zoomLevel;
    
    if (self.level >= 4)
    {
        self.level --;
    }
    else
    {
        self.level = 3.0f;
    }
    
    [self.mapView setZoomLevel:self.level];
    
    
}

- (void)onAdd
{
    self.level = _mapView.zoomLevel;
    
    if (self.level <= 20)
    {
        self.level ++;
    }
    else
    {
        self.level = 21.0f;
    }
    
    [self.mapView setZoomLevel:self.level];
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.image = [UIImage imageNamed:@"activityLvImage"];
        
//        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示

        if ([annotation.title isEqualToString:@"我的位置"])
            newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        else
        {
           newAnnotationView.pinColor = BMKPinAnnotationColorRed;
            [newAnnotationView setSelected:YES animated:YES];
        }
        
        return newAnnotationView;
    }
    return nil;
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

}

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKCircle class]])
    {
        BMKCircleView *circleView = [[BMKCircleView alloc]initWithOverlay:overlay];
        circleView.fillColor = [UIColor colorWithRed:0/255.0 green:127/255.0 blue:255/255.0 alpha:0.3];
        circleView.strokeColor = [UIColor colorWithRed:0/255.0 green:127/255.0 blue:255/255.0 alpha:0.7]; ;
        circleView.lineWidth = 2.0;
        
        return circleView;
    }
    return nil;
}

- (IBAction)onBack:(id)sender
{
//    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController popViewControllerAnimated:YES];

}

@end
