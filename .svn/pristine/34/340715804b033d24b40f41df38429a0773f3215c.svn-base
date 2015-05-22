//
//  Tools.h
//  Dome
//
//  Created by BTW on 15/1/13.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PromptView.h"

typedef NS_ENUM(NSInteger, DeviceModelType)
{
    DeviceModelTypeLogin = 0,
    DeviceModelTypeList,
    DeviceModelTypeDetail,
};

typedef NS_ENUM(NSInteger, LoginUserType)
{
    LoginUserTypeGeneralUser = 1,
    LoginUserTypeFacilitatorUser,
};

@interface Tools : NSObject

//color
+ (UIColor *)colorWithHex:(NSString *)hex alpha:(CGFloat)alpha;

//NSString and NSDate Convert
+ (NSDate *) convertDateFromString:(NSString *)stringDate withType:(NSString *)_type;
+ (NSString *) convertStringFromDate:(NSDate *)_date withType:(NSString *)_type;

//alert
+ (void)alertWithTitle:(NSString *)_title message:(NSString *)_msg;

//promptView
+ (PromptView *) showPromptToView:(UIView *)view atPoint:(CGPoint)point withText:(NSString *)text duration:(NSTimeInterval)duration;


//判断网络是否连接
+ (BOOL) isNetworking;

+ (NSString *)getCurrentTime;


@end
