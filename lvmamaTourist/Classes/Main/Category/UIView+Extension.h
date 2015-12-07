//
//  UIView+Extension.h
//  神马微博
//
//  Created by admin on 15-10-1.
//  Copyright (c) 2015年 Earth. All rights reserved.
//
//这里是UIView的拓展类

#import <UIKit/UIKit.h>

@interface UIView (Extension)


/**
    扩充属性,设置setter&getter方法
    能够让所有继承自UIView的对象,能够直接对frame进行取值赋值操作.

    注意:此处是属性扩充,不是属性覆盖.
    也就是继承自UIView的对象都多了.x/.y/.width...等getter/setter方法
    原来的.frame.origin.x/frame.origin.y/frame.size.width...等不变
 */

/**
 *  对UIView扩充的x属性,能通过该属性直接对frame.origin.x进行取值/赋值操作.
 */
@property (nonatomic, assign) CGFloat x;
/**
 *  对UIView扩充的y属性,能通过该属性直接对frame.origin.y进行取值/赋值操作.
 */
@property (nonatomic, assign) CGFloat y;
/**
 *  对UIView扩充的width属性,能通过该属性直接对frame.size.width进行取值/赋值操作.
 */
@property (nonatomic, assign) CGFloat width;
/**
 *  对UIView扩充的height属性,能通过该属性直接对frame.size.height进行取值/赋值操作.
 */
@property (nonatomic, assign) CGFloat height;
/**
 *  对UIView扩充的size属性,能通过该属性直接对frame.size进行取/值赋值操作.
 */
@property (nonatomic, assign) CGSize  size;
/**
 *  对UIView扩充的origin属性,能通过该属性直接对frame.origin进行取值/赋值操作.
 */
@property (nonatomic, assign) CGPoint origin;




@end
