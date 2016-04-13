//
//  HomePageViewController.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/11.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "HomePageViewController.h"
#import "Model_scrollImage.h"
#import "scrollImageView_new.h"
#import "ScrollImageService.h"
#import "TopicView_new.h"
#import "ColorfulService.h"
#import "TopicModel.h"
#import "SpecialView_new.h"
#import "LMMHeaderView.h"
#import "MJExtension.h"
#import "VocationWeekend.h"
#import "VocationLongService.h"
#import "MJDIYHeader.h"
#import "MJDIYBackFooter.h"
#import "DuringVocationCellTableViewCell.h"
#import "LocationPlaceTableViewController.h"
#import "LocationSelecterViewController.h"


#define headerColor [UIColor colorWithRed:204/255.0 green:32/255.0 blue:139/255.0 alpha:1]

@interface HomePageViewController ()<ServiceCallback,UITableViewDataSource,UITableViewDelegate,HeaderProtocol,BMKLocationServiceDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) ScrollImageService *scrollService;
@property (nonatomic, strong) ColorfulService *colorfulService;
@property (nonatomic, strong) VocationWeekend *weekendService;
@property (nonatomic, strong) VocationLongService *longService;

@property (nonatomic, assign) int pageOne;
@property (nonatomic, assign) int pageTwo;

@property (nonatomic, strong) NSMutableArray *sourceOne;
@property (nonatomic, strong) NSMutableArray *sourceTwo;

@property (nonatomic, assign) BOOL flag;

@property (nonatomic, strong) LMMHeaderView *headerView;

@property (nonatomic, assign) CLLocationCoordinate2D location;

@property (nonatomic, strong) BMKLocationService *locationService;


//  是不是不刷新
@property (nonatomic, assign) BOOL no_change;

@end

@implementation HomePageViewController

- (BMKLocationService *)locationService
{
    if (!_locationService)
    {
        _locationService = [[BMKLocationService alloc]init];
        _locationService.delegate = self;
    }
    return _locationService;
}

- (NSMutableArray *)sourceOne
{
    if (!_sourceOne)
    {
        _sourceOne = [[NSMutableArray alloc]init];
    }
    return _sourceOne;
}

- (NSMutableArray *)sourceTwo
{
    if (!_sourceTwo)
    {
        _sourceTwo = [[NSMutableArray alloc]init];
    }
    return _sourceTwo;
}

- (void)viewWillAppear:(BOOL)animated
{
    [GiFHUD setGifWithImageName:@"lvmama0.2.gif"];

    if (!_no_change)
    {
        LMMWriteToPlist *plistReader = [[LMMWriteToPlist alloc]init];
        PlistModel *model = [plistReader readPlistData];
        self.location = CLLocationCoordinate2DMake(model.latitude, model.longitude);
        self.labelOfPlace.text = model.city;
        [self loadServiceWithLocation:self.location];
        _no_change = YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self creatService];
    
    [self.locationService startUserLocationService];
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingBlock:^{

        _pageOne = 1;
        _pageTwo = 1;
        [self loadServiceWithLocation:self.location];
    }];
    
    self.tableView.mj_footer = [MJDIYBackFooter footerWithRefreshingBlock:^{
        if (_flag)
        {
            [self.weekendService requestData:_pageOne];
        }
        else
        {
            [self.longService requestData:_pageTwo];
        }
    }];
    
    
}

//  初始化请求
- (void)creatService
{
    _pageOne = 1;
    _pageTwo = 1;
    _flag = YES;

    self.scrollService = [[ScrollImageService alloc]initWithSid:@"scrollService" andCallback:self];
    self.colorfulService = [[ColorfulService alloc]initWithSid:@"colorfulService" andCallback:self];
    self.weekendService = [[VocationWeekend alloc]initWithSid:@"weekendService" andCallback:self];
    self.longService = [[VocationLongService alloc]initWithSid:@"longService" andCallback:self];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DuringVocationCellTableViewCell" bundle:nil]forCellReuseIdentifier:@"vocationCell"];
}

//  发起请求
- (void)loadService
{
    [GiFHUD show];
    [self.scrollService requestData];
    [self.colorfulService requestData];
    [self.weekendService requestData:_pageOne];
    [self.longService requestData:_pageTwo];
}

//  发起请求
- (void)loadServiceWithLocation:(CLLocationCoordinate2D)location
{
    [GiFHUD show];
    [self.scrollService requestDataLocation:location];
    [self.colorfulService requestDataLocation:location];
    [self.weekendService requestDataLocation:location withOffset:_pageOne];
    [self.longService requestDataLocation:location withOffset:_pageTwo];
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    [self.locationService stopUserLocationService];
    CLLocation *tempLocation = userLocation.location;
    
    //创建位置
    CLGeocoder *revGeo = [[CLGeocoder alloc] init];
    
    [revGeo reverseGeocodeLocation:tempLocation
    //反向地理编码
                 completionHandler:^(NSArray *placemarks, NSError *error) {
                     if (!error && [placemarks count] > 0)
                     {
                         NSDictionary *dict =
                         [[placemarks objectAtIndex:0] addressDictionary];
                         
                         NSString *city = [NSString stringWithFormat:@"%@",dict[@"City"]];
                         
                         if(self.labelOfPlace.text == nil){
                             self.labelOfPlace.text = @"肇庆";
                         }
                         
                         if (![city containsString:self.labelOfPlace.text] && [self.navigationController.viewControllers count] == 1)
                         {
                             NSString *message = [NSString stringWithFormat:@"定位到当前城市是%@,是否前往切换?",city];
                             
                             UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"驴妈妈旅游" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                            
                             [alertView show];
                         }
                         else
                         {
                             
                             PlistModel *model = [[PlistModel alloc]init];
                             model.latitude = tempLocation.coordinate.latitude;
                             model.longitude = tempLocation.coordinate.longitude;
                             model.city = self.labelOfPlace.text;
                             
                             LMMWriteToPlist *writer = [[LMMWriteToPlist alloc]init];
                             [writer writePlistData:model withFileName:@"myLocation"];
                         }
                     }
                     else  
                     {  
                         NSLog(@"ERROR: %@", error); }  
                 }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        LocationSelecterViewController *viewCtl = [[LocationSelecterViewController alloc]init];
        viewCtl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewCtl animated:YES];
    }
}


- (void)didFailToLocateUserWithError:(NSError *)error
{
    
    LMMLog(@"%@",error);
    
}


#pragma mark    -   tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DuringVocationCellTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"vocationCell" forIndexPath:indexPath];
    [cell setViewWithData:self.dataSource[indexPath.row] withController:self];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 218;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        self.headerView = [LMMHeaderView headerView];
        self.headerView.delegate = self;
        
        if(_flag)
        {
            self.headerView.labelOne.textColor = headerColor;
            self.headerView.labelTwo.textColor = [UIColor darkGrayColor];
            self.headerView.markViewOne.hidden = NO;
            self.headerView.markViewTwo.hidden = YES;
        }
        else
        {
            self.headerView.labelTwo.textColor = headerColor;
            self.headerView.labelOne.textColor = [UIColor darkGrayColor];
            self.headerView.markViewTwo.hidden = NO;
            self.headerView.markViewOne.hidden = YES;
        }
            
        
        return _headerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 44;
    else
        return 0.000001;
}

#pragma mark    -   回调数据

- (void)callbackWithResult:(ServiceResult *)result forSid:(NSString *)sid
{
    if ([sid isEqualToString:@"scrollService"])
    {
        
        for (UIView *view in self.contentViewOfScrollView.subviews)
        {
            [view removeFromSuperview];
        }
        
        NSMutableArray *scrollSource = [Model_scrollImage analyzeJsonWithData:result.data[@"datas"][0][@"infos"]];
        scrollImageView_new *newScroll = [[scrollImageView_new alloc]initWithFrame:self.contentViewOfScrollView.frame];
        newScroll.tag = 101;
        [newScroll setScrollViewImage:scrollSource withController:self];
        newScroll.frame = self.contentViewOfScrollView.frame;
        [self.contentViewOfScrollView addSubview:newScroll];
    }
    
    if ([sid isEqualToString:@"colorfulService"])
    {
        for (UIView *view in self.contentViewOfColorfulView.subviews)
        {
            [view removeFromSuperview];
        }
        
        NSMutableArray *colorfulSource = [TopicModel analyzeJsonWithData:result.data[@"datas"][3][@"infos"]];
        TopicView_new *newColorful = [TopicView_new colorfulView];
        
        [newColorful setViewWithData:colorfulSource withController:self];
        
        CGRect rect = self.contentViewOfColorfulView.frame;
        rect.origin = newColorful.frame.origin;
        newColorful.frame = rect;
        
        [self.contentViewOfColorfulView addSubview:newColorful];
        
        for (UIView *view in self.contentViewOfSpecialView.subviews)
        {
            [view removeFromSuperview];
        }
        
        NSMutableArray *specialSource = [TopicModel analyzeJsonWithData:result.data[@"datas"][4][@"infos"]];
        SpecialView_new *newSpecial = [SpecialView_new specialView];
        [newSpecial setSmallImage:specialSource withController:self];
        
        CGRect rectt = self.contentViewOfSpecialView.frame;
        rectt.origin = newSpecial.frame.origin;
        newSpecial.frame = rectt;
        
        [self.contentViewOfSpecialView addSubview:newSpecial];
    }
    
    if ([sid isEqualToString:@"weekendService"])
    {
        if (_pageOne == 1)
        {
            [self.sourceOne removeAllObjects];
        }
        [self.sourceOne addObject: [TopicModel analyzeJsonWithData:result.data[@"datas"][0][@"infos"]]];
        
        self.dataSource = [NSMutableArray arrayWithArray:[self tempWithDataArray:self.sourceOne]];
        [self.tableView reloadData];
        
        [self finish];
        _pageOne ++;
    }
    
    if ([sid isEqualToString:@"longService"])
    {
        if (_pageTwo == 1)
        {
            [self.sourceTwo removeAllObjects];
        }
        [self.sourceTwo addObject:[TopicModel analyzeJsonWithData:result.data[@"datas"][0][@"infos"]]];
        
        self.dataSource = [NSMutableArray arrayWithArray:[self tempWithDataArray:self.sourceTwo]];
        
        _pageTwo ++;
    }
}


- (NSMutableArray *)tempWithDataArray:(NSMutableArray *)mArray
{
    NSMutableArray *tempSource = [[NSMutableArray alloc]init];
    
    for (NSMutableArray  *firstArray in mArray)
    {
        for (TopicModel *model in firstArray)
        {
            [tempSource addObject:model];
        }
    }
    return tempSource;
}

- (void)callbackWhenError:(ServiceResult *)result forSid:(NSString *)sid
{
    
}

- (void)finish
{
    if ([self.tableView.mj_header isRefreshing])
        [self.tableView.mj_header endRefreshing];
    if ([self.tableView.mj_footer isRefreshing])
        [self.tableView.mj_footer endRefreshing];
    
    
    [GiFHUD dismiss];
}

- (void)change
{
    _flag = !_flag;
    if (_flag)
        self.dataSource = [NSMutableArray arrayWithArray:[self tempWithDataArray:self.sourceOne]];
    else
        self.dataSource = [NSMutableArray arrayWithArray:[self tempWithDataArray:self.sourceTwo]];
    
    [self.tableView reloadData];
}

- (IBAction)onTapLoaction:(id)sender
{
    LocationSelecterViewController *viewCtl = [[LocationSelecterViewController alloc]init];
    viewCtl.hidesBottomBarWhenPushed = YES;
//    viewCtl.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController:viewCtl animated:YES];
}

- (void)changeData:(NSNotification *)notifice
{
    _no_change = NO;
}


@end
