//
//  ShareInfo.h
//  Dome
//
//  Created by BTW on 14/12/19.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
/**
 *  储存用户信息
 */

@interface ShareInfo : NSObject

@property(nonatomic,strong,readonly)UserModel * userModel;

+(ShareInfo *)shareInstance;

@end
