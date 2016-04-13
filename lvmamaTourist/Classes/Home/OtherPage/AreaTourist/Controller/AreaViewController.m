//
//  AreaViewController.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/12.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "AreaViewController.h"
#import "AreaService.h"
#import "TopicModel.h"
#import "UIImageView+WebCache.h"
#import "LMMWebViewController.h"
#import "TitleModel.h"
#import "AreaCellService.h"
#import "MJDIYHeader.h"
#import "MJDIYBackFooter.h"
#import "AreaViewCell.h"

@interface AreaViewController ()<ServiceCallback,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) AreaService *areaService;
@property (nonatomic, strong) AreaCellService *areaCellService;

@property (nonatomic, strong) NSMutableArray *imagesArray;

@property (nonatomic, strong) NSMutableArray *modelArrayOne;
@property (nonatomic, strong) NSMutableArray *modelArrayTwo;

@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic, strong) NSMutableArray *heightArray;



@end

@implementation AreaViewController

- (NSMutableArray *)modelArrayTwo
{
    if (!_modelArrayTwo)
    {
        _modelArrayTwo = [[NSMutableArray alloc]init];
    }
    return _modelArrayTwo;
}

- (NSMutableArray *)heightArray
{
    if (!_heightArray)
    {
        _heightArray = [[NSMutableArray alloc]init];
    }
    return _heightArray;
}

- (NSMutableArray *)imagesArray
{
    if (!_imagesArray)
    {
        _imagesArray = [NSMutableArray arrayWithObjects:_imageOne,_imageTwo,_imageThree,_imageFour,_imageFive,_imageSix,nil];
    }
    return _imagesArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [GiFHUD show];
    
    _pageIndex = 1;
    
    _areaService =[[ AreaService alloc]initWithSid:@"areaService" andCallback:self];
    _areaCellService = [[AreaCellService alloc]initWithSid:@"areaCellService" andCallback:self];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AreaViewCell" bundle:nil] forCellReuseIdentifier:@"areaCell"];
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingBlock:^{
        
        _pageIndex = 1;
        
        [_areaCellService requestDataWithPageIndex:_pageIndex];
        [_areaService requestData];
        
    }];
    self.tableView.mj_footer = [MJDIYBackFooter footerWithRefreshingBlock:^{
       
        [_areaService requestData];
        [_areaCellService requestDataWithPageIndex:_pageIndex];
    }];
    
    
    [_areaService requestData];
    [_areaCellService requestDataWithPageIndex:_pageIndex];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AreaViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"areaCell" forIndexPath:indexPath];
    
    [cell setCellWithData:self.dataSource[indexPath.row] withController:self];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//- (CGFloat)tableView:(UITableView *)tableView  heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
}

- (void)callbackWithResult:(ServiceResult *)result forSid:(NSString *)sid
{
    if ([sid isEqualToString:@"areaService"])
    {
        TitleModel *model = [[TitleModel alloc]init];
        
        NSMutableArray *array = [model analizeDictToModelArrays:result.data[@"datas"]];
        
        self.modelArrayOne = [NSMutableArray arrayWithArray:array];
        
        [self setViewWithData:array];
    }
    
    if ([sid isEqualToString:@"areaCellService"])
    {
        if (_pageIndex == 1)
        {
            [self.modelArrayTwo removeAllObjects];
        }
        
        NSMutableArray *array = [TopicModel analyzeJsonWithData:result.data[@"datas"][0][@"infos"]];
        
        for (TopicModel *model in array)
        {
            [self.modelArrayTwo addObject:model];
        }
        
        self.dataSource = [NSMutableArray arrayWithArray:self.modelArrayTwo];
        [self.tableView reloadData];
        
        _pageIndex ++;
        [self finish];
        
    }
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

- (void)setViewWithData:(NSMutableArray *)modelArray
{
    for (int i = 0; i <self.imagesArray.count; i ++)
    {
        TitleModel *model = modelArray[i];
        UIImageView *imageView = self.imagesArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.large_image] placeholderImage:nil];
        
        imageView.tag = i;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClick:)];
        [imageView addGestureRecognizer:tap];
    }
}

- (void)onClick:(UITapGestureRecognizer *)tapGesture
{
    LMMWebViewController *viewCtl = [[LMMWebViewController alloc]init];
    TitleModel *model = self.modelArrayOne[tapGesture.view.tag];
    viewCtl.urlString = model.url;
    viewCtl.titleName = model.title;
    viewCtl.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:viewCtl animated:YES];
}

- (IBAction)onTapBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
