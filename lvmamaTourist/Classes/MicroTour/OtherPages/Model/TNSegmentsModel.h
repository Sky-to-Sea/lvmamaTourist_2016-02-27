//
//  TNSegmentsModel.h
//  lvmamaTourist
//
//  Created by Earth on 16/2/20.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNSegmentsModel : NSObject

@property (nonatomic, strong) NSString *imageUrl;

@property (nonatomic, strong) NSString *text;

- (TNSegmentsModel *)analizeDictionaryToModel:(NSDictionary *)dict;

@end
