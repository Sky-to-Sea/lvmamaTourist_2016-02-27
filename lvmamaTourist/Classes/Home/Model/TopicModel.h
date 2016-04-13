//
//  TopicModel.h
//  lvmamaTourist
//
//  Created by Earth on 16/1/3.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicModel : NSObject

@property (nonatomic, copy) NSString *all_channel;
@property (nonatomic, copy) NSString *back_word1;
@property (nonatomic, copy) NSString *back_word2;
@property (nonatomic, copy) NSString *back_word3;
@property (nonatomic, copy) NSString *back_word4;
@property (nonatomic, copy) NSString *back_word5;
@property (nonatomic, copy) NSString *begin_time;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *created_time;
@property (nonatomic, copy) NSString *destName;
@property (nonatomic, copy) NSString *end_time;
@property (nonatomic, copy) NSString *ide;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *ipad_image;
@property (nonatomic, copy) NSString *is_valid;
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, copy) NSString *keyword_type;
@property (nonatomic, copy) NSString *large_image;
@property (nonatomic, copy) NSString *market_price;
@property (nonatomic, copy) NSString *object_id;
@property (nonatomic, copy) NSString *online;
@property (nonatomic, copy) NSString *pindao;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *productDestId;
@property (nonatomic, copy) NSString *search_type;
@property (nonatomic, copy) NSString *seq;
@property (nonatomic, copy) NSString *sub_object_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *url;

/**
 *  JSON解析方法
 */
+ (NSMutableArray *) analyzeJsonWithData:(NSDictionary *) dict;

@end
