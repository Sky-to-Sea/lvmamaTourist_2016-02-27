//
//  ARAroundViewController.m
//  lvmamaTourist
//
//  Created by Earth on 16/2/22.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "ARAroundViewController.h"
#import "ARPlaceService.h"
#import "ARHotelService.h"

#import "AroundViewCell.h"
#import "ARHotelViewCell.h"

#import "Model_Around.h"
#import "ARHotelModel.h"

#import "MJDIYHeader.h"
#import "MJDIYBackFooter.h"

#import "ARPlaceDetailViewController.h"
#import "ARPlaceIntroductViewController.h"
#import "ARTotalPlaceMapViewController.h"

#import "ARLocationModel.h"
#import "PlistModel.h"
#import "LMMWriteToPlist.h"

#define TitleColor [UIColor colorWithRed:211/256.0 green:7/256.0 blue:117/256.0 alpha:1]

@interface ARAroundViewController ()<ServiceCallback,UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *buttonOne;

@property (weak, nonatomic) IBOutlet UIButton *buttonTwo;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *dataSourceOne;

@property (nonatomic, strong) NSMutableArray *dataSourceTwo;

@property (nonatomic, strong) ARPlaceService *placeService;
@property (nonatomic, strong) ARHotelService *hotelService;

@property (nonatomic, assign) int pageNumOne;
@property (nonatomic, assign) int pageNumTwo;

@property (nonatomic, assign) CLLocationCoordinate2D place;
//@property (nonatomic, strong) BMKLocationService *locationService;

//  传到地图的模型数据源
@property (nonatomic, strong) NSMutableArray *modeDataSource;

//  是[景点]？ 否则[酒店]
@property (nonatomic, assign) BOOL flag;

//  是否使用新的坐标?
@property (nonatomic, assign) BOOL no_change;

@end

@implementation ARAroundViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    
    if (!_no_change)
    {
        PlistModel *model = [[[LMMWriteToPlist alloc]init] readPlistData];
        self.place = CLLocationCoordinate2DMake(model.latitude, model.longitude);
        
        _pageNumOne = 1;
        _pageNumTwo = 1;
        //  发起请求
        [GiFHUD show];
        [_placeService requestPageNum:_pageNumOne pageSize:20 location:self.place];
        [_hotelService requestPageInde:_pageNumTwo pRadius:20 location:self.place pageSize:20];
        
        //  不改变吗? 是的,不改了.
        _no_change = YES;
    }
}

- (NSMutableArray *)dataSourceOne
{
    if (!_dataSourceOne)
    {
        _dataSourceOne = [[NSMutableArray alloc]init];
    }
    return _dataSourceOne;
}

- (NSMutableArray *)dataSourceTwo
{
    if (!_dataSourceTwo)
    {
        _dataSourceTwo = [[NSMutableArray alloc]init];
    }
    return _dataSourceTwo;
}

//-(BMKLocationService *)locationService
//{
//    if ( !_locationService)
//    {
//        _locationService = [[BMKLocationService alloc]init];
//        _locationService.delegate = self;
//    }
//    return _locationService;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GiFHUD show];
    
    _flag = YES;
    _pageNumOne = 1;
    _pageNumTwo = 1;
    
//    [self.locationService startUserLocationService];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AroundViewCell" bundle:nil] forCellReuseIdentifier:@"placeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ARHotelViewCell" bundle:nil] forCellReuseIdentifier:@"hotelCell"];
    
    _placeService = [[ARPlaceService alloc]initWithSid:@"placeService" andCallback:self];
    _hotelService = [[ARHotelService alloc]initWithSid:@"hotelService" andCallback:self];
    
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingBlock:^{
        [GiFHUD show];
        if (_flag)
        {
            _pageNumOne = 1;
            [_placeService requestPageNum:_pageNumOne pageSize:20 location:_place];
        }
        else
        {
            _pageNumTwo = 1;
            [_hotelService requestPageInde:_pageNumTwo pRadius:20 location:_place pageSize:20];
        }
    }];
    
    self.tableView.mj_footer = [MJDIYBackFooter footerWithRefreshingBlock:^{
        [GiFHUD show];
        if (_flag)
        {
            [_placeService requestPageNum:_pageNumOne pageSize:20 location:_place];
        }
        else
        {
            [_hotelService requestPageInde:_pageNumTwo pRadius:20 location:_place pageSize:20];
        }
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_flag)
    {
        AroundViewCell  *placeCell = [self.tableView dequeueReusableCellWithIdentifier:@"placeCell" forIndexPath:indexPath];
        Model_Around *model = self.dataSource[indexPath.section][indexPath.row];
        [placeCell setAroundPalaceData:model withController:self];
        
        return placeCell;
    }
    else
    {
        ARHotelViewCell *hotelCell = [self.tableView dequeueReusableCellWithIdentifier:@"hotelCell" forIndexPath:indexPath];
        ARHotelModel *model = self.dataSource[indexPath.section][indexPath.row];
        
        [hotelCell setCellWithData:model withController:self];
        
        return hotelCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_flag)
    {
        //  景点详情
        Model_Around *model = self.dataSource[indexPath.section][indexPath.row];
        
        ARPlaceIntroductViewController *viewCtl = [[ARPlaceIntroductViewController alloc]init];
        
        self.hidesBottomBarWhenPushed = YES;
        
        viewCtl.productId = model.productId;
        viewCtl.location = CLLocationCoordinate2DMake([model.baiduLatitude floatValue], [model.baiduLongitude floatValue]);
        
        [self.navigationController pushViewController:viewCtl animated:YES];

        
        self.hidesBottomBarWhenPushed = NO;
    }
    else
    {
        // 酒店详情
        ARHotelModel *model = self.dataSource[indexPath.section][indexPath.row];
        
        ARPlaceDetailViewController *viewCtl = [[ARPlaceDetailViewController alloc]init];
        
        self.hidesBottomBarWhenPushed = YES;
        
        viewCtl.location = CLLocationCoordinate2DMake([model.latitude floatValue], [model.longitude floatValue]);
        
        viewCtl.productId = model.hotelId;
        
        [self.navigationController pushViewController:viewCtl animated:YES];
        
        self.hidesBottomBarWhenPushed = NO;
    }

}

- (void)callbackWithResult:(ServiceResult *)result forSid:(NSString *)sid
{
    if ([sid isEqualToString:@"placeService"])
    {
        if (_pageNumOne == 1)
        {
            [self.dataSourceOne removeAllObjects];
        }
        [self.dataSourceOne addObject:[Model_Around analyzeJsonWithData:result.data[@"data"][@"tickList"]]];
        
        _pageNumOne ++;
    }
    
    if ([sid isEqualToString:@"hotelService"])
    {
        if (_pageNumTwo == 1)
        {
            [self.dataSourceTwo removeAllObjects];
        }
        [self.dataSourceTwo addObject:[ARHotelModel analyzeJsonWithData:result.data[@"data"][@"hotelList"]]];
        _pageNumTwo ++;
    }
    
    //  停止刷新
    if ([self.tableView.mj_header isRefreshing])
    {
        [self.tableView.mj_header endRefreshing];
    }
    
    if ([self.tableView.mj_footer isRefreshing])
    {
        [self.tableView.mj_footer endRefreshing];
    }
   
    
    [self reloadData];
    
    self.tableView.hidden = NO;
}

- (void)callbackWhenError:(ServiceResult *)result forSid:(NSString *)sid
{
    [GiFHUD dismiss];
    
    self.tableView.hidden = YES;
    
    //  停止刷新
    if ([self.tableView.mj_header isRefreshing])
    {
        [self.tableView.mj_header endRefreshing];
    }
    
    if ([self.tableView.mj_footer isRefreshing])
    {
        [self.tableView.mj_footer endRefreshing];
    }
}

- (IBAction)buttonOne:(id)sender
{
    UIButton *button = sender;
    
    _flag = YES;
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor  = TitleColor;
    
    [_buttonTwo setTitleColor:TitleColor forState:UIControlStateNormal];
    _buttonTwo.backgroundColor = [UIColor whiteColor];
    
    [self reloadData];
}

- (IBAction)buttonTwo:(id)sender
{
    UIButton *button = sender;
    
    _flag = NO;
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = TitleColor;
    
    [_buttonOne setTitleColor:TitleColor forState:UIControlStateNormal];
    _buttonOne.backgroundColor = [UIColor whiteColor];
    
    [self reloadData];
}

- (void) reloadData
{
    self.modeDataSource = [[NSMutableArray alloc]init];
    
    if (_flag)
    {
        self.dataSource = [NSMutableArray arrayWithArray:self.dataSourceOne];
        [self.tableView reloadData];
        
        self.modeDataSource = [ARLocationModel analizeToModelWithArray:self.dataSourceOne withType:_flag];
    }
    else
    {
        self.dataSource = [NSMutableArray arrayWithArray:self.dataSourceTwo];
        [self.tableView reloadData];
        
        self.modeDataSource = [ARLocationModel analizeToModelWithArray:self.dataSourceTwo withType:_flag];
    }
    [GiFHUD dismiss];
}

//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
//{
//    [self.locationService stopUserLocationService];
//    
//    self.place = userLocation.location.coordinate;
//    
//    //  假如为空的话
//    if (self.place.latitude == 0 || self.place.longitude == 0)
//    {
//        // 使用谷歌坐标
//        self.place = CLLocationCoordinate2DMake(23.105881, 112.499662);
//    }
//    [_placeService requestPageNum:_pageNumOne pageSize:20 location:userLocation.location.coordinate];
//    [_hotelService requestPageInde:_pageNumTwo pRadius:20 location:userLocation.location.coordinate pageSize:20];
//}

- (IBAction)onMapView:(id)sender
{
    ARTotalPlaceMapViewController *viewCtl = [[ARTotalPlaceMapViewController alloc]init];
    
    viewCtl.dataSource = self.modeDataSource;
    viewCtl.myLocation = self.place;
    
    viewCtl.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:viewCtl animated:YES];
    
}

- (void)changeData:(NSNotification *)notifice
{
//    CLLocation *location = notifice.object;
//    
//    if (notifice.object && [notifice.name isEqualToString:@"CHANGE_LOCATION"])
//    {
//        self.place = location.coordinate;
    
        //  不改变地理位置吗? 不,要改变了!
        _no_change = NO;
//    }
}



@end
