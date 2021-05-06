//
//  PLCacheHelper.m
//  Frame
//
//  Created by DELI_PENGL on 2018/4/28.
//  Copyright © 2018年 PENGL. All rights reserved.
//

#import "PLAPPCacheHelper.h"
#import <YYCache.h>
static NSString *const kUserCache = @"INFO_Cache";
@implementation PLAPPCacheHelper

static YYCache *_dataCache;

//+ (void)initialize {
//    _dataCache = [YYCache cacheWithName:kUserCache];
//}

#pragma mark -- Life cycle

+ (instancetype)sharedInstance {
    
    static PLAPPCacheHelper *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PLAPPCacheHelper alloc] init];
        _dataCache = [YYCache cacheWithName:@"INFO_Cache"];
    });
    return sharedInstance;
}


#pragma mark -- Getters and setters

// 缓存KEY VALUE
- (void)setCacheWithKey:(NSString *)key value:(id)value {
    
    //异步缓存,不会阻塞主线程
    [_dataCache setObject:value forKey:key withBlock:nil];
}

// 按KEY 获取Value
- (id)cacheValueForKey:(NSString *)key {
    
    return [_dataCache objectForKey:key];
}

@end
