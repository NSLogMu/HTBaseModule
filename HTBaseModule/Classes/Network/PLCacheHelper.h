//
//  PLCacheHelper.h
//  Frame
//
//  Created by DELI_PENGL on 2018/4/24.
//  Copyright © 2018年 PENGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLCacheHelper : NSObject

+ (instancetype)sharedInstance;


/**
 设置Cache

 @param responseData 响应数据
 @param url url
 @param parameters params
 */
+ (void)setHTTPCache:(id)responseData url:(NSString *)url params:(NSDictionary *)parameters;



/**
 返回Cache数据

 @param url url
 @param parameters 参数
 @return 返回缓存
 */
+ (id)httpCacheForURL:(NSString *)url params:(NSDictionary *)parameters;


/**
 获取网络缓存的总大小 bytes(字节)

 @return return value description
 */
+ (NSInteger)getAllHTTPCacheSize;


/**
 删除所有缓存
 */
+ (void)removeAllHTTPCache;

@end
