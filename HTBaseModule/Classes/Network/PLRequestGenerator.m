//
//  PLRequestGenerator.m
//  Frame
//
//  Created by DELI_PENGL on 2018/4/9.
//  Copyright © 2018年 PENGL. All rights reserved.
//

#import "PLRequestGenerator.h"
#import "AFNetworking.h"
#import "NSURLRequest+PLNetworkingMethods.h"
#import "PLServiceFactory.h"

@interface PLRequestGenerator ()

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation PLRequestGenerator

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    static PLRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PLRequestGenerator alloc] init];
    });
    return sharedInstance;
}


- (NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName timeoutInterval:(NSInteger)timeout {
  
    PLService *service = [[PLServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString;
    if (![service.apiVersion isEqualToString:@""]) {
        if ([serviceIdentifier isEqualToString:kFirstService]) {
            urlString = [NSString stringWithFormat:@"%@%@", service.apiBaseUrl, methodName];
        }
    }
    if (service.serializationType == SERIALIZATION_JSON) {
        self.httpRequestSerializer = [self jsonRequestSerializer];
    }
    else {
        self.httpRequestSerializer = [self hRequestSerializer];
    }
    // 设置请求超时时间
    if (timeout > 0) {
        self.httpRequestSerializer.timeoutInterval = timeout;
    }
    else {
        self.httpRequestSerializer.timeoutInterval = 45;
    }
    
    // 加签
//    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
//    NSString *timer =[NSString stringWithFormat:@"%0.0f",now];
//    static NSString *key = @"4b424e19fd7287dc2378271f985bd0b8";
//    NSString *path = [NSString stringWithFormat:@"/%@",methodName];
//    NSString *bodyStr;
//    NSString *keyValue;
//    if (requestParams&&requestParams.allKeys.count>0) {
//        bodyStr = [self convertToJsonData:requestParams];
//        keyValue = [NSString stringWithFormat:@"%@%@%@%@", path, bodyStr, timer,key];
//    }else{
//        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
//        bodyStr = [self convertToJsonData:dic];
//        keyValue = [NSString stringWithFormat:@"%@%@%@%@", path, bodyStr, timer,key];
//    }
//    NSLog(@"keyValue============%@",keyValue);
//
    
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:requestParams error:NULL];
    for (HeaderFieldModel *model in service.httpHeaderFieldArray) {
        [request setValue:model.keyValueStr forHTTPHeaderField:model.headerKeyStr];
    }
    
    // 增加参数
//    [request setValue:[NSString md5HexDigest:keyValue]  forHTTPHeaderField:@"Signature"];

    
    if (service.serializationType == SERIALIZATION_JSON) {
        request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:0 error:NULL];
    }
    else {
        NSMutableString *bodyStr = [NSMutableString string];
        [requestParams enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [bodyStr appendFormat:@"%@=%@&",key,obj];
        }];
        request.HTTPBody = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    }
    request.requestParams = requestParams;
    
    return request;
}


- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName timeoutInterval:(NSInteger)timeout {
    
    PLService *service = [[PLServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", service.apiBaseUrl, methodName];
    if (service.serializationType == SERIALIZATION_JSON) {
        self.httpRequestSerializer = [self jsonRequestSerializer];
    }
    else {
        self.httpRequestSerializer = [self hRequestSerializer];
    }
    // 设置请求超时时间
    if (timeout > 0) {
        self.httpRequestSerializer.timeoutInterval = timeout;
    }
    else {
        self.httpRequestSerializer.timeoutInterval = 45;
    }
    // 处理Get特定请求方法的参数
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:requestParams error:NULL];
    for (HeaderFieldModel *model in service.httpHeaderFieldArray) {
        [request setValue:model.keyValueStr forHTTPHeaderField:model.headerKeyStr];
    }
    
//    // 加签
//    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
//    NSString *timer =[NSString stringWithFormat:@"%0.0f",now];
//    static NSString *key = @"4b424e19fd7287dc2378271f985bd0b8";
//    NSString *path = [NSString stringWithFormat:@"/%@",methodName];
//    NSString *bodyStr;
//    NSString *keyValue;
//    if (requestParams&&requestParams.allKeys.count>0) {
//        bodyStr = [self convertToJsonData:requestParams];
//        keyValue = [NSString stringWithFormat:@"%@%@%@%@", path, bodyStr, timer,key];
//    }else{
//        keyValue = [NSString stringWithFormat:@"%@%@%@", path,timer,key];
//
//    }
//    NSLog(@"keyValue===================%@",keyValue);
    // 增加两个参数
//    [request setValue:[NSString md5HexDigest:keyValue]  forHTTPHeaderField:@"Signature"];
    request.requestParams = requestParams;
    
    return request;
}


- (NSURLRequest *)generateDELETERequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName timeoutInterval:(NSInteger)timeout {
    
    
    PLService *service = [[PLServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", service.apiBaseUrl, methodName];
    if (service.serializationType == SERIALIZATION_JSON) {
        self.httpRequestSerializer = [self jsonRequestSerializer];
    }
    else {
        self.httpRequestSerializer = [self hRequestSerializer];
    }
    // 设置请求超时时间
    if (timeout > 0) {
        self.httpRequestSerializer.timeoutInterval = timeout;
    }
    else {
        self.httpRequestSerializer.timeoutInterval = 45;
    }
    // 处理DELETE特定请求方法的参数
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"DELETE" URLString:urlString parameters:nil error:NULL];
    for (HeaderFieldModel *model in service.httpHeaderFieldArray) {
        [request setValue:model.keyValueStr forHTTPHeaderField:model.headerKeyStr];
    }
    
    // 加签
//    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
//    NSString *timer =[NSString stringWithFormat:@"%0.0f",now];
//    static NSString *key = @"4b424e19fd7287dc2378271f985bd0b8";
//    NSString *bodyStr;
//    NSString *path = [NSString stringWithFormat:@"/%@",methodName];
//    NSString *keyValue;
//    if (requestParams&&requestParams.allKeys.count>0) {
//        bodyStr = [self convertToJsonData:requestParams];
//        keyValue = [NSString stringWithFormat:@"%@%@%@%@", path, bodyStr, timer,key];
//    }else{
//        keyValue = [NSString stringWithFormat:@"%@%@%@", path,timer,key];
//
//    }
    // 增加两个参数
//    [request setValue:[NSString md5HexDigest:keyValue]  forHTTPHeaderField:@"Signature"];
    if (requestParams) {
         if (service.serializationType == SERIALIZATION_JSON) {
               request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:0 error:NULL];
           }
           else {
               NSMutableString *bodyStr = [NSMutableString string];
               [requestParams enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                   [bodyStr appendFormat:@"%@=%@&",key,obj];
               }];
               request.HTTPBody = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
           }
    }
   
    request.requestParams = requestParams;
    
    return request;
}

- (NSURLRequest *)generatePATCHRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName timeoutInterval:(NSInteger)timeout {
    
    PLService *service = [[PLServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", service.apiBaseUrl, methodName];
    if (service.serializationType == SERIALIZATION_JSON) {
        self.httpRequestSerializer = [self jsonRequestSerializer];
    }
    else {
        self.httpRequestSerializer = [self hRequestSerializer];
    }
    // 设置请求超时时间
    if (timeout > 0) {
        self.httpRequestSerializer.timeoutInterval = timeout;
    }
    else {
        self.httpRequestSerializer.timeoutInterval = 45;
    }
    // 处理PATCH特定请求方法的参数
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"PATCH" URLString:urlString parameters:requestParams error:NULL];
    for (HeaderFieldModel *model in service.httpHeaderFieldArray) {
        [request setValue:model.keyValueStr forHTTPHeaderField:model.headerKeyStr];
    }
    
    //    // 加签
    //    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    //    NSString *timer =[NSString stringWithFormat:@"%0.0f",now];
    //    static NSString *key = @"4b424e19fd7287dc2378271f985bd0b8";
    //    NSString *path = [NSString stringWithFormat:@"/%@",methodName];
    //    NSString *bodyStr;
    //    NSString *keyValue;
    //    if (requestParams&&requestParams.allKeys.count>0) {
    //        bodyStr = [self convertToJsonData:requestParams];
    //        keyValue = [NSString stringWithFormat:@"%@%@%@%@", path, bodyStr, timer,key];
    //    }else{
    //        keyValue = [NSString stringWithFormat:@"%@%@%@", path,timer,key];
    //
    //    }
    //    NSLog(@"keyValue===================%@",keyValue);
    // 增加两个参数
    //    [request setValue:[NSString md5HexDigest:keyValue]  forHTTPHeaderField:@"Signature"];
    request.requestParams = requestParams;
    
    return request;
}

#define PLEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]
- (NSURLRequest *)generateUploadRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName timeoutInterval:(NSInteger)timeout {
    
    PLService *service = [[PLServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", service.apiBaseUrl, methodName];
    if (![service.apiVersion isEqualToString:@""]) {
        urlString = [NSString stringWithFormat:@"%@%@", service.apiBaseUrl,methodName];
    }
    __autoreleasing NSError *error;
    
    // 设置请求超时时间
    if (timeout > 0) {
        self.httpRequestSerializer.timeoutInterval = timeout;
    }
    else {
        self.httpRequestSerializer.timeoutInterval = 120;
    }
    
    // 文件上传
    NSString *path = requestParams[@"filePath"];
    NSArray *fileArr = [path componentsSeparatedByString:@"/"];
    NSString *fileName = fileArr[fileArr.count -1];
    NSArray *expandNameArr = [fileArr[fileArr.count -1] componentsSeparatedByString:@"."];
    NSString *expandName = [expandNameArr[expandNameArr.count -1] lowercaseString];
    NSString *mimeType = @"text/html";
    if ([expandName isEqualToString:@"pdf"]) {
        mimeType = @"application/pdf";
    }
    else if ([expandName isEqualToString:@"jpg"]
             || [expandName isEqualToString:@"jpeg"]
             || [expandName isEqualToString:@"jpg"]) {
        mimeType = @"image/jpeg";
    }
    else if ([expandName isEqualToString:@"png"]) {
        mimeType = @"image/png";
    }
    else if ([expandName isEqualToString:@"doc"]) {
        mimeType = @"application/msword";
    }
    else if ([expandName isEqualToString:@"docx"]) {
        mimeType = @"application/vnd.openxmlformats-officedocument.wordprocessingml.document";
    }
    else if ([expandName isEqualToString:@"ppt"]) {
        mimeType = @"application/vnd.ms-powerpoint";
    }
    else if ([expandName isEqualToString:@"pptx"]) {
        mimeType = @"application/vnd.openxmlformats-officedocument.presentationml.presentation";
    }
    else if ([expandName isEqualToString:@"xls"]) {
        mimeType = @"application/vnd.ms-excel";
    }
    else if ([expandName isEqualToString:@"xlsx"]) {
        mimeType = @"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
    }
    else if ([expandName isEqualToString:@"txt"]) {
        mimeType = @"text/plain";
    }
    
    
    //    NSMutableURLRequest *request = [self.httpRequestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    //        [formData appendPartWithFileData:[[NSData alloc] initWithContentsOfFile:path] name:@"mypic" fileName:fileName mimeType:mimeType];
    //        // 普通参数
    ////        [requestParams enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    ////            // 参数开始的标志
    ////////            [formData appendData:PLEncode(@"--PL\r\n")];
    //////            NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n", key];
    ////            if (![key isEqualToString:@"filePath"]) {
    ////                [formData appendPartWithFormData:[obj dataUsingEncoding:NSUTF8StringEncoding] name:key];
    ////            }
    ////        }];
    //
    //    } error:&error];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:requestParams error:NULL];
    
    
    // 设置请求体
    NSMutableData *body = [NSMutableData data];
    
    // 参数开始的标志
    [body appendData:PLEncode(@"--PL\r\n")];
    
    // name : 指定参数名(必须跟服务器端保持一致) filename : 文件名
    NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n", fileName];
    [body appendData:PLEncode(disposition)];
    NSString *type = [NSString stringWithFormat:@"Content-Type: %@\r\n", mimeType];
    
    [body appendData:PLEncode(type)];
    [body appendData:PLEncode(@"\r\n")];
    NSData *fileData = [[NSData alloc] initWithContentsOfFile:path];
    [body appendData:fileData];
    [body appendData:PLEncode(@"\r\n")];
    //    [changeParams setObject:fileData forKey:@"file"];
    // 普通参数
    [requestParams enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([key isEqualToString:@"filePath"]
            || [key isEqualToString:@"fileData"]) {
            // 这两个参数不参与发送。
        }
        else {
            // 参数开始的标志
            [body appendData:PLEncode(@"--PL\r\n")];
            NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n", key];
            [body appendData:PLEncode(disposition)];
            [body appendData:PLEncode(@"\r\n")];
            //            if ([key isEqualToString:@"file"]) {
            //                [body appendData:obj];
            //            }
            //            else {
            [body appendData:PLEncode(obj)];
            //            }
            [body appendData:PLEncode(@"\r\n")];
        }
    }];
    
    // 服务端接收参数为非JSON,
    //    request.HTTPBody = [[bodyStr substringToIndex:bodyStr.length-1] dataUsingEncoding:NSUTF8StringEncoding];
    // 设置Body
    [body appendData:PLEncode(@"--PL--\r\n")];
    request.HTTPBody = body;
    [request setValue:@"multipart/form-data; boundary=PL" forHTTPHeaderField:@"Content-Type"];
    request.requestParams = requestParams;
    
    return request;
}





#pragma mark - getters and setters
//- (AFHTTPRequestSerializer *)httpRequestSerializer {
//
//    if (_httpRequestSerializer == nil) {
//        // 如果服务端接受格式为JSON,则使用JSON,如果不是，则使用HTTP
////        _httpRequestSerializer = [AFJSONRequestSerializer serializer];
//        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
//        //        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
//        //        _httpRequestSerializer.timeoutInterval = kPLNetworkingTimeoutSeconds;
//        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
//    }
//    return _httpRequestSerializer;
//}

- (AFHTTPRequestSerializer *)jsonRequestSerializer {
    
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    return requestSerializer;
}

- (AFHTTPRequestSerializer *)hRequestSerializer {
    
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    return requestSerializer;
}
-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

@end
