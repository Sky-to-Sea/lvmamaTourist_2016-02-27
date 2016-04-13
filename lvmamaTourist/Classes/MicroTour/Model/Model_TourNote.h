//
//  Model_TourNote.h
//  lvmamaTourist
//
//  Created by Earth on 15/12/13.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model_TourNote : NSObject

@property (nonatomic, strong) NSString *abroad;
/**
 *  评论数量
 */
@property (nonatomic, strong) NSString *commentCount;
/**
 *  图片地址（需自行添加@"http://pic.lvmama.com"）;
 */
@property (nonatomic, strong) NSString *coverImg;
/**
 *  1970年至今时间
 */
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *currentName;
/**
 *  旅游时长
 */
@property (nonatomic, strong) NSString *dayCount;
/**
 *  收藏？
 */
@property (nonatomic, strong) NSString *favoriteCount;
@property (nonatomic, strong) NSString *fileUrl;
/**
 *  Y/N
 */
@property (nonatomic, strong) NSString *finished;
@property (nonatomic, strong) NSString *imgCount;
@property (nonatomic, strong) NSString *loscIn;
@property (nonatomic, strong) NSString *loscOut;
/**
 *  很长，然而不知道是什么东西
 */
@property (nonatomic, strong) NSString *memo;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *parentName;
@property (nonatomic, strong) NSString *shareCount;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *tripId;
/**
 *  更新时间
 */
@property (nonatomic, strong) NSString *updateDate;
@property (nonatomic, strong) NSString *userId;
/**
 *  用户头像
 */
@property (nonatomic, strong) NSString *userImg;
/**
 *  用户名
 */
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *verify;
@property (nonatomic, strong) NSString *visitTime;


/**
 *  解析JSON
 */
+ (NSMutableArray *) analyzeJsonWithData:(NSDictionary *)list;

@end
