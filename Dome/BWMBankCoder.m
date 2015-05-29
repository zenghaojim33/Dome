//
//  BWMBankCoder.m
//  BeautifulShop
//
//  Created by Bi Weiming on 15/4/21.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import "BWMBankCoder.h"

@interface BWMBankCoder()

@property (strong, nonatomic, readwrite) NSString *bankCode;
@property (strong, nonatomic, readwrite) NSString *bankName;

@end

@implementation BWMBankCoder

+ (NSArray *)p_bankListArray {
    static NSArray *bankListArray = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"BankCode" ofType:@"json"];
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        bankListArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    });
    return bankListArray;
}

+ (NSArray *)banksArray {
    NSArray *theArray = [self p_bankListArray];
    NSMutableArray *banksArray = [NSMutableArray new];
    [theArray enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
        BWMBankCoder *coder = [[BWMBankCoder alloc] init];
        coder.bankCode = obj[@"bankCode"];
        coder.bankName = obj[@"bankName"];
        [banksArray addObject:coder];
    }];
    
    return banksArray;
}

+ (NSArray *)banksNameArray {
    // 读取银行列表
    NSArray *banksArray = [self banksArray];
    NSMutableArray *banksNameArray = [NSMutableArray new];
    [banksArray enumerateObjectsUsingBlock:^(BWMBankCoder *bankObj, NSUInteger idx, BOOL *stop) {
        [banksNameArray addObject:bankObj.bankName];
    }];
    
    return banksNameArray;
}

+ (NSString *)bankCodeWithName:(NSString *)bankName {
    NSArray *theArray = [self p_bankListArray];
    __block NSString *resultBankCode = nil;
    [theArray enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
        if ([obj[@"bankName"] isEqualToString:bankName]) {
            resultBankCode = obj[@"bankCode"];
            *stop = YES;
        }
    }];
    return resultBankCode;
}

+ (BOOL)hasBankName:(NSString *)bankName {
    if([bankName isEqualToString:@""]) {
        return NO;
    }
    
    __block BOOL hasBankName = NO;
    NSArray *theArray = [self p_bankListArray];
    [theArray enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
        if ([obj[@"bankName"] isEqualToString:bankName]) {
            hasBankName = YES;
            *stop = YES;
        }
    }];
    return hasBankName;
}

@end
