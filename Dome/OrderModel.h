//
//  OrderModel.h
//  Dome
//
//  Created by BTW on 15/3/3.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property(nonatomic,strong)NSString *suborderid;
@property(nonatomic,strong)NSString *productid;
@property(nonatomic,strong)NSString *count;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *createtime;

@property(nonatomic)int labelHeight;
@end
