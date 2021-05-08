//
//  APPEnvironmentConfig.m
//  AFNetworking
//
//  Created by mc on 2021/5/6.
//

#import "APPEnvironmentConfig.h"

@implementation APPEnvironmentConfig
+ (Service_Environment)appEnvironment{
    
  NSUserDefaults *userDeclassCodefaults = [NSUserDefaults standardUserDefaults];
    
  NSString *changeIPAddressStr = [userDeclassCodefaults objectForKey:@"ChangeIPAddressKey"];
    if (changeIPAddressStr) {
        if ([changeIPAddressStr isEqualToString:@"1"]) {
            return ENVIRONMENT_TEST;
        }else{
            return ENVIRONMENT_PRODUCT;
        }
    }
    return ENVIRONMENT_PRODUCT;
}
@end
