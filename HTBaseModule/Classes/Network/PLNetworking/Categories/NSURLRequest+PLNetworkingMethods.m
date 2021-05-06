//
//  NSURLRequest+CTNetworkingMethods.m
//  RTNetworking
//
//  Created by casa on 14-5-26.
//  Copyright (c) 2014年 casatwy. All rights reserved.
//

#import "NSURLRequest+PLNetworkingMethods.h"
#import <objc/runtime.h>

static void *PLNetworkingRequestParams;

@implementation NSURLRequest (PLNetworkingMethods)



- (void)setRequestParams:(NSDictionary *)requestParams {
    
    objc_setAssociatedObject(self, &PLNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams {
    
    return objc_getAssociatedObject(self, &PLNetworkingRequestParams);
}

@end
