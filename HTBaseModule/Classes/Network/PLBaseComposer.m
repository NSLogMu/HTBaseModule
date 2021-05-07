//
//  PLBaseComposer.m
//  Frame
//
//  Created by DELI_PENGL on 2018/4/3.
//  Copyright © 2018年 PENGL. All rights reserved.
//

#import "PLBaseComposer.h"
#import "PLService.h"
#import "PLServiceFactory.h"
@implementation PLBaseComposer


// 将参数排序之后进行MD5加密
- (NSString *)md5WithParams:(NSDictionary *)dic withServiceIdentifier:(NSString *)serviceIdentifier {
    //排序参数
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
        if (count == 0) {
            [parameterString appendString:[NSString stringWithFormat:@"%@=%@",object,dictSign[object]]];
        }
        else if (count) {
            [parameterString appendString:[NSString stringWithFormat:@"&%@=%@",object,dictSign[object]]];
        }
        count++;
    }
    NSString *token = dic[@"token"];
    if (token && ![token isEqualToString:@""]) {
        PLService *service = [[PLServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
        NSString *privateKey = service.privateKey;
        [parameterString appendString:[NSString stringWithFormat:@"&%@", privateKey?privateKey:@""]];
    }
    NSString *md5Str = [NSString md5HexDigest:parameterString];
    return md5Str;
}


@end
