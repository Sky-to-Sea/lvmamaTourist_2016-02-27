//
//  Model_dataCache.h
//  lvmamaTourist
//
//  Created by Earth on 15/12/7.
//  Copyright © 2015年 Earth. All rights reserved.
//

//  这个类是用来写缓存的.

#import <Foundation/Foundation.h>
#import "Model_scrollImage.h"

@interface Model_dataCache : NSObject

/**
 *  传入model集合,归档
 *
 */
- (void) creatCache:(NSMutableArray *)imageData;

/**
 *  解档
 */
- (NSMutableArray *) undoData;

@end
