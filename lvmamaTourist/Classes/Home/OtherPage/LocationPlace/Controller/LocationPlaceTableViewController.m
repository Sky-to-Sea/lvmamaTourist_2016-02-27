//
//  LocationPlaceTableViewController.m
//  lvmamaTourist
//
//  Created by Earth on 16/1/25.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "LocationPlaceTableViewController.h"
#import "LocationPlaceModel.h"

#define WORDS @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"

@interface LocationPlaceTableViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *totalSource;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *headerSource;

@property (nonatomic, strong) NSMutableArray *searchSource;

//  是否调换数据源为[搜索]？
@property (nonatomic, assign) BOOL flag;

@end


@implementation LocationPlaceTableViewController

- (NSMutableArray *)totalSource
{
    if (!_totalSource)
    {
        _totalSource = [[NSMutableArray alloc]initWithArray:self.dataSource];
    }
    return _totalSource;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [self analizeLocalJsonDataWithName:@"locationPlace"];
        //  收集热门城市
        NSMutableArray *hotCity = [[NSMutableArray alloc]init];
        for (int i = 0; i < _dataSource.count; i ++)
        {
            NSMutableArray *mArray = _dataSource[i];
            for (int j = 0; j < mArray.count; j ++)
            {
                LocationPlaceModel *model = mArray[j];
                if (model.isHot)
                {
                    [hotCity addObject:model];
                }
            }
        }
        
        //  收集定位的城市
        LocationPlaceModel *model = [[LocationPlaceModel alloc]init];
        model.name = @"肇庆";
        NSMutableArray *locateCity = [[NSMutableArray alloc]initWithObjects:model, nil];
        [_dataSource insertObject:locateCity atIndex:0];
        [_dataSource insertObject:hotCity atIndex:1];
    }
    return _dataSource;
}

- (NSMutableArray *)searchSource
{
    if (!_searchSource)
    {
        _searchSource = [[NSMutableArray alloc]init];
    }
    return _searchSource;
}

- (NSMutableArray *)headerSource
{
    if (!_headerSource)
    {
        _headerSource = [[NSMutableArray alloc]init];
        
        [_headerSource addObject:@"当前定位城市"];
        [_headerSource addObject:@"热门出发城市"];
        
        for (int i = 0; i < WORDS.length; i ++)
        {
            [_headerSource addObject:[WORDS substringWithRange:NSMakeRange(i,1)]];
        }
    }
    return _headerSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _flag = NO;
    //   设定返回按钮
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 26)];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 14, 21)];
    UIImage *image = [UIImage imageNamed:@"arrowLeft"];
    imageView.image = image;
    [view addSubview:imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onBack)];
    [view addGestureRecognizer:tap];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    
    //  设定搜索框
    UISearchBar *bar = [[ UISearchBar alloc]initWithFrame:CGRectMake(0, 0, WIDTH - 44, 35)];
    bar.layer.cornerRadius = 10;
    bar.clipsToBounds = YES;
    self.navigationItem.titleView = bar;
    bar.keyboardType = UIKeyboardTypeNamePhonePad;
    bar.returnKeyType = UIReturnKeyDone;
    
    bar.delegate = self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_flag)
    {
        return 0;
    }
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
    view.backgroundColor = [UIColor colorWithRed:239/256.0 green:239/256.0 blue:244/256.0 alpha:1];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 120, 44)];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = self.headerSource[section];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textColor = [UIColor grayColor];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 43, WIDTH, 0.8)];
    line.backgroundColor = [UIColor lightGrayColor];
    
    [view addSubview:label];
    [view addSubview:line];
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.totalSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.totalSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    
    LocationPlaceModel *model = self.totalSource[indexPath.section][indexPath.row];
    cell.textLabel.text = model.name;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 31, WIDTH, 0.8)];
    line.backgroundColor = [UIColor lightGrayColor];
    
    [cell addSubview:line];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 32;
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
    LocationPlaceModel *model = [[LocationPlaceModel alloc]init];
    return [model modelWithDict:rootDict[@"data"]];
}

/**
 *  pop返回
 */
- (void)onBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText isEqualToString: @""])
    {
        _flag = NO;
        [self.totalSource removeAllObjects];
        self.totalSource = [[NSMutableArray alloc]initWithArray:self.dataSource];
        
        [self.tableView reloadData];
    }
    else
    {
        _flag = YES;
        NSMutableArray *mArray = [[NSMutableArray alloc]init];
        NSMutableArray *source = [self analizeLocalJsonDataWithName:@"locationPlace"];
        
        for (int i = 0; i < source.count; i ++)
        {
            NSMutableArray *array = source[i];
            
            for (int j = 0; j < array.count; j ++)
            {
                LocationPlaceModel *model = array[j];
                
                if ([model.name containsString:searchText])
                {
                    [mArray addObject:model];
                }
                else if(searchText.length >= 2&&[model.shortPinyin localizedCaseInsensitiveContainsString:searchText])
                {
                    [mArray addObject:model];
                }
                else if([model.pinyin localizedCaseInsensitiveContainsString:searchText])
                {
                    [mArray addObject:model];
                }
            }
        }
        
        [self.totalSource removeAllObjects];
        [self.totalSource addObject:mArray];
        
        [self.tableView reloadData];
    }
}

@end
