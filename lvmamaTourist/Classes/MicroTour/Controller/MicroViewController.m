//
//  MicroViewController.m
//  lvmama
//
//  Created by Earth on 15/11/17.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import "MicroViewController.h"
#import "AFNetworking.h"
#import "Model_TourNote.h"

//  cell
#import "TourNoteCellTableViewCell.h"

//  refresh控件
#import "MJDIYHeader.h"
#import "MJDIYBackFooter.h"

#import "MicroTourService.h"


@interface MicroViewController () <ServiceCallback>

@property (nonatomic, strong) NSMutableArray    *dataSource;

@property (nonatomic, strong) MicroTourService  *microTourService;

@property (nonatomic, assign) int pageIndex;

@end

@implementation MicroViewController


#pragma mark - 懒加载

- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

#pragma mark - 实现方法

- (void)viewDidLoad
{
    [super viewDidLoad];

    //  加载所有配置
    [self loadConfig];
    
    //  指定代理
    _microTourService = [[MicroTourService alloc]initWithSid:@"microTourService" andCallback:self];

    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingBlock:^{
       
        [GiFHUD show];
        self.pageIndex = 1;
        
        [_microTourService requestByPageIndex:_pageIndex pageSize:6];
    }];
    
    self.tableView.mj_footer = [MJDIYBackFooter footerWithRefreshingBlock:^{
       
        [GiFHUD show];
        [_microTourService requestByPageIndex:_pageIndex pageSize:6];
    }];

   [_microTourService requestByPageIndex:_pageIndex pageSize:6];
}


#pragma mark -  代理方法:UITableViewDataSource/UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TourNoteCellTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"tourNoteCell" forIndexPath:indexPath];
    
    Model_TourNote *model = _dataSource[indexPath.section];
    
    [cell setTourData:model controller:self];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WIDTH * 43.5 / 62.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 16;
}


#pragma mark    -   数据请求返回值

- (void)callbackWithResult:(ServiceResult *)result forSid:(NSString *)sid
{
    
    [GiFHUD dismiss];
    
    if (_pageIndex == 1)
    {
       _dataSource = [Model_TourNote analyzeJsonWithData:result.data[@"data"][@"list"]];
    }
    else
    {
        NSMutableArray *mArray = (NSMutableArray *)[_dataSource arrayByAddingObjectsFromArray:[Model_TourNote analyzeJsonWithData:result.data[@"data"][@"list"]]];
        _dataSource = mArray;
    }
    
    _pageIndex ++;
    //  停止刷新
    if ([self.tableView.mj_header isRefreshing])
    {
        [self.tableView.mj_header endRefreshing];
    }
    
    if ([self.tableView.mj_footer isRefreshing])
    {
        [self.tableView.mj_footer endRefreshing];
    }
    
    self.tableView.hidden = NO;
    
    [self.tableView reloadData];
}

- (void)callbackWhenError:(ServiceResult *)result forSid:(NSString *)sid
{
    
    [GiFHUD dismiss];
    
    self.view.hidden = YES;
    
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

#pragma mark - 基本配置

//  启动所有加载配置方法
- (void) loadConfig
{
    //  初始化,pageIndex
    _pageIndex = 1;
    
    self.tableView.hidden = YES;
    
    [GiFHUD setGifWithImageName:@"lvmama0.2.gif"];
    [GiFHUD show];
    
    [self configTableView];
    [self registClassOrNib];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    label.textColor = [UIColor whiteColor];
    label.text = @"游记";
    label.font = [UIFont boldSystemFontOfSize:22];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
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
    [self.tableView registerNib:[UINib nibWithNibName:@"TourNoteCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"tourNoteCell"];
}



@end
