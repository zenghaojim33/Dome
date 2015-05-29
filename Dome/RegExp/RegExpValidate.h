//
//  RegExp.h
//  SeafoodHome
//
//  Created by btw on 15/1/4.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  正则表达式验证类
 */
@interface RegExpValidate : NSObject

/** 验证电子邮箱 */
+ (BOOL)validateEmail:(NSString *)email;

/** 验证手机号码 */
+ (BOOL)validateMobile:(NSString *)mobile;

/** 验证车牌号 */
+ (BOOL)validateCarNo:(NSString *)carNo;

/** 验证车型 */
+ (BOOL)validateCarType:(NSString *)CarType;

/** 验证用户名 */
+ (BOOL)validateUserName:(NSString *)name;

/** 验证密码 */
+ (BOOL)validatePassword:(NSString *)passWord;

/** 验证昵称 */
+ (BOOL)validateNickname:(NSString *)nickname;

/** 验证身份证号 */
+ (BOOL)validateIdentityCard: (NSString *)identityCard;

/** 判断金钱
 1.只能输入数字和小数点
 2.只能输入一个小数点
 3.只能以一个0开头
 4.小数点后后面只能输入两位数字 */
+ (BOOL)validateMoney: (NSString *)money;

/** 验证腾讯QQ号 (腾讯QQ号从10000开始) */
+ (BOOL)validateQQNumber:(NSString *)QQNumber;

/** 验证中国邮政编码 (中国邮政编码为6位数字) */
+ (BOOL)validateZipCode:(NSString *)zipCode;

/** IP地址 (提取IP地址时有用)  */
+ (BOOL)validateIPAddress:(NSString *)IPAddress;

/** 电话号码("XXX-XXXXXXX"、"XXXX-XXXXXXXX"、"XXX-XXXXXXX"、"XXX-XXXXXXXX"、"XXXXXXX"和"XXXXXXXX)  */
+ (BOOL)validatePhoneNumber:(NSString *)phoneNumber;

/** InternetURL  */
+ (BOOL)validateInternetURL:(NSString *)internetURL;

/** 验证银行卡号 */
+ (BOOL)validateBankAccountNumber:(NSString *)bankAccountNumber;

@end
