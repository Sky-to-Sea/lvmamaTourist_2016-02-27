//
//  Model_dataCache.m
//  lvmamaTourist
//
//  Created by Earth on 15/12/7.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import "Model_dataCache.h"

@implementation Model_dataCache

- (void) creatCache:(NSMutableArray *)imageData
{
    NSLog(@" ---- 开始数据归档 ----");
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:imageData];
    [NSKeyedArchiver archiveRootObject:data toFile:@"colorDataCache.archiver"];

    NSFileManager *manager = [NSFileManager defaultManager];
    
    LMMLog(@"归档路径:%@",[manager currentDirectoryPath]);

    NSLog(@" ---- 归档结束 ----");
    
}

- (NSMutableArray *) undoData
{
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:@"colorDataCache.archiver"])
    {
        NSData *data = [NSKeyedUnarchiver unarchiveObjectWithFile:@"colorDataCache.archiver"];
        mArray = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    LMMLog(@" ---- 解档完毕 ---- ");
    
    return mArray;
}

@end
