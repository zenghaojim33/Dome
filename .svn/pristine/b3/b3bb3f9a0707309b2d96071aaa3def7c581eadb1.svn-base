//
//  BWMLineChartView.m
//  ios-chartsDemo
//
//  Created by Bi Weiming on 15/4/23.
//  Copyright (c) 2015年 Bi Weiming. All rights reserved.
//

#import "BWMLineChartView.h"
#import "BWMLineChartViewFactory.h"
#import "BWMLineChartCaptionView.h"

@interface BWMLineChartView() <ChartViewDelegate> {
    BWMLineChartCaptionView *_captionView;
    LineChartView *_lineChartView;
}

@end

@implementation BWMLineChartView

- (void)setTitle:(NSString *)title {
    _title = title;
    
    _captionView.title = title;
}

- (void)setColor:(UIColor *)color {
    _color = color;
    
    _captionView.originColor = color;
}

- (void)updateWithTitle:(NSString *)title XVals:(NSArray *)XVals YVals:(NSArray *)YVals {
    _captionView.title = title;
    
    NSMutableArray *chartDataEntryArray = [NSMutableArray array];
    [YVals enumerateObjectsUsingBlock:^(NSNumber *numberObj, NSUInteger idx, BOOL *stop) {
        [chartDataEntryArray addObject:[BWMLineChartViewFactory createChartDataEntryWithValue:[numberObj floatValue] xIndex:idx]];
    }];
    LineChartDataSet * lineChartDataSet = [BWMLineChartViewFactory createLineChartDataSetWithYVals:chartDataEntryArray color:self.color];
    LineChartData * lineChartData = [BWMLineChartViewFactory createLineChartDataWithXVals:XVals dataSet:lineChartDataSet];
    _lineChartView.data = lineChartData;
    [BWMLineChartViewFactory upData:lineChartData toLineChartView:_lineChartView];
}

- (instancetype)initWithFrame:(CGRect)frame
                        color:(UIColor *)color
                     hasFloat:(BOOL)hasFloat
                     delegate:(id<BWMLineChartViewDelegate>)delegate {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        if (color==nil) {
            color = [UIColor redColor];
        }
        
        self.color = color;
        self.delegate = delegate;
        
        _captionView = [BWMLineChartCaptionView
                        createWithFrame:CGRectMake(0, 10, self.frame.size.width, 20)
                        originColor:color
                        title:@""
                        marginLeft:10.0f];
        [self addSubview:_captionView];
        
        _lineChartView = [BWMLineChartViewFactory
                          createLineChartViewWithFrame:CGRectMake(0, _captionView.frame.size.height, self.frame.size.width, self.frame.size.height-_captionView.frame.size.height)
                          hasFloat:hasFloat
                          delegate:nil];
        [self addSubview:_lineChartView];
        _lineChartView.userInteractionEnabled = NO;
        
        [self bringSubviewToFront:_captionView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)viewTap:(UITapGestureRecognizer *)recognizer {
    if (_delegate) {
        [_delegate lineChartViewSelected:self];
    }
}

@end
