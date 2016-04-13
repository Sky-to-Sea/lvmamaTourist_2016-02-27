//
//  LocationSelecterViewController.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/13.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "LocationSelecterViewController.h"
#import "LocationPlaceModel.h"
#import "LocationHeaderView.h"
#import "LMMTapGestureRecognizer.h"
#import "LMMWriteToPlist.h"

#define IS_CH_SYMBOL(chr) ((int)(chr)>127)

#define WORDS @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"

@interface LocationSelecterViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *totalSource;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *headerSource;

@property (nonatomic, strong) NSMutableArray *searchSource;


//  预分类:
//  名字缩写是两个字符
@property (nonatomic, strong) NSMutableArray *source2char;
//  名字缩写是三个字符
@property (nonatomic, strong) NSMutableArray *source3char;

//  没分类的城市数据
@property (nonatomic, strong) NSMutableArray *sourceData;

@property (nonatomic, strong) CLGeocoder *geoC;

//  是否调换数据源为[搜索]？
@property (nonatomic, assign) BOOL flag;

@end

@implementation LocationSelecterViewController

- (CLGeocoder *)geoC
{
    if (!_geoC)
    {
        _geoC = [[CLGeocoder alloc]init];
    }
    return _geoC;
}

- (NSMutableArray *)sourceData
{
    if (!_sourceData)
    {
        _sourceData = [self analizeDataToArrayWithName:@"locationPlace"];
    }
    return _sourceData;
}

- (NSMutableArray *)source2char
{
    if (!_source2char)
    {
        _source2char = [[NSMutableArray alloc]init];
    }
    return _source2char;
}

- (NSMutableArray *)source3char
{
    if (!_source3char)
    {
        _source3char = [[NSMutableArray alloc]init];
    }
    return _source3char;
}

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
    
    
    //  预分类
    [self preClass];
    
    
    [self.textInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

//  预先分类
- (void)preClass
{
    for (LocationPlaceModel *model in self.sourceData)
    {
        if (model.shortPinyin.length == 2)
        {
            [self.source2char addObject:model];
        }
        else if (model.shortPinyin.length == 3)
        {
            [self.source3char addObject:model];
        }
    }
}


- (void) textFieldDidChange:(UITextField *) TextField
{
    //  判断文字中有多少汉字
    NSInteger is_CH = 0;
    
    //  是否是第一个汉字
    BOOL is_first = YES;
    
    //  用于搜索的字符串
    NSString *firstString;
    
    for (int i = 0; i < TextField.text.length ; i ++)
    {
        if (IS_CH_SYMBOL([TextField.text characterAtIndex:i]))
        {
            //  取出首个汉字
            if (is_first)
            {
                firstString = [TextField.text substringWithRange:NSMakeRange(i, 1)];
                is_first = NO;
            }
            is_CH ++;
        }
    }
    
    //  含汉字/全汉字,以汉字为主
    if (is_CH <= TextField.text.length && is_CH > 0)
    {
        _flag = YES;
        //  存储检索结果
        NSMutableArray *array = [[NSMutableArray alloc]init];
        //  目标搜索字符
        NSString *searchString;
        
        if (is_CH < TextField.text.length)
            searchString = firstString;
        else
            searchString = TextField.text;

        for (LocationPlaceModel *model in self.sourceData)
        {
            if ([model.name containsString:searchString])
            {
                [array addObject:model];
            }
        }
        [self.totalSource removeAllObjects];
        [self.totalSource addObject:array];
        
        [self.tableView reloadData];
        
        return; //直接返回
    }
    
    
    //  不含汉字
    
    //  如果是空
    if ([TextField.text isEqualToString: @""])
    {
        _flag = NO;
        [self.totalSource removeAllObjects];
        self.totalSource = [[NSMutableArray alloc]initWithArray:self.dataSource];
        
        [self.tableView reloadData];
    }
    else
    {
        _flag = YES;

        NSMutableArray *array = [[NSMutableArray alloc]init];
        
        
        if (TextField.text.length <= 2)
        {
            for (LocationPlaceModel *model in self.sourceData)
            {
                if ([model.shortPinyin localizedCaseInsensitiveContainsString:TextField.text]||[model.pinyin hasPrefix:[TextField.text uppercaseString]])
                {
                    [array addObject:model];
                }
            }
        }
        else
        {
            for (LocationPlaceModel *model in self.sourceData)
            {
                if ([model.shortPinyin localizedCaseInsensitiveContainsString:TextField.text] || [model.pinyin localizedCaseInsensitiveContainsString:TextField.text])
                {
                    [array addObject:model];
                }
            }
        }

        [self.totalSource removeAllObjects];
        [self.totalSource addObject:array];
        
        [self.tableView reloadData];
        
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_flag)
    {
        return 0.00001;
    }
    
    return 34;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LocationHeaderView *view = [LocationHeaderView headerView];
    view.labelText = self.headerSource[section];
    
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
    
    LMMTapGestureRecognizer * tap = [[LMMTapGestureRecognizer alloc]initWithTarget:self action:@selector(onClick:)];
    tap.locationModel = model;
    [cell addGestureRecognizer:tap ];
    cell.userInteractionEnabled = YES;
    
    return cell;
}

- (void)onClick:(LMMTapGestureRecognizer *)tapGesture
{
    LocationPlaceModel *model = tapGesture.locationModel;
    LMMLog(@"%@",model.name);
    
    [self.geoC geocodeAddressString:model.name completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if(error == nil)
        {
            CLPlacemark *pl = [placemarks firstObject];
            
            NSLog(@"%@ - %f - %f",pl.name,pl.location.coordinate.latitude,pl.location.coordinate.longitude);
            
            NSNotification *notification = [NSNotification notificationWithName:@"CHANGE_LOCATION" object:pl.location];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            PlistModel *plist = [[PlistModel alloc]init];
            plist.city = model.name;
            plist.latitude = pl.location.coordinate.latitude;
            plist.longitude = pl.location.coordinate.longitude;
            
            LMMWriteToPlist *writer = [[LMMWriteToPlist alloc]init];
            [writer writePlistData:plist];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else
        {
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"驴妈妈旅游" message:@"抱歉!该地点无法进行地理编码!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [view show];
//            NSLog(@"错误");
        }
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 32;
}

#pragma mark    -   自定义的方法

/**
 *  解析本地json的数据(分组).
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
 *  解析本地json的数据(不分组)
 */
- (NSMutableArray *)analizeDataToArrayWithName:(NSString *)fileName
{
    NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    LocationPlaceModel *model = [[LocationPlaceModel alloc]init];
    return [model arrayWithDict:rootDict[@"data"]];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.textInput)
    {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}


- (IBAction)onTapBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
