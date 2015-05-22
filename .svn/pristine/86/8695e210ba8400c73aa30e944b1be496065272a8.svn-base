//
//  DSUserInfoModel.m
//  DoShop
//
//  Created by Anson on 15/2/4.
//  Copyright (c) 2015年 Anson Tsang. All rights reserved.
//

#import "DSBaseModel.h"
@implementation DSBaseModel

#define DSModelDidUpdateNotification @"DSModelDidUpdate"

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return nil;
}

/**
 *  用字典初始化Model
 *
 *  @param dict JSON返回的字典
 *
 *  @return ModelObject
 */
+(id)init:(NSDictionary *)dict
{
    
    id object = [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:dict error:nil];
    return object;
    
}

/**
 *  反转化成字典
 *
 *  @return JSON字典
 */
- (NSDictionary*) JSONDictionary {
    return [MTLJSONAdapter JSONDictionaryFromModel:self];
}

/**
 *  将对象数组存进缓存
 *
 *  @param cacheList 缓存对象
 *  @param key       对应的键值
 */
+(void)saveObjectListToCache:(NSArray *)cacheList andKey:(NSString *)key
{
    
    if (key && cacheList)
    {
        TMCache * cache = [self getCache];
        [cache setObject:cacheList forKey:key];
    }
    
}

/**
 *  储存单一对象
 *
 *  @param model 对象
 *  @param key   键值
 */
+(void)saveObjectToCache:(DSBaseModel *)model andKey:(NSString *)key
{
    
    if (model && key)
    {
        TMCache * cache = [self getCache];
        [cache setObject:model forKey:key];
    }
    
    
}

/**
 *  从键值中取出对象数组
 *
 *  @param key 键值
 *
 *  @return 数组
 */
+(NSArray *)cacheListBykey:(NSString *)key
{
    if (key)
    {
        TMCache * cache  = [self getCache];
        NSArray * arr = [cache objectForKey:key];
        return arr;
    }
    return nil;
}
/**
 *  从键值中取出单一对象
 *
 *  @param key 键值
 *
 *  @return 对象
 */
+(id)cacheObjectByKey:(NSString *)key
{
    if (key)
    {
        TMCache * cache = [self getCache];
        DSBaseModel * model = [cache objectForKey:key];
        return model;
    }
    return nil;
}
/**
 *  获得TMCache
 *
 *  
 */
+ (TMCache*) getCache {
    return [TMCache sharedCache];
}



- (void)updateFrom:(NSDictionary *)parameters {
    MTLModel *newObject = [self.class init:parameters];
    [self mergeValuesForKeysFromModel:newObject];
    [[NSNotificationCenter defaultCenter] postNotificationName:DSModelDidUpdateNotification object:self];
}


@end
