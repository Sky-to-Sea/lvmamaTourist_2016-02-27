//
//  Model_scrollImage.h
//  lvmama
//
//  Created by Earth on 15/11/18.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model_scrollImage : NSObject

/**
 *  id,标志为"ide"
 */
@property (nonatomic, strong) NSString *ide;
@property (nonatomic, strong) NSString *keyword;
/**
 *  标题
 */
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *market_price;
/**
 *  创建时间
 */
@property (nonatomic, strong) NSString *created_time;
/**
 *  跳转地址
 */
@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *image;
/**
 *  枚举类型(url/place)
 */
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *object_id;
@property (nonatomic, strong) NSString *sub_object_id;
/**
 *  (活动)结束时间
 */
@property (nonatomic, strong) NSString *end_time;
/**
 *  (活动)开始时间
 */
@property (nonatomic, strong) NSString *begin_time;
/**
 *  用户是否在线(登陆)
 */
@property (nonatomic, strong) NSString *online;

@property (nonatomic, strong) NSString *seq;
@property (nonatomic, strong) NSString *search_type;
/**
 *  是否有效("Y"/"N")
 */
@property (nonatomic, strong) NSString *is_valid;

@property (nonatomic, strong) NSString *keyword_type;
/**
 *  图片地址
 */
@property (nonatomic, strong) NSString *large_image;
/**
 *  iPad图片
 */
@property (nonatomic, strong) NSString *ipad_image;
/**
 *  stcok股票?基本都是999
 */
@property (nonatomic, strong) NSString *stock;

@property (nonatomic, strong) NSString *back_word5;
@property (nonatomic, strong) NSString *back_word4;
@property (nonatomic, strong) NSString *back_word3;
@property (nonatomic, strong) NSString *back_word2;
@property (nonatomic, strong) NSString *back_word1;
@property (nonatomic, strong) NSString *pindao;

@property (nonatomic, strong) NSString *destName;
@property (nonatomic, strong) NSString *productDestId;


/**
 *  JSON解析方法
 */
+ (NSMutableArray *) analyzeJsonWithData:(NSDictionary *) list;

/**
 *  合并dictionary并解析
 */
+ (NSMutableArray *) analyzeJsonWithData:(NSDictionary *) listOne andData:(NSDictionary *)listTwo;



@end
