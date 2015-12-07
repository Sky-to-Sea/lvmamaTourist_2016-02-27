//
//  Tool_Json.h
//  lvmama
//
//  Created by Earth on 15/11/18.
//  Copyright © 2015年 Earth. All rights reserved.

/*
 *  【此工具类作废】
 *  情况：已将相同功能的方法直接加入到ViewController中
 *  原因：技术问题，目前解决不了block之后dataSource回传问题；
 *  解决思路：可以考虑delegate回传。但这个方法需要统筹异步请求以及数据回传，当前类亦无法独立完成，废弃。
 */

/*
 *  用于解析全部JSON类型的工具类
 *  传入需要解析的类型,返回对应的Model
 */


#import <Foundation/Foundation.h>
#import "Model_scrollImage.h"



typedef NS_ENUM(NSUInteger , LMMJsonType) {
    /**
     *  解析首页滚动图片(默认)
     */
    JsonType_scrollImage = 0,
};

@interface Tool_Json : NSObject


+ (Model_scrollImage *) modelWithType:(LMMJsonType) type;

@end
