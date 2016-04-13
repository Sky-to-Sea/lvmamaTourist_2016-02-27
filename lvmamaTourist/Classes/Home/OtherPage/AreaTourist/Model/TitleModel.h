//
//  TitleModel.h
//  lvmamaTourist
//
//  Created by Earth on 16/3/12.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TitleModel : NSObject

@property (nonatomic, strong) NSString *all_channel;
@property (nonatomic, strong) NSString *back_word1;
@property (nonatomic, strong) NSString *back_word2;
@property (nonatomic, strong) NSString *back_word3;
@property (nonatomic, strong) NSString *back_word4;
@property (nonatomic, strong) NSString *back_word5;
@property (nonatomic, strong) NSString *begin_time;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *created_time;
@property (nonatomic, strong) NSString *destName;
@property (nonatomic, strong) NSString *end_time;
@property (nonatomic, strong) NSString *ide;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *ipad_image;
@property (nonatomic, strong) NSString *is_valid;
@property (nonatomic, strong) NSString *keyword;
@property (nonatomic, strong) NSString *keyword_type;
@property (nonatomic, strong) NSString *large_image;
@property (nonatomic, strong) NSString *market_price;
@property (nonatomic, strong) NSString *object_id;
@property (nonatomic, strong) NSString *online;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *productDestId;
@property (nonatomic, strong) NSString *search_type;
@property (nonatomic, strong) NSString *seq;
@property (nonatomic, strong) NSString *sub_object_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *url;


- (NSMutableArray *)analizeDictToModelArrays:(NSDictionary *)dict;


@end
