//
//  PromptView.h
//  Dome
//
//  Created by BTW on 15/1/13.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "convertGB_BIG.h"

@interface PromptView : UIView{
    
    UIImageView *loadingBar;
    UIActivityIndicatorView *myLoading;
    UIView *mAlertView;
    UIView *mAlertViewSuperView;
    CGPoint boundses;
    //简体转换繁体
    BOOL traditionalStyle;
    //    convertGB_BIG *_convertManager;
    
}
@property (nonatomic, retain) UIImageView *loadingBar;
@property (nonatomic, retain) UILabel *loadingLabel;
@property (nonatomic, retain) UIView *mAlertView;
@property (nonatomic, retain) UIView *mAlertViewSuperView;
@property (nonatomic, assign) CGPoint boundses;
@property (nonatomic, assign) NSInteger autoFlag;
@property (nonatomic, assign) BOOL loadingFlag;
@property (nonatomic, assign) BOOL loadingOkDelayFlag;
@property (nonatomic, assign) CGFloat orginxx;
@property (nonatomic, assign) CGFloat missTime;
-(void)setText:(NSString *)text;
-(void)startLoading;
-(void)stopLoading;
-(void)dismissAlertView;
- (id)initAutoLoading:(CGPoint)bounds;
@end
