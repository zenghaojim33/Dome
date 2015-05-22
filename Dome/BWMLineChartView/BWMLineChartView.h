//
//  BWMLineChartView.h
//  ios-chartsDemo
//
//  Created by Bi Weiming on 15/4/23.
//  Copyright (c) 2015年 Bi Weiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BWMLineChartView;

@protocol BWMLineChartViewDelegate <NSObject>

/** 选中BWMLineChartView的时候回调 */
- (void)lineChartViewSelected:(BWMLineChartView *)lineChartView;

@end

/** BWMLineChartView图表 */
@interface BWMLineChartView : UIView

/** 的标题 */
@property (strong, nonatomic, readwrite) NSString *title;

/** 全局颜色 */
@property (strong, nonatomic, readwrite) UIColor *color;

/** 需要设置的代理 */
@property (weak, nonatomic, readwrite) id<BWMLineChartViewDelegate> delegate;

/** 创建BWMLineChartView */
- (instancetype)initWithFrame:(CGRect)frame
                        color:(UIColor *)color
                     hasFloat:(BOOL)hasFloat
                     delegate:(id<BWMLineChartViewDelegate>)delegate;

/** 更新BWMLineChartView的数据 */
- (void)updateWithTitle:(NSString *)title
                  XVals:(NSArray *)XVals
                  YVals:(NSArray *)YVals;

@end
