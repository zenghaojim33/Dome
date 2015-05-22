//
//  BWMiOSChartsFactory.h
//  ios-chartsDemo
//
//  Created by Bi Weiming on 15/4/23.
//  Copyright (c) 2015年 Bi Weiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Charts/Charts.h>
#import <Charts/Charts-Swift.h>
//#import "Dome-Swift.h"

/** BWMLineChartViewFactory用于顺序创建LineChartView */
@interface BWMLineChartViewFactory : NSObject

/** 1、创建LineChartView。hasFloat为Y轴显示是否需要浮点值，delegate可以为空。 */
+ (LineChartView *)createLineChartViewWithFrame:(CGRect)frame
                                       hasFloat:(BOOL)hasFloat
                                       delegate:(id<ChartViewDelegate>)delegate;

/** 2、创建 ChartDataEntry，相当于坐标的每个点的值 */
+ (ChartDataEntry *)createChartDataEntryWithValue:(float)value xIndex:(NSInteger)xIndex;

/** 3、创建LineChartDataSet。YVals是ChartDataEntry的数组，color为原点和线条的颜色 */
+ (LineChartDataSet *)createLineChartDataSetWithYVals:(NSArray *)YVals color:(UIColor *)color;

/** 4、创建LineChartData。XVals为x轴字符串的数组；dataSets为LineChartDataSet。 */
+ (LineChartData *)createLineChartDataWithXVals:(NSArray *)XVals dataSet:(LineChartDataSet *)dataSet;

/** 5、更新数据 */
+ (void)upData:(LineChartData *)lineChartData toLineChartView:(LineChartView *)lineChartView;

@end
