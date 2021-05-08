//
//  PLURLResponse.m
//  Frame
//
//  Created by DELI_PENGL on 2018/4/9.
//  Copyright © 2018年 PENGL. All rights reserved.
//

#import "PLURLResponse.h"
#import "NSURLRequest+PLNetworkingMethods.h"
#import "NSObject+PLNetworkingMethods.h"

@interface PLURLResponse ()

@property (nonatomic, assign, readwrite) PLURLResponseStatus status;
@property (nonatomic, copy, readwrite) NSString *contentString;
@property (nonatomic, copy, readwrite) id content;
@property (nonatomic, copy, readwrite) NSURLRequest *request;
@property (nonatomic, assign, readwrite) NSInteger requestId;
@property (nonatomic, copy, readwrite) NSData *responseData;
@property (nonatomic, assign, readwrite) BOOL isCache;

@end

@implementation PLURLResponse

#pragma mark - life cycle

- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData status:(PLURLResponseStatus)status {
    
    self = [super init];
    if (self) {
        //后台返回格式有问题自处理
//        responseString = [responseString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        self.contentString = responseString;
        NSError *err;
        self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&err];

        if(err) {
            NSLog(@"json解析失败：%@",err);
            responseString  = [responseString stringByReplacingOccurrencesOfString:@"null" withString:@"\"1207\""];
            NSData *strData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSError *nextErr;
            self.content = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableContainers error:&nextErr];
            if (nextErr) {
                NSLog(@"json解析再次失败：%@",nextErr);
            }

        }
        self.status = status;
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = [NSDictionary dictionaryWithDictionary:self.request.requestParams];
        self.isCache = NO;
    }
    return self;
}

- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData error:(NSError *)error {
    
    self = [super init];
    if (self) {
        self.contentString = [responseString PL_defaultValue:@""];
        self.status = [self responseStatusWithError:error];
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = [NSDictionary dictionaryWithDictionary:self.request.requestParams];
        self.isCache = NO;
        
        if (responseData) {
            self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        } else {
            self.content = nil;
        }
    }
    return self;
}

- (instancetype)initWithData:(NSData *)data {
    
    self = [super init];
    if (self) {
        self.contentString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.status = [self responseStatusWithError:nil];
        self.requestId = 0;
        self.request = nil;
        self.responseData = [data copy];
        self.content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        self.isCache = YES;
    }
    return self;
}

- (void)setStatus:(PLURLResponseStatus)status {
    _status = status;
}

#pragma mark - private methods
- (PLURLResponseStatus)responseStatusWithError:(NSError *)error {
    
    if (error) {
        PLURLResponseStatus result = PLURLResponseStatusErrorNoNetwork;
        // 除了超时以外，所有错误都当成是无网络
        if (error.code == NSURLErrorTimedOut) {
            result = PLURLResponseStatusErrorTimeout;
        }
        return result;
    } else {
        return PLURLResponseStatusSuccess;
    }
}


@end
