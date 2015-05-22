//
//  JSONData.m
//  BeautifulShop
//
//  Created by BeautyWay on 14-10-10.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import "JSONData.h"

@implementation JSONData

+(id)JSONDataValue:(NSString *)urlString
{
    NSString *link = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   
    NSLog(@"link:%@",link);
    
    NSURL *url = [NSURL URLWithString:link];
    
    NSMutableURLRequest  *request=[[NSMutableURLRequest alloc]initWithURL:url];
    request.timeoutInterval = 30.0;
    NSError *err=nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil
                                                     error:&err];
    
    
    if (data) {
        
        NSError *error=nil;
        id JsonObject=[NSJSONSerialization JSONObjectWithData:data
                                                      options:NSJSONReadingAllowFragments
                                                        error:&error];
        
        if (JsonObject!=nil&&error==nil) {
            if ([JsonObject isKindOfClass:[NSDictionary class]]) {
                
                NSMutableDictionary *dict = (NSMutableDictionary *)JsonObject;
                return dict;
            }
            else if ([JsonObject isKindOfClass:[NSArray class]]) {
                
                NSMutableArray *array = (NSMutableArray *)JsonObject;
                return array;
                
            }else if([JsonObject isKindOfClass:[NSString class]]){
                
                NSString *jsonValue = (NSString *)JsonObject;
                return jsonValue;
            }
        }
        
        return JsonObject;
    }
    
    return nil;

}

@end
