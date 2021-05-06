//
//  UIView+Extension.h
//  HTBase
//
//  Created by mc on 2021/4/25.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LeShadowPathTop,
    LeShadowPathBottom,
    LeShadowPathLeft,
    LeShadowPathRight,
    LeShadowPathCommon,
    LeShadowPathAround,
} LeShadowPathType;


@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
//@property (nonatomic, assign) CGPoint origin;


// 虚线
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

- (CGFloat)left;
- (void)setLeft:(CGFloat)x;
- (CGFloat)top;
- (void)setTop:(CGFloat)y;
- (CGFloat)right;
- (void)setRight:(CGFloat)right;
- (CGFloat)bottom;
- (void)setBottom:(CGFloat)bottom;



- (UIViewController *)getParentviewController;


- (void)viewShadowPathWithColor:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowPathType:(LeShadowPathType)shadowPathType shadowPathWidth:(CGFloat)shadowPathWidth;
@end
@interface UtilityHelper : NSObject {
    
}
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
@end
