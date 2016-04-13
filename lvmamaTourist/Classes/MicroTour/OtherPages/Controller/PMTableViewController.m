//
//  PMTableViewController.m
//  lvmamaTourist
//
//  Created by Earth on 16/2/22.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "PMTableViewController.h"
#import "PMTableViewService.h"
#import "UIImageView+WebCache.h"
#import "PNTableViewCellModel.h"
#import "PNTableViewCell.h"

#import "MJDIYHeader.h"
#import "MJDIYBackFooter.h"

#import "LMMNavigationBar.h"

@interface PMTableViewController ()<ServiceCallback>

@property (nonatomic, strong) PMTableViewService *tableViewService;
@property (nonatomic, assign) NSInteger pageIndex;

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) LMMNavigationBar *bar;

@end

@implementation PMTableViewController

- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [GiFHUD show];
    [self setNavigationBar];
    
    _pageIndex = 1;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PNTableViewCell" bundle:nil]forCellReuseIdentifier:@"tableViewCell"];
    
    _tableViewService = [[PMTableViewService alloc]initWithSid:@"tableViewService" andCallback:self];
    
    [_tableViewService requestDataWith:_userId pageIndex:_pageIndex pageSize:6];
    
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingBlock:^{
        
        _pageIndex = 1;
        
        [_tableViewService requestDataWith:_userId pageIndex:_pageIndex pageSize:6];
        
    }];
    
    self.tableView.mj_footer = [MJDIYBackFooter footerWithRefreshingBlock:^{
        
        [_tableViewService requestDataWith:_userId pageIndex:_pageIndex pageSize:6];
        
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PNTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    
    [cell setCellWithData:self.dataSource[indexPath.section][indexPath.row] controller:self];
    
    return cell;
}

- (void)callbackWithResult:(ServiceResult *)result forSid:(NSString *)sid
{
    //  直接设置部分
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:_headImageUrl] placeholderImage:[UIImage imageNamed:@"defaultHeadImage-1"]];
    self.nameLabel.text = _userName;
    
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *jsonDic in result.data[@"data"][@"list"])
    {
        [mArray addObject:[PNTableViewCellModel initWithDict:jsonDic]];
    }
    
    //  当pageIndex是1时，移除所有旧的数据源。
    if (_pageIndex == 1) [self.dataSource removeAllObjects];
    
    [self.dataSource addObject:mArray];
    
    _pageIndex ++;
    
    [self.dataSource addObject:mArray];
    [self.tableView reloadData];
    
    //  停止刷新
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [GiFHUD dismiss];
}

- (void)callbackWhenError:(ServiceResult *)result forSid:(NSString *)sid
{
    [GiFHUD dismiss];
}


- (void)setNavigationBar
{
    _bar = [LMMNavigationBar navigationBar];
    _bar.titleLabel.text = @"个人主页";
    _bar.titleLabel.textAlignment = NSTextAlignmentCenter;
    _bar.tag = 101;
    
    [_bar.leftButton addTarget:self action:@selector(onBackTap:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:_bar];
    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
}

- (void)onBackTap:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = NO;
    
    for (UIView *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 101)
        {
            [view removeFromSuperview];
        }
    }
}

@end
