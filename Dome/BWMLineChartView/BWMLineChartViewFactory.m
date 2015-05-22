//
//  BWMiOSChartsFactory.m
//  ios-chartsDemo
//
//  Created by Bi Weiming on 15/4/23.
//  Copyright (c) 2015年 Bi Weiming. All rights reserved.
//

#import "BWMLineChartViewFactory.h"

@implementation BWMLineChartViewFactory

+ (LineChartView *)createLineChartViewWithFrame:(CGRect)frame
                                       hasFloat:(BOOL)hasFloat
                                       delegate:(id<ChartViewDelegate>)delegate {
    LineChartView *lineChartView = [[LineChartView alloc] initWithFrame:frame];
    lineChartView.delegate = delegate;
    [lineChartView setDoubleTapToZoomEnabled:NO];
    [lineChartView setDescriptionText:@""];
    [lineChartView setNoDataText:@"加载数据中..."];
    [lineChartView setDrawGridBackgroundEnabled:NO];
    [lineChartView setDragEnabled:NO];
    [lineChartView setScaleEnabled:NO];
    [lineChartView setHighlightEnabled:NO];
    [lineChartView setHighlightIndicatorEnabled:NO];
    [lineChartView setPinchZoomEnabled:NO];
    [lineChartView setBackgroundColor:[UIColor whiteColor]];
    lineChartView.rightAxis.enabled = NO;
    lineChartView.leftAxis.labelCount = 4;
    lineChartView.leftAxis.startAtZeroEnabled = YES;
    
    [lineChartView.xAxis setDrawGridLinesEnabled:NO];
    [lineChartView.leftAxis setDrawAxisLineEnabled:NO];
    [lineChartView.xAxis setGridLineWidth:1.25f];
    [lineChartView.xAxis setGridColor:[UIColor whiteColor]];
    
    [lineChartView.xAxis setLabelPosition:XAxisLabelPositionBottom];
    lineChartView.legend.enabled = NO;
    
    [lineChartView.xAxis setSpaceBetweenLabels:-3];
    
    if (!hasFloat) {
        ChartYAxis *leftAxis = lineChartView.leftAxis;
        leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
        leftAxis.valueFormatter = [[NSNumberFormatter alloc] init];
    }
    
    return lineChartView;
}

+ (ChartDataEntry *)createChartDataEntryWithValue:(float)value xIndex:(NSInteger)xIndex {
    ChartDataEntry *chartDataEntry = [[ChartDataEntry alloc] initWithValue:value xIndex:xIndex];
    return chartDataEntry;
}

+ (LineChartDataSet *)createLineChartDataSetWithYVals:(NSArray *)YVals color:(UIColor *)color {
    LineChartDataSet *d = [[LineChartDataSet alloc] initWithYVals:YVals label:@""];
    d.drawValuesEnabled = NO;
    d.lineWidth = 1.5f;
    d.circleRadius = 2.5f;
    [d setColor:color];
    [d setCircleColor:color];
    return d;
}

+ (LineChartData *)createLineChartDataWithXVals:(NSArray *)XVals dataSet:(LineChartDataSet *)dataSet {
    LineChartData *resultData = [[LineChartData alloc] initWithXVals:XVals dataSets:@[dataSet]];
    return resultData;
}

+ (void)upData:(LineChartData *)lineChartData toLineChartView:(LineChartView *)lineChartView {
    lineChartView.data = lineChartData;
    [lineChartView animateWithXAxisDuration:1.0 easingOption:ChartEasingOptionLinear];
}

@end
