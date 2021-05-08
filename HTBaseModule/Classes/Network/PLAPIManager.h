//
//  PLAPIManager.h
//  Frame

/**
    以网络请求为一个对象来管理，更灵活方便
    需要实现以下功能：
    1). 使用前，需要初始化参数包括: URL、请求类型（POST,GET）、请求的服务名称、当前API操作时时间、是否使用缓存
    2). 通过loadData来启动
    2). 成功后的代理事件处理
    3). 失败后的代理事件处理
 **/

//  Created by DELI_PENGL on 2018/4/9.
//  Copyright © 2018年 PENGL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLURLResponse.h"

typedef NS_ENUM (NSUInteger, PLAPIManagerErrorType){
    PLAPIManagerErrorTypeDefault,       //没有产生过API请求，这个是manager的默认状态。
    PLAPIManagerErrorTypeSuccess,       //API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。
    PLAPIManagerErrorTypeNoContent,     //API请求成功但返回数据不正确。如果回调数据验证函数返回值为NO，manager的状态就会是这个。
    PLAPIManagerErrorTypeToken,     // Token异常
    PLAPIManagerErrorTypeParamsError,   //参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的。
    PLAPIManagerErrorTypeTimeout,       //请求超时。APIProxy设置的是120秒超时，具体超时时间的设置请在APIManager中设置。
    PLAPIManagerErrorTypeNoNetWork      //网络不通。在调用API之前会判断一下当前网络是否通畅，这个也是在调用API之前验证的，和上面超时的状态是有区别的。
};

typedef NS_ENUM (NSUInteger, PLAPIManagerRequestType){
    PLAPIManagerRequestTypeGet,
    PLAPIManagerRequestTypePost,
    PLAPIManagerRequestTypeUpload,
    PLAPIManagerRequestTypeDELETE,
    PLAPIManagerRequestTypePatch
};

@class PLAPIManager;

@protocol PLAPIManagerCallBackDelegate <NSObject>
@required
// 回调  成功/失败
- (void)managerCallAPIDidSuccess:(PLAPIManager *)manager;
- (void)managerCallAPIDidFailed:(PLAPIManager *)manager;
@end


@interface PLAPIManager : NSObject
@property (nonatomic, weak) id<PLAPIManagerCallBackDelegate> delegate;
@property (nonatomic, copy, readonly) NSString *errorMessage;

/**
 服务端类型，
 */
@property (nonatomic, copy) NSString *serviceType;

/**
 URL的方法
 */
@property (nonatomic, copy) NSString *methodName;


/**
 请求的参数
 */
@property (nonatomic, copy) NSDictionary *paramSource;

@property (nonatomic, copy) NSDictionary *originalParamSource;

/**
 是否需要缓存
 */
@property (nonatomic, assign) BOOL hasCache;


/**
 请求类型
 */
@property (nonatomic, assign) PLAPIManagerRequestType requestType;


/**
 超时时间
 */
@property (nonatomic, assign) NSInteger timeOut;


/**
 响应的数据
 */
@property (nonatomic, strong, readonly) PLURLResponse *response;


/**
 加载请求

 @return 返回是否
 */
- (NSInteger)loadData;

@end
