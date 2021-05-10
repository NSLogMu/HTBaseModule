//
//  PLAPIManager.m
//  Frame
//
//  Created by DELI_PENGL on 2018/4/9.
//  Copyright © 2018年 PENGL. All rights reserved.
//

#import "PLAPIManager.h"
#import "PLAPIProxy.h"
#import "NetworkModuleHeader.h"
#import "PLCacheHelper.h"
#import "HTRegexTool.h"
#define PLCallAPI(REQUEST_METHOD, REQUEST_ID)                                                   \
{                                                                                               \
__weak typeof(self) weakSelf = self;                                                        \
REQUEST_ID = [[PLAPIProxy sharedInstance] call##REQUEST_METHOD##WithParams:self.paramSource serviceIdentifier:self.serviceType methodName:self.methodName timeoutInterval:self.timeOut success:^(PLURLResponse *response) { \
__strong typeof(weakSelf) strongSelf = weakSelf;                                        \
[strongSelf successedOnCallingAPI:response];                                            \
} fail:^(PLURLResponse *response) {                                                        \
__strong typeof(weakSelf) strongSelf = weakSelf;    \
PLAPIManagerErrorType type = PLAPIManagerErrorTypeNoNetWork; \
if (response.status == PLURLResponseStatusErrorTimeout) \
type = PLAPIManagerErrorTypeTimeout; \
else if (response.status == PLURLResponseStatusErrorNoNetwork) \
type = PLAPIManagerErrorTypeNoNetWork; \
else if (response.status == PLURLResponseStatusErrorToken) \
type = PLAPIManagerErrorTypeToken; \
else  \
type = PLAPIManagerErrorTypeNoNetWork; \
[strongSelf failedOnCallingAPI:response withErrorType:type];    \
}];                                                                                         \
[self.requestIdList addObject:@(REQUEST_ID)];                                               \
}

@interface PLAPIManager ()

@property (nonatomic, assign) PLAPIManagerErrorType errorType;
@property (nonatomic, strong) NSMutableArray *requestIdList;

@end


@implementation PLAPIManager


#pragma mark -- 加载

/**
 加载请求
 
 @return 返回是否
 */
- (NSInteger)loadData {
    
    NSInteger requestId = 0;
    // 1.检查是否有缓存，如果有，则先加载缓存， 进行网络请求
    if (self.hasCache) {
        PLURLResponse *response = (PLURLResponse *)[PLCacheHelper httpCacheForURL:[self apiUrl] params:self.paramSource];
        [self successedOnCallingAPI:response];
    }
    // 2.实际的网络请求
    if ([self isReachable]) {
        switch (self.requestType)
        {
            case PLAPIManagerRequestTypeGet:
                PLCallAPI(GET, requestId);
                break;
            case PLAPIManagerRequestTypePost:
                PLCallAPI(POST, requestId);
                break;
            case PLAPIManagerRequestTypeUpload:
                PLCallAPI(UPLOAD, requestId);
                break;
            case PLAPIManagerRequestTypeDELETE:
                PLCallAPI(DELETE, requestId);
                break;
            case PLAPIManagerRequestTypePatch:
                PLCallAPI(PATCH, requestId);
                break;
            default:
                break;
        }
        return requestId;
    }
    else {
        [self failedOnCallingAPI:nil withErrorType:PLAPIManagerErrorTypeNoNetWork];
        return requestId;
    }
    return requestId;
}

#pragma mark - api callbacks
// 数据请求成功
- (void)successedOnCallingAPI:(PLURLResponse *)response {
    
    _response = response;
    [self removeRequestIdWithRequestID:response.requestId];
    // 参数校验
    PLService *service = [[PLServiceFactory sharedInstance] serviceWithIdentifier:self.serviceType];
    if ([service verifyResponseDate:response.content complete:^(NSString *messageStr) {
        self->_errorMessage = messageStr;
    }]) {
        if (self.hasCache && !response.isCache) {
            // 缓存数据
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [PLCacheHelper setHTTPCache:self->_response url:[self apiUrl] params:self.paramSource];
            });
        }
        __weak typeof(*&self) wSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([wSelf.delegate respondsToSelector:@selector(managerCallAPIDidSuccess:)]) {
                [wSelf.delegate managerCallAPIDidSuccess:wSelf];
            }
        });
    }
    else {
        [self failedOnCallingAPI:response withErrorType:PLAPIManagerErrorTypeNoContent];
    }
}

- (void)failedOnCallingAPI:(PLURLResponse *)response withErrorType:(PLAPIManagerErrorType)errorType {
    
//    self.isLoading = NO;
    _response = response;
//    if ([response.content[@"id"] isEqualToString:@"expired_access_token"]) {
//    // 处理token 失效等操作
//    }
//    else
    {
        // 其他错误
        self.errorType = errorType;
        
        [self removeRequestIdWithRequestID:response.requestId];
        if (errorType == PLAPIManagerErrorTypeNoNetWork) {
            _errorMessage = @"请求失败，请稍后再试！";
            if (response.content) {
                if (response.content[@"message"]) {
                    _errorMessage = response.content[@"message"];
                }
            }
        }
        else if (errorType == PLAPIManagerErrorTypeTimeout) {
            _errorMessage = @"请求超时,请稍后再试！";
        }
        else if (errorType == PLAPIManagerErrorTypeDefault) {
            _errorMessage = @"网络异常,请稍后再试";
            if (response.content) {
                if (response.content[@"message"]) {
                    _errorMessage = response.content[@"message"];
                }
            }
        }
        else if (errorType == PLAPIManagerErrorTypeParamsError) {
            _errorMessage = @"数据异常,请稍候再试";
            if (response.content) {
                if (response.content[@"message"]) {
                    _errorMessage = response.content[@"message"];
                }
            }
        }
        else if (errorType == PLAPIManagerErrorTypeToken) {
            // Token错误, 广播
//            [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFICATION_TOKEN_ERROR object:nil];
//            [AccountTool logoutQSCAccount];
            
            NSLog(@"NO Token");
            return;
        }
        __weak typeof(*&self) wSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新主线程处理（如UI更新）
            if ([wSelf.delegate respondsToSelector:@selector(managerCallAPIDidFailed:)]) {
                [wSelf.delegate managerCallAPIDidFailed:wSelf];
            }
        });
    }
}

- (void)removeRequestIdWithRequestID:(NSInteger)requestId {
    
    NSNumber *requestIDToRemove = nil;
    for (NSNumber *storedRequestId in self.requestIdList) {
        if ([storedRequestId integerValue] == requestId) {
            requestIDToRemove = storedRequestId;
        }
    }
    if (requestIDToRemove) {
        [self.requestIdList removeObject:requestIDToRemove];
    }
}

#pragma mark - getters and setters

- (BOOL)isReachable {
    
    BOOL isReachability = [HTRegexTool isNetReachable];
    if (!isReachability) {
        self.errorType = PLAPIManagerErrorTypeNoNetWork;
    }
    return isReachability;
}

- (NSString *)apiUrl {
    
    PLService *service = [[PLServiceFactory sharedInstance] serviceWithIdentifier:self.serviceType];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", service.apiBaseUrl, self.methodName];
    if (![service.apiVersion isEqualToString:@""]) {
        urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, service.apiVersion, self.methodName];
    }
    return urlString;
}

@end
