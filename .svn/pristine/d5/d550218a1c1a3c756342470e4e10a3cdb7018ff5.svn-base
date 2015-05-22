//
//  EndTimeViewController.m
//  Dome
//
//  Created by BTW on 15/2/15.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import "EndTimeViewController.h"

@interface EndTimeViewController ()

@end

@implementation EndTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请选择结束日期";
    self.view.backgroundColor = [UIColor colorWithHexString:@"0xf3f3f3"];
    
    UIView * white = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    white.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:white];
    
    
    VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
    CGPoint point = calendar.center;
    point.x = self.view.center.x;
    calendar.center = point;
    
    calendar.delegate=self;
    [self.view addSubview:calendar];
}
-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(long int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    if (month==[[NSDate date] month]) {
        NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:5], nil];
        [calendarView markDates:dates];
    }
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString* dateString = [fmt stringFromDate:date];
    
    
    
    BOOL isComparison = [self ComparisonDataForDate1:self.StartTimeStr AndDate2:dateString];
    
    if (isComparison ==false)
    {
        [self ShowAlertViewForTitle:@"结束日期不可早与开始日期"];
    }else{
        
        [self.delegate SetEndTimeString:dateString];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-  (BOOL)ComparisonDataForDate1:(NSString*)date1Str AndDate2:(NSString*)date2Str
{
    
    
    BOOL isCompar;
    NSDateFormatter *DateFormatter1 = [[NSDateFormatter alloc] init];
    
    [DateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *Date1 = [DateFormatter1 dateFromString:date1Str];
    
    NSTimeZone *NowZone = [NSTimeZone systemTimeZone];
    
    NSInteger NowInterval = [NowZone secondsFromGMTForDate: Date1];
    
    Date1 = [Date1  dateByAddingTimeInterval: NowInterval];
    
    NSLog(@"开始时间:%@", Date1);
    
    NSDateFormatter *DateFormatter2 = [[NSDateFormatter alloc] init];
    
    [DateFormatter2 setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *Date2 = [DateFormatter2 dateFromString:date2Str];
    
    NSTimeZone *NowZone2 = [NSTimeZone systemTimeZone];
    
    NSInteger NowInterval2 = [NowZone2 secondsFromGMTForDate: Date2];
    
    Date2 = [Date2  dateByAddingTimeInterval: NowInterval2];
    
    NSLog(@"结束时间:%@", Date2);
    
    NSDate * earlyDate = [Date1 earlierDate:Date2];
    
    if ([earlyDate isEqualToDate:Date2]) {
        isCompar = NO;
    }else{
        isCompar = YES;
    }
    
    return isCompar;
    
}
-(void)ShowAlertViewForTitle:(NSString*)title
{
    UIAlertView * av = [[UIAlertView alloc]initWithTitle:title message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [av show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
