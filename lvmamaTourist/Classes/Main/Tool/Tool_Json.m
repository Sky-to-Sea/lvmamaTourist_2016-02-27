//
//  Tool_Json.m
//  lvmama
//
//  Created by Earth on 15/11/18.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import "Tool_Json.h"
#import "Model_scrollImage.h"

@interface Tool_Json ()

@end

@implementation Tool_Json


#pragma mark - 选择支
/**
 *  传入一个想要的数据类型
 *  返回对应的数据model
 */
+ (Model_scrollImage *)modelWithType:(LMMJsonType)type
{
    Model_scrollImage *model = nil;
    
    if (type == 0)
    {
        model = [self modelWithScrollImage];
    }
    
    return model;
}

#pragma mark - 具体实现方法

+ (Model_scrollImage *) modelWithScrollImage
{

    NSURL *url = [NSURL URLWithString:SCROLLIMAGE];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        
        if (connectionError || data == nil)
        {
            LMMLog(@" ---- scrollImage网络请求错误 ---- \n%@",connectionError);
        }
        else
        {
            LMMLog(@" ---- scrollImage网络请求成功 ---- ");
            // 将获取的json交给对应的model分析,返回一个填充好数据的model
            [Model_scrollImage analyzeJsonWithData:data];
        }
    }];
    return nil;
}

@end
