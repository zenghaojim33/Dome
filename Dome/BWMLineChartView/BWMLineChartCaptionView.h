//
//  BWMLineChartCaptionView.h
//  ios-chartsDemo
//
//  Created by Bi Weiming on 15/4/23.
//  Copyright (c) 2015年 Bi Weiming. All rights reserved.
//

#import <UIKit/UIKit.h>

/** LineChartView的表头 */
@interface BWMLineChartCaptionView : UIView

/** 表头字符串 */
@property (strong, nonatomic, readwrite) NSString *title;

/** 表头原点颜色 */
@property (strong, nonatomic, readwrite) UIColor *originColor;

/** 左边偏移距离 */
@property (assign, nonatomic, readwrite) CGFloat marginLeft;

/** 表头标题Label (readonly) */
@property (strong, nonatomic, readonly) UILabel *titleLabel;

/** 表头标题原点 (readonly) */
@property (strong, nonatomic, readonly) UIView *originView;

/** 创建BWMLineChartCaptionView */
+ (instancetype)createWithFrame:(CGRect)frame
                    originColor:(UIColor *)originColor
                          title:(NSString *)title
                     marginLeft:(CGFloat)marginLeft;

@end
