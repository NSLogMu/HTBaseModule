//
//  NSObject+PLNetworkingMethods.m
//  ElinePrintSDK
//
//  Created by PENGL on 19/10/16.
//  Copyright © 2016年 Eline. All rights reserved.
//

#import "NSObject+PLNetworkingMethods.h"

@implementation NSObject (PLNetworkingMethods)


- (id)PL_defaultValue:(id)defaultData {
    
    if (![defaultData isKindOfClass:[self class]]) {
        return defaultData;
    }
    
    if ([self PL_isEmptyObject]) {
        return defaultData;
    }
    
    return self;
}

- (BOOL)PL_isEmptyObject {
    
    if ([self isEqual:[NSNull null]]) {
        return YES;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        if ([(NSString *)self length] == 0) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSArray class]]) {
        if ([(NSArray *)self count] == 0) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSDictionary class]]) {
        if ([(NSDictionary *)self count] == 0) {
            return YES;
        }
    }
    
    return NO;
}


@end
