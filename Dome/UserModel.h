//
//  UserModel.h
//  Dome
//
//  Created by BTW on 14/12/19.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property(nonatomic,strong)NSString * userID;//用户id
@property(nonatomic,strong)NSString * phone;//手机号码
@property(nonatomic,strong)NSString * shopid;//店铺id
@property(nonatomic,strong)NSString * shopname;//店铺名
@property(nonatomic,strong)NSString * shopinfo;
@end
