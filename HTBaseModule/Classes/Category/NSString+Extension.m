//
//  NSString+Extension.m
//  HTBaseModule
//
//  Created by mc on 2021/4/26.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonCryptor.h>
#define cachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation NSString (Extension)

+ (NSString *)stringDisposeWithFloatStringValue:(NSString *)floatStringValue {
    NSString *str = floatStringValue;
    NSUInteger len = str.length;
    for (int i = 0; i < len; i++)
    {
        if (![str  hasSuffix:@"0"])
            break;
        else {
            if ([str rangeOfString:@"."].location != NSNotFound) {
                str = [str substringToIndex:[str length]-1];
            } else {
                break;
            }
        }
    }
    if ([str hasSuffix:@"."])//避免像2.0000这样的被解析成2.
    {
        return [str substringToIndex:[str length]-1];//s.substring(0, len - i - 1);
    }
    else
    {
        return str;
    }
}

//此方法去掉2.0000这样的浮点后面多余的0
//传人一个浮点字符串,需要保留几位小数则保留好后再传
+ (NSString *)stringDisposeWithFloatValue:(float)floatNum {
    
    NSString *str = [NSString stringWithFormat:@"%.2f",floatNum];
    NSUInteger len = str.length;
    for (int i = 0; i < len; i++)
    {
        if (![str  hasSuffix:@"0"])
            break;
        else
            str = [str substringToIndex:[str length]-1];
    }
    if ([str hasSuffix:@"."])//避免像2.0000这样的被解析成2.
    {
        return [str substringToIndex:[str length]-1];//s.substring(0, len - i - 1);
    }
    else
    {
        return str;
    }
}

+ (NSString *)ittemThousandPointsFromNumString:(NSString *)numString {
    NSString *str = numString;
    
    NSString *preStr = @"";
    if ([str rangeOfString:@"-"].location != NSNotFound) {
        str = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
        preStr = @"-";
    }
    
    NSString *lastStr = @"";
    if ([str rangeOfString:@"."].location != NSNotFound) {
        NSArray *array = [str componentsSeparatedByString:@"."];
        if (array.count > 1) {
            str = array[0];
            lastStr = [NSString stringWithFormat:@".%@",array[1]];
        }
    }

    NSUInteger len = [str length];
    NSUInteger x = len % 3;
    NSUInteger y = len / 3;
    NSUInteger dotNumber = y;
    
    if (x == 0) {
        dotNumber -= 1;
        x = 3;
    }
    NSMutableString *rs = [@"" mutableCopy];
    
    [rs appendString:[str substringWithRange:NSMakeRange(0, x)]];
    
    for (int i = 0; i < dotNumber; i++) {
        [rs appendString:@","];
        [rs appendString:[str substringWithRange:NSMakeRange(x + i * 3, 3)]];
    }
    rs = [NSMutableString stringWithFormat:@"%@%@",preStr,rs];
   [rs appendString:lastStr];
   return rs;
}

- (CGSize)ex_sizeWithFont:(UIFont *)font
        constrainedToSize:(CGSize)size{
    CGSize resultSize;
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(boundingRectWithSize:options:attributes:context:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(boundingRectWithSize:options:attributes:context:)];
        NSDictionary *attributes = @{ NSFontAttributeName:font };
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
        NSStringDrawingContext *context;
        [invocation setArgument:&size atIndex:2];
        [invocation setArgument:&options atIndex:3];
        [invocation setArgument:&attributes atIndex:4];
        [invocation setArgument:&context atIndex:5];
        [invocation invoke];
        CGRect rect;
        [invocation getReturnValue:&rect];
        resultSize = rect.size;
    } else {
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(sizeWithFont:constrainedToSize:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(sizeWithFont:constrainedToSize:)];
        [invocation setArgument:&font atIndex:2];
        [invocation setArgument:&size atIndex:3];
        [invocation invoke];
        [invocation getReturnValue:&resultSize];
    }
    
    return resultSize;
}

//时间戳转换时间
+(NSString *)timeWithTimeIntervalString:(NSString *)timeString
                          withFormatter:(NSString *)dateFormat{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    if (!dateFormat) {
        dateFormat = @"yyyy-MM-dd  HH:mm:ss";
    }
    
    [formatter setDateFormat:dateFormat];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    NSInteger minTime;
    if (timeString.length>10) {
         minTime =[timeString integerValue]/1000;
    }else{
        minTime =[timeString integerValue];
    }
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:minTime];
    
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}


/*
 *  时间戳对应的NSDate
 */
-(NSDate *)date{
    
    NSTimeInterval timeInterval=self.floatValue;
    
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}


- (NSInteger)getAgeWithCardNum:(NSString *)idCardNum{
    // 年份
    int strYear = [[idCardNum substringWithRange:NSMakeRange(6, 4)] intValue];
    // 月份
    int strMonth = [[idCardNum substringWithRange:NSMakeRange(10, 2)] intValue];
    // 日
    int strDay = [[idCardNum substringWithRange:NSMakeRange(12, 2)] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",
                                                strYear, strMonth, strDay]];
    
    NSLog(@"%@",date);
    
    NSInteger age =  [self ageWithDateOfBirth:date];
    return age;
}


- (NSInteger)ageWithDateOfBirth:(NSDate *)date;{
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    
    return iAge;
}


-  (int)stringConvertToInt:(NSString*)strtemp{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    
    return (strlength+1)/2;
}

+ (NSString *)md5HexDigest:(NSString*)input{
    
    const char* str = [input UTF8String];
    unsigned char result[CC_MD2_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];//
    for(int i = 0; i<CC_MD2_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

const Byte iv[] = {1,2,3,4,5,6,7,8};
+ (NSString *)encryptDESBase64:(NSString *)plainText key:(NSString *)key {
    
    NSString *ciphertext = nil;
    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024*100];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          [textData bytes], dataLength,
                                          buffer, 1024*100,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [NSString encodeData:data];
    }
    return ciphertext;
    
}
// Base64加密时的编码
+ (NSString *)encodeData:(NSData *)data {
    
    if (data.length == 0)
        return nil;
    
    char *characters = malloc(data.length * 3 / 2);
    
    if (characters == NULL)
        return nil;
    
    int end = data.length - 3;
    int index = 0;
    int charCount = 0;
    int n = 0;
    
    while (index <= end) {
        int d = (((int)(((char *)[data bytes])[index]) & 0x0ff) << 16)
        | (((int)(((char *)[data bytes])[index + 1]) & 0x0ff) << 8)
        | ((int)(((char *)[data bytes])[index + 2]) & 0x0ff);
        
        characters[charCount++] = encodingTable[(d >> 18) & 63];
        characters[charCount++] = encodingTable[(d >> 12) & 63];
        characters[charCount++] = encodingTable[(d >> 6) & 63];
        characters[charCount++] = encodingTable[d & 63];
        
        index += 3;
        
        if(n++ >= 14)
        {
            n = 0;
            characters[charCount++] = ' ';
        }
    }
    
    if(index == data.length - 2)
    {
        int d = (((int)(((char *)[data bytes])[index]) & 0x0ff) << 16)
        | (((int)(((char *)[data bytes])[index + 1]) & 255) << 8);
        characters[charCount++] = encodingTable[(d >> 18) & 63];
        characters[charCount++] = encodingTable[(d >> 12) & 63];
        characters[charCount++] = encodingTable[(d >> 6) & 63];
        characters[charCount++] = '=';
    }
    else if(index == data.length - 1)
    {
        int d = ((int)(((char *)[data bytes])[index]) & 0x0ff) << 16;
        characters[charCount++] = encodingTable[(d >> 18) & 63];
        characters[charCount++] = encodingTable[(d >> 12) & 63];
        characters[charCount++] = '=';
        characters[charCount++] = '=';
    }
    NSString * rtnStr = [[NSString alloc] initWithBytesNoCopy:characters length:charCount encoding:NSUTF8StringEncoding freeWhenDone:YES];
    return rtnStr;
}

// 解密Base64
+ (NSString *)decryptUseDESBase64:(NSString *)cipherText
                              key:(NSString *)key {
    
    NSString *plaintext = nil;
    NSData *cipherdata = [NSString decode:cipherText];
    unsigned char buffer[1024*100];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          [cipherdata bytes], [cipherdata length],
                                          buffer, 1024*100,
                                          &numBytesDecrypted);
    if(cryptStatus == kCCSuccess) {
        NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
    }
    return plaintext;
}

// Base64解密
+ (NSData *)decode:(NSString *)data {
    
    if(data == nil || data.length <= 0) {
        return nil;
    }
    NSMutableData *rtnData = [[NSMutableData alloc]init];
    int slen = data.length;
    int index = 0;
    while (true) {
        while (index < slen && [data characterAtIndex:index] <= ' ') {
            index++;
        }
        if (index >= slen || index  + 3 >= slen) {
            break;
        }
        
        int byte = ([NSString char2Int:[data characterAtIndex:index]] << 18) + ([NSString char2Int:[data characterAtIndex:index + 1]] << 12) + ([NSString char2Int:[data characterAtIndex:index + 2]] << 6) + [NSString char2Int:[data characterAtIndex:index + 3]];
        Byte temp1 = (byte >> 16) & 255;
        [rtnData appendBytes:&temp1 length:1];
        if([data characterAtIndex:index + 2] == '=') {
            break;
        }
        Byte temp2 = (byte >> 8) & 255;
        [rtnData appendBytes:&temp2 length:1];
        if([data characterAtIndex:index + 3] == '=') {
            break;
        }
        Byte temp3 = byte & 255;
        [rtnData appendBytes:&temp3 length:1];
        index += 4;
        
    }
    return rtnData;
}

+ (int)char2Int:(char)c {
    
    if (c >= 'A' && c <= 'Z') {
        return c - 65;
    } else if (c >= 'a' && c <= 'z') {
        return c - 97 + 26;
    } else if (c >= '0' && c <= '9') {
        return c - 48 + 26 + 26;
    } else {
        switch(c) {
            case '+':
                return 62;
            case '/':
                return 63;
            case '=':
                return 0;
            default:
                return -1;
        }
    }
}

//字典转json
+ (NSString *)convertToJsonData:(NSDictionary *)dict{
    
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

- (BOOL)isIncludeWord:(NSString *)word{
    
    NSRange range = [self rangeOfString:word];
    
    if(range.location != NSNotFound) {
        return YES;
    }
    return NO;
}

+ (NSString *)ChineseWithInteger:(NSInteger)integer{
    
    NSDictionary *dicData = @{
                              @"1":@"一",
                              @"2":@"二",
                              @"3":@"三",
                              @"4":@"四",
                              @"5":@"五",
                              @"6":@"六",
                              @"7":@"七",
                              @"8":@"八",
                              @"9":@"九",
                              @"10":@"十",
                              @"11":@"十一",
                              @"12":@"十二",
                              @"13":@"十三",
                              @"14":@"十四",
                              @"15":@"十五",
                              @"16":@"十六",
                              @"17":@"十七",
                              @"18":@"十八",
                              @"19":@"十九",
                              @"20":@"二十",
                              @"21":@"二一",
                              @"22":@"二二",
                              @"23":@"二三",
                              @"24":@"二四",
                              @"25":@"二五",
                              @"26":@"二六",
                              @"27":@"二七",
                              @"28":@"二八",
                              @"29":@"二九",
                              @"30":@"三十",
                              };
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
//    NSString *string = [formatter stringFromNumber:[NSNumber numberWithInt:(int)integer]];
    NSString *string = dicData[[NSString stringWithFormat:@"%ld",integer]];
    if (string.length ==0) {
        string = [NSString stringWithFormat:@"%ld",integer];
    }
    return string;
}


//去除后面的零
//
//@return 返回不带尾部0

- (NSString *)wipeRightZore{
    
    NSString *s = nil;
    if (self && self.length < 1) {
        return @"";
    }
    int offset = (int)self.length - 1;
    if ([self rangeOfString:@"."].location == NSNotFound) {
        return self;
    }
    else {
        while (offset) {
            s = [self substringWithRange:NSMakeRange(offset, 1)];
            if ([s isEqualToString:@"0"] || [s isEqualToString:@"."]) {
                // 如果当前为0，或者为.,vkj
                NSString *leftStr = [self substringWithRange:NSMakeRange(0, offset)];
                offset--;
                if ([leftStr rangeOfString:@"."].location == NSNotFound) {
                    break;
                }
                else {
                }
            }
            else {
                break;
            }
        }
    }
    NSString *outStr = [self substringToIndex:offset+1];
    
    return outStr;
}

// 缓存大小
+(NSString *)getCachesSize{
    // 调试
#ifdef DEBUG
    
    // 如果文件夹不存在 or 不是一个文件夹, 那么就抛出一个异常
    // 抛出异常会导致程序闪退, 所以只在调试阶段抛出。发布阶段不要再抛了,--->影响用户体验
    
    BOOL isDirectory = NO;
    
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:cachePath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        
        NSException *exception = [NSException exceptionWithName:@"文件错误" reason:@"请检查你的文件路径!" userInfo:nil];
        
        [exception raise];
    }
    
    //发布
#else
    
#endif
    
    //1.获取“cachePath”文件夹下面的所有文件
    NSArray *subpathArray= [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    NSString *filePath = nil;
    long long totalSize = 0;
    
    for (NSString *subpath in subpathArray) {
        
        // 拼接每一个文件的全路径
        filePath =[cachePath stringByAppendingPathComponent:subpath];
        
        BOOL isDirectory = NO;   //是否文件夹，默认不是
        
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];   // 判断文件是否存在
        
        // 文件不存在,是文件夹,是隐藏文件都过滤
        if (!isExist || isDirectory || [filePath containsString:@".DS"]) continue;
        
        // attributesOfItemAtPath 只可以获得文件属性，不可以获得文件夹属性，
        //这个也就是需要遍历文件夹里面每一个文件的原因
        
        long long fileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil] fileSize];
        
        totalSize += fileSize;
        
    }
    
    // 2.将文件夹大小转换为 M/KB/B
    NSString *totalSizeString = nil;
    
//    if (totalSize > 1000 * 1000) {
//
//        totalSizeString = [NSString stringWithFormat:@"%.1fM",totalSize / 1000.0f /1000.0f];
//
//    } else if (totalSize > 1000) {
//
//        totalSizeString = [NSString stringWithFormat:@"%.1fKB",totalSize / 1000.0f ];
//
//    } else {
//
//        totalSizeString = [NSString stringWithFormat:@"%.1fB",totalSize / 1.0f];
//
//    }
    
    if (totalSize > 1000 * 1000) {
        
        totalSizeString = [NSString stringWithFormat:@"%.1fM",totalSize / 1000.0f /1000.0f];
        
    } else {
        
        totalSizeString = @"0M";
        
    }
    
    return totalSizeString;
    
}

+ (NSString *)getCurrentTimeWithFormatterType:(NSString *)formatterType{
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:formatterType];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    return dateTime;
}

//result == NSOrderedDescending  说明当前时间大于指定时间
//result == NSOrderedAscending，说明当前时间小于指定时间
+ (BOOL)compareOneDay:(NSString *)oneDay
       withCurrentDay:(NSString *)currentDay
         andFormatter:(NSString *)formatter{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (formatter) {
        [dateFormatter setDateFormat:formatter];
    }else{
       [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    NSDate *dateA = [dateFormatter dateFromString:oneDay];
    NSDate *dateB = [dateFormatter dateFromString:currentDay];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        //NSLog(@"DateA  is in the future");
        return YES;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"DateA is in the past");
        return NO;
    }else{
        //NSLog(@"Both dates are the same");
        return NO;
    }
    
}

+ (NSString *)compareOneDay:(NSString *)oneDay withCurrentDay:(NSString *)currentDay{
    
  NSInteger currentTime =   [[NSDate date] timeIntervalSince1970];
    
    NSTimeInterval balance = [oneDay intValue] - currentTime;
    
    NSString*timeString = [[NSString alloc]init];

    timeString = [NSString stringWithFormat:@"%f",balance /60];

    timeString = [timeString substringToIndex:timeString.length-7];

    NSInteger timeInt = [timeString intValue];

    NSInteger hour = timeInt /60;
    if(hour ==0) {
        return @"剩0.5小时";

    }else if (hour <0){
        return @"";
    }else{
        return [NSString stringWithFormat:@"剩%ld小时",hour];
     }
}


+(NSString *)getFileSizeWithLength:(NSString *)length{
     // 2.将文件夹大小转换为 M/KB/B
        NSString *totalSizeString = nil;
    NSInteger  totalSize = [length integerValue];
        if (totalSize > 1000 * 1000) {
            totalSizeString = [NSString stringWithFormat:@"%.1fM",totalSize / 1000.0f /1000.0f];
    
        } else if (totalSize > 1000) {
    
            totalSizeString = [NSString stringWithFormat:@"%.0fKB",totalSize / 1000.0f ];
    
        } else {
            totalSizeString = [NSString stringWithFormat:@"%.1fB",totalSize / 1.0f];
        }
        return totalSizeString;
}

+ (BOOL)validatePwd:(NSString *)param{

NSString *pwdRegex = @"^[a-zA-Z0-9]+$";

NSPredicate *pwdPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pwdRegex];

return [pwdPredicate evaluateWithObject:param];

}

+(BOOL)hasChinese:(NSString *)str{
    for(int i=0; i< [str length];i++){
        int a =[str characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
       }

   }
    return NO;

}

@end
