//
//  HTBaseLabel.h
//  AFNetworking
//
//  Created by mc on 2021/5/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTBaseLabel : UILabel
@property (nonatomic, assign) UIEdgeInsets textInsets; // 控制字体与控件边界的间隙
// 主色调Lab
+ (instancetype)mainColorLabel;

// 辅助色Color
+ (instancetype)subColorLabel;

@end

NS_ASSUME_NONNULL_END
