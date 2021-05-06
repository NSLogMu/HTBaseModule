//
//  PLServiceFactory.m
//  Frame
//
//  Created by DELI_PENGL on 2018/4/4.
//  Copyright © 2018年 PENGL. All rights reserved.
//

#import "PLServiceFactory.h"
#import "FirstService.h"

NSString * const kFirstService = @"FirstService";

NSString * const kFirstService_Key = @"app_2017";
@interface PLServiceFactory ()

@property (nonatomic, strong) NSMutableDictionary *serviceStorage;

@end

@implementation PLServiceFactory

#pragma mark - life cycle

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    static PLServiceFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PLServiceFactory alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods

- (PLService *)serviceWithIdentifier:(NSString *)identifier {
    
    if (self.serviceStorage[identifier] == nil) {
        self.serviceStorage[identifier] = [self newServiceWithIdentifier:identifier];
    }
    return self.serviceStorage[identifier];
}

#pragma mark - private methods

- (PLService *)newServiceWithIdentifier:(NSString *)identifier {
    
    if ([identifier isEqualToString:kFirstService]) {
        return [[FirstService alloc] init];
    }
    return nil;
}

#pragma mark - Getters and Setters

- (NSMutableDictionary *)serviceStorage {
    
    if (_serviceStorage == nil) {
        _serviceStorage = [[NSMutableDictionary alloc] init];
    }
    return _serviceStorage;
}

#pragma mark - Callback Events


///**
// 创建第一个服务器APIManager工厂
//
// @param params params description
// @return return value description
// */
//+ (PLAPIManager *)createFirstServiceAPIManager:(NSDictionary *)params {
//
//    PLAPIManager *apiManager = [[PLAPIManager alloc] init];
////    PLService *service = [[PLServiceFactory sharedInstance] serviceWithIdentifier:kFirstService];
//    NSMutableDictionary *requstOriginalParams = [NSMutableDictionary dictionaryWithDictionary:params];
//    apiManager.paramSource = requstOriginalParams;
//    apiManager.originalParamSource = requstOriginalParams;
//
//    return apiManager;
//}

+ (PLAPIManager *)createFirstServiceAPIManager:(NSDictionary *)params {

    
    
    PLAPIManager *apiManager = [[PLAPIManager alloc] init];
    //    PLService *service = [[PLServiceFactory sharedInstance] serviceWithIdentifier:kFirstService];
    NSMutableDictionary *requstOriginalParams = [NSMutableDictionary dictionaryWithDictionary:params];
    apiManager.paramSource = requstOriginalParams;
    apiManager.originalParamSource = requstOriginalParams;
    
    return apiManager;
}

@end
