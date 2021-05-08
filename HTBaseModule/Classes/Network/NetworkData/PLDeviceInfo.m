//
//  PLDeviceInfo.m
//  Frame
//
//  Created by DELI_PENGL on 2018/4/28.
//  Copyright © 2018年 PENGL. All rights reserved.
//

#import "PLDeviceInfo.h"

#import "SFHFKeychainUtils.h"
#import"sys/utsname.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <Photos/Photos.h>
#import "HTBaseModuleHeader.h"
#define kKeyBindKeychainUUID @"iOSBindUUID"
#define kKeyBindKeychainServiceName @"iOSBindKeychainServiceName"

// 判断string是否为空 nil 或者 @"" 或者 (null)；
#define kISNULLString(__String) (__String==nil || [__String isEqualToString:@""] || [[__String stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""])
@interface PLDeviceInfo()

@property (nonatomic, copy, readwrite) NSString *deviceName;
@property (nonatomic, assign, readwrite) CGFloat ppi;

@end

@implementation PLDeviceInfo

@synthesize deviceID = _deviceID;

#pragma mark -- Life cycle

+ (instancetype)sharedInstance {
    
    static PLDeviceInfo *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PLDeviceInfo alloc] init];
    });
    return sharedInstance;
}


#pragma mark -- View

#pragma mark -- Private Event response

#pragma mark -- Delegate & DataSource

#pragma mark -- Getters and setters

- (NSString *)type {
    
    return @"ios";
}

- (NSString *)model {
    
    return [[UIDevice currentDevice] name];
}

- (NSString *)os {
    
    return [[UIDevice currentDevice] systemVersion];
}

- (NSString *)rom {
    
    return [[UIDevice currentDevice] model];
}

- (NSString *)imei {
    
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

- (NSString *)imsi {
    
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

- (NSString *)deviceName {
    
    if (_deviceName == nil) {
        struct  utsname systemInfo;
        uname(&systemInfo);
        NSString *code = [NSString stringWithCString:systemInfo.machine
                                            encoding:NSUTF8StringEncoding];
        _deviceName = code;
    }
    return _deviceName;
}

- (CGFloat)ppi {
    
    if(_ppi < 1) {
        CGFloat ppi = 0;
        if ([self.deviceName isEqualToString:@"iPod1,1"] ||
            [self.deviceName isEqualToString:@"iPod2,1"] ||
            [self.deviceName isEqualToString:@"iPod3,1"] ||
            [self.deviceName isEqualToString:@"iPhone1,1"] ||
            [self.deviceName isEqualToString:@"iPhone1,2"] ||
            [self.deviceName isEqualToString:@"iPhone2,1"]) {
            
            ppi = 163;
        }
        else if ([self.deviceName isEqualToString:@"iPod4,1"] ||
                 [self.deviceName isEqualToString:@"iPhone3,1"] ||
                 [self.deviceName isEqualToString:@"iPhone3,3"] ||
                 [self.deviceName isEqualToString:@"iPhone4,1"]) {
            
            ppi = 326;
        }
        else if ([self.deviceName isEqualToString:@"iPhone5,1"] ||
                 [self.deviceName isEqualToString:@"iPhone5,2"] ||
                 [self.deviceName isEqualToString:@"iPhone5,3"] ||
                 [self.deviceName isEqualToString:@"iPhone5,4"] ||
                 [self.deviceName isEqualToString:@"iPhone6,1"] ||
                 [self.deviceName isEqualToString:@"iPhone6,2"]) {
            
            ppi = 326;
        }
        else if ([self.deviceName isEqualToString:@"iPhone7,1"]
                 || [self.deviceName isEqualToString:@"iPhone8,2"]
                 || [self.deviceName isEqualToString:@"iPhone9,2"]
                 || [self.deviceName isEqualToString:@"iPhone9,4"]) {
            ppi = 401;
        }
        else if ([self.deviceName isEqualToString:@"iPhone7,2"]
                 ||[self.deviceName isEqualToString:@"iPhone8,1"]
                 ||[self.deviceName isEqualToString:@"iPhone8,4"]
                 ||[self.deviceName isEqualToString:@"iPhone9,1"]
                 ||[self.deviceName isEqualToString:@"iPhone9,3"]) {
            ppi = 326;
        }
        else if ([self.deviceName isEqualToString:@"iPad1,1"] ||
                 [self.deviceName isEqualToString:@"iPad2,1"]) {
            ppi = 132;
        }
        else if ([self.deviceName isEqualToString:@"iPad3,1"] ||
                 [self.deviceName isEqualToString:@"iPad3,4"] ||
                 [self.deviceName isEqualToString:@"iPad4,1"] ||
                 [self.deviceName isEqualToString:@"iPad4,2"]) {
            ppi = 264;
        }
        else if ([self.deviceName isEqualToString:@"iPad2,5"]) {
            ppi = 163;
        }
        else if ([self.deviceName isEqualToString:@"iPad4,4"] ||
                 [self.deviceName isEqualToString:@"iPad4,5"]) {
            ppi = 326;
        }
        else if ([self.deviceName isEqualToString:@"x86_64"]) {
            ppi = 326;
        }
        else {
            ppi = 326;  // 6 SE
            //            ppi = 401;  // 6P
        }
        _ppi = ppi;
    }
    return _ppi;
}

- (CGSize)resolution {
    
    CGSize resolution = CGSizeZero;
    if ([self.deviceName isEqualToString:@"iPod1,1"] ||
        [self.deviceName isEqualToString:@"iPod2,1"] ||
        [self.deviceName isEqualToString:@"iPod3,1"] ||
        [self.deviceName isEqualToString:@"iPhone1,1"] ||
        [self.deviceName isEqualToString:@"iPhone1,2"] ||
        [self.deviceName isEqualToString:@"iPhone2,1"]) {
        
        resolution = CGSizeMake(320, 480);
    }
    else if ([self.deviceName isEqualToString:@"iPod4,1"] ||
             [self.deviceName isEqualToString:@"iPhone3,1"] ||
             [self.deviceName isEqualToString:@"iPhone3,3"] ||
             [self.deviceName isEqualToString:@"iPhone4,1"]) {
        
        resolution = CGSizeMake(640, 960);
    }
    else if ([self.deviceName isEqualToString:@"iPhone5,1"] ||
             [self.deviceName isEqualToString:@"iPhone5,2"] ||
             [self.deviceName isEqualToString:@"iPhone5,3"] ||
             [self.deviceName isEqualToString:@"iPhone5,4"] ||
             [self.deviceName isEqualToString:@"iPhone6,1"] ||
             [self.deviceName isEqualToString:@"iPhone6,2"] ||
             [self.deviceName isEqualToString:@"iPhone8,4"]) {
        
        resolution = CGSizeMake(640, 1136);
    }
    else if ([self.deviceName isEqualToString:@"iPhone7,1"]
             || [self.deviceName isEqualToString:@"iPhone8,2"]
             || [self.deviceName isEqualToString:@"iPhone9,2"]
             || [self.deviceName isEqualToString:@"iPhone9,4"]
             || [self.deviceName isEqualToString:@"iPhone10,2"]
             || [self.deviceName isEqualToString:@"iPhone10,5"]) {
        resolution = CGSizeMake(1080, 1920);
    }
    else if (([self.deviceName isEqualToString:@"iPhone7,2"]
              || [self.deviceName isEqualToString:@"iPhone8,1"]
              ||[self.deviceName isEqualToString:@"iPhone9,1"]
              ||[self.deviceName isEqualToString:@"iPhone9,3"]
              ||[self.deviceName isEqualToString:@"iPhone10,1"]
              ||[self.deviceName isEqualToString:@"iPhone10,4"])) {
        resolution = CGSizeMake(750, 1334);
    }
    else if ([self.deviceName isEqualToString:@"iPhone10,3"]
             || [self.deviceName isEqualToString:@"iPhone10,6"]) {
        resolution = CGSizeMake(1125, 2436);
    }
    
    else if ([self.deviceName isEqualToString:@"iPad1,1"] ||
             [self.deviceName isEqualToString:@"iPad2,1"]) {
        resolution = CGSizeMake(768, 1024);
    }
    else if ([self.deviceName isEqualToString:@"iPad3,1"] ||
             [self.deviceName isEqualToString:@"iPad3,4"] ||
             [self.deviceName isEqualToString:@"iPad4,1"] ||
             [self.deviceName isEqualToString:@"iPad4,2"]) {
        resolution = CGSizeMake(1536, 2048);
    }
    else if ([self.deviceName isEqualToString:@"iPad2,5"]) {
        resolution = CGSizeMake(768, 1024);
    }
    else if ([self.deviceName isEqualToString:@"iPad4,4"] ||
             [self.deviceName isEqualToString:@"iPad4,5"]) {
        resolution = CGSizeMake(1536, 2048);
    }
    else {
        resolution = CGSizeMake(750, 1334);     // 6
        //        resolution = CGSizeMake(1080, 1920);    // 6P
        //        resolution = CGSizeMake(640, 1136);     // SE
    }
    return resolution;
}

- (NSString *)appVersion {
    
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
}

- (NSString *)appBuild {
    
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
}

- (NSString *)machineName {
    
    struct  utsname systemInfo;
    uname(&systemInfo);
    NSString *code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    return code;
}

- (NSString *)deviceID {
    
    if (_deviceID == nil) {
        // 生成UUID
        NSString *uuid = [SFHFKeychainUtils getPasswordForUsername:kKeyBindKeychainUUID andServiceName:kKeyBindKeychainServiceName error:nil];
        if (kISNULLString(uuid)) {
            uuid = [PLDeviceInfo uuid];
            // save to keychain
            [SFHFKeychainUtils storeUsername:kKeyBindKeychainUUID andPassword:uuid forServiceName:kKeyBindKeychainServiceName updateExisting:YES error:nil];
        }
        NSString *uuidMd5 = [NSString md5HexDigest:uuid];
        _deviceID = uuidMd5;
    }
    return _deviceID;
}

+ (NSString *)uuid {
    
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}


+ (NSString *)getPlatformString {
    
    NSString *platform = @"";//[self getDeviceVersion];
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 1";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4s";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    //iPot Touch
    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch";
    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2";
    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3";
    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4";
    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch 5";
    //iPad
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1";
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1";
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1";
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad air";
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad air";
    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad air";
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,7"]) return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,8"]) return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,9"]) return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad5,3"]) return @"iPad air 2";
    if ([platform isEqualToString:@"iPad5,4"]) return @"iPad air 2";
    if ([platform isEqualToString:@"iPhone Simulator"] || [platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    
    return platform;
}

#pragma mark -- WIFI


/**
 IP地址
 
 @return return value description
 */
+ (nullable NSString *)getCurrentLocalIP {
    
    NSString *address = nil;
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

/**
 WIFI SSID
 
 @return return value description
 */
+ (nullable NSString *)getCurreWiFiSSID {
    
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSLog(@"Supported interfaces: %@", ifs);
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NSLog(@"%@ => %@", ifnam, info);
        if (info && [info count]) { break; }
    }
    return [(NSDictionary*)info objectForKey:@"SSID"];
}

/**
 *  总的空间
 */
+ (NSNumber *)totalDiskSpace {
    
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    
    return [fattributes objectForKey:NSFileSystemSize];
}

/**
 *  剩余空间
 */
+ (NSNumber *)freeDiskSpace {
    
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    
    return [fattributes objectForKey:NSFileSystemFreeSize];
}

/**
 *  已用空间
 */
+ (NSNumber *)haveUseDiskSpace {
    
    CGFloat totalDiskSpace = [[PLDeviceInfo totalDiskSpace] floatValue];
    CGFloat freeDiskSpace = [[PLDeviceInfo freeDiskSpace] floatValue];
    CGFloat haveUseDiskSpace = totalDiskSpace - freeDiskSpace;
    
    return [NSNumber numberWithFloat:haveUseDiskSpace];
}

/**
 *  已用空间Str
 */
+ (NSString *)haveUseDiskSpaceStr {
    
    CGFloat haveUseDiskSpace = [[PLDeviceInfo haveUseDiskSpace] floatValue];
    
    if (haveUseDiskSpace >= 1024*1024*1024)
    {
        return [NSString stringWithFormat:@"%.2fG",haveUseDiskSpace/(1024*1024*1024.00)];
    }
    
    return [NSString stringWithFormat:@"%.2fM",haveUseDiskSpace/(1024*1024.00)];
}

/**
 *  可用空间Str
 */
+ (NSString *)freeDiskSpaceStr {
    
    CGFloat freeDiskSpace = [[PLDeviceInfo freeDiskSpace] floatValue];
    
    if (freeDiskSpace >= 1024*1024*1024)
    {
        return [NSString stringWithFormat:@"%.2fG",freeDiskSpace/(1024*1024*1024.00)];
    }
    
    return [NSString stringWithFormat:@"%.2fM",freeDiskSpace/(1024*1024.00)];
}



/**
 判断是否有相册访问权限

 @return return value description
 */
+ (BOOL)accessPhotosRight {
    
    BOOL isRight = YES;
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        //无权限
        isRight = NO;
    }
    return isRight;
}


/**
 判断相机权限

 @return return value description
 */
+ (BOOL)accessCamaraRight {
    
    // 用户是否允许摄像头使用
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
        return NO;
    }
    else {
        return YES;
    }
}
@end
