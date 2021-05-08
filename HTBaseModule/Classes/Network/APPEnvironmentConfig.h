//
//  APPEnvironmentConfig.h
//  AFNetworking
//
//  Created by mc on 2021/5/6.
//

#import <Foundation/Foundation.h>

// 服务端环境定义
typedef enum : NSUInteger {
    
    ENVIRONMENT_DEVELOP = 0,    // 必须以0开头, 开发环境
    ENVIRONMENT_TEST,           // 测试环境
    ENVIRONMENT_PRODUCT,        // 生产环境
    ENVIRONMENT_PRETEST,        // 预备生产环境
    ENVIRONMENT_SANDBOX,        // 沙盒环境
    ENVIRONMENT_DEVELOPER1,        // 开发人员1 环境
} Service_Environment;


typedef enum : NSUInteger {
    // 网络状态
    NETWORK_STATUS_NOT_REACHABLE,   // 无网络
    NETWORK_STATUS_WLAN,
    NETWORK_STATUS_WIFI,
} Network_Environment;

// 服务端版本
#define kServierVersion             @"1.1"

@interface APPEnvironmentConfig : NSObject
+ (Service_Environment)appEnvironment;
@end
