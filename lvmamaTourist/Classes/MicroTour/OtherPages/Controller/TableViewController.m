//
//  TableViewController.m
//  lvmamaTourist
//
//  Created by Earth on 16/2/16.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewService.h"

#import "UIImageView+WebCache.h"

#import "TNHeaderView.h"

#import "TNHeaderModel.h"

#import "TNTripDaysModel.h"

#import "TNTracksModel.h"

#import "TNImageTextCell.h"

#import "PMTableViewController.h"

#import "LMMNavigationBar.h"

@interface TableViewController ()<ServiceCallback>

/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *labelOfTitle;
/**
 *  行程
 */
@property (weak, nonatomic) IBOutlet UILabel *numberOfTourist;
/**
 *  照片
 */
@property (weak, nonatomic) IBOutlet UILabel *numberOfPhotos;
/**
 *  收藏
 */
@property (weak, nonatomic) IBOutlet UILabel *numberOfCollection;
/**
 *  评论
 */
@property (weak, nonatomic) IBOutlet UILabel *numberOfComment;
/**
 *  头像图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageOfHead;
/**
 *  背景图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageOfBackgournd;


@property (nonatomic, strong) TableViewService *tableViewServices;

@property (nonatomic, strong) NSMutableArray *headerSource;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) LMMNavigationBar *bar;

@end


@implementation TableViewController


- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GiFHUD setGifWithImageName:@"lvmama0.2.gif"];
    [GiFHUD show];
    
    [self setNavigationBar];
    
    [self.tableView registerClass:[TNImageTextCell class] forCellReuseIdentifier:@"imageTextCell"];
    
    _tableViewServices = [[TableViewService alloc]initWithSid:@"tableViewServices" andCallback:self];
    
    [_tableViewServices requestDataWithPath:_urlString];
    
    
//    [self setHeadTapGesture];
    
}

- (void)setHeadTapGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapedHead)];
    [self.imageOfHead addGestureRecognizer:tap];
}
- (void)onTapedHead
{
    PMTableViewController *viewCtl = [[PMTableViewController alloc]init];
    [self.navigationController pushViewController:viewCtl animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [((TNTripDaysModel *)self.dataSource[section]).tracks count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [[UITableViewCell alloc]init];
//    cell.backgroundColor = [UIColor redColor];
    
    TNImageTextCell *cell = [[TNImageTextCell alloc]init];
//    TNImageTextCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"imageTextCell" forIndexPath:indexPath];
    
    NSMutableArray *mArray = ((TNTripDaysModel *)self.dataSource[indexPath.section]).tracks;
    
    TNTracksModel *model = mArray[indexPath.row];
    
    [cell setCellWithData:model withController:self];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    TNImageTextCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TNHeaderView *view = [TNHeaderView loadHeader];
    TNHeaderModel *model = _headerSource[section];
    view.dayOfTravelDay.text = model.date;
    view.numberOfDay.text = model.days;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (void)setNavigationBar
{
    _bar = [LMMNavigationBar navigationBar];
    _bar.titleLabel.text = @"游记详情";
    _bar.titleLabel.textAlignment = NSTextAlignmentCenter;
    _bar.tag = 100;
    _bar.backgroundColor = [UIColor clearColor];
    
    _bar.frame = CGRectMake(0, 0, WIDTH, _bar.frame.size.height);
    
    [_bar.leftButton addTarget:self action:@selector(onBackTap:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:_bar];
    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
}


- (void)callbackWithResult:(ServiceResult *)result forSid:(NSString *)sid
{
    [GiFHUD dismiss];
    
    // 直接设置部分
    [self.imageOfBackgournd sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://pic.lvmama.com%@",result.data[@"data"][@"coverImg"]]] placeholderImage:[UIImage imageNamed:@"mtcoverImage"]];
    [self.imageOfHead sd_setImageWithURL:[NSURL URLWithString:result.data[@"data"][@"userImg"]] placeholderImage:[UIImage imageNamed:@"defaultHeadImage"]];
    self.labelOfTitle.text = result.data[@"data"][@"title"];
    self.numberOfPhotos.text = [NSString stringWithFormat:@"%@",(NSNumber *)result.data[@"data"][@"imgCount"]];
    self.numberOfTourist.text = [NSString stringWithFormat:@"%@",(NSNumber *)result.data[@"data"][@"dayCount"]];
    self.numberOfCollection.text = [NSString stringWithFormat:@"%@",(NSNumber *)result.data[@"data"][@"favoriteCount"]];
    self.numberOfComment.text = [NSString stringWithFormat:@"%@",(NSNumber *)result.data[@"data"][@"commentCount"]];
    
    // 取出header的数据
    _headerSource = [[NSMutableArray alloc]init];
    int kk = 0;
    for (NSDictionary *dic in result.data[@"data"][@"tripDays"])
    {
        kk ++;
        TNHeaderModel *model = [[TNHeaderModel alloc]init];
        
        model.days = [NSString stringWithFormat:@"%d",kk];
        model.date = [self formatterDataFormString:[NSString stringWithFormat:@"%@",dic[@"date"]]];
        
        [_headerSource addObject:model];
    }
    
    //  取出所有的数据
    for (NSDictionary *dic in result.data[@"data"][@"tripDays"])
    {
        TNTripDaysModel *model = [[TNTripDaysModel alloc]init];
        [self.dataSource addObject:[model analizeDictionaryToModel:dic]];
    }
    
    [self.tableView reloadData];
}

- (NSString *)formatterDataFormString:(NSString *)seconds
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yy年MM月dd日"];
    return [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[seconds  integerValue]]];
}

- (void)callbackWhenError:(ServiceResult *)result forSid:(NSString *)sid
{
    [GiFHUD dismiss];
}


- (void)onBackTap:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = NO;
    
    for (UIView *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 100)
        {
            [view removeFromSuperview];
        }
    }
}

@end
