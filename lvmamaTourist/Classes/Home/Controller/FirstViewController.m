//
//  FirstViewController.m
//  lvmamaTourist
//
//  Created by Earth on 16/1/2.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "FirstViewController.h"
#import <CoreLocation/CoreLocation.h>
//  第三方框架
#import "JSONKit.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "MJDIYHeader.h"
#import "MJDIYBackFooter.h"

//  cell
#import "scrollImageViewCell.h"
#import "TopicViewCell.h"
#import "PeculiarServicesCell.h"
#import "WonderfulCell.h"
#import "FavoriteActiveCell.h"
#import "HappyVocationCell.h"
#import "PeculiarServicesCell.h"
#import "limitedShoppingTableViewCell.h"
//  模型
#import "Model_scrollImage.h"
#import "limitedShopModel.h"
//  自定义控件
#import "headVocationView.h"
#import "TopicModel.h"


#import "ScrollImageService.h"
#import "ColorfulService.h"
#import "LimitedService.h"
#import "VocationWeekend.h"
#import "VocationLongService.h"


#import "LocationPlaceTableViewController.h"


@interface FirstViewController () <ServiceCallback,CLLocationManagerDelegate>

#pragma mark    -   属性

/**
 *  代理
 */
@property (nonatomic, strong) ScrollImageService *scrollService;
@property (nonatomic, strong) ColorfulService    *colorfulService;
@property (nonatomic, strong) LimitedService     *limitedService;
@property (nonatomic, strong) VocationWeekend    *weekendService;
@property (nonatomic, strong) VocationLongService   *vocationService;

/**
 *  这是总数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSource;
/**
 *  第一个section的数据源  -  滚动栏
 */
@property (nonatomic, strong) NSMutableArray *dataSourceScroll;
/**
 *  第二个section的数据源  -  缤纷出游
 */
@property (nonatomic, strong) NSMutableArray *dataSourceColorful;
/**
 *  第三个section的数据源  -  特色业务
 */
@property (nonatomic, strong) NSMutableArray *dataSourcePeculiar;
/**
 *  第三个section的数据源  -  限时抢购
 */
@property (nonatomic, strong) NSMutableArray *dataSourceLimited;
/**
 *  第四个section的数据源  -   度周末
*/
@property (nonatomic, strong) NSMutableArray *dataSourceWeekend;
/**
 *  第五个section的数据源  -   度假期
 */
@property (nonatomic, strong) NSMutableArray *dataSourceVocation;


/*
 *  判断当前是第几次发起网络请求
 */
@property (nonatomic, assign) NSInteger     flag_i;
/**
 *  定位管理器
 */
@property (nonatomic, strong) CLLocationManager *manager;
/**
 *  判断下拉是刷新[度周末]还是[度长假]  !NO -> [度周末]  !YES -> [度长假]
 */
@property (nonatomic, assign) BOOL  flag_vocation;
/**
 *  度周末的偏移
 */
@property (nonatomic, assign) int   offset_one;
/**
 *  度长假的偏移
 */
@property (nonatomic, assign) int   offset_tow;
/**
 *  是否清空数据
 */
@property (nonatomic, assign) BOOL clean;
/**
 *  是否已经定位
 */
@property (nonatomic, assign) BOOL isLocated;
/**
 *  定位地址
 */
@property (nonatomic, assign) CLLocationCoordinate2D location;

@end

@implementation FirstViewController


#pragma mark    -   懒加载

- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [[NSMutableArray alloc]initWithCapacity:5];
        [_dataSource addObject:self.dataSourceScroll];
        [_dataSource addObject:self.dataSourceColorful];
        [_dataSource addObject:self.dataSourcePeculiar];
        [_dataSource addObject:self.dataSourceLimited];
        [_dataSource addObject:self.dataSourceWeekend];
    }
    return _dataSource;
}
- (NSMutableArray *)dataSourceScroll
{
    if (!_dataSourceScroll)
    {
        _dataSourceScroll = [[NSMutableArray alloc]init];
    }
    return _dataSourceScroll;
}
- (NSMutableArray *)dataSourceColorful
{
    if (!_dataSourceColorful)
    {
        _dataSourceColorful = [[NSMutableArray alloc]init];
    }
    return _dataSourceColorful;
}
-(NSMutableArray *)dataSourcePeculiar
{
    if (!_dataSourcePeculiar)
    {
        _dataSourcePeculiar = [[NSMutableArray alloc]init];
    }
    return _dataSourcePeculiar;
}
- (NSMutableArray *)dataSourceLimited
{
    if (!_dataSourceLimited)
    {
        _dataSourceLimited = [[NSMutableArray alloc]init];
    }
    return _dataSourceLimited;
}
- (NSMutableArray *)dataSourceWeekend
{
    if (!_dataSourceWeekend)
    {
        _dataSourceWeekend = [[NSMutableArray alloc]init];
    }
    return _dataSourceWeekend;
}
- (NSMutableArray *)dataSourceVocation
{
    if (!_dataSourceVocation)
    {
        _dataSourceVocation = [[NSMutableArray alloc]init];
    }
    return _dataSourceVocation;
}
- (CLLocationManager *)manager
{
    if (!_manager)
    {
        _manager = [[CLLocationManager alloc]init];
        _manager.delegate = self;
    }
    return _manager;
}

#pragma mark    -   实现方法
- (void)viewWillAppear:(BOOL)animated
{
//    [GiFHUD show];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self loadConfig];

    //  设置代理
    self.scrollService = [[ScrollImageService alloc]initWithSid:@"ScrollImageService" andCallback:self];
    self.colorfulService = [[ColorfulService alloc]initWithSid:@"ColorfulService" andCallback:self];
    self.limitedService = [[LimitedService alloc]initWithSid:@"LimitedService" andCallback:self];
    self.weekendService = [[VocationWeekend alloc]initWithSid:@"VocationWeekend" andCallback:self];
    self.vocationService = [[VocationLongService alloc]initWithSid:@"VocationLong" andCallback:self];
    
    //  进入之后加载数据
    [self loadDataOneline];
    
    //  下拉加载
    self.tableView.mj_header= [MJDIYHeader headerWithRefreshingBlock:^{
        
        //  初始化
        self.flag_vocation = NO;    //  首先请求的是度周末
        self.offset_one = 1;        //  从1开始
        self.offset_tow = 1;        //  从1开始
        
        [self.dataSourceWeekend removeAllObjects];
        [self.dataSourceVocation removeAllObjects];
        
        [self loadDataOneline];
        
    }];
    
    //  上拉加载
    self.tableView.mj_footer = [MJDIYBackFooter footerWithRefreshingBlock:^{
        
        if (!_flag_vocation)
        {
            [self.weekendService requestData:_offset_one];
        }
        else
        {
            [self.vocationService requestData:_offset_tow];
        }
    }];
    
    //  直接加载本地json
    [self.dataSourceColorful addObject:[self analizeLocalJsonDataWithName:@"colorful"]];
    [self.dataSource replaceObjectAtIndex:1 withObject:self.dataSourceColorful];
}

#pragma mark    -   发起网络请求
/**
 *  默认地址
 */
- (void)loadDataOneline
{
    [self.scrollService requestData];
    [self.colorfulService requestData];
    [self.limitedService requestData];
    [self.weekendService requestData:_offset_one];
    [self.vocationService requestData:_offset_tow];
}

/**
 *  指定地址
 */
- (void)loadDataOneline:(CLLocationCoordinate2D)location
{
    [self.scrollService requestDataLocation:location];
    [self.colorfulService requestDataLocation:location];
    [self.limitedService requestDataLocation:location];
    [self.weekendService requestDataLocation:location withOffset:_offset_one];
    [self.vocationService requestDataLocation:location withOffset:_offset_tow];
}

#pragma mark    -   代理方法 - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        scrollImageViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"scrollCell" forIndexPath:indexPath];
        [cell setScrollViewImage:self.dataSource[indexPath.section][0] withController:self];
        return cell;
    }
    if (indexPath.section == 1)
    {
        TopicViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"topicCell" forIndexPath:indexPath];
        [cell setTopicImage:self.dataSource[indexPath.section][0]];
        return cell;
    }
    if (indexPath.section == 2)
    {
        PeculiarServicesCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"peculiarCell" forIndexPath:indexPath];
        [cell setSmallImage:self.dataSource[indexPath.section][0]];
        return cell;
    }
    if (indexPath.section == 3)
    {
        limitedShoppingTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"limitedCell" forIndexPath:indexPath];
        [cell setCellWithData:self.dataSource[indexPath.section][0]];
         return cell;
    }
    
    if (indexPath.section == 4)
    {
        HappyVocationCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"happyCell" forIndexPath:indexPath];
        [cell setHappyImage:self.dataSource[indexPath.section][indexPath.row]];
        
        return cell;
    }
    
    return [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:@"defaultCell"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        return WIDTH * 19/62.0;
    }
    if (indexPath.section == 1)
    {
        return WIDTH * 13.5/62.0;
    }
    if (indexPath.section == 2)
    {
        return WIDTH *22.5/62.0;
    }
    if(indexPath.section == 3)
    {
        return WIDTH *28.5/62.0;
    }
    if (indexPath.section >= 4)
    {
        return WIDTH * 40.0/62.0;
    }
    return 44;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    headVocationView *view = nil;
    if (section == 4)
    {
        view = [[headVocationView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 38)];
        
        view.changeDataSource = ^(BOOL change){
            _flag_vocation = change;
            
            if (!_flag_vocation){
                [self.dataSource replaceObjectAtIndex:4 withObject:self.dataSourceWeekend];
            }
            else{
                [self.dataSource replaceObjectAtIndex:4 withObject:self.dataSourceVocation];
            }
            
            [self.tableView reloadData];
        };
    }
    return view;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.0001;
    }
    if (section == 4)
    {
        return 38;
    }
    return 8;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3)
    {
        return 12;
    }
    return 0.0001;
}

#pragma mark    -   代理方法 - callBack

- (void)callbackWithResult:(ServiceResult *)result forSid:(NSString *)sid
{
    [GiFHUD dismiss];
    
    //  返回scrollImageView的数据
    if ([sid isEqualToString:@"ScrollImageService"])
    {
        [self.dataSourceScroll removeAllObjects];
        [self.dataSourceScroll addObject: [Model_scrollImage analyzeJsonWithData:result.data[@"datas"][0][@"infos"]]];
        [self.dataSource replaceObjectAtIndex:0 withObject:self.dataSourceScroll];
    }
    
    //  返回colorful的数据
    if ([sid isEqualToString:@"ColorfulService"])
    {
        [self.dataSourcePeculiar removeAllObjects];
        [self.dataSourcePeculiar addObject: [TopicModel analyzeJsonWithData:result.data[@"datas"][4][@"infos"]]];
        [self.dataSource replaceObjectAtIndex:2 withObject:self.dataSourcePeculiar];

    }
    
    //  返回limited的数据
    if ([sid isEqualToString:@"LimitedService"])
    {
        [self.dataSourceLimited removeAllObjects];
        [self.dataSourceLimited addObject: [limitedShopModel analizeToModelWithDict:result.data[@"datas"][0][@"infos"][0]]];
        [self.dataSource replaceObjectAtIndex:3 withObject:self.dataSourceLimited];
    }
   
    //  返回weekend的数据
    if ([sid isEqualToString:@"VocationWeekend"])
    {
        _offset_one ++;
        [self.dataSourceWeekend addObjectsFromArray:[TopicModel analyzeJsonWithData:result.data[@"datas"][0][@"infos"]]];
        [self.dataSource replaceObjectAtIndex:4 withObject:self.dataSourceWeekend];
    }
   
    //  返回vocation的数据
    if ([sid isEqualToString:@"VocationLong"])
    {
        _offset_tow ++;
        
        [self.dataSourceVocation addObjectsFromArray:[TopicModel analyzeJsonWithData:result.data[@"datas"][0][@"infos"]]];
        if (_flag_vocation)
        {
            [self.dataSource replaceObjectAtIndex:4 withObject:self.dataSourceVocation];
        }
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
    
    [self.tableView reloadData];
}

- (void)callbackWhenError:(ServiceResult *)result forSid:(NSString *)sid
{
    [GiFHUD dismiss];
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


#pragma mark    -   代理方法 - CLLocation
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [self.manager stopUpdatingLocation];
    CLLocation *location = [locations lastObject];
    
    if (!_isLocated)
    {
        _isLocated = YES;
        [self loadDataOneline:location.coordinate];
    }
}

#pragma mark    -   基本配置 - tableView

- (void) loadConfig
{
    [GiFHUD setGifWithImageName:@"lvmama0.2.gif"];
    [GiFHUD show];
    
    [self configTableView];
    [self registClassOrNib];
    [self setMainUI];
}


- (void) configTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor redColor];
    self.tableView = [[UITableView alloc]initWithFrame:BOUNDS style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    
    //  定位用户信息
    [self.manager requestWhenInUseAuthorization];
    [self.manager startUpdatingLocation];
    
    //  初始化
    self.flag_vocation = NO;    //  首先请求的是度周末
    self.isLocated = NO;
    self.offset_one = 1;        //  从1开始
    self.offset_tow = 1;        //  从1开始
}

#pragma mark - 注册xib或class

- (void) registClassOrNib
{
    [self.tableView registerClass:[scrollImageViewCell class] forCellReuseIdentifier:@"scrollCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicViewCell"  bundle:nil] forCellReuseIdentifier:@"topicCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"PeculiarServicesCell" bundle:nil] forCellReuseIdentifier:@"peculiarCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"limitedShoppingTableViewCell" bundle:nil] forCellReuseIdentifier:@"limitedCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HappyVocationCell" bundle:nil] forCellReuseIdentifier:@"happyCell"];
}

- (void) setMainUI
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 32, 25)];
    label.text = @"肇庆";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(35, 10 , 10, 6)];
    imageView.image = [UIImage imageNamed:@"arrowDownWhite"];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 25)];
    view.contentMode = UIViewContentModeScaleAspectFit;
    
    [view addSubview:label];
    [view addSubview:imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapedOnLocation)];
    [view addGestureRecognizer:tap ];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = bar;
}

#pragma mark    -   自定义的方法

/**
 *  解析本地json的数据.
 */
- (NSMutableArray *)analizeLocalJsonDataWithName:(NSString *)fileName
{
    NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    return [TopicModel analyzeJsonWithData:rootDict[@"infos"]];
}

/**
 *  添加按钮事件
 */
- (void)tapedOnLocation
{
    LocationPlaceTableViewController *viewCtl = [[LocationPlaceTableViewController alloc]init];

    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewCtl animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}

@end
