//
//  LMMWriteToPlist.m
//  lvmamaTourist
//
//  Created by Earth on 16/3/13.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import "LMMWriteToPlist.h"
#import "MJExtension.h"

@implementation LMMWriteToPlist

- (PlistModel *)readPlistData
{
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"LocationData" ofType:@"plist"];
//    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"LocationData.plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    
    PlistModel *model = [PlistModel mj_objectWithKeyValues:data];
    
    return model;
}

- (void)writePlistData:(PlistModel *)model
{
    NSString *plistPath0 = [[NSBundle mainBundle] pathForResource:@"LocationData" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath0];
    
    data[@"city"] = model.city;
    data[@"latitude"] = [NSString stringWithFormat:@"%f",model.latitude];
    data[@"longitude"] = [NSString stringWithFormat:@"%f",model.longitude];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"LocationData.plist"];
    
    [data writeToFile:plistPath atomically:YES];
}

- (PlistModel *)readPlistDataWithFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    PlistModel *model = [PlistModel mj_objectWithKeyValues:data];
    
    return model;
}

- (void)writePlistData:(PlistModel *)model withFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"LocationData.plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    data[@"city"] = model.city;
    data[@"latitude"] = [NSString stringWithFormat:@"%f",model.latitude];
    data[@"longitude"] = [NSString stringWithFormat:@"%f",model.longitude];
    
    [data writeToFile:plistPath atomically:YES];
}


@end
