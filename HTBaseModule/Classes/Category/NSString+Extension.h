//
//  NSString+Extension.h
//  HTBaseModule
//
//  Created by mc on 2021/4/26.
//

#import <Foundation/Foundation.h>


@interface NSString (Extension)
//去掉无意义的0
+ (NSString *)stringDisposeWithFloatStringValue:(NSString *)floatStringValue;

+ (NSString *)stringDisposeWithFloatValue:(float)floatNum;

//千分位格式化数据
+ (NSString *)ittemThousandPointsFromNumString:(NSString *)numString;

//计算字符串的CGSize
- (CGSize)ex_sizeWithFont:(UIFont *)font
        constrainedToSize:(CGSize)size;

//时间戳转换时间
+(NSString *)timeWithTimeIntervalString:(NSString *)timeString
                          withFormatter:(NSString *)dateFormat;

// 根据身份证获取年龄
-(NSInteger)getAgeWithCardNum:(NSString *)idCardNum;

//获取字符串长度（中英文）
-(int)stringConvertToInt:(NSString*)strtemp;

//获取字符串MD5
+ (NSString *)md5HexDigest:(NSString*)input;

+(NSString *)convertToJsonData:(NSDictionary *)dict;

// DES Base64加密
+ (NSString *)encryptDESBase64:(NSString *)plainText
                           key:(NSString *)key;
// 解密Base64
+ (NSString *)decryptUseDESBase64:(NSString *)cipherText
                              key:(NSString *)key;
/**
 是否包含字符
 
 @param word word description
 @return return value description
 */
- (BOOL)isIncludeWord:(NSString *)word;

+ (NSString *)ChineseWithInteger:(NSInteger)integer;

- (NSString *)wipeRightZore;

+(NSString *)getCachesSize;

//获取当前时间
+ (NSString *)getCurrentTimeWithFormatterType:(NSString *)formatterType;

+ (BOOL)compareOneDay:(NSString *)oneDay
       withCurrentDay:(NSString *)currentDay
         andFormatter:(NSString *)formatter;

+ (NSString *)compareOneDay:(NSString *)oneDay
             withCurrentDay:(NSString *)currentDay;

+(NSString *)getFileSizeWithLength:(NSString *)length;

//判断密码格式
+ (BOOL)validatePwd:(NSString *)param;

+(BOOL)hasChinese:(NSString *)str;
@end

