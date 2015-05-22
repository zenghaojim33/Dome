//
//  JenkButton.m
//  Dome
//
//  Created by BTW on 15/3/4.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import "JenkButton.h"

@implementation JenkButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}
-(id)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
    
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}
-(void)initialize
{
    self.ButtinTitleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 4, 30, 32)];
    [self addSubview:self.ButtinTitleImageView];
    
    self.ButtonTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(46, 9, 80, 21)];
    [self addSubview:self.ButtonTitleLabel];
    
    self.TodayTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(46+80, 9, 33, 21)];
    [self addSubview:self.TodayTitleLabel];
    
    self.TodayNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(46+80+34, 9, 50, 21)];
    [self addSubview:self.TodayNumberLabel];
    
    self.YesterDayTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(46+80+34+50, 9, 33, 21)];
    [self addSubview:self.YesterDayTitleLabel];
    
    self.YesterDayNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(46+80+34+50+34, 9, 50, 21)];
    [self addSubview:self.YesterDayNumberLabel];

}
-(void)setButtinImage:(UIImage*)image ButtonTitle:(NSString*)buttinTitle TodayTitle:(NSString*)todayTitle TodayNumber:(NSString*)todayNumber YesterDayTitleLabel:(NSString*)yesterDayTitle YesterDayNumberLabel:(NSString*)yesterDayNumber
{

    self.ButtinTitleImageView.image = image;
    self.ButtonTitleLabel.text = buttinTitle;
    
    self.TodayTitleLabel.text = @"今天:";
    self.TodayTitleLabel.font = [UIFont systemFontOfSize:13.0];
    
    self.TodayNumberLabel.text = todayNumber;
    self.TodayNumberLabel.font = [UIFont systemFontOfSize:13.0];
    
    self.YesterDayTitleLabel.text = @"昨天:";
    self.YesterDayTitleLabel.font = [UIFont systemFontOfSize:13.0];
    
    self.YesterDayNumberLabel.text = yesterDayNumber;
    self.YesterDayNumberLabel.font = [UIFont systemFontOfSize:13.0];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
