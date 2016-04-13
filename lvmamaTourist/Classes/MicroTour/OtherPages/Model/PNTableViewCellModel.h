//
//  PNTableViewCellModel.h
//  lvmamaTourist
//
//  Created by Earth on 16/3/1.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNTableViewCellModel : NSObject

@property (nonatomic, strong) NSString *abroad;
@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, strong) NSString *coverImg;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *currentName;
@property (nonatomic, strong) NSString *dayCount;
@property (nonatomic, strong) NSString *favoriteCount;
@property (nonatomic, strong) NSString *fileUrl;
@property (nonatomic, strong) NSString *finished;
@property (nonatomic, strong) NSString *imgCount;
@property (nonatomic, strong) NSString *loscIn;
@property (nonatomic, strong) NSString *loscOut;
@property (nonatomic, strong) NSString *memo;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *parentName;
@property (nonatomic, strong) NSString *photos;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *shareCount;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *tripId;
@property (nonatomic, strong) NSString *updateDate;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userImg;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *verify;
@property (nonatomic, strong) NSString *visitTime;

+ (PNTableViewCellModel *)initWithDict:(NSDictionary *)dict;

- (PNTableViewCellModel *)analizeDictionaryToModel:(NSDictionary *)dict;

@end
