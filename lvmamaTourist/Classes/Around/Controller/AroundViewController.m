//
//  AroundViewController.m
//  lvmama
//
//  Created by Earth on 15/11/17.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import "AroundViewController.h"
#import "Model_Around.h"
#import "MJDIYHeader.h"
#import "MJDIYBackFooter.h"
#import "Data_Around.h"

#import "AFNetworking.h"

//  cell
#import "AroundViewCell.h"

@interface AroundViewController ()

@property (nonatomic, strong) NSMutableArray *dataSourceOne;
@property (nonatomic, strong) NSMutableArray *dataSourceTwo;
@property (nonatomic, strong) NSMutableArray *dataSourceThree;

/**
 *  判断当前刷新到的界面
 */
@property (nonatomic, assign) int            pageNumberOfOne;
@property (nonatomic, assign) int            pageNumberOfTwo;
/**
 *  1:景点 2:酒店 3:度假
 */
@property (nonatomic, assign) int            type;
/**
 *  1:肇庆 2:北京
 */
@property (nonatomic, assign) int            location;

/**
 *  封装请求url
 */
@property (nonatomic, strong) NSMutableArray *aroundData;

@end

@implementation AroundViewController


- (NSMutableArray *)dataSourceOne
{
    if (!_dataSourceOne)
    {
        _dataSourceOne = [[NSMutableArray alloc]initWithCapacity:20];
    }
    return _dataSourceOne;
}
- (NSMutableArray *)dataSourceTwo
{
    if (!_dataSourceTwo)
    {
        _dataSourceTwo = [[NSMutableArray alloc]initWithCapacity:20];
    }
    return _dataSourceTwo;
}
- (NSMutableArray *)dataSourceThree
{
    if (!_dataSourceThree)
    {
        _dataSourceThree = [[NSMutableArray alloc]initWithCapacity:20];
    }
    return _dataSourceThree;
}
- (NSMutableArray *)aroundData
{
    if (!_aroundData)
    {
        _aroundData = [Data_Around getLocationOneData];
    }
    return _aroundData;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //  加载所有配置
    [self loadConfig];
    //  加载网络数据
    [self loadDataOnLine];
    
}


#pragma mark -  代理方法:UITableViewDataSource/UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.type == 1)
    {
        return _dataSourceOne.count;
    }
    if (self.type == 2)
    {
        return _dataSourceTwo.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AroundViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"aroundCell" forIndexPath:indexPath];
    
    Model_Around *model = self.dataSourceOne[indexPath.row];
    
//    [cell setAroundPalaceData:model];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 16;
}

#pragma mark - 网络请求

- (void) loadDataOnLine
{
    //  假如地点是肇庆
    if (self.location == 1)
    {
        //  假如是景点
        if (self.type == 1)
        {
            [self refreshData: self.dataSourceOne];
        }
        //  假如是酒店
        if (self.type == 2)
        {
            [self refreshData:self.dataSourceTwo];
        }
    }
}

- (void) refreshData :(NSMutableArray *)dataSource
{
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingBlock:^{
        //  下拉之后,加载页面刷新
        [dataSource removeAllObjects];
        
        if (self.type == 1)
        {
            self.pageNumberOfOne = -1;
        }
        if (self.type == 2)
        {
            self.pageNumberOfTwo = -1;
        }
        
        [self AFNRequest];
        
        [self.tableView.mj_header endRefreshing];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.tableView.mj_header endRefreshing];
//        });
    }];
    
    self.tableView.mj_footer = [MJDIYBackFooter footerWithRefreshingBlock:^{
        
        [self AFNRequest];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshing];
        });
    }];
}

- (void) AFNRequest
{
    
    NSString *urlStr = nil;
    int pageNumber = -1;
    
    if (self.type == 1)
    {
        self.pageNumberOfOne ++;
        if (self.pageNumberOfOne >= [self.aroundData[self.type - 1] count] || self.pageNumberOfOne < 0)
        {
            LMMLog(@"TourNote请求地址有误 | 数据已经加载完毕");
            return;
        }
        urlStr = self.aroundData[self.type - 1][self.pageNumberOfOne];
        pageNumber = self.pageNumberOfOne;
    }
    if (self.type == 2)
    {
        self.pageNumberOfTwo ++;
        if (self.pageNumberOfTwo >= [self.aroundData[self.type - 1] count] || self.pageNumberOfTwo < 0)
        {
            LMMLog(@"TourNote请求地址有误 | 数据已经加载完毕");
            return;
        }
        urlStr = self.aroundData[self.type - 1][self.pageNumberOfTwo];
        pageNumber = self.pageNumberOfTwo;
    }
    
    if(!urlStr)
    {
        LMMLog(@"地址输入有误，数据请求终止！");
    }
    else
    {
        NSDictionary *parameter = nil;
        //  请求景点数据
        if (self.type == 1)
        {
            parameter = @{@"pageSize":@"20",@"version":@"2.0.0",@"windage":@"100",@"pageNum":
                              [NSString stringWithFormat:@"%d",pageNumber + 1],@"latitude":@"39.916700",@"longitude":@"116.383300"};
        }
        //  请求酒店数据
        if (self.type == 2)
        {
            parameter = @{@"distance":@"10",@"departureDate":@"2015-12-12",@"arrivalDate":@"2015-12-11",@"longitude":@"112.503603",@"hotelStar":@"104%2C105%2C102%2C103%2C100%2C101",@"latitude":@"23.116655",@"version":@"2.0.0",@"pageIndex":[NSString stringWithFormat:@"%d",pageNumber + 1]};
        }
        // 创建请求
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
            NSDictionary *list = nil;
            NSArray *array = nil;
            
            if (self.type == 1)
            {
                list = responseObject[@"data"][@"tickList"];
                array = [Model_Around analyzeJsonWithData:list];
            }
            if (self.type == 2)
            {
                LMMLog(@"%@",operation.responseObject);
            }
            
            
            if (self.type == 1)
            {
                for (Model_Around *model in array)
                {
                    [self.dataSourceOne addObject:model];
                }
            }
            if (self.type == 2)
            {
                for (Model_Around *model in array)
                {
                    [self.dataSourceTwo addObject:model];
                }
            }
            
            [self.tableView reloadData];
            
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            
            LMMLog(@"%@",@"网络请求失败");
            
        }];
    }
    
}

#pragma mark - 基本配置

//  启动所有加载配置方法
- (void) loadConfig
{
    self.location    = 1;
    self.type        = 1;
    
    // 初始化刷新到的页面
    self.pageNumberOfOne = -1;
    self.pageNumberOfTwo = -1;
    
    [self configTableView];
    [self registClassOrNib];
}

//  self.tableView的基本设置
- (void) configTableView
{
    //  取消cell的下划线(下划线属于footer)
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //  设置tableView的大小,以及样式
    self.tableView = [[UITableView alloc]initWithFrame:BOUNDS style:UITableViewStyleGrouped];
}

#pragma mark - 注册xib或class

- (void) registClassOrNib
{
    [self.tableView registerNib:[UINib nibWithNibName:@"AroundViewCell" bundle:nil] forCellReuseIdentifier:@"aroundCell"];
}

@end
