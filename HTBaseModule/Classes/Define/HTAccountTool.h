//
//  HTAccountTool.h
//  AFNetworking
//
//  Created by mc on 2021/5/6.
//

#import <Foundation/Foundation.h>
#import "HTSingleton.h"
#import "HTAccount.h"

#define AccountTool [HTAccountTool sharedHTAccountTool]


@interface HTAccountTool : NSObject
singleton_interface(HTAccountTool)
@property (nonatomic, strong) HTAccount *account;
//保存用户数据
- (void)saveAccount:(HTAccount *)account;
// 是否登录
- (BOOL)isLogin;
@end


