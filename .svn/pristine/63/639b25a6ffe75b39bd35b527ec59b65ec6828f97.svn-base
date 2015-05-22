//
//  EndTimeViewController.h
//  Dome
//
//  Created by BTW on 15/2/15.
//  Copyright (c) 2015年 jenk. All rights reserved.
//
@protocol EndTimeDelegate;
#import <UIKit/UIKit.h>
#import "VRGCalendarView.h"
@interface EndTimeViewController : UIViewController<VRGCalendarViewDelegate>
@property(nonatomic,strong)NSString * StartTimeStr;
@property(nonatomic,strong)id<EndTimeDelegate>delegate;
@end
@protocol EndTimeDelegate <NSObject>

-(void)SetEndTimeString:(NSString *)EndTime;

@end