//
//  ProductModel.h
//  Dome
//
//  Created by BTW on 15/2/6.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject
@property (nonatomic,strong) NSString * productId;
@property (nonatomic,strong) NSString * categoryId;
@property (nonatomic,strong) NSString * categoryName;
@property (nonatomic,strong) NSString * productName;
@property (nonatomic,strong) NSString * price;
@property(nonatomic,strong)NSString * inPrice;
@property (nonatomic,strong) NSString * brandid;
@property (nonatomic,strong) NSString * brandname;
@property(nonatomic,strong) NSString * shopPrice;
@property(nonatomic,strong)NSMutableArray * TitleImages;//字典 key == path;
@property (nonatomic) BOOL isSelect;

@end
