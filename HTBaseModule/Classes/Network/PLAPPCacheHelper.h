//
//  PLCacheHelper.h
//  Frame
//
//  Created by DELI_PENGL on 2018/4/28.
//  Copyright © 2018年 PENGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLAPPCacheHelper : NSObject

+ (instancetype)sharedInstance;

// 缓存KEY VALUE
- (void)setCacheWithKey:(NSString *)key value:(id)value;
// 按KEY 获取Value
- (id)cacheValueForKey:(NSString *)key;


@end
