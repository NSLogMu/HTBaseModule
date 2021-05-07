//
//  HTBaseNavigationController.m
//  HTBaseModule
//
//  Created by mc on 2021/4/26.
//

#import "HTBaseNavigationController.h"
#import "UIView+Extension.h"
#import "NSString+Extension.h"
#import "UIImage+Extension.h"
#import "HTBaseModuleHeader.h"

@interface HTBaseNavigationController ()

@end

@implementation HTBaseNavigationController

- (void)loadView {
    [super loadView];
    // bg.png为自己ps出来的想要的背景颜色。
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:NAVBackgroundColor size:CGSizeMake(self.navigationBar.frame.size.width, self.navigationBar.frame.size.height + 20)]
                            forBarPosition:UIBarPositionAny
                                barMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
    
    //title颜色和字体
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:NAVTitleColor,
                                               NSFontAttributeName:[UIFont systemFontOfSize:18*SCALE_6]};
    
    //系统返回按钮图片设置
    NSString *imageName = @"back_more_";
    if (kStatusBarStyle == UIStatusBarStyleLightContent) {
        imageName = @"back_more_";
    }
    UIImage *image = [UIImage imageNamed:imageName];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width-1, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:kUIToneTextColor];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(5, 0)
                                                         forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    for (Class classes in self.rootVcAry) {
        if ([viewController isKindOfClass:classes]) {
            if (self.navigationController.viewControllers.count > 0) {
                viewController.hidesBottomBarWhenPushed = YES;
            } else {
                viewController.hidesBottomBarWhenPushed = NO;
            }
        } else {
            viewController.hidesBottomBarWhenPushed = YES;
        }
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark -  RootVc

- (NSMutableArray *)rootVcAry {
    if (!_rootVcAry) {
        _rootVcAry = [NSMutableArray new];
    }
    return _rootVcAry;
}

@end
