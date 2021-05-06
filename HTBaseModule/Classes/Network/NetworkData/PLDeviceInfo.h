//
//  PLDeviceInfo.h
//  Frame
//
//  Created by DELI_PENGL on 2018/4/28.
//  Copyright © 2018年 PENGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLDeviceInfo : NSObject

// 设备信息
@property (nonatomic, copy, readonly) NSString * _Nullable type;
@property (nonatomic, copy, readonly) NSString * _Nullable model;
@property (nonatomic, copy, readonly) NSString * _Nullable os;
@property (nonatomic, copy, readonly) NSString * _Nullable rom;
@property (nonatomic, assign, readonly) CGFloat ppi;
@property (nonatomic, copy, readonly) NSString * _Nullable imei;
@property (nonatomic, copy, readonly) NSString * _Nullable imsi;
@property (nonatomic, copy, readonly) NSString * _Nullable deviceName;
@property (nonatomic, strong, readonly) NSString * _Nullable deviceID;
@property (nonatomic, assign, readonly) CGSize resolution;
@property (nonatomic, copy, readonly) NSString * _Nullable appVersion;
@property (nonatomic, copy, readonly) NSString * _Nullable appBuild;

+ (instancetype _Nullable)sharedInstance;
/**
 IP地址
 
 @return return value description
 */
+ (nullable NSString *)getCurrentLocalIP;
/**
 WIFI SSID
 
 @return return value description
 */
+ (nullable NSString *)getCurreWiFiSSID;

/**
 *  剩余空间
 */
+ (NSNumber *_Nullable)freeDiskSpace;

/**
 判断是否有相册访问权限
 
 @return return value description
 */
+ (BOOL)accessPhotosRight;

/**
 判断相机权限
 
 @return return value description
 */
+ (BOOL)accessCamaraRight;
@end
