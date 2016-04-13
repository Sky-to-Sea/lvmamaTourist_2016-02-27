//
//  TableModel.h
//  lvmamaTourist
//
//  Created by Earth on 16/2/19.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableModel : NSObject

//  游历时间
@property (nonatomic, strong) NSString *date;
//  游历者ID
@property (nonatomic, strong) NSString *ide;



- (void)analizeDictionaryToModel:(NSMutableDictionary *)dict;

@end
