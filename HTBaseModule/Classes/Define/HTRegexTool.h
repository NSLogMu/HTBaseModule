//
//  HTRegexTool.h
//  HTBase
//
//  Created by mc on 2021/4/25.
//

#import <Foundation/Foundation.h>


@interface HTRegexTool : NSObject
//邮箱
+ (BOOL)validateEmail:(NSString *)email;

//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile;

//身份证号
+ (BOOL)validateIdentityCard: (NSString *)identityCard;

//银行卡
+ (BOOL)validateBankCardNumber: (NSString *)bankCardNumber;

//控制最多输入两位小数
+ (BOOL)matchNumbersInTextfield:(NSString*)text;


//校验只能输入字母和数字
+ (BOOL)validateSoliderID: (NSString *)text;


//校验只能输数字
+ (BOOL)validateOnlyNumber: (NSString *)text;

//如果想要判断设备是ipad
+ (BOOL)getIsIpad;

//判断网络连接
+ (BOOL)isNetReachable;
@end


