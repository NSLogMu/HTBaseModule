//
//  HTPublicDefine.h
//  Pods
//
//  Created by mc on 2021/4/25.
//

#ifndef HTPublicDefine_h
#define HTPublicDefine_h

//返回安全的字符串
#define kSafeString(str) str.length > 0 ? str : @""

//屏幕分辨率

#define SCALE_6                                                   ((kscreenWidth<kscreenHeight?kscreenWidth:kscreenHeight)/ 375)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IOS_11  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.f)
#define kIS_IPHONE                  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIS_IPHONE_X                (IS_IOS_11 && kIS_IPHONE && (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) >= 375 && MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) >= 812))
#define kSafeArea_Status            (kIS_IPHONE_X ? 44 : 20)
#define kSafeArea_Nav               (kIS_IPHONE_X ? 88 : 64)
#define kSafeArea_Bottom            (kIS_IPHONE_X ? 34 : 0)
#define kSafeArea_ViewHeight        kIS_IPHONE_X?kScreenHeight-88-34:kScreenHeight-64    // 屏幕有效屏幕高度,及判断了iphoneX上部分88+34 +底部
#define kSafeArea_Tab               (kIS_IPHONE_X ? 84 : 50)

#define kscreenWidth [UIScreen mainScreen].bounds.size.width
#define kscreenHeight [UIScreen mainScreen].bounds.size.height

//颜色
#define UIColorFromHexA(hexValue, a)     [UIColor colorWithRed:(((hexValue & 0xFF0000) >> 16))/255.0f green:(((hexValue & 0xFF00) >> 8))/255.0f blue:((hexValue & 0xFF))/255.0f alpha:a]
#define MY_COLOR_RGBA(aR,aG,aB,aA)  [UIColor colorWithRed:aR/255.0 green:aG/255.0 blue:aB/255.0 alpha:aA]
#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define NAVBackgroundColor @"#ffffff"
#define NAVTitleColor @"#000000"
#define PlaceholderColor @"#BABCC4"
#define TextColor @"#333333"
#define LineColor @"#F9F9FA"
#define MainColor @"#F76B1C"
#define QianColor @"#FCE6D6"
#define UnEnableColor @"#F6BE95"
#define FuColor @"#888888"
#define kUIToneTextColor @"#666666" //UI整体文字色调 与背景颜色对应
#define kStatusBarStyle UIStatusBarStyleLightContent //状态栏样式

#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define LZJNotificationCenter [NSNotificationCenter defaultCenter]
#define WEAKSELF  typeof(self) __weak weakSelf=self;


//相关key
#define ChangeIPAddressKey @"ChangeIPAddressKey"

#pragma mark -Log相关

#ifdef DEBUG

#define kLog(...)                   NSLog(__VA_ARGS__);   // 普通Log
#define kLog_Method(format, ...)        printf("[%s] %s [第%d行] %s", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else

#define kLog(...)  ;
#define kLog_Method(format, ...)        printf("[%s] %s [第%d行] %s", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);

#endif


#endif /* HTPublicDefine_h */
