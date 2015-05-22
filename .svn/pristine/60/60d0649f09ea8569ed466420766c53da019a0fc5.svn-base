//
//  PromptView.m
//  Dome
//
//  Created by BTW on 15/1/13.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import "PromptView.h"
#import <QuartzCore/QuartzCore.h>

#define loadBackColor       [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1]
@implementation PromptView

@synthesize loadingLabel;
@synthesize mAlertView;
@synthesize mAlertViewSuperView;
@synthesize loadingBar;
@synthesize boundses;
@synthesize autoFlag;
@synthesize loadingFlag;
@synthesize loadingOkDelayFlag;
@synthesize orginxx;
@synthesize missTime;

static CGFloat kTransitionDuration = 0.3f;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //繁体转换
        traditionalStyle = [[NSUserDefaults standardUserDefaults] boolForKey:@"Language"];
        
        if (traditionalStyle) {
            
            //            _convertManager = [[convertGB_BIG alloc] init];
        }
    }
    return self;
}
- (id)initAutoLoading:(CGPoint)bounds
{
    self.boundses = bounds;
    CGRect frame = CGRectMake(bounds.x-50, bounds.y-50, 100, 100);
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        self.userInteractionEnabled = NO;
        
        self.loadingLabel = [[UILabel alloc] init];
        
        self.mAlertView = [[UIView alloc] init];
        self.mAlertViewSuperView = [[UIView alloc] init] ;
        //........................................................
        
        
        self.loadingLabel.backgroundColor = [UIColor clearColor];
        self.loadingLabel.textColor = [UIColor whiteColor];
        self.loadingLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
        
        self.mAlertViewSuperView.backgroundColor = [UIColor clearColor];
        self.mAlertView.backgroundColor = loadBackColor;
        self.mAlertView.layer.cornerRadius = 8;
        self.mAlertView.alpha = 0.8;
        self.mAlertView.layer.masksToBounds = YES;
        self.autoFlag = 1;
        
        //繁体转换
        traditionalStyle = [[NSUserDefaults standardUserDefaults] boolForKey:@"Language"];
        
        if (traditionalStyle) {
            
            //            _convertManager = [[convertGB_BIG alloc] init];
        }
    }
    return self;
}

-(void)setText:(NSString *)text{
    
    self.loadingLabel.text = text;
    
    if (traditionalStyle) {
        
        self.loadingLabel.text = self.loadingLabel.text;
    }
}
-(void)startLoading
{
    [self.superview bringSubviewToFront:self];
    
    self.loadingFlag = YES;
    if (self.autoFlag == 1)
    {
        NSString *str = loadingLabel.text;
        if ([str length] > 0) {
            self.loadingLabel.text = str;
        }else{
            self.loadingLabel.text = @"loading......";
        }
        self.loadingLabel.textAlignment = UITextAlignmentCenter;
        CGSize fSize = [self.loadingLabel.text sizeWithFont:self.loadingLabel.font];
        CGSize loadSize;
        if (fSize.width < 300) {
            loadSize = [self.loadingLabel.text sizeWithFont:self.loadingLabel.font constrainedToSize:CGSizeMake(140, 1000) lineBreakMode:self.loadingLabel.lineBreakMode];
            
        }else {
            loadSize = [self.loadingLabel.text sizeWithFont:self.loadingLabel.font constrainedToSize:CGSizeMake(190, 1000) lineBreakMode:self.loadingLabel.lineBreakMode];
        }
        CGSize oSize = loadSize;//[Loading getTheSize:loadSize];
        self.loadingLabel.frame = CGRectMake(20, 38, oSize.width, oSize.height);
        self.loadingLabel.numberOfLines = ceil(oSize.height/20);
        if (fSize.width < 150) {
            self.loadingLabel.textAlignment = UITextAlignmentCenter;
        }else{
            self.loadingLabel.textAlignment = UITextAlignmentLeft;
        }
        
        self.mAlertView.frame = CGRectMake(0, 0, oSize.width+40, oSize.height+45);
        self.mAlertViewSuperView.frame = CGRectMake(0, 0, oSize.width+40, oSize.height+45);
        
        self.frame = CGRectMake(boundses.x-mAlertViewSuperView.frame.size.width/2, boundses.y-mAlertViewSuperView.frame.size.height/2, mAlertViewSuperView.frame.size.width, mAlertViewSuperView.frame.size.height);
        self.loadingLabel.frame = CGRectMake(20, (self.mAlertView.frame.size.height-oSize.height)/2, oSize.width, oSize.height);
        
    }
    
    
    [self.mAlertView addSubview:self.loadingLabel];
    [self.mAlertViewSuperView addSubview:self.mAlertView];
    [self addSubview:self.mAlertViewSuperView];
    
    self.mAlertView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce1AnimationStopped)];
    self.mAlertView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    [self.mAlertViewSuperView setAlpha:1.0f];
    [UIView commitAnimations];
    
    if (self.missTime == 0.0) {
        
        self.missTime = 1.0;
        
    }
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:self.missTime];
}
- (void)bounce1AnimationStopped{
    
    
}
-(void)stopLoading
{
    self.loadingFlag = NO;
    [self dismissAlertView];
}

- (void)dismissAlertView{
    [UIView beginAnimations:nil context:nil];
    if (self.loadingOkDelayFlag)
    {
        [UIView setAnimationDelay:1.0];
    }
    else
    {
        [UIView setAnimationDelay:0.5];
    }
    
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(alertViewIsRemoved)];
    [mAlertViewSuperView setAlpha:0.0f];
    [UIView commitAnimations];
}
- (void)alertViewIsRemoved{
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
