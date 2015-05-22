//
//  Tools.m
//  Dome
//
//  Created by BTW on 15/1/13.
//  Copyright (c) 2015年 jenk. All rights reserved.
//
#import "Tools.h"
//#import "Reachability.h"

@implementation Tools

#pragma mark - color

+ (UIColor*)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:alpha];
}

+ (UIColor*)colorWithHex:(NSString*)hex alpha:(CGFloat)alpha
{
    assert(7 == [hex length]);
    assert('#' == [hex characterAtIndex:0]);
    
    NSString *redHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(1, 2)]];
    NSString *greenHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(3, 2)]];
    NSString *blueHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(5, 2)]];
    
    unsigned redInt = 0;
    NSScanner *rScanner = [NSScanner scannerWithString:redHex];
    [rScanner scanHexInt:&redInt];
    
    unsigned greenInt = 0;
    NSScanner *gScanner = [NSScanner scannerWithString:greenHex];
    [gScanner scanHexInt:&greenInt];
    
    unsigned blueInt = 0;
    NSScanner *bScanner = [NSScanner scannerWithString:blueHex];
    [bScanner scanHexInt:&blueInt];
    
    return [self colorWith8BitRed:redInt green:greenInt blue:blueInt alpha:alpha];
}

#pragma mark - NSString and NSDate Convert

+ (NSDate *) convertDateFromString:(NSString *)stringDate withType:(NSString *)_type
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:_type];
    
    return [dateFormatter dateFromString:stringDate];
}

+ (NSString *) convertStringFromDate:(NSDate *)_date withType:(NSString *)_type
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:_type];
    
    return [dateFormatter stringFromDate:_date];
}

#pragma mark - alert

+ (void)alertWithTitle:(NSString *)_title message:(NSString *)_msg
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:_title message:_msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - promptView

+ (PromptView *) showPromptToView:(UIView *)view atPoint:(CGPoint)point withText:(NSString *)text duration:(NSTimeInterval)duration
{
    
    PromptView *promptView = [[PromptView alloc] initAutoLoading:point];
    [promptView setText:text];
    promptView.missTime = duration;
    [promptView startLoading];
    [view addSubview:promptView];
    
    return promptView;
}
+ (BOOL) isNetworking{
    
    //    BOOL networking = [[Reachability reachabilityForInternetConnection] isReachable];
    BOOL networking = NO;
    //    Reachability *r=[Reachability reachabilityWithHostname:@"www.baidu.com"];
    //    switch ([r currentReachabilityStatus]) {
    //        case NotReachable:
    //            NSLog(@"not work");
    //            networking = NO;
    //            break;
    //        case ReachableViaWiFi:
    //            NSLog(@"wifi");
    //            break;
    //        case ReachableViaWWAN:{
    //            NSLog(@"wan");
    //        }
    //            break;
    //        default:
    //            break;
    //    }
    
    return networking;
}

+ (NSString *)getCurrentTime{
    
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy:MM:dd HH:mm:ss"];
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    currentTime = [NSString stringWithFormat:@"%@",currentTime];
    formatter = nil;
    
    return currentTime;
    
}
@end
