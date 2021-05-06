//
//  PLCacheHelper.m
//  Frame
//
//  Created by DELI_PENGL on 2018/4/24.
//  Copyright © 2018年 PENGL. All rights reserved.
//

#import "PLCacheHelper.h"
#import <YYCache.h>
#import <YYDiskCache.h>
static NSString *const kNetworkResponseCache = @"kPPNetworkResponseCache";

@implementation PLCacheHelper

static YYCache *_dataCache;

+ (void)initialize {
    _dataCache = [YYCache cacheWithName:kNetworkResponseCache];
}
+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    static PLCacheHelper *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PLCacheHelper alloc] init];
    });
    return sharedInstance;
}

/**
 设置Cache
 
 @param responseData 响应数据
 @param url url
 @param parameters params
 */
+ (void)setHTTPCache:(id)responseData url:(NSString *)url params:(NSDictionary *)parameters {
 
    NSString *cacheKey = [self cacheKeyWithURL:url parameters:parameters];
    //异步缓存,不会阻塞主线程
    [_dataCache setObject:responseData forKey:cacheKey withBlock:nil];
}


/**
 返回Cache数据
 
 @param url url
 @param parameters 参数
 @return 返回缓存
 */
+ (id)httpCacheForURL:(NSString *)url params:(NSDictionary *)parameters {
    
    NSString *cacheKey = [self cacheKeyWithURL:url parameters:parameters];
    return [_dataCache objectForKey:cacheKey];
}


/**
 获取网络缓存的总大小 bytes(字节)
 
 @return return value description
 */
+ (NSInteger)getAllHTTPCacheSize {
   return  [_dataCache.diskCache totalCost];
}


/**
 删除所有缓存
 */
+ (void)removeAllHTTPCache {
    
    [_dataCache.diskCache removeAllObjects];
}

+ (NSString *)cacheKeyWithURL:(NSString *)url parameters:(NSDictionary *)parameters {
    
    if (!parameters || parameters.count == 0) {
        return url;
    }
    // 可以过滤像时间之类的字段
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    
    // 将URL与转换好的参数字符串拼接在一起,成为最终存储的KEY值
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@",url,paraString];
    // 可以处理包含token相关的信息
    
    return cacheKey;
}
@end
