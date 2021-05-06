//
//  HTBaseTabBarController.m
//  HTBaseModule
//
//  Created by mc on 2021/4/27.
//

#import "HTBaseTabBarController.h"
#import "HTBaseNavigationController.h"
@interface HTBaseTabBarController ()<UITabBarControllerDelegate>
@property (nonatomic, assign) NSInteger  indexFlag; //记录上一次点击tabbar
@property (nonatomic, strong) NSMutableArray *arry;

@end

@implementation HTBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arry = [NSMutableArray arrayWithCapacity:0];
    self.indexFlag = 0;
    [self setViewControllers];
    self.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)viewWillLayoutSubviews{
    float height;
    if (kIS_IPHONE_X) {
        height =83*SCALE_6;
    }else{
        height = 50*SCALE_6;
        
    }
    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
    tabFrame.size.height = height;
    tabFrame.origin.y = self.view.frame.size.height - height;
    self.tabBar.frame = tabFrame;
    [self.tabBar setBarTintColor:NAVBackgroundColor];
    self.tabBar.translucent = NO;
}

- (void)setViewControllers {
    //UITabBarController 数据源
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TabBarConfigure" ofType:@"plist"];
    NSArray *dataAry = [[NSArray alloc] initWithContentsOfFile:path];
    
    for (NSDictionary *dataDic in dataAry) {
        //每个tabar的数据
        Class classs = NSClassFromString(dataDic[@"class"]);
        NSString *title = dataDic[@"title"];
        NSString *imageName = dataDic[@"image"];
        NSString *selectedImage = dataDic[@"selectedImage"];
        NSString *badgeValue = dataDic[@"badgeValue"];
        
        [self addChildViewController:[self ittemChildViewController:classs title:title imageName:imageName selectedImage:selectedImage badgeValue:badgeValue]];
    }
}

- (HTBaseNavigationController *)ittemChildViewController:(Class)classs title:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImage badgeValue:(NSString *)badgeValue {
    UIViewController *vc = [classs new];
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc.tabBarItem.selectedImage = [[[UIImage imageNamed:selectedImage] imageToColor:kUIToneBarTitleColor] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    if (kIS_IPHONE_X) {
        float origin = (-9 + 6+5)*SCALE_6;
        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(origin, 0, -origin,0);
        vc.tabBarItem.titlePositionAdjustment = UIOffsetMake((-2 + 8)*SCALE_6, (2-8+5)*SCALE_6);
    }else{
        if ([HTRegexTool getIsIpad]) {
            float origin = (-9 + 6)*SCALE_6;
            vc.tabBarItem.imageInsets = UIEdgeInsetsMake(origin, 0, -origin,0);
            vc.tabBarItem.titlePositionAdjustment = UIOffsetMake((-2 + 8)*SCALE_6, -5);
        }else{
            float origin = (-9 + 6)*SCALE_6;
            vc.tabBarItem.imageInsets = UIEdgeInsetsMake(origin, 0, -origin,0);
            vc.tabBarItem.titlePositionAdjustment = UIOffsetMake((-2 + 8)*SCALE_6, (2-8)*SCALE_6);
        }
       

    }
    
    //title设置
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UTILITYCOLOR(@"#929295"),NSFontAttributeName:[UIFont systemFontOfSize:10*SCALE_6]} forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:MainColor,NSFontAttributeName:[UIFont systemFontOfSize:10*SCALE_6]} forState:UIControlStateSelected];
    vc.tabBarItem.title = title;
    
    //小红点
    vc.tabBarItem.badgeValue = badgeValue.intValue > 0 ? badgeValue : nil;
    //导航
    HTBaseNavigationController *nav = [[HTBaseNavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.topItem.title = title;
    [nav.rootVcAry addObject:classs];
    return nav;
}


// 是否可以点击
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    return YES;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (index != self.indexFlag) {
        //执行动画
        [self.arry removeAllObjects];
        for (UIView *btn in self.tabBar.subviews) {
            if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                btn.tag = btn.x;
                [self.arry addObject:btn];
            }
        }
        
        //添加动画
        // 先缩小
        UIView *bt = self.arry[index];
        bt.transform = CGAffineTransformMakeScale(0.6, 0.6);
        
        // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
        [UIView animateWithDuration: 1 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.3 options:0 animations:^{
            // 放大
            bt.transform = CGAffineTransformMakeScale(1, 1);
        } completion:nil];
        
        self.indexFlag = index;
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
