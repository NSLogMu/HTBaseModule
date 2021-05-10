//
//  PLServiceFactory.h
//  Frame
//
//  Created by DELI_PENGL on 2018/4/4.
//  Copyright © 2018年 PENGL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLService.h"
#import "NetworkModuleHeader.h"
extern NSString * const kFirstService;
extern NSString * const kFOService;

extern NSString * const kH5Service;



extern NSString * const kFirstService_Key;

#define  kFirstService_Secret_Key   @"Exchange_User_Secret_Key"
#define  kFOService_Secret_Key   @"xxxx"

@interface PLServiceFactory : NSObject

+ (instancetype)sharedInstance;
- (PLService *)serviceWithIdentifier:(NSString *)identifier;

/**
 创建第一个服务器APIManager工厂
 
 @param params params description
 @return return value description
 */
+ (PLAPIManager *)createFirstServiceAPIManager:(NSDictionary *)params;
@end
