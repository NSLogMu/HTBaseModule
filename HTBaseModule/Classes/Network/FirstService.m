//
//  FirstService.m
//  Frame
//
//  Created by DELI_PENGL on 2018/4/4.
//  Copyright © 2018年 PENGL. All rights reserved.
//

#import "FirstService.h"
#import "APPEnvironmentConfig.h"
#import "HTAccountTool.h"
#import "NSString+Extension.h"
#import "NetworkModuleHeader.h"
@interface FirstService()

@property (nonatomic, strong) NSArray *baseURLArray; // url环境
@end

@implementation FirstService


#pragma mark - Call Back
/**
 校验请求响应回来的数据信息
 
 @param manager APIManager
 @param data response.content
 @return 是否为正常的操作
 */
- (BOOL)verifyResponseDate:(NSDictionary *)data complete:(void(^)(NSString *messageStr))completeBlock {
    
//    NSString *messageStr = kText(@"*未知异常*");
//    if (data[@"msg"]) {
//        messageStr = [data objectForKey:@"msg"];
//    }
//    completeBlock ? completeBlock(messageStr) : nil;
//    return ([data[@"code"] isEqualToString:@"00000"]||[data[@"code"] isEqualToString:@"00008"]||[data[@"code"] isEqualToString:@"00007"]||[data[@"code"] isEqualToString:@"00006"]) ? YES : NO;
    return YES;
}

- (void)setPrivateKey:(NSString *)key {
    
    [[PLAPPCacheHelper sharedInstance] setCacheWithKey:kFirstService_Secret_Key value:key];
}

#pragma mark - Private Event response

#pragma mark - Delegate

#pragma mark - Getters and setters

- (NSString *)apiBaseUrl {
    
//    NSString *appURLStr =  [[PLAPPCacheHelper sharedInstance] cacheValueForKey:@"APP_MAIN_URL"];
//    if (!kIsStrEmpty(appURLStr)) {
//        return appURLStr;
//    }
    
    if (self.baseURLArray.count > [APPEnvironmentConfig appEnvironment]+1){
        
        return self.baseURLArray[[APPEnvironmentConfig appEnvironment]];
    }
    else {
//        kLog_Method(@"baseURL配置错误");
        return nil;
    }
}

- (NSString *)apiVersion {
    
    return @"v1";
}

- (NSString *)publicKey {
    
    return @"";
}
- (NSString *)privateKey {
    
    NSString *key = [[PLAPPCacheHelper sharedInstance] cacheValueForKey:kFirstService_Secret_Key];
    if (key) {
        return key;
    }
    return @"";
}

- (NSArray *)httpHeaderFieldArray {
    
    HeaderFieldModel *header1 = [[HeaderFieldModel alloc] init];
    header1.headerKeyStr = @"Content-Type";
    header1.keyValueStr = @"application/json";
    
    NSMutableArray *headerFieldArray = [NSMutableArray array];
    [headerFieldArray addObject:header1];
    NSString *token = AccountTool.account.token;
    if (token) {
        HeaderFieldModel *header2 = [[HeaderFieldModel alloc] init];
        header2.headerKeyStr = @"Authorization";
        header2.keyValueStr = token;
        [headerFieldArray addObject:header2];
    }
    HeaderFieldModel *header3 = [[HeaderFieldModel alloc] init];
    header3.headerKeyStr = @"TERMINAL-TYPE";
    header3.keyValueStr = @"IOS";
    [headerFieldArray addObject:header3];
    
    HeaderFieldModel *header4 = [[HeaderFieldModel alloc] init];
    header4.headerKeyStr = @"TERMINAL-CODE";
    header4.keyValueStr = [NSString stringWithFormat:@"lesmart1%@",[PLDeviceInfo sharedInstance].deviceID];
    [headerFieldArray addObject:header4];
    
    
    HeaderFieldModel *header5 = [[HeaderFieldModel alloc] init];
    header5.headerKeyStr = @"Product-Mode";
    header5.keyValueStr = @"il";
    [headerFieldArray addObject:header5];
//    
//    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
//    NSString *timer =[NSString stringWithFormat:@"%0.0f",now];
//    HeaderFieldModel *header6 = [[HeaderFieldModel alloc] init];
//    header6.headerKeyStr = @"Timestamp";
//    header6.keyValueStr = timer;
//    [headerFieldArray addObject:header6];
    
    return headerFieldArray;
    return nil;
}


/*
 ENVIRONMENT_DEVELOP = 0,    // 必须以0开头, 开发环境
 ENVIRONMENT_TEST,           // 测试环境
 ENVIRONMENT_PRODUCT,        // 生产环境
 ENVIRONMENT_PRETEST,        // 预备生产环境
 ENVIRONMENT_SANDBOX,        // 沙盒环境
 */
- (NSArray *)baseURLArray {
    
    if (_baseURLArray == nil) {
        NSMutableArray *arrayURL = [NSMutableArray array];
        NSString *developURLStr = @"http://app.test.lesmartx.com";
        NSString *testURLStr = @"https://app.test.lesmartx.com";
        NSString *productURLStr =@"https://app.lesmartx.com";
        NSString *pretestURLStr = @"http://app.test.lesmartx.com";
        NSString *sandboxURLStr = @"http://app.ikedou.net/app";
        [arrayURL addObject:developURLStr];
        [arrayURL addObject:testURLStr];
        [arrayURL addObject:productURLStr];
        [arrayURL addObject:pretestURLStr];
        [arrayURL addObject:sandboxURLStr];
        _baseURLArray = [NSArray arrayWithArray:arrayURL];
    }
    return _baseURLArray;
}

- (PLHTTPBodySerializationType)serializationType {
    
    return SERIALIZATION_JSON;
}

- (NSMutableDictionary *)commonParams {
    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setValue:kServierVersion forKey:@"version"];
//    [params setValue:[[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"] forKey:@"appVersion"];
//    [params setValue:@"UTF8" forKey:@"charset"];
//    [params setValue:@"cn" forKey:@"language"];
//    [params setValue:@"iOS" forKey:@"terminalType"];
//    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
//    if (systemVersion) {
//        [params setValue:systemVersion forKey:@"terminalVersion"];
//    }
//    NSString *deviceID = [PLDeviceInfo sharedInstance].deviceID;
//    if (deviceID) {
//        [params setValue:deviceID forKey:@"terminalCode"];
//    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setValue:kServierVersion forKey:@"version"];
//    [params setValue:[[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"] forKey:@"appVersion"];
//    NSTimeInterval now = [[NSDate date] timeIntervalSince1970] *1000;
//    [params setValue:[NSString stringWithFormat:@"%0.0f",now] forKey:@"timestamp"];
//    [params setValue:@"UTF8" forKey:@"charset"];
//    [params setValue:@"cn" forKey:@"language"];
//    [params setValue:@"IOS" forKey:@"terminalType"];
//    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
//    if (systemVersion) {
//        [params setValue:systemVersion forKey:@"terminalVersion"];
//    }
//    NSString *deviceID = [PLDeviceInfo sharedInstance].deviceID;
//    if (deviceID) {
//        [params setValue:deviceID forKey:@"terminalCode"];
//    }
    return params;
}


#pragma mark -- 加密排序

// 加签（排序+签名）
- (NSString *)signStringWithDictionary:(NSDictionary *)dic {
    //签名密钥
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
    for (int i = 0; i< [[dict allKeys] count]; i++) {
        if ([[NSString stringWithFormat:@"%@",[[dict allValues] objectAtIndex:i]] isEqualToString:@""]) {
            [dict removeObjectForKey:[[dict allKeys] objectAtIndex:i]];
        }
    }
    NSMutableDictionary *dictSign = [NSMutableDictionary dictionaryWithDictionary:dict];
    
    
    NSArray *ketArray = [dictSign allKeys];
    NSMutableString *parameterString = [NSMutableString new];
    ketArray = [ketArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result==NSOrderedDescending;
    }];
    NSInteger count = 0;
    for (id object in ketArray) {
        if (count == 0){
            [parameterString appendString:[NSString stringWithFormat:@"%@=%@",object,dictSign[object]]];
        }else if (count) {
            [parameterString appendString:[NSString stringWithFormat:@"&%@=%@",object,dictSign[object]]];
        }
        count++;
    }
    NSString *token = dic[@"token"];
    if (token && ![token isEqualToString:@""]) {
        NSString *privateKey = self.privateKey;
        [parameterString appendString:[NSString stringWithFormat:@"&%@", privateKey?privateKey:@""]];
    }
    NSString *md5Str = [NSString md5HexDigest:parameterString];
    return md5Str;
}

@end
