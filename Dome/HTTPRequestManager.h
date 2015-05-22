//
//  HTTPRequestManager.h
//  DoShop
//
//  Created by Anson on 15/2/4.
//  Copyright (c) 2015年 Anson Tsang. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "DSBaseModel.h"

@interface HTTPRequestManager : AFHTTPRequestOperationManager
typedef void(^responseBlock)(id responseObject, NSError *error);
typedef void(^responseBlockWithStatusCode)(NSInteger statusCode, NSError *error);

+(instancetype)sharedManager;

+(AFHTTPRequestOperation*)postURL:(NSString*)url andParameter:(NSDictionary*)param onCompletion:(responseBlock)completionBlock;
+(AFHTTPRequestOperation*)getURL:(NSString*)url andParameter:(NSDictionary*)param onCompletion:(responseBlock)completionBlock;
+(AFHTTPRequestOperation *)postURLWithData:(NSData *)data andURL:(NSString *)url andParameter:(NSDictionary *)param onCompletion:(responseBlockWithStatusCode)completionBlock;

/**
 *  保存单个对象
 *
 *  @param model 单个对象
 *  @param key   对应的Key
 */

+(void)saveObjectToCache:(DSBaseModel*)model andKey:(NSString*)key;



/**
 *  保存对象数组
 *
 *  @param cacheList 对象数组
 *  @param key       对应的key
 */

+(void)saveObjectListToCache:(NSArray*)cacheList andKey:(NSString*)key;


/**
 *  获取已缓存的对象数组
 *
 *  @param key 对应的key
 *
 *  @return 对象数组
 */
+(NSArray*)cacheListBykey:(NSString*)key;



/**
 *  获取已缓存的单个对象
 *
 *  @param key 对应的key
 *
 *  @return 对象
 */
+(id)cacheObjectByKey:(NSString*)key;




/**
 *  生成缓存对象
 *
 *  @return Tmcache
 */
+ (TMCache*) getCache;

@end
