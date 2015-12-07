//
//  HomeViewController.m
//  lvmama
//
//  Created by Earth on 15/11/17.
//  Copyright © 2015年 Earth. All rights reserved.
//


#import "HomeViewController.h"

//  第三方框架
#import "JSONKit.h"
#import "AFNetworking.h"
#import "MJExtension.h"

//  cell
#import "scrollImageViewCell.h"
#import "TopicViewCell.h"
#import "PeculiarServicesCell.h"
#import "WonderfulCell.h"

//  模型
#import "Model_scrollImage.h"
#import "Model_dataCache.h" //用于归档数据


@interface HomeViewController () <UITableViewDelegate,UITableViewDataSource>

/**
 *  完整数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSource;
/**
 *  <轮播视图><缤纷出游><特色业务><精彩活动>数据源
 */
@property (nonatomic, strong) NSMutableArray *dataItemOne;
/**
 *  <热门活动>数据源
 */
@property (nonatomic, strong) NSMutableArray *dataItemTwo;
/**
 *  <度周末>数据源
 */
@property (nonatomic, strong) NSMutableArray *dataItemThree;
/**
 *  <度长假>数据源
 */
@property (nonatomic, strong) NSMutableArray *dataItemFour;
/**
 *  轮播视图数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSource_scrollImage;

@end

@implementation HomeViewController

#pragma mark - 懒加载
- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [[NSMutableArray alloc]init];
        if (self.dataItemOne.count)
        {
            [_dataSource addObject:self.dataItemOne];
        }
        if (self.dataItemTwo.count)
        {
            [_dataSource addObject:self.dataItemTwo];
        }
        if (self.dataItemThree.count)
        {
            [_dataSource addObject:self.dataItemThree];
        }
        if (self.dataItemFour.count)
        {
            [_dataSource addObject:self.dataItemFour];
        }
    }
    LMMLog(@" 数据源: %@",_dataSource);
    return _dataSource;
}
- (NSMutableArray *)dataSource_scrollImage
{
    if (!_dataSource_scrollImage)
    {
        _dataSource_scrollImage = [[NSMutableArray alloc]init];
    }
    return _dataSource_scrollImage;
}

//  dataItemOne加载离线数据
- (NSMutableArray *)dataItemOne
{
    if (!_dataItemOne)
    {
        _dataItemOne = [[NSMutableArray alloc]init];
        for (int i = 0; i < 4; i++)
        {
            NSMutableArray *array = [[NSMutableArray alloc]init];
            [_dataItemOne addObject:array];
        }
        //_dataItemOne[1] = [self loadColorfulData];
    }
    return _dataItemOne;
}
- (NSMutableArray *)dataItemTwo
{
    if (!_dataItemTwo)
    {
        _dataItemTwo = [[NSMutableArray alloc]init];
    }
    return _dataItemTwo;
}
- (NSMutableArray *)dataItemThree
{
    if (!_dataItemThree)
    {
        _dataItemThree = [[NSMutableArray alloc]init];
    }
    return _dataItemOne;
}
- (NSMutableArray *)dataItemFour
{
    if (!_dataItemFour)
    {
        _dataItemFour = [[NSMutableArray alloc]init];
    }
    return _dataItemOne;
}


#pragma mark - 实现代码

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = [[NSMutableArray alloc ]init];
    
    self.tableView = [[UITableView alloc]initWithFrame:BOUNDS style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //  注册首页滚动视图的View
    [self registerNibAndClass];
    
     // 创建url
    NSURL *url = [NSURL URLWithString:SCROLLIMAGE];
    
    if(!url)
    {
        LMMLog(@"地址输入有误，数据请求终止！");
    }
    else
    {
        // 创建请求
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        // 创建操作
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
        // 设置
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
            // 取出返回的数据
            NSData *jsonData = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
            
            // 取出对应位置的数据
            NSDictionary *list = [jsonData objectFromJSONData][@"datas"][0][@"infos"];
            
            // LMMLog(@"%@",list);
            
            
            // 图片轮播器
//            [self.dataItemOne addObject:_dataSource_scrollImage];
            self.dataItemOne[0] = [Model_scrollImage analyzeJsonWithData:list];
            
//           [self.dataItemOne addObject:@"占位字符"];
//            self.dataItemOne[1] = @"占位字符";
            
            [self.dataSource addObject:self.dataItemOne];

            [self loadOtherImage];
            
            // 刷新tableView上的数据
            //[self.tableView reloadData];
            
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            
            NSLog(@"获取网络数据失败，开始加载本地备用数据。");
            
        }];
        
        NSOperationQueue *queue = [[NSOperationQueue alloc]init];
        
        // 将操作添加到线程中去
        [queue addOperation:operation];
        
    }
}

#pragma mark - 代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_dataSource[section] count];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            scrollImageViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"scrollImageCell" forIndexPath:indexPath];
            
            NSMutableArray *modelData = _dataSource[0][indexPath.row];
            
            [cell setScrollViewImage:modelData];
            
            return cell;
        }
        if (indexPath.row == 1)
        {
            TopicViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"colorfulCell" forIndexPath:indexPath];
            NSMutableArray *modelData = _dataSource[0][indexPath.row];
            
            [cell setTopicImage:modelData];
            
            return cell;
        }
        if (indexPath.row == 2)
        {
            PeculiarServicesCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"peculiarCell" forIndexPath:indexPath];
            NSMutableArray *modelData = _dataSource[0][indexPath.row];
            
            [cell setSmallImage:modelData];
            return cell;
        }
        if (indexPath.row == 3)
        {
            WonderfulCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"wonderCell" forIndexPath:indexPath];
            NSMutableArray *modelData = _dataSource[0][indexPath.row];
            
            [cell setWonderImage:modelData];
            return cell;
        }
        
    }
    
    return [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultCell"];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00001;
}


#pragma mark    -   注册nib/class

- (void) registerNibAndClass
{
    [self.tableView registerClass:[scrollImageViewCell class] forCellReuseIdentifier:@"scrollImageCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicViewCell" bundle:nil] forCellReuseIdentifier:@"colorfulCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"PeculiarServicesCell" bundle:nil] forCellReuseIdentifier:@"peculiarCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WonderfulCell" bundle:nil] forCellReuseIdentifier:@"wonderCell"];
}

#pragma mark    -   加载离线数据

- (NSMutableArray *) loadOutLineData
{
    //  添加滚动视图离线数据
    Model_scrollImage *model1 = [[Model_scrollImage alloc]init];
    model1.type = @"localFile";
    model1.url  = @"defaultDestDetailImage";
    NSMutableArray *mArray1 = [NSMutableArray arrayWithObject:model1];
    
    //  添加缤纷出游离线数据
    NSMutableArray *mArray2 = [NSMutableArray arrayWithCapacity:6];
    for (int i = 0; i <= 5; i ++)
    {
        Model_scrollImage *model2 = [[Model_scrollImage alloc]init];
        model2.type = @"localFile";
        model2.url  = [self loadColorfulData][i];
        [mArray2 addObject:model2];
    }
    
    NSMutableArray *mArray = [NSMutableArray arrayWithObjects:mArray1, mArray2, nil];
    return mArray;
}

//  读取缤纷出游本地图片数组
- (NSMutableArray *) loadColorfulData
{
    NSMutableArray *mArray = [NSMutableArray arrayWithObjects:@"chujingyou",@"dujiajiudian",@"guoneiyou",@"jingdianmenpiao",@"youlun",@"zhoubianyou", nil];
    return mArray;
}

#pragma mark    -   发起http请求
- (void) loadOtherImage
{
    NSURL *url = [NSURL URLWithString:COLORIMAGE];
    
    if(!url)
    {
        LMMLog(@"地址输入有误，数据请求终止！");
    }
    else
    {
        // 创建请求
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        // 创建操作
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
        // 设置
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
            // 取出返回的数据
            NSData *jsonData = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
            
            // LMMLog(@"%@",[jsonData objectFromJSONData]);
            NSDictionary *jsonDic = [jsonData objectFromJSONData];
            
            // 精彩活动
            NSDictionary *list0 = jsonDic[@"datas"][0][@"infos"];
            NSDictionary *list1 = jsonDic[@"datas"][1][@"infos"];
            
            _dataItemOne[3] = [Model_scrollImage analyzeJsonWithData:list1 andData:list0];
            
            // list3 缤纷出游
            NSDictionary *list3 = jsonDic[@"datas"][3][@"infos"];
            _dataItemOne[1] = [Model_scrollImage analyzeJsonWithData:list3];
            
            // list4 特色业务
            NSDictionary *list4 = jsonDic[@"datas"][4][@"infos"];
            _dataItemOne[2] = [Model_scrollImage analyzeJsonWithData:list4];

            // list2 热门活动
            NSDictionary *list2 = jsonDic[@"datas"][2][@"infos"];
            self.dataItemTwo = [Model_scrollImage analyzeJsonWithData:list2];
            
            
            // 刷新tableView上的数据
            [self.tableView reloadData];
            
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            
            NSLog(@"获取网络数据失败，开始加载本地备用数据。");
            
        }];
        
        NSOperationQueue *queue = [[NSOperationQueue alloc]init];
        
        // 将操作添加到线程中去
        [queue addOperation:operation];
        
    }

}




@end
