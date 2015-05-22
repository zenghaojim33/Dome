//
//  StartTimeViewController.h
//  Dome
//
//  Created by BTW on 15/2/15.
//  Copyright (c) 2015年 jenk. All rights reserved.
//
@protocol StartTimeDelegate;

#import <UIKit/UIKit.h>
#import "VRGCalendarView.h"
@interface StartTimeViewController : UIViewController<VRGCalendarViewDelegate>
@property(nonatomic,strong)id<StartTimeDelegate>delegate;
@end

@protocol StartTimeDelegate <NSObject>

-(void)SetStartTimeString:(NSString *)startTime;

@end