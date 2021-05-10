//
//  NetworkModuleHeader.h
//  Frame
//

/*
 NetworkModule 文件树型结构
 
 .NetworkModule
 |____PLNetworking
 | |____APIManager
 | | |____PLAPIManager.h        API的请求部分，主要的调用部分
 | | |____PLAPIManager.m
 | |____APIProxy
 | | |____PLAPIProxy.h        请求的代理
 | | |____PLAPIProxy.m
 | |____Categories
 | | |____NSObject+PLNetworkingMethods.h
 | | |____NSObject+PLNetworkingMethods.m
 | | |____NSURLRequest+PLNetworkingMethods.h
 | | |____NSURLRequest+PLNetworkingMethods.m
 | |____Generators
 | | |____PLRequestGenerator.h    请求的表单内容方式
 | | |____PLRequestGenerator.m
 | |____Services
 | | |____HeaderFieldModel.h    请求头的特殊处理
 | | |____HeaderFieldModel.m
 | | |____PLService.h        服务端基类
 | | |____PLService.m
 | | |____PLServiceFactory.h    服务端工厂
 | | |____PLServiceFactory.m
 | |____URLResponse
 | | |____PLURLResponse.h    响应的数据结构
 | | |____PLURLResponse.m
 |____PLNetworkingConfig        用户服务端配置
 | |____CustomServices
 | | |____FirstService.h        服务端配置、包含URL、统一的校验
 | | |____FirstService.m
 
 
 
 Composer         APIManager        APIProxy
 |           |                          |
 |           |                          |
 |(设置API参数）-> |（loadData）           |
 |           |                          |
 |           |                          |
 |           |                          |
 |           |(POST/GET)->              |
 |           |                          |(响应)
 |           |                          |
 |           |(Service Check)       <-  |
 |           |                          |
 |           |                          |
 |           |                          |
 |(成功代理处理)  <-|(true)               |
 |           |            |
 |           |            |
 |           |            |
 |(失败代理)     <-|(false) |
 |           |            |
 
 */
//  Created by DELI_PENGL on 2018/4/17.
//  Copyright © 2018年 PENGL. All rights reserved.
//

#ifndef NetworkModuleHeader_h
#define NetworkModuleHeader_h

#import "PLAPIManager.h"
#import "PLServiceFactory.h"
#import "PLAPPCacheHelper.h"
#import "PLDeviceInfo.h"

#endif /* NetworkModuleHeader_h */
