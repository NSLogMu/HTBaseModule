//
//  HTBaseViewController.h
//  HTBaseModule
//
//  Created by mc on 2021/4/26.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTBaseViewController : UIViewController
//设置navigationItem titleView
- (void)setNavigationItemTitle:(NSString *)title;
- (void)setBlackNavigationItemTitle:(NSString *)title;
//设置navigationItem rightItem
- (void)rightItemWithImage:(NSString *)imageName
                 andAction:(SEL)action;
- (void)rightItemWithText:(NSString *)text
                andAction:(SEL)action;
//设置navigationItem leftItem
- (void)leftItemWithImage:(NSString *)imageName
                andAction:(SEL)action;
- (void)leftItemWithText:(NSString *)text
                andAction:(SEL)action;
//设置backButton
- (void)addBackButton;
- (void)backToPrevious;

- (void)showHUD;
- (void)showHUDWithText;
- (void)hideHUD;
- (void)showViewMessage:(NSString *)message;
- (void)showErrorMessage:(NSString *)messageStr;
- (void)showActiveMessage:(NSString *)messageStr;
- (void)showWanningMessage:(NSString *)messageStr;
- (void)showSucceedMessage:(NSString *)messageStr;
@end

NS_ASSUME_NONNULL_END
