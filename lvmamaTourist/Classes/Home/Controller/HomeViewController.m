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
#import "MJDIYHeader.h"
#import "MJDIYBackFooter.h"

//  cell
#import "scrollImageViewCell.h"
#import "TopicViewCell.h"
#import "PeculiarServicesCell.h"
#import "WonderfulCell.h"
#import "FavoriteActiveCell.h"
#import "HappyVocationCell.h"

//  模型
#import "Model_scrollImage.h"

//  自定义控件
#import "headVocationView.h"

@interface HomeViewController ()

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

@property (nonatomic, strong) headVocationView *viewLength;

@end

@implementation HomeViewController

#pragma mark - 懒加载
- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [[NSMutableArray alloc]init];
        
        for (int i = 0; i <= 2; i ++)
        {
            [_dataSource addObject:[[NSMutableArray alloc]init]];
        }
    }
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
    return _dataItemThree;
}
- (NSMutableArray *)dataItemFour
{
    if (!_dataItemFour)
    {
        _dataItemFour = [[NSMutableArray alloc]init];
    }
    return _dataItemFour;
}
- (headVocationView *)viewLength
{
    if (!_viewLength)
    {
        _viewLength = [[headVocationView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 38)];
    }
    return _viewLength;
}

-(void)dealloc
{
    [_viewLength removeObserver:self forKeyPath:@"flag"];
}

#pragma mark - 实现代码

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:BOUNDS style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 下拉刷新
    self.tableView.mj_header= [MJDIYHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
            
            // 结束刷新
            [self.tableView.mj_header endRefreshing];

    }];
    // [self.tableView.mj_header beginRefreshing];
    // 上拉刷新
    self.tableView.mj_footer = [MJDIYBackFooter footerWithRefreshingBlock:^{
         [self loadNewWeekendData];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
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
            
            self.dataSource[0] =  self.dataItemOne;

            [self loadOtherImage];
            
            [self loadVocationData];
            
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
    LMMLog(@"count : %ld",section);
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
            
            [cell setScrollViewImage:modelData withController:self];
            
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
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            FavoriteActiveCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"favoriteCell" forIndexPath:indexPath];
            NSMutableArray *data = _dataSource[1][0];
            
            [cell setFavoriteImage:data];
            return cell;
        }
    }
    else
    {
        HappyVocationCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"happyCell" forIndexPath:indexPath];
        Model_scrollImage *data = _dataSource[indexPath.section][indexPath.row];
        
        [cell setHappyImage:data];
        return cell;
        
    }
    
    LMMLog(@"%lu : %lu",indexPath.section,indexPath.row);
    
    return [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultCell"];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView  *oneView = nil;
    
    if (section == 2)
    {
        // 仅添加一次监听.
        if (!_viewLength)
        {
            [self.viewLength addObserver:self forKeyPath:@"flag" options:NSKeyValueObservingOptionNew context:nil];
        }
        oneView = _viewLength;
    }
    return oneView;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2)
    {
        return 37;
    }
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
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
    [self.tableView registerNib:[UINib nibWithNibName:@"FavoriteActiveCell" bundle:nil] forCellReuseIdentifier:@"favoriteCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HappyVocationCell" bundle:nil] forCellReuseIdentifier:@"happyCell"];
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
            [self.dataItemTwo addObject:[Model_scrollImage analyzeJsonWithData:list2]];
            
            _dataSource[1] = _dataItemTwo;
            
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

- (void) loadVocationData
{
    NSURL *url = [NSURL URLWithString:VOCATION];
    
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
            
            NSDictionary *jsonDic = [jsonData objectFromJSONData];
            
            NSDictionary *list1 = jsonDic[@"datas"][0][@"infos"];
            NSDictionary *list2 = jsonDic[@"datas"][1][@"infos"];
            
            self.dataItemThree = [Model_scrollImage analyzeJsonWithData:list1];
            self.dataItemFour  = [Model_scrollImage analyzeJsonWithData:list2];
            
            _dataSource[2] = _dataItemThree;
            
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

- (void) loadNewWeekendData
{
    
    NSURL *url = [NSURL URLWithString:WEEKEND];
    
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
            
            NSDictionary *jsonDic = [jsonData objectFromJSONData];
            
            NSDictionary *list1 = jsonDic[@"datas"][0][@"infos"];
            
            NSMutableArray *dataArray = [Model_scrollImage analyzeJsonWithData:list1];
            
            for (Model_scrollImage *model in dataArray)
            {
                [self.dataItemThree addObject:model];
            }
            
            _dataSource[2] = _dataItemThree;
            
            // 刷新tableView上的数据
            [self.tableView reloadData];
            
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            
            NSLog(@"获取网络数据失败，开始加载本地备用数据。");
            
        }];
        
        NSOperationQueue *queue = [[NSOperationQueue alloc]init];
        // 将操作添加到线程中去
        [queue addOperation:operation];
    }
    LMMLog(@"加载新数据");
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    LMMLog(@"%@",change[@"new"]);
    
    if ([change[@"new"] isEqualToString: @"1"])
    {
        _dataSource[2] = _dataItemThree;
    }
    if ([change[@"new"] isEqualToString: @"0"])
    {
        _dataSource[2] = _dataItemFour;
    }
    [UIView animateWithDuration:2 animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
    
    [self.tableView reloadData];
    
    LMMLog(@"属性改变了.");
}

@end
