//
//  ShareInfo.m
//  Dome
//
//  Created by BTW on 14/12/19.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import "ShareInfo.h"

static ShareInfo *shareInfo = nil;

@interface ShareInfo ()

@property (nonatomic, strong, readwrite) UserModel * userModel;

@end

@implementation ShareInfo

+ (ShareInfo *) shareInstance
{
    if (!shareInfo) {
        shareInfo = [[self alloc] init];
    }  
    
    return shareInfo;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(UserModel *)userModel
{
    if (!_userModel) {
        _userModel = [UserModel new];
    }
    return _userModel;
}

@end
