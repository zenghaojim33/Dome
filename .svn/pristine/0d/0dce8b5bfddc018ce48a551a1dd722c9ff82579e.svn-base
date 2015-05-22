//
//  StartTimeViewController.m
//  Dome
//
//  Created by BTW on 15/2/15.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import "StartTimeViewController.h"

@interface StartTimeViewController ()

@end

@implementation StartTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"请选择开始日期";
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
-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
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
    NSLog(@"selectedDate:%@", dateString);
    
    [self.delegate SetStartTimeString:dateString];
    
    [self.navigationController popViewControllerAnimated:YES];
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
