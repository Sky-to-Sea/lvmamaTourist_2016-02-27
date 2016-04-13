//
//  LMMWriteToPlist.h
//  lvmamaTourist
//
//  Created by Earth on 16/3/13.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlistModel.h"


@interface LMMWriteToPlist : NSObject

- (PlistModel *)readPlistData;

- (PlistModel *)readPlistDataWithFileName:(NSString *)name;

- (void)writePlistData:(PlistModel *)model;

- (void)writePlistData:(PlistModel *)model withFileName:(NSString *)name;


@end
