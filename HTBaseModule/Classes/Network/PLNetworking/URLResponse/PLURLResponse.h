//
//  PLURLResponse.h
//  Frame
//
//  Created by DELI_PENGL on 2018/4/9.
//  Copyright © 2018年 PENGL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PLURLResponseStatus)
{
    PLURLResponseStatusSuccess, //作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于签名是否正确，返回的数据是否完整，由上层的Server对象来决定。
    PLURLResponseStatusErrorTimeout,
    PLURLResponseStatusErrorToken,      // Token异常
    PLURLResponseStatusError404,      // 404
    PLURLResponseStatusErrorNoNetwork // 默认除了超时以外的错误都是无网络错误。
};

@interface PLURLResponse : NSObject

@property (nonatomic, assign, readonly) PLURLResponseStatus status;
@property (nonatomic, copy, readonly) NSString *contentString;
@property (nonatomic, copy, readonly) id content;
@property (nonatomic, assign, readonly) NSInteger requestId;
@property (nonatomic, copy, readonly) NSURLRequest *request;
@property (nonatomic, copy, readonly) NSData *responseData;
@property (nonatomic, copy) NSDictionary *requestParams;
@property (nonatomic, copy) NSDictionary *responseHeader;
@property (nonatomic, assign, readonly) BOOL isCache;

- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData status:(PLURLResponseStatus)status;
- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData error:(NSError *)error;

// 使用initWithData的response，它的isCache是YES，上面两个函数生成的response的isCache是NO
- (instancetype)initWithData:(NSData *)data;
- (void)setStatus:(PLURLResponseStatus)status;
@end
