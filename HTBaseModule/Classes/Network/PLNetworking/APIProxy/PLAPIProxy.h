//
//  PLAPIProxy.h
//  Frame
//
//  Created by DELI_PENGL on 2018/4/9.
//  Copyright © 2018年 PENGL. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PLURLResponse.h"

typedef void(^PLCallback)(PLURLResponse *response);

@interface PLAPIProxy : NSObject

+ (instancetype)sharedInstance;

- (NSInteger)callGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName timeoutInterval:(NSInteger )timeout success:(PLCallback)success fail:(PLCallback)fail;

- (NSInteger)callPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName timeoutInterval:(NSInteger)timeout success:(PLCallback)success fail:(PLCallback)fail;

- (NSInteger)callUPLOADWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName timeoutInterval:(NSInteger)timeout success:(PLCallback)success fail:(PLCallback)fail;

- (NSInteger)callDELETEWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName timeoutInterval:(NSInteger)timeout success:(PLCallback)success fail:(PLCallback)fail;

- (NSInteger)callPATCHWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName timeoutInterval:(NSInteger)timeout success:(PLCallback)success fail:(PLCallback)fail;

- (NSNumber *)callApiWithRequest:(NSURLRequest *)request success:(PLCallback)success fail:(PLCallback)fail;
- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;

@end
