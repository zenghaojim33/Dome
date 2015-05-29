//
//  BWMBankCoder.h
//  BeautifulShop
//
//  Created by Bi Weiming on 15/4/21.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWMBankCoder : NSObject

/** 银行编号 */
@property (strong, nonatomic, readonly) NSString *bankCode;

/** 银行名称 */
@property (strong, nonatomic, readonly) NSString *bankName;

/** Array Of BWMBankCoder */
+ (NSArray *)banksArray;

/** Array Of Bank Name */
+ (NSArray *)banksNameArray;

/** 根据银行名称查询得到银行编号 */
+ (NSString *)bankCodeWithName:(NSString *)bankName;

/** 检查是否存在此银行名称 */
+ (BOOL)hasBankName:(NSString *)bankName;

@end
