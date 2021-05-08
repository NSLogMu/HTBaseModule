//
//  PLService.h
//  Frame
/**
 服务器基本配置
 服务端 URL，
 服务端URL配置
 
 **/
//  Created by DELI_PENGL on 2018/4/3.
//  Copyright © 2018年 PENGL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APPEnvironmentConfig.h"
#import "HeaderFieldModel.h"

typedef NS_ENUM (NSUInteger, PLHTTPBodySerializationType){
    SERIALIZATION_JSON,
    SERIALIZATION_DEFAULT
};

@interface PLService : NSObject

@property (nonatomic, strong, readonly) NSString *apiBaseUrl;
@property (nonatomic, strong, readonly) NSString *apiVersion;
@property (nonatomic, strong, readonly) NSString *publicKey;
@property (nonatomic, strong, readonly) NSString *privateKey;
@property (nonatomic, strong, readonly) NSArray *httpHeaderFieldArray;
@property (nonatomic, assign, readonly) Service_Environment serviceEnvironment;       // 服务端环境
@property (nonatomic, assign, readonly) PLHTTPBodySerializationType serializationType;       // HTTPBody 序列化方式


/**
 校验请求响应回来的数据信息,并返回是否校验成功，以及提醒信息

 @param data data description
 @param completeBlock 提醒信息
 @return 是否校验成功
 */
- (BOOL)verifyResponseDate:(NSDictionary *)data complete:(void(^)(NSString *messageStr))completeBlock;

/**
 请法庭的公共参数
 
 @return 返回的公共参数
 */
- (NSMutableDictionary *)commonParams;

// 加签（排序+签名）
- (NSString *)signStringWithDictionary:(NSDictionary *)dic;

// 设置私密
- (void)setPrivateKey:(NSString *)key;

- (NSString *)getRequestURLWithMethod:(NSString *)method;
@end
