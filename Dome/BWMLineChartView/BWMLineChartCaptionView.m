//
//  BWMLineChartCaptionView.m
//  ios-chartsDemo
//
//  Created by Bi Weiming on 15/4/23.
//  Copyright (c) 2015年 Bi Weiming. All rights reserved.
//

#import "BWMLineChartCaptionView.h"

@implementation BWMLineChartCaptionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width-30, self.frame.size.height)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [self addSubview:_titleLabel];
    
    _originView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height/2.0-2.5, 5, 5)];
    _originView.layer.cornerRadius = 5/2.0;
    _originView.layer.masksToBounds = YES;
    [self addSubview:_originView];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

- (void)setOriginColor:(UIColor *)originColor {
    _originColor = originColor;
    _originView.backgroundColor = originColor;
}

- (void)setMarginLeft:(CGFloat)marginLeft {
    _marginLeft = marginLeft;
    
    CGRect rect = _titleLabel.frame;
    rect.origin.x += marginLeft;
    _titleLabel.frame = rect;
    
    rect = _originView.frame;
    rect.origin.x += marginLeft;
    _originView.frame = rect;
}

+ (instancetype)createWithFrame:(CGRect)frame
                    originColor:(UIColor *)originColor
                          title:(NSString *)title
                     marginLeft:(CGFloat)marginLeft {
    BWMLineChartCaptionView *view = [[BWMLineChartCaptionView alloc] initWithFrame:frame];
    view.originColor = originColor;
    view.title = title;
    view.marginLeft = marginLeft;
    return view;
}

@end
