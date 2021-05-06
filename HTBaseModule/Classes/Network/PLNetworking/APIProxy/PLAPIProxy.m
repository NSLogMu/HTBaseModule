//
//  PLAPIProxy.m
//  Frame
//
//  Created by DELI_PENGL on 2018/4/9.
//  Copyright © 2018年 PENGL. All rights reserved.
//

#import "PLAPIProxy.h"
#import <AFNetworking.h>
#import "PLRequestGenerator.h"

#define kFirstServiceKey    @"app_2017"

@interface PLAPIProxy ()

@property (nonatomic, strong) NSMutableDictionary *dispatchTable;
@property (nonatomic, strong) NSNumber *recordedRequestId;


@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation PLAPIProxy

#pragma mark - life cycle
+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    static PLAPIProxy *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PLAPIProxy alloc] init];
    });
    return sharedInstance;
}
- (void)dealloc {
    
    NSLog(@">>>PLAPIProxy-> dealloc");
}

#pragma mark - public methods

- (NSInteger)callPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName timeoutInterval:(NSInteger)timeout success:(PLCallback)success fail:(PLCallback)fail {
    
    NSURLRequest *request = [[PLRequestGenerator sharedInstance] generatePOSTRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName timeoutInterval:timeout];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

- (NSInteger)callGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName timeoutInterval:(NSInteger)timeout success:(PLCallback)success fail:(PLCallback)fail {
    
    NSURLRequest *request = [[PLRequestGenerator sharedInstance] generateGETRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName timeoutInterval:timeout];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}


- (NSInteger)callDELETEWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName timeoutInterval:(NSInteger)timeout success:(PLCallback)success fail:(PLCallback)fail {
    
    NSURLRequest *request = [[PLRequestGenerator sharedInstance] generateDELETERequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName timeoutInterval:timeout];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

- (NSInteger)callUPLOADWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName timeoutInterval:(NSInteger)timeout success:(PLCallback)success fail:(PLCallback)fail {
    
    //    NSURLRequest *request = [[PLRequestGenerator sharedInstance] generatePOSTRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName];
    NSURLRequest *request = [[PLRequestGenerator sharedInstance] generateUploadRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName timeoutInterval:timeout];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

- (NSInteger)callPATCHWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName timeoutInterval:(NSInteger)timeout success:(PLCallback)success fail:(PLCallback)fail {
    
    NSURLRequest *request = [[PLRequestGenerator sharedInstance] generatePATCHRequestWithServiceIdentifier:servieIdentifier requestParams:params methodName:methodName timeoutInterval:timeout];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

- (void)cancelRequestWithRequestID:(NSNumber *)requestID {
    
    NSURLSessionDataTask *requestOperation = self.dispatchTable[requestID];
    [requestOperation cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList
{
    for (NSNumber *requestId in requestIDList) {
        [self cancelRequestWithRequestID:requestId];
    }
}

/**
 *  主要用于切换网络请求的形式，如果加入第三方网络请求
 *
 *  @param request <#request description#>
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 *
 *  @return <#return value description#>
 */
- (NSNumber *)callApiWithRequest:(NSURLRequest *)request success:(PLCallback)success fail:(PLCallback)fail {
    
#ifdef DEBUG
    NSLog(@"\n-------Request Start---------\nURL:%@\n", request.URL);
#else
    
#endif
    
    // 跑到这里的block的时候，就已经是主线程了。
    __block NSURLSessionDataTask *dataTask = nil;
    __weak __typeof(self) wSelf = self;
    dataTask = [self.sessionManager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
           
       } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
           
       }completionHandler:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
        NSNumber *requestID = @([dataTask taskIdentifier]);
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSData *responseData = responseObject;
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];

#ifdef DEBUG
        BOOL shouldLogError = error ? YES : NO;
        NSMutableString *logString = [NSMutableString stringWithString:@"\n-----------API Response-------------\n"];
        [logString appendFormat:@"Status:\t%ld\t(%@)\n\n", (long)httpResponse.statusCode, [NSHTTPURLResponse localizedStringForStatusCode:httpResponse.statusCode]];
        [logString appendFormat:@"Content:\n\t%@\n\n", responseString];
        if (shouldLogError) {
            [logString appendFormat:@"Error Domain:\t\t\t\t\t\t\t%@\n", error.domain];
            [logString appendFormat:@"Error Domain Code:\t\t\t\t\t\t%ld\n", (long)error.code];
            [logString appendFormat:@"Error Localized Description:\t\t\t%@\n", error.localizedDescription];
            [logString appendFormat:@"Error Localized Failure Reason:\t\t\t%@\n", error.localizedFailureReason];
            [logString appendFormat:@"Error Localized Recovery Suggestion:\t%@\n\n", error.localizedRecoverySuggestion];
        }
        [logString appendString:@"\n---------------  Related Request Content  --------------\n"];
        [logString appendFormat:@"HTTP URL:\n%@\n",request.URL];
        [logString appendFormat:@"HTTP Header:\n%@\n",request.allHTTPHeaderFields ? request.allHTTPHeaderFields :@"N/A"];
        NSString *bodyStr = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]?[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]:@"N/A";
        [logString appendFormat:@"HTTP Body:\n"];
        [logString appendFormat:@"OLD:\n%@\n",bodyStr];
        if ([bodyStr hasPrefix:@"body="]) {
            bodyStr = [NSString decryptUseDESBase64:[[bodyStr substringFromIndex:5] stringByRemovingPercentEncoding] key:kFirstServiceKey];
        }
        [logString appendFormat:@"body=\n%@\n",bodyStr];
        [logString appendFormat:@"\n-------------Response End-------------\n"];
        NSLog(@"%@", logString);
#endif
        if (error) {
                
                PLURLResponse *response = [[PLURLResponse alloc] initWithResponseString:responseString requestId:requestID request:request responseData:responseData error:error];
             response.responseHeader = httpResponse.allHeaderFields;
            if (httpResponse.statusCode == 401) {
                [response setStatus:PLURLResponseStatusErrorToken];
            }
            else if (httpResponse.statusCode == 404)
            {
                [response setStatus:PLURLResponseStatusError404];
            }
                fail?fail(response):nil;
        }
        else {
            PLURLResponse *response = [[PLURLResponse alloc] initWithResponseString:responseString requestId:requestID request:request responseData:responseData status:PLURLResponseStatusSuccess];
            response.responseHeader = httpResponse.allHeaderFields;
            success?success(response):nil;
        }
        [wSelf.dispatchTable removeObjectForKey:requestID];
    }];
    NSNumber *requestId = @([dataTask taskIdentifier]);
    
    self.dispatchTable[requestId] = dataTask;
    [dataTask resume];
    return requestId;
}

//
//- (NSNumber *)uploadApiWithRequest:(NSURLRequest *)request withFormData:(NSData *)formData success:(PLCallback)success fail:(PLCallback)fail
//{
//
//    NSLog(@"\n-------Request Start---------\nURL>>%@\n", request.URL);
//
//    // 跑到这里的block的时候，就已经是主线程了。
//    __block NSURLSessionDataTask *dataTask = nil;
//    dataTask = [self.sessionManager uploadTaskWithRequest:request withFormData:formData completionHandler:^(id _Nullable responseObject, NSURLResponse * _Nonnull response, NSError * _Nullable error) {
//        NSNumber *requestID = @([dataTask taskIdentifier]);
//        [self.dispatchTable removeObjectForKey:requestID];
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//        NSData *responseData = responseObject;
//        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//
//        if (error) {
//            [PLLogger logDebugInfoWithResponse:httpResponse
//                                responseString:responseString
//                                       request:request
//                                         error:error];
//            PLURLResponse *response = [[PLURLResponse alloc] initWithResponseString:responseString requestId:requestID request:request responseData:responseData error:error];
//            fail?fail(response):nil;
//        } else {
//            // 检查http response是否成立。
//            [PLLogger logDebugInfoWithResponse:httpResponse
//                                responseString:responseString
//                                       request:request
//                                         error:NULL];
//            PLURLResponse *response = [[PLURLResponse alloc] initWithResponseString:responseString requestId:requestID request:request responseData:responseData status:PLURLResponseStatusSuccess];
//            success?success(response):nil;
//        }
//    }];
//    NSNumber *requestId = @([dataTask taskIdentifier]);
//
//    self.dispatchTable[requestId] = dataTask;
//    [dataTask resume];
//    return requestId;
//}



#pragma mark - getters and setters

- (NSMutableDictionary *)dispatchTable
{
    if (_dispatchTable == nil) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}

- (AFHTTPSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.securityPolicy.allowInvalidCertificates = YES;
        _sessionManager.securityPolicy.validatesDomainName = NO;
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        
    }
    return _sessionManager;
}

//- (void)dealloc {
//
//    NSLog(@"API Proxy dealloc");
//}

@end
