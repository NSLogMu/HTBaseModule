//
//  HUDHelp.h
//  HTBaseModule
//
//  Created by mc on 2021/4/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HUDHelp : NSObject
#pragma mark --tips
+ (void)showTipMessageInWindow:(NSString *)message;
+ (void)showTipMessageInView:(UIView *)view message:(NSString *)message;
+ (void)showTipMessageInWindow:(NSString *)message timer:(int)timer;
+ (void)showTipMessageInView:(UIView *)view message:(NSString *)message timer:(int)timer;
//+ (void)showTipMessageInWindow:(NSString *)message timer:(int)timer hudCompletion:(void(^)())hudCompletion;
//+ (void)showTipMessageInView:(UIView *)view message:(NSString *)message timer:(int)timer hudCompletion:(void(^)())hudCompletion;


#pragma mark --show Activity
+ (void)showActivityMessageInWindow:(NSString *)message;
+ (void)showActivityMessageInView:(UIView *)view message:(NSString *)message;
+ (void)showActivityMessageInWindow:(NSString *)message timer:(int)timer;
+ (void)showActivityMessageInView:(UIView *)view message:(NSString *)message timer:(int)timer;

#pragma mark --show Image
+ (void)showSuccessMessage:(NSString *)message;
+ (void)showErrorMessage:(NSString *)message;
+ (void)showInfoMessage:(NSString *)message;
+ (void)showWarnMessage:(NSString *)message;

+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message;
+ (void)showCustomIconInView:(UIView *)view iconName:(NSString *)iconName message:(NSString *)message;

#pragma mark --hide hud
+ (void)hideHUDWihtView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
