//
//  HUDHelp.m
//  HTBaseModule
//
//  Created by mc on 2021/4/27.
//

#import "HUDHelp.h"
#import <MBProgressHUD/MBProgressHUD.h>
static const NSUInteger TipSecond = 1.5;

@implementation HUDHelp
+ (MBProgressHUD *)createMBProgressHUDViewWithMessage:(NSString *)message view:(UIView *)view {
    
    if (view) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        if ([self isBlankString:message]) {
            hud.detailsLabel.text=@"加载中...";
        }else{
            hud.detailsLabel.text = message;
        }
        hud.detailsLabel.font = [UIFont systemFontOfSize:14];
        
        hud.removeFromSuperViewOnHide = YES;
//        hud.dimBackground=NO;
        return hud;
    }
    return nil;
    
}

+ (BOOL)isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        
        return YES;}
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

#pragma mark --show Tip

+ (void)showTipMessageInWindow:(NSString *)message {
    
    // 主线程更新
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showTipMessage:message view:[UIApplication sharedApplication].delegate.window timer:TipSecond];
    });
}

+ (void)showTipMessageInView:(UIView *)view message:(NSString *)message {
    
    // 主线程更新
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showTipMessage:message view:view timer:TipSecond];
    });
}

+ (void)showTipMessageInWindow:(NSString *)message timer:(int)timer {
    
    // 主线程更新
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showTipMessage:message view:[UIApplication sharedApplication].delegate.window timer:timer];
    });
}

+ (void)showTipMessageInView:(UIView *)view message:(NSString *)message timer:(int)timer {
    
    // 主线程更新
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showTipMessage:message view:view timer:timer];
    });
}

//+ (void)showTipMessageInWindow:(NSString *)message timer:(int)timer hudCompletion:(void(^)())hudCompletion {
//
//    MBProgressHUD *hud=[self createMBProgressHUDViewWithMessage:message view:[UIApplication sharedApplication].delegate.window];
//    hud.mode = MBProgressHUDModeText;
//    [hud showAnimated:YES whileExecutingBlock:^{
//        sleep(timer);
//    } completionBlock:^{
//        [hud removeFromSuperview];
//        hudCompletion();
//    }];
//
//}
//+ (void)showTipMessageInView:(UIView *)view message:(NSString *)message timer:(int)timer hudCompletion:(void(^)())hudCompletion {
//
//    MBProgressHUD *hud=[self createMBProgressHUDViewWithMessage:message view:view];
//    hud.mode = MBProgressHUDModeText;
//    [hud showAnimated:YES whileExecutingBlock:^{
//        sleep(timer);
//    } completionBlock:^{
//        [hud removeFromSuperview];
//        hudCompletion();
//    }];
//}


+ (void)showTipMessage:(NSString *)message view:(UIView *)view timer:(int)timer {

    // 主线程更新
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self createMBProgressHUDViewWithMessage:message view:view];
        hud.mode = MBProgressHUDModeText;
        [hud hideAnimated:YES afterDelay:timer];
    });
}

#pragma mark --show Activity
+ (void)showActivityMessageInWindow:(NSString *)message {
    
    // 主线程更新
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showActivityMessage:message view:[UIApplication sharedApplication].delegate.window timer:0];
    });
}

+ (void)showActivityMessageInView:(UIView *)view message:(NSString *)message {
    
    // 主线程更新
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showActivityMessage:message view:view timer:0];
    });
}

+ (void)showActivityMessageInWindow:(NSString *)message timer:(int)timer {
    // 主线程更新
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showActivityMessage:message view:[UIApplication sharedApplication].delegate.window timer:timer];
    });
}

+ (void)showActivityMessageInView:(UIView *)view message:(NSString *)message timer:(int)timer {
    
    // 主线程更新
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showActivityMessage:message view:view timer:timer];
    });
}

+ (void)showActivityMessage:(NSString *)message view:(UIView *)view timer:(int)timer {
    
    // 主线程更新
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud=[self createMBProgressHUDViewWithMessage:message view:view];
        hud.mode=MBProgressHUDModeIndeterminate;
        if (timer>0) {
            [hud hideAnimated:YES afterDelay:timer];
        }
    });
}


#pragma mark --show Image

+ (void)showSuccessMessage:(NSString *)message {
    
    // 主线程更新
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showCustomIconInWindow:@"MBHUD_Success" message:message];
    });
}

+ (void)showErrorMessage:(NSString *)message {
    
    // 主线程更新
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showCustomIconInWindow:@"MBHUD_Error" message:message];
    });
}

+ (void)showInfoMessage:(NSString *)message {
    
    // 主线程更新
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showCustomIconInWindow:@"MBHUD_Info" message:message];
    });
}

+ (void)showWarnMessage:(NSString *)message {
    
    // 主线程更新
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showCustomIconInWindow:@"MBHUD_Success" message:message];
    });
}

+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message {
    
    // 主线程更新
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showCustomIconInView:[UIApplication sharedApplication].delegate.window iconName:iconName message:message];
    });
}

+ (void)showCustomIconInView:(UIView *)view iconName:(NSString *)iconName message:(NSString *)message {
    
    // 主线程更新
    dispatch_async(dispatch_get_main_queue(), ^{
        //    [self showCustomIconInView:view iconName:iconName message:message];
        [self showCustomIcon:iconName message:message view:view];
    });
}


+ (void)showCustomIcon:(NSString *)iconName message:(NSString *)message view:(UIView *)view {
    
    // 主线程更新
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud=[self createMBProgressHUDViewWithMessage:message view:view];
        hud.customView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:[@"MBProgressHUD+JDragon.bundle/MBProgressHUD" stringByAppendingPathComponent:iconName]]];
        hud.mode=MBProgressHUDModeCustomView;
        [hud hideAnimated:YES afterDelay:TipSecond];
    });
}

#pragma mark --hide hud
+ (void)hideHUDWihtView:(UIView *)view {
    
    // 主线程更新
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView  *winView =(UIView*)[UIApplication sharedApplication].delegate.window;
        [MBProgressHUD hideHUDForView:winView animated:YES];
        [MBProgressHUD hideHUDForView:view animated:YES];
    });
}

+ (UIViewController *)getCurrentUIVC {
    
    UIViewController  *superVC = [[self class]  getCurrentWindowVC];
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }
    return superVC;
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentWindowVC {
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows) {
            if (tempWindow.windowLevel == UIWindowLevelNormal) {
                window = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    }
    else {
        result = window.rootViewController;
    }
    return  result;
}

@end
