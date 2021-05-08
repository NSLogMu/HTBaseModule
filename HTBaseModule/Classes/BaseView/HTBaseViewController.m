//
//  HTBaseViewController.m
//  HTBaseModule
//
//  Created by mc on 2021/4/26.
//

#import "HTBaseViewController.h"
#import "HTBaseModuleHeader.h"
#define kLoadingTimer               1.5
@interface HTBaseViewController (){
    // 用于记录加载中画面时间，时间至少需要停留1秒
    NSTimeInterval _showLoadingTimer;
}
// 是否显示了加载画面
@property (nonatomic, assign) BOOL isShowLoading;

@end

@implementation HTBaseViewController

//设置navgation bar title
- (void)setNavigationItemTitle:(NSString *)title{
    
    UILabel *label_ = [[UILabel alloc] initWithFrame:CGRectZero];
    NSString *string = title;
    if (!string) {
        string = @"暂无标题";
    }
    CGRect frame_ = CGRectMake(0, 0, 100, 44);
    
    label_.frame = frame_;
    label_.font = [UIFont boldSystemFontOfSize:18*SCALE_6];
    label_.textColor = [UIColor whiteColor];
    label_.text = title;
    label_.backgroundColor = [UIColor clearColor];
    label_.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label_;
}

- (void)setBlackNavigationItemTitle:(NSString *)title{
    UILabel *label_ = [[UILabel alloc] initWithFrame:CGRectZero];
    NSString *string = title;
    if (!string) {
        string = @"暂无标题";
    }
    CGRect frame_ = CGRectMake(0, 0, 100, 44);
    
    label_.frame = frame_;
    label_.font = [UIFont boldSystemFontOfSize:18*SCALE_6];
    label_.textColor = NAVTitleColor;
    label_.text = title;
    label_.adjustsFontSizeToFitWidth = YES;
    label_.backgroundColor = [UIColor clearColor];
    label_.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label_;
}
//设置navigationItem rightItem
- (void)rightItemWithImage:(NSString *)imageName
                 andAction:(SEL)action
{
    UIButton *button_ = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    button_.imageEdgeInsets = UIEdgeInsetsMake(9.6, 8.8, 9.6, 8.8);//上左下右
    [button_ setImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
    [button_ setImage:[UIImage imageNamed:imageName] forState:(UIControlStateHighlighted)];
    [button_ addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
}

- (void)rightItemWithText:(NSString *)text
                andAction:(SEL)action
{
    
    UIButton *button_ = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    button_.imageEdgeInsets = UIEdgeInsetsMake(9.6, 8.8, 9.6, 8.8);//上左下右
    
    [button_ addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    button_.titleLabel.font=[UIFont systemFontOfSize:14];
    UILabel *label_ = [[UILabel alloc] initWithFrame:CGRectZero];
    CGRect frame_ = CGRectMake(0, 15, 80, 15);
    label_.frame = frame_;
    label_.font = [UIFont systemFontOfSize:14*SCALE_6];
    label_.textColor = MainColor;
    label_.text = text;
    label_.backgroundColor = [UIColor clearColor];
    label_.textAlignment = NSTextAlignmentRight;
    [button_ addSubview:label_];
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
}


- (void)leftItemWithText:(NSString *)text
                andAction:(SEL)action
{
    
    UIButton *button_ = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    button_.imageEdgeInsets = UIEdgeInsetsMake(9.6, 8.8, 9.6, 8.8);//上左下右
    
    [button_ addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    button_.titleLabel.font=[UIFont systemFontOfSize:14];
    UILabel *label_ = [[UILabel alloc] initWithFrame:CGRectZero];
    CGRect frame_ = CGRectMake(0, 15, 80, 15);
    label_.frame = frame_;
    label_.font = [UIFont systemFontOfSize:14*SCALE_6];
    label_.textColor = FuColor;
    label_.text = text;
    label_.backgroundColor = [UIColor clearColor];
    label_.textAlignment = NSTextAlignmentLeft;
    [button_ addSubview:label_];
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_];
    [self.navigationItem setLeftBarButtonItem:rightBarButtonItem];
}
//设置navigationItem leftItem
- (void)leftItemWithImage:(NSString *)imageName
                andAction:(SEL)action
{
    UIButton *button_ = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    [button_ addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    [button_ setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button_ setImageEdgeInsets:UIEdgeInsetsMake(0, -50, 0, 0)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button_];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -10;
    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,leftItem]];
    
}

//设置backButton
- (void)addBackButton
{
    [self leftItemWithImage:@"blackBack" andAction:@selector(backToPrevious)];
}

- (void)backToPrevious
{
    //    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES ];
}

- (void)leftItemWithImage:(NSString *)imageName
{
    UIImageView *imageView_ = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 58, 29)];
    imageView_.backgroundColor = [UIColor clearColor];
    imageView_.image = [UIImage imageNamed:imageName];
    
    UIBarButtonItem * leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageView_];
    [self.navigationItem setLeftBarButtonItem:leftBarButtonItem];
}

- (void)showViewMessage:(NSString *)message {
    
    if (message == nil || [message isEqualToString:@""]) {
        return;
    }
    if (self.isShowLoading) {
        // 默认HUD需要停留 默认时长。
        NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
        if (now - _showLoadingTimer < kLoadingTimer) {
            [self performSelector:@selector(showSuccessMessage:) withObject:message afterDelay:kLoadingTimer - (now - _showLoadingTimer)];
            return;
        }
        else {
            _showLoadingTimer = [[NSDate date] timeIntervalSince1970];
            [HUDHelp hideHUDWihtView:self.view];
            [HUDHelp showInfoMessage:message];
            self.isShowLoading = YES;
        }
    }
    else {
        _showLoadingTimer = [[NSDate date] timeIntervalSince1970];
        [HUDHelp hideHUDWihtView:self.view];
        [HUDHelp showInfoMessage:message];
        self.isShowLoading = YES;
    }
}

- (void)showErrorMessage:(NSString *)messageStr {
    
    if (messageStr == nil || [messageStr isEqualToString:@""]) {
        return;
    }
    if (self.isShowLoading) {
        // 默认HUD需要停留 默认时长。
        NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
        if (now - _showLoadingTimer < kLoadingTimer) {
            [self performSelector:@selector(showErrorMessage:) withObject:messageStr afterDelay:kLoadingTimer - (now - _showLoadingTimer)];
            return;
        }
        else {
            _showLoadingTimer = [[NSDate date] timeIntervalSince1970];
            [HUDHelp hideHUDWihtView:self.view];
            [HUDHelp showErrorMessage:messageStr];
            self.isShowLoading = YES;
        }
    }
    else {
        _showLoadingTimer = [[NSDate date] timeIntervalSince1970];
        [HUDHelp hideHUDWihtView:self.view];
        [HUDHelp showErrorMessage:messageStr];
        self.isShowLoading = YES;
    }
}
- (void)showActiveMessage:(NSString *)messageStr {
    
    if (messageStr == nil || [messageStr isEqualToString:@""]) {
        return;
    }
    self.isShowLoading = YES;
    _showLoadingTimer = [[NSDate date] timeIntervalSince1970];
    __weak typeof(*&self) wSelf = self;
    // 主线程更新
    dispatch_async(dispatch_get_main_queue(), ^{
        [HUDHelp showActivityMessageInView:wSelf.view message:messageStr];
    });
}
- (void)showWanningMessage:(NSString *)messageStr {
    
    if (messageStr == nil || [messageStr isEqualToString:@""]) {
        return;
    }
    if (self.isShowLoading) {
        // 默认HUD需要停留 默认时长。
        NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
        if (now - _showLoadingTimer < kLoadingTimer) {
            [self performSelector:@selector(showWanningMessage:) withObject:messageStr afterDelay:kLoadingTimer - (now - _showLoadingTimer)];
            return;
        }
        else {
            _showLoadingTimer = [[NSDate date] timeIntervalSince1970];
            [HUDHelp hideHUDWihtView:self.view];
            [HUDHelp showWarnMessage:messageStr];
            self.isShowLoading = YES;
        }
    }
    else {
        _showLoadingTimer = [[NSDate date] timeIntervalSince1970];
        [HUDHelp hideHUDWihtView:self.view];
        [HUDHelp showWarnMessage:messageStr];
        self.isShowLoading = YES;
    }
}
- (void)showSucceedMessage:(NSString *)messageStr {
    
    if (messageStr == nil || [messageStr isEqualToString:@""]) {
        return;
    }
    if (self.isShowLoading) {
        // 默认HUD需要停留 默认时长。
        NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
        if (now - _showLoadingTimer < kLoadingTimer) {
            [self performSelector:@selector(showSucceedMessage:) withObject:messageStr afterDelay:kLoadingTimer - (now - _showLoadingTimer)];
            return;
        }
        else {
            _showLoadingTimer = [[NSDate date] timeIntervalSince1970];
            [HUDHelp hideHUDWihtView:self.view];
            [HUDHelp showSuccessMessage:messageStr];
            self.isShowLoading = YES;
        }
    }
    else {
        _showLoadingTimer = [[NSDate date] timeIntervalSince1970];
        [HUDHelp hideHUDWihtView:self.view];
        [HUDHelp showSuccessMessage:messageStr];
        self.isShowLoading = YES;
    }
}

- (void)showHUD{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.tag = 130697;
}

- (void)hideHUD{
    //            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    NSArray *huds = [MBProgressHUD allHUDsForView:self.view];
    for (MBProgressHUD *hud in huds) {
        if (hud.tag == 130697) {
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES];
        }
    }
}
@end
