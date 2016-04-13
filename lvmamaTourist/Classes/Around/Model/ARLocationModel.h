//
//  ARLocationModel.h
//  lvmamaTourist
//
//  Created by Earth on 16/3/10.
//  Copyright © 2016年 Earth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARLocationModel : NSObject

/**
 *  坐标位置
 */
@property (nonatomic, assign) CLLocationCoordinate2D location;
/**
 *  预览图片的地址
 */
@property (nonatomic, strong) NSString *imageUrl;
/**
 *  产品ID
 */
@property (nonatomic, strong) NSString *productId;
/**
 *  产品名称
 */
@property (nonatomic, strong) NSString *productName;

/**
 *  类型
 */
@property (nonatomic, assign) BOOL type;

+ (NSMutableArray *)analizeToModelWithArray:(NSMutableArray *)mArray withType:(BOOL)type;


@end
