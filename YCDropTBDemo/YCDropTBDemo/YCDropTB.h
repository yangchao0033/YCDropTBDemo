//
//  YCDropTB.h
//  YCDropTBDemo
//
//  Created by 超杨 on 15/10/15.
//  Copyright (c) 2015年 超杨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCDropTB : UIViewController

/*!
 *  @author 杨超, 15-09-21 13:09:40
 *
 *  @brief  数据源
 *
 *  @since 1.0
 */
@property (nonatomic, strong, nonnull) NSMutableArray *dataSource;
/*!
 *  @author 杨超, 15-10-15 15:10:07
 *
 *  @brief  设置列表的大小(可以不设置，由控件自己计算)
 *
 *  @since 1.0
 */
@property (nonatomic, assign) CGSize Size;
/*!
 *  @author 杨超, 15-10-15 15:10:09
 *
 *  @brief  初始化数据源并创建控件
 *
 *  @param dataSource 数据源
 *
 *  @return 返回本类实例
 *
 *  @since <#1.0#>
 */
+ (nonnull instancetype )YCDropTBWithDataSource:(NSMutableArray  * __nonnull)dataSource;
/*!
 *  @author 杨超, 15-09-21 10:09:20
 *
 *  @brief  工厂方法
 *
 *  @param arr 数据源数组
 *
 *  @return 实例对象
 *
 *  @since 1.0
 */
+ (nonnull instancetype )YCDropTBWithDataSource:(NSMutableArray  * __nonnull)dataSource backIndexOfDataSource:(void (^__nullable)(NSInteger index, UIView * __nullable blewView))backIndex;

/*!
 *  @author 杨超, 15-09-21 10:09:43
 *
 *  @brief  展示界面
 *
 *  @since 1.0
 */
- (void)showBlowView:(UIView * __nonnull)view;

@property (nonatomic, copy) void ( ^ __nullable backIndexOfDataSource)(NSInteger index, UIView * __nullable blewView);

@end