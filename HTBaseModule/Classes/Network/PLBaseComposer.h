//
//  PLBaseComposer.h
//  Frame
/**
    组合器，用于提供UIViewController 基础数据结构或视图
 
 **/
//  Created by DELI_PENGL on 2018/4/3.
//  Copyright © 2018年 PENGL. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface PLBaseComposer : NSObject

// 将参数排序之后进行MD5加密
- (NSString *)md5WithParams:(NSDictionary *)dic withServiceIdentifier:(NSString *)serviceIdentifier;

/**
 返回响应的Block ,操作名称、是否成功、返回信息
 */
@property (nonatomic, strong) void(^callbackResponseBlock)(NSUInteger responseName, BOOL isSuccess, NSString *messageStr);

@end
