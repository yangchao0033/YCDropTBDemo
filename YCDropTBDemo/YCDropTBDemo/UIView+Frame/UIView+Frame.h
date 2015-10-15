//
//  UIView+Frame.h
//  传智微博
//
//  Created by 李南江 on 15/3/1.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

// 如果@property在分类里面使用只会自动声明get,set方法,不会实现,并且不会帮你生成成员属性
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
/*!
 *  @author 杨超, 15-09-24 11:09:30
 *
 *  @brief  自适应文字高度
 *
 *  @param width 预估宽度
 *  @param font  字体
 *  @param str   字符处啊
 *
 *  @return 返回高度
 *
 *  @since 1.0
 */
- (CGFloat)AdaptiveTextHeightWithWidth:(CGFloat)width andFont:(UIFont *)font andStr:(NSString *)str;
/*!
 *  @author 杨超, 15-09-29 11:09:16
 *
 *  @brief  返回指定文字size
 *
 *  @param width 文字限制宽度
 *  @param font  文字字体
 *  @param str   字符串
 *
 *  @return 返回值
 *
 *  @since 1.0
 */
- (CGSize)AdaptiveStrHeightWithWidth:(CGFloat)width andFont:(UIFont *)font andStr:(NSString *)str;
@end
