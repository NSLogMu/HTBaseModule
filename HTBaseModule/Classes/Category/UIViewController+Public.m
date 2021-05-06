//
//  UIViewController+Public.m
//  HTBaseModule
//
//  Created by mc on 2021/4/26.
//

#import "UIViewController+Public.h"

@implementation UIViewController (Public)

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



@end


