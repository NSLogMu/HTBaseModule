//
//  PLRequestGenerator.h
//  Frame
//
//  Created by DELI_PENGL on 2018/4/9.
//  Copyright © 2018年 PENGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLRequestGenerator : NSObject

+ (instancetype)sharedInstance;

- (NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName timeoutInterval:(NSInteger)timeout;



- (NSURLRequest *)generateUploadRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName timeoutInterval:(NSInteger)timeout;


- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName timeoutInterval:(NSInteger)timeout;

- (NSURLRequest *)generateDELETERequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName timeoutInterval:(NSInteger)timeout;

- (NSURLRequest *)generatePATCHRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName timeoutInterval:(NSInteger)timeout;
@end
