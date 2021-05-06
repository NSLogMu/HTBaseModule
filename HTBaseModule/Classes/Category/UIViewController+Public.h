//
//  UIViewController+Public.h
//  HTBaseModule
//
//  Created by mc on 2021/4/26.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIViewController (Public)
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
@end

